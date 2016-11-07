#!/bin/bash
LOCK_NAME="OSYNC_PROCESS"
LOCK_DIR='/tmp/'${LOCK_NAME}.lock
PID_FILE=${LOCK_DIR}'/'${LOCK_NAME}'.pid'

if mkdir ${LOCK_DIR} 2>/dev/null; then
  # If the ${LOCK_DIR} doesn't exist, then start working & store the ${PID_FILE}
  echo $$ > ${PID_FILE}

  /etc/osync/osync.sh /etc/osync/syncN.conf --stats --verbose --no-initiator-delete 2> /dev/null

  rm -rf ${LOCK_DIR}
  exit
else
  if [ -f ${PID_FILE} ] && kill -0 $(cat ${PID_FILE}) 2>/dev/null; then
    # Confirm that the process file exists & a process
    # with that PID is truly running.
    echo "Running [PID "$(cat ${PID_FILE})"]" >&2
    exit
  else
    # If the process is not running, yet there is a PID file--like in the case
    # of a crash or sudden reboot--then get rid of the ${LOCK_DIR}
    rm -rf ${LOCK_DIR}
    exit
  fi
fi
