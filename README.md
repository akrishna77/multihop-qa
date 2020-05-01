# multihop-qa

This repository contains the code for our Georgia Tech CS7643 class project. This code contains scripts for reproducing paper results and also combining two approaches outlined in our final report. There are additional README files in each directory for the respective model, and the convert.py script can be used to feed output from the Graph Reason Path Retriever to the DecompRC model.

# Converting data

Once you've run the information retrieval code on your desired dataset, you need to format it into the input of DecompRC. To do so, run the command

`python convert.py {$InformationReteriverout.json} {$OriginalDataset.json} {$DesiredOutputFile.json}`

The script combines the information found in the original dataset (labels, question types, etc) with the reasoning paths in a json format accessible by the DecompRC model.
