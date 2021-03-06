#!/bin/bash

python3 main.py --do_predict --output_dir out/scorer --model classifier \
            --predict_file data/hotpot-all/dev.json,comparison,bridge,intersec,onehop \
            --init_checkpoint model/scorer/model.pt \
            --max_seq_length 400 --prefix dev_
