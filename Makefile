nixroot    = /etc/nixos
nixconf    = configuration.nix 
nixhconf   = hardware-configuration.nix
nixreb     = nixos-rebuild
configs    = configs
home       = ${HOME}
pwd        = $(shell pwd)


switch:
	$(nixreb) test
	$(nixreb) switch

boot:
	$(nixreb) test
	$(nixreb) boot


setup:
	cp configs/.emacs $(home)
#	cp configs/.i3config $(home)/.config/i3/config
	cp configs/.zshrc $(home)
	cp configs/.gitconfig $(home)

# end
