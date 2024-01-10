# Step.1 Train TFMFT
python3 -m torch.distributed.launch --nproc_per_node=8 --use_env main_track.py --dataset_file mft --coco_path MFT22 --batch_size 8  --with_box_refine  --num_queries 500 --epochs 30 --lr_drop 10  --track_train_split train

# Step.2 Evaluate
python3 main_track.py --dataset_file mft --coco_path MFT22 --batch_size 1 --resume models/TFMFT.pth --eval --with_box_refine --num_queries 500 --track_eval_split val

# Step.3 Evaluate CLEAR
GROUNDTRUTH=train
RESULTS=eval/val/tracks
GT_TYPE=_val_half
THRESHOLD=-1

python3 track_tools/eval_motchallenge.py \
--groundtruths ${GROUNDTRUTH} \
--tests ${RESULTS} \
--gt_type ${GT_TYPE} \
--eval_official \
--score_threshold ${THRESHOLD}