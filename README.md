# multihop-qa

This repository contains the code for our Georgia Tech CS7643 class project. This code contains scripts for reproducing paper results and also combining two approaches outlined in our final report. There are additional README files in each directory for the respective model, and the convert.py script can be used to feed output from the Graph Reason Path Retriever to the DecompRC model.

## Running the Information Retriever Model

The code for running this part of the model is found in the reasoning_paths directory, and contains its own README file.

## Converting data

Once you've run the information retrieval code on your desired dataset, you need to format it into the input of DecompRC. To do so, run the command

`python convert.py {$InformationReteriverout.json} {$OriginalDataset.json} {$DesiredOutputFile.json}`

The script combines the information found in the original dataset (labels, question types, etc) with the reasoning paths in a json format accessible by the DecompRC model.

## Running DecompRC

The output of the conversion script can be used as the input file for DecompRC, and the details for running this section of the code are also found within its own directory, DecompRC. To speed up inference but do each piece separately there are scripts: decomp_bridge.sh, decomp_intersec.sh, decomp_onehop.sh, and scorer.sh that can be ran in that order to obtain results. These are in the decomp/DecompRC folder. So in run the following to obtain results:

1. Put the training and dev data from hotpotqa into data/hotpot folder and download the pretrained models. All the info and data for these models can be found (https://drive.google.com/file/d/1XaMX-u5ZkWGH3f0gPrDtrBK1lKDU-QFk/view?usp=sharing)[here] and (https://drive.google.com/file/d/1p7VrJIEmUY9tAWmx31chhStS-KoRWOJQ/view?usp=sharing)[here]. The first link should be stored 3 directories above the current directory or the code will need to be adjusted. The other models in the second link should be put in a folder called model in the DecompRC directory and the data should be in the folder called data.

Ensure you are in the DecompRC directory then run the following for the rest of the steps

```bash
python convert_hotpot2squad.py --data_dir {DATA_DIR} --task hotpot-all
./decomp_bridge.sh
./decomp_intersec.sh
./decomp_onehop.sh
./scorer.sh
python show_result.py --data_file {ORIGINAL_HOTPOT_DEV_FILE} --prediction_file {FILE_TO_SAVE}
```

For more details see the Readme within the decomp directory.