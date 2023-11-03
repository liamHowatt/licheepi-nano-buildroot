set -e

docker cp $CONTAINER_NAME:/root/licheepi-nano/board .
docker cp $CONTAINER_NAME:/root/licheepi-nano/configs .
docker cp $CONTAINER_NAME:/root/licheepi-nano/Config.in .
docker cp $CONTAINER_NAME:/root/licheepi-nano/external.desc .
docker cp $CONTAINER_NAME:/root/licheepi-nano/external.mk .
