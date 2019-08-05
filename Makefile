nixroot    = /etc/nixos
nixconf    = configuration.nix 
nixhconf   = hardware-configuration.nix
nixreb     = nixos-rebuild
configs    = configs
home       = ${HOME}
pwd        = $(shell pwd)

build: 
	$(nixreb) build

test: cp_nixconf
	$(nixreb) test

switch: test
	$(nixreb) switch

boot: test
	$(nixreb) boot

setup:
	cp configs/.emacs $(home)
#	cp configs/.i3config $(home)/.config/i3/config
	cp configs/.zshrc $(home)
	cp configs/.gitconfig $(home)

cp_nixconf:
	cp $(nixconf) $(nixroot) 

# TODO: finish the different configs
desktop: cp_desktop_conf
	sleep 1

thinkpad: cp_thinkpad_conf
	sleep 1


# end
