set -e

# remember to run `make savedefconfig`` and `make linux-savedefconfig`
cp buildroot/output/build/linux-custom/.config licheepi-nano/board/licheepi_nano/licheepi_nano_linux_defconfig
docker cp $CONTAINER_NAME:/root/licheepi-nano/board .
docker cp $CONTAINER_NAME:/root/licheepi-nano/configs .
docker cp $CONTAINER_NAME:/root/licheepi-nano/Config.in .
docker cp $CONTAINER_NAME:/root/licheepi-nano/external.desc .
docker cp $CONTAINER_NAME:/root/licheepi-nano/external.mk .
