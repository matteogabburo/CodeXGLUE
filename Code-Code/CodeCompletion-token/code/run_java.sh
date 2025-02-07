LANG=java
DATADIR=../dataset/javaCorpus/token_completion
OUTPUTDIR=../save/javaCorpus
PRETRAINDIR=$1
LOGFILE=completion_javaCorpus.log
PER_NODE_GPU=1

python -m torch.distributed.launch --nproc_per_node=$PER_NODE_GPU run_lm.py \
--data_dir=$DATADIR \
--langs=$LANG \
--output_dir=$OUTPUTDIR \
--pretrain_dir=$PRETRAINDIR \
--log_file=$LOGFILE \
--model_type=auto \
--block_size=$2 \
--do_train \
--node_index 0 \
--gpu_per_node $PER_NODE_GPU \
--learning_rate=8e-5 \
--weight_decay=0.01 \
--evaluate_during_training \
--per_gpu_train_batch_size=2 \
--per_gpu_eval_batch_size=4 \
--gradient_accumulation_steps=4 \
--num_train_epochs=5 \
--logging_steps=100 \
--save_steps=1000 \
--overwrite_output_dir \
--seed=42 \
--not_pretrain