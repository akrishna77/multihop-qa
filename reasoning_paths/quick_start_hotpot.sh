# download trained models
# mkdir models
# cd models
# gdown https://drive.google.com/uc?id=1ra37xtEXSROG_f90XxR4kgElGJWUHQyM
# unzip hotpot_models.zip
# rm hotpot_models.zip
# cd ..

# download eval data
# mkdir data
# cd data
# mkdir hotpot
# cd hotpot
# gdown https://drive.google.com/uc?id=1m_7ZJtWQsZ8qDqtItDTWYlsEHDeVHbPt
# gdown https://drive.google.com/uc?id=1D-Uj4DPMZWkSouzw5Gg5YhkGiBHSqCJp
# wget http://curtis.ml.cmu.edu/datasets/hotpot/hotpot_dev_distractor_v1.json
#cd ../..

# run evaluation scripts
python eval_main.py \
--eval_file_path data/hotpot/hotpot_fullwiki_first_100.jsonl \
--graph_retriever_path models/hotpot_models/graph_retriever_path/pytorch_model.bin \
--reader_path models/hotpot_models/reader \
--tfidf_path models/hotpot_models/tfidf_retriever/tfidf_results_from_enwiki_intro_only/enwiki_intro-tfidf-ngram\=2-hash\=16777216-tokenizer\=simple.npz \
--db_path models/hotpot_models/wiki_db/enwiki_intro.db \
--tfidf_results_save_path models/hotpot_models/tfidf_retriever/saved/enwiki_intro_tfidf_results.json \
--selector_results_save_path models/hotpot_models/graph_retriever_path/saved/enwiki_intro_selector_results.json \
--reader_results_save_path models/hotpot_models/reader/saved/enwiki_intro_reader_results.json \
--bert_model_sequential_sentence_selector bert-large-uncased --do_lower_case \
--tfidf_limit 500 --eval_batch_size 4 --pruning_by_links --beam_graph_retriever 8 \
--beam_sequential_sentence_selector 8 --max_para_num 2000 --sampled