SHELL ::= /bin/bash


# ASSUME DEBIAN LINUX / UBUNTU


prepare-system: 99-microbit.rules
	rustup component add llvm-tools-preview
	cargo install cargo-binutils --vers 0.3.3
	sudo apt-get install -y pkg-config libusb-1.0-0-dev libftdi1-dev libudev-dev libssl-dev
	# cargo install probe-rs --features cli,ftdi
	cargo install cargo-embed --vers 0.18.0
	sudo cp -vf 99-microbit.rules /etc/udev/rules.d/99-microbit.rules
	sudo apt-get install -y gdb-multiarch minicom
	sudo udevadm control --reload-rules # refresh udev to enact new rules




.PHONY: monitor verify-installation
monitor:
	udevadm monitor

verify-installation: verify-permissions
	@echo "installation verified"


verify-permissions:
	lsusb | grep -i "NXP ARM mbed"
	@echo "device assigned to file path: '/dev/bus/usb/<bus-number>/<device-number>'"
