#!/bin/bash

set -xe
printf Restarting automount...
service autofs restart

printf \nMaking sure cvmfs is mounted
ls -alh /cvmfs/data.galaxyproject.org

printf \nMounting s3fs bucket: $AWS_BUCKET_NAME
s3fs $AWS_BUCKET_NAME /opt/s3fs/ -o kernel_cache -o max_background=1000 -o max_stat_cache_size=1000000 -o multipart_size=52 -o parallel_count=30 -o multireq_max=30 -o url="$AWS_ENDPOINT" -o endpoint="$AWS_REGION"

printf \nMaking sure s3fs is mounted
ls -alh /opt/s3fs/
