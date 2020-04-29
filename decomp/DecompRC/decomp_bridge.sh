python3 main.py --do_predict --model span-predictor --output_dir out/decom-bridge \
              --init_checkpoint model/decom_bridge/model.pt \
              --predict_file data/hotpot-all/dev.json,data/decomposition-data/decomposition-bridge-dev-v1.json \
              --max_seq_length 100 --max_n_answers 1 --prefix dev_ --with_key
python3 run_decomposition.py --task decompose --data_type dev_b --out_name out/decom-bridge
python3 main.py --do_predict --output_dir out/onehop \
            --predict_file data/decomposed/dev_b.1.json \
            --init_checkpoint model/onehop/model1.pt,model/onehop/model2.pt,model/onehop/model3.pt \
            --prefix dev_b_1_ --n_best_size 4
python3 run_decomposition.py --task plug --data_type dev_b --topk 10
python3 main.py --do_predict --output_dir out/onehop \
            --predict_file data/decomposed/dev_b.2.json \
            --init_checkpoint model/onehop/model1.pt,model/onehop/model2.pt,model/onehop/model3.pt \
            --prefix dev_b_2_ --n_best_size 4
python3 run_decomposition.py --task aggregate-bridge --data_type dev_b --topk 10
