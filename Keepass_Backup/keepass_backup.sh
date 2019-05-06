#! /usr/bin/env bash

BASEDIR=/tmp/keepass_backup
LOG_FILE=${BASEDIR}/keepass_backup.log
PIPE_FILE=${BASEDIR}/pipe
DEVICE_UUID="2279-AF60"


trap cleanup EXIT

cleanup() {
    rm -f ${PIPE_FILE}
}

getMountPoint() {
    DEVICE_NODE=$(realpath /dev/disk/by-uuid/${DEVICE_UUID})
    mount -l | grep "${DEVICE_NODE}" | cut -d' ' -f3
}

synchronize() {
    BACKUP_FOLDER="${HOME}/.local/share/keepassxc/backup/$(date -Iseconds)"
    BACKUP_BASE="$(dirname "${BACKUP_FOLDER}")"
    mkdir -p "${BACKUP_BASE}"
    cp -Rv "${MOUNT_POINT}/keepass" "${BACKUP_FOLDER}" 2>&1 >> ${LOG_FILE}
    ls -1 "${BACKUP_BASE}" | head -n-5 | xargs rm -rfv 2>&1 >> ${LOG_FILE}
}

mkdir -p ${BASEDIR}
tail -n20 ${LOG_FILE} 2>&1 > ${LOG_FILE}

MOUNT_POINT="$(getMountPoint)"
[[ -n "${MOUNT_POINT}" ]] && [[ -e "${MOUNT_POINT}" ]] && synchronize

[[ ! -p "${PIPE_FILE}" ]] && mkfifo ${PIPE_FILE}
while true
do
    if read -r line < ${PIPE_FILE}
    then
        if [[ "${line}" == "connected" ]]
        then
            while [[ ( -z "${MOUNT_POINT}" ) || ( ! -e "${MOUNT_POINT}" ) ]]
            do
                sleep 1
                MOUNT_POINT=$(getMountPoint)
            done
            synchronize
        else
            echo "Unhandled message: $line" >> ${LOG_FILE}
        fi
    fi
done

