#!/bin/sh -e

if [ $# -ne 2 ] ; then
	echo "Usage: $0 <bbl> <.ota-ext4 file>"
	exit 1
fi

set -x

qemu-system-riscv64  -machine virt -smp 2 -m 512 -serial mon:stdio -serial null \
    --drive file=$2,format=raw,id=hd0 \
    -kernel $1 \
    -append 'root=/dev/vda rw console=ttyS0' \
    -device virtio-blk-device,drive=hd0 \
    -device virtio-net-device,netdev=usernet \
    -netdev user,id=usernet,hostfwd=tcp::22222-:22 \
    -nographic

