set -e

docker cp board $CONTAINER_NAME:/root/licheepi-nano/
docker cp configs $CONTAINER_NAME:/root/licheepi-nano/
docker cp Config.in $CONTAINER_NAME:/root/licheepi-nano/
docker cp external.desc $CONTAINER_NAME:/root/licheepi-nano/
docker cp external.mk $CONTAINER_NAME:/root/licheepi-nano/
