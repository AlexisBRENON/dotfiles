#! /usr/bin/env bash

set -eu

BASEDIR=/tmp/keepass_backup
LOG_FILE=${BASEDIR}/keepass_backup.log
PIPE_FILE=${BASEDIR}/pipe
DEVICE_UUIDS="2279-AF60 4EFC-6574"
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
    for UUID in ${DEVICE_UUIDS}; do
        if [[ -e "/dev/disk/by-uuid/${UUID}" ]]; then
            DEVICE_NODE=$(realpath /dev/disk/by-uuid/${UUID})
            MOUNT_POINT=$(mount -l | grep "${DEVICE_NODE}" | cut -d' ' -f3)
            break
        fi
    done
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
    rm -f "${BACKUP_BASE}/latest"
    ln -s "${BACKUP_FOLDER}" "${BACKUP_BASE}/latest"
    log "Synchronisation done"
}

mkdir -p ${BASEDIR}
tail -n20 ${LOG_FILE} 2>&1 > ${LOG_FILE}

getMountPoint
[[ -n "${MOUNT_POINT}" ]] && [[ -e "${MOUNT_POINT}" ]] && synchronize

[[ ! -p "${PIPE_FILE}" ]] && log "Creating FIFO file" && mkfifo "${PIPE_FILE}"
while true
do
    log "Waiting for message in pipe"
    if read -r line < "${PIPE_FILE}"
    then
        if [[ "${line}" == "connected" ]]
        then
            if waitMount
            then
                synchronize
            else
                log "Device was never mounted..."
            fi
        else
            log "Unhandled message: $line"
        fi
    fi
done

