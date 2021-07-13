#!/usr/bin/env bash

set -x -o errexit -o nounset -o pipefail

# vars
export DOCKER_IMAGE=$(./ci/custom/get_docker_image_run.sh)

# get image
docker pull "${DOCKER_IMAGE}"

# test code isolatedly
docker run --rm \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --mount type=bind,source="$(pwd)",target=/srv/repository \
       "${DOCKER_IMAGE}" \
       /bin/bash -c \
       'cd /srv/repository; ./ci/custom/internal_test.sh'
