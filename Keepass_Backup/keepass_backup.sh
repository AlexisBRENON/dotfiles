#! /usr/bin/env bash

set -eu

BASEDIR=/tmp/keepass_backup
LOG_FILE=${BASEDIR}/keepass_backup.log
PIPE_FILE=${BASEDIR}/pipe
DEVICE_UUID="2279-AF60"
DEVICE_NODE=""
MOUNT_POINT=""


trap cleanup EXIT

log() {
    echo "$(date -Iseconds) # $@" | tee -a ${LOG_FILE}
}

cleanup() {
    log "Exiting"
    rm -f ${PIPE_FILE}
    log "Exited"
}

getMountPoint() {
    log "Looking for mount point."
    DEVICE_NODE=$(realpath /dev/disk/by-uuid/${DEVICE_UUID})
    MOUNT_POINT=$(mount -l | grep "${DEVICE_NODE}" | cut -d' ' -f3)
    log "$DEVICE_NODE is mounted on '${MOUNT_POINT}'."
}

waitMount() {
    for I in $(seq 1 30)
    do
        if [[ ( -z "${MOUNT_POINT}" ) || ( ! -e "${MOUNT_POINT}" ) ]]
        then
            sleep 1
            getMountPoint
        else
            return 0
        fi
    done
    return 1
}

synchronize() {
    log "Launching synchronization."
    BACKUP_FOLDER="${HOME}/.local/share/keepassxc/backup/$(date -Iseconds)"
    BACKUP_BASE="$(dirname "${BACKUP_FOLDER}")"
    mkdir -p "${BACKUP_BASE}"
    cp -Rv "${MOUNT_POINT}/keepass" "${BACKUP_FOLDER}" 2>&1 >> ${LOG_FILE}
    ls -1 "${BACKUP_BASE}" | head -n-5 | xargs rm -rfv 2>&1 >> ${LOG_FILE}
    log "Synchronisation done"
}

mkdir -p ${BASEDIR}
tail -n20 ${LOG_FILE} 2>&1 > ${LOG_FILE}

getMountPoint
[[ -n "${MOUNT_POINT}" ]] && [[ -e "${MOUNT_POINT}" ]] && synchronize

[[ ! -p "${PIPE_FILE}" ]] && mkfifo ${PIPE_FILE}
while true
do
    if read -r line < ${PIPE_FILE}
    then
        if [[ "${line}" == "connected" ]]
        then
            if waitMount
            then
                synchronize
            else
                log "Device was never mounted..."
            fi
            synchronize
        else
            echo "Unhandled message: $line" >> ${LOG_FILE}
        fi
    fi
done

