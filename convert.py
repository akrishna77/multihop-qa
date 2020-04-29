import json
import copy
import sys



# HotPotQA dev file can be found at http://curtis.ml.cmu.edu/datasets/hotpot/hotpot_dev_fullwiki_v1.json

#Change this flag to true to include all reasoning paths found by the retriever, not just the top one
LOAD_ALL_CONTEXT = True
TOP_K_VAL = 3


def extract_data(q_id, data, keys):
	#Extract a question's data from hotpotqa_dev using the question ID as a foreign key
	for obj in data:
		if obj['_id'] == q_id:
			d = {}
			for k in keys:
				d[k] = obj[k]
			return d
	raise Exception("No supporting facts found")


if __name__ == "__main__":
	if len(sys.argv) < 4:
		raise Exception("Incorrect Usage. Order of arguments: \n \t `python convert.py $reasoning_path_input $hotpotqa_dev_file $output_file \n")
	else:
		_, reasoning_path, hotpot_file, output_file = sys.argv


	with open(reasoning_path,'r') as f:
		rp_data = json.load(f)

	with open(hotpot_file, 'r') as f:
		hp_data = json.load(f)


	'''
	Process:
			Change field names where necessary
			Extract the top list of contexts and reformat the data
			Remove trailing _0 from contexts and titles
			Cross-reference HotpotQA json and extract corresponding supporting facts for each question
	'''


	hotpot_list = []

	for obj in rp_data:
		new_obj = {}
		new_obj['_id'] = obj['q_id']
		if LOAD_ALL_CONTEXT:
			contexts = []
			for context_list in obj['topk_titles']: #Extract unique values
				for context in context_list:
					if context not in contexts:
						contexts.append(context)
		else:
			if len(contexts) > TOP_K_VAL:
				contexts = []
				for context_list in obj['topk_titles'][:TOP_K_VAL-1]: #Extract unique values
					for context in context_list:
						if context not in contexts:
							contexts.append(context)
			else:
				for context_list in obj['topk_titles']:
					for context in context_list:
						if context not in contexts:
							contexts.append(context)

		hp_feats = extract_data(new_obj['_id'], hp_data, ['supporting_facts', 'answer', 'type', 'level'])

		c_list = []
		for c in contexts:
			#Contexts in Hotpot seem to be a list with each element a sentence.
			c_list.append([c, obj['context'][c].split(". ")])

		for i in range(len(c_list)):
			#Removing trailing _0 if necessary
			if c_list[i][0][-2:] == '_0':
				c_list[i][0] = c_list[i][0][:-2]
			for j in range(len(c_list[i][1])):
				c_list[i][1][j] = c_list[i][1][j] + "."


		new_obj['context'] = c_list
		new_obj['supporting_facts'] = hp_feats['supporting_facts']
		new_obj['answer'] = hp_feats['answer']
		new_obj['type'] = hp_feats['type']
		new_obj['level'] = hp_feats['level']
		new_obj['question'] = obj['question']
		hotpot_list.append(copy.deepcopy(new_obj))

	with open(output_file, 'w+') as f:
		json.dump(hotpot_list, f)