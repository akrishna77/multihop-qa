import json
import copy
import sys


def extract_supp_facts(q_id, data):
	for obj in data:
		if obj['_id'] == q_id:
			return obj['supporting_facts']
	raise Exception("No supporting facts found")


if __name__ == "__main__":
	if len(sys.argv) < 4:
		raise Exception("Incorrect Usage. Order of arguments: \n \t `python convert.py $reasoning_path_input $cross-reference_hotpotqa_file $output_file \n")
	else:
		_, reasoning_path, hotpot_file, output_file = sys.argv


	with open(reasoning_path,'r') as f:
		rp_data = json.load(f)

	with open(hotpot_file, 'r') as f:
		hp_data = json.load(f)


	hotpot_list = []

	for obj in rp_data:
		new_obj = {}
		new_obj['_id'] = obj['q_id']
		contexts = obj['topk_titles'][0]
		supporting_facts = extract_supp_facts(new_obj['_id'], hp_data)

		c_list = []
		for c in contexts:
			c_list.append([c, obj['context'][c].split(". ")])

		for i in range(len(c_list)):
			if c_list[i][0][-2:] == '_0':
				c_list[i][0] = c_list[i][0][:-2]


		new_obj['context'] = c_list
		new_obj['supporting_facts'] = supporting_facts
		new_obj['question'] = obj['question']
		hotpot_list.append(copy.deepcopy(new_obj))

	with open(output_file, 'w+') as f:
		json.dump(hotpot_list, f)