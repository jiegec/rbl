arch := riscv32
kernel := target/$(arch)/debug/rbl
qemu-opts := \
		-smp cores=1 \
		-machine virt \
		-kernel $(kernel) \
		-nographic

.PHONY: build run debug $(kernel)

$(kernel):
	@cargo xbuild --target=$(arch).json

build: $(kernel)

run: build
	@qemu-system-$(arch) $(qemu-opts)

debug:
	@tmux split-window "sleep 1 && rust-gdb $(kernel) -x gdbinit"
	@qemu-system-$(arch) $(qemu-opts) -s -S
