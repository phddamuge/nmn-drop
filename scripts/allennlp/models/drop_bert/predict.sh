#!/usr/bin/env

# PACKAGE TO BE INCLUDED WHICH HOUSES ALL THE CODE
INCLUDE_PACKAGE=semqa
export GPU=0
export BEAMSIZE=1
export DEBUG=true

# SAVED MODEL
MODEL_DIR=./resources/semqa/checkpoints/drop/date_num/date_ydNEW_num_hmyw_cnt_rel_600_10p/drop_parser_bert/CNTFIX_false/EXCLOSS_true/MMLLOSS_true/aux_true/SUPEPOCHS_5/S_1/BertModel_wTest/
MODEL_TAR=${MODEL_DIR}/model.tar.gz
PREDICTION_DIR=${MODEL_DIR}/predictions
mkdir ${PREDICTION_DIR}

DATASET_DIR=./resources/data/drop/date_num

# This should contain:
# 1. drop_dataset_mydev.json and drop_dataset_mytest.json
# 2. A folder containing multiple sub-dataset folders, each with dev and test .json
DATASET_NAME=date_ydNEW_num_hmyw_cnt_rel_600_10p
QUESTYPE_SETS_DIR=questype_datasets

FULL_VALFILE=${DATASET_DIR}/${DATASET_NAME}/drop_dataset_mydev.json
PREDICTION_FILE=${PREDICTION_DIR}/${DATASET_NAME}_dev_numstepanalysis.tsv
PREDICTOR=drop_analysis_predictor

allennlp predict --output-file ${PREDICTION_FILE} \
                     --predictor ${PREDICTOR} \
                     --cuda-device ${GPU} \
                     --include-package ${INCLUDE_PACKAGE} \
                     --silent \
                     --batch-size 1 \
                     --use-dataset-reader \
                     --overrides "{"model": { "beam_size": ${BEAMSIZE}, "debug": ${DEBUG}}}" \
                    ${MODEL_TAR} ${FULL_VALFILE}



#for EVAL_DATASET in datecomp_full year_diff_re count how_many_yards_was who_relocate_re numcomp_full
#do
#    VALFILE=${DATASET_DIR}/${DATASET_NAME}/${QUESTYPE_SETS_DIR}/${EVAL_DATASET}/drop_dataset_mydev.json
#
#    # ANALYSIS_FILE=${PREDICTION_DIR}/${EVAL_DATASET}_dev_analysis.tsv
#    PREDICTION_FILE=${PREDICTION_DIR}/${EVAL_DATASET}_dev_numstepanalysis.tsv
#    # PREDICTION_FILE=${PREDICTION_DIR}/${EVAL_DATASET}_dev_pred.txt
#    PREDICTOR=drop_analysis_predictor
#    # PREDICTOR=drop_parser_predictor
#
#    ###################################################################################################################
#
#    # allennlp predict --output-file ${PREDICTION_FILE} \
#    allennlp predict --output-file ${PREDICTION_FILE} \
#                     --predictor ${PREDICTOR} \
#                     --cuda-device ${GPU} \
#                     --include-package ${INCLUDE_PACKAGE} \
#                     --silent \
#                     --batch-size 1 \
#                     --use-dataset-reader \
#                     --overrides "{"model": { "beam_size": ${BEAMSIZE}, "debug": ${DEBUG}}}" \
#                    ${MODEL_TAR} ${VALFILE}
#
#    echo -e "Predictions file saved at: ${PREDICTION_FILE}"
#done