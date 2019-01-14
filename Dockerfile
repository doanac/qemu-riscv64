FROM alpine

RUN apk --no-cache add qemu-system-riscv64

COPY ./run.sh /run.sh
