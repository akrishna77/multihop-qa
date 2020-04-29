python3 main.py --do_predict --output_dir out/onehop \
            --predict_file data/hotpot-all/dev.json \
            --init_checkpoint model/hotpot/model.pt --max_seq_length 300 --prefix dev_ --n_best_size 4
python3 run_decomposition.py --task onehop --data_type dev --topk 10
