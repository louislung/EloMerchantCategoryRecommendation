#!/usr/bin/env bash
###############################################################################
#
# VERSION:      1.0
#
# DATE:         2017/12/14
#
# RETURN:
#    0 Success
#    1 Failure
#
# DESCRIPTION
#
# MODIFICATION HISTORY:
# Name           Date         Description
# =============  ===========  =================================================
# Louis Law      10-Dec-2017  initial version
#
###############################################################################


#
# Constants
#
FILE=`basename $0`


###############################################################################
#  Function
###############################################################################
quit() {
  log_error "Error in ${FILE}"
  log_info "Quiting..."
  exit 1
}

log() {
    msg_type=$1
    msg=$2

    timestamp=`date +'%Y-%m-%d %H:%M:%S'`

    case ${msg_type} in
        I) msg_type_text="[INFO] ";;
        W) msg_type_text="[WARN] ";;
        E) msg_type_text="[ERROR]";;
        S) msg_type_text="[START]";;
        E) msg_type_text="[END]  ";;
        *) show_usage;;
    esac

    #
    # Display the message
    #
    echo "${timestamp} ${msg_type_text} - ${FILE}: ${msg}"
}

log_info() {
	msg=$1
    log I "${msg}"
}

log_warn() {
	msg=$1
   log W "${msg}"
}

log_error() {
	msg=$1
    log E "${msg}"
}


###############################################################################
#  Main Program
###############################################################################
mkdir -p ./data
retcode=$?
if [ ${retcode} -ne 0 ]; then
    log_error "Fail to create data directory"
    quit
fi

log_info "Start download data"
cd data
kaggle competitions download -c elo-merchant-category-recommendation
if [ ${retcode} -ne 0 ]; then
    log_error "Fail to download data for elo-merchant-category-recommendation"
    quit
fi
chmod 777 *
log_info "Done download data"


log_info "Start unzip data"
cd data
unzip "*.zip"
if [ ${retcode} -ne 0 ]; then
    log_error "Fail to unzip data"
    quit
fi
chmod 777 *
log_info "Done unzip data"

log_info "Done, exit script"
exit 0
