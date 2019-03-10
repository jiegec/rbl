arch := riscv32
kernel := target/$(arch)/debug/rbl
payload := ../rcore_plus_lab/kernel/target/$(arch)/debug/rcore
qemu-opts := \
		-smp cores=1 \
		-machine virt \
		-kernel $(kernel) \
		-nographic

.PHONY: build run debug $(kernel)

payload: $(payload)
	cp $(payload) payload

$(kernel): payload
	@cargo xbuild --target=$(arch).json

build: $(kernel)

run: build
	@qemu-system-$(arch) $(qemu-opts)

debug: build
	@tmux split-window "sleep 1 && rust-gdb $(kernel) -x gdbinit"
	@qemu-system-$(arch) $(qemu-opts) -s -S
