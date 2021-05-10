#! /bin/sh

dk_list_tags() {
    local repo=${1}
    local page_size=${2:-20}
    [ -z "${repo}" ] && echo "Usage: listTags <repoName> [page_size]" 1>&2 && return 1

    local next="https://registry.hub.docker.com/v2/repositories/${repo}/tags/?page_size=${page_size}"
    local count=0

    while [ -n "${next}" ]; do
        curl -s -S "${next}" > /tmp/dk_list_tags
        local total=$(cat /tmp/dk_list_tags | jq -r '.count')
        next=$(cat /tmp/dk_list_tags | jq -r '.next')
        local num_results=$(cat /tmp/dk_list_tags | jq -r '.results | length')
        count=$(( count + num_results ))

        cat /tmp/dk_list_tags | \
            jq -r '[.results[] | {digest:(.images[] | select(.architecture == "amd64").digest),name:.name}] |
                group_by(.digest) |
                [.[] | {digest:.[0].digest, names:[.[].name]}] |
                .[] | (.digest[7:15] + ": " + (.names | join(", ")))' | \
            sort -k2

        if [ "${count}" -lt "${total}" ]; then
            echo ""
            echo "Results ${count} / ${total}"
            echo "Continue ?"
            read yn
        fi
    done
}

