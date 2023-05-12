#!/usr/bin/env bash

bucket=${S3_APP_BUCKET}
workspace_dir=`pwd`

s3_upload() {
    cd ${workspace_dir}/

    local app=${1}
    local version=${2}

    local package_dir="./services/${app}/package"
    rm -rf ${package_dir}
    mkdir -p ${package_dir}
    
    cp app/build/outputs/apk/official/release/app-official-release.apk ${package_dir}/Coinhub_$version.apk

    aws s3 cp ${package_dir}/Coinhub_$version.apk s3://${bucket}/package/
    scp ${package_dir}/Coinhub_$version.apk ememyk@47.93.230.57:/app
}

source .github/scripts/all_services.sh

push_tag() {
    local tag=${1}
    local prefix="official-"
    tag=${tag#$prefix}
    
    for service_name in "${all_services[@]}"
    do
        s3_upload ${service_name} ${tag}
    done
}

if [[ -n "$GITHUB_REF_NAME" ]]; then
    push_tag $GITHUB_REF_NAME
fi
