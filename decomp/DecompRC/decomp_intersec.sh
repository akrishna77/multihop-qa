#!/bin/bash
python3 main.py --do_predict --model span-predictor --output_dir out/decom-intersec \
              --init_checkpoint model/decom_intersec/model.pt \
              --predict_file data/hotpot-all/dev.json,data/decomposition-data/decomposition-intersec-dev-v1.json \
              --max_seq_length 100 --max_n_answers 1 --prefix dev_

python3 run_decomposition.py --task decompose --data_type dev_i --out_name out/decom-intersec
python3 main.py --do_predict --output_dir out/onehop \
            --predict_file data/decomposed/dev_i.1.json \
            --init_checkpoint model/onehop/model1.pt,model/onehop/model2.pt,model/onehop/model3.pt \
            --prefix dev_i_1_ --n_best_size 4
python3 main.py --do_predict --output_dir out/onehop \
            --predict_file data/decomposed/dev_i.2.json \
            --init_checkpoint model/onehop/model1.pt,model/onehop/model2.pt,model/onehop/model3.pt \
            --prefix dev_i_2_ --n_best_size 4
python3 run_decomposition.py --task aggregate-intersec --data_type dev_i --topk 10
