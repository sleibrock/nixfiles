nixpkgsdir = $(shell pwd)/nixpkgs
nixroot    = /etc/nixos
nixconf    = configuration.nix 
nixhconf   = hardware-configuration.nix

home_switch:
	home-manager switch


clean: clean_nix_root
	rm -rf result

nixos_build: link_nix_files
	nixos-rebuild build	

clean_nix_root:
	rm -rf $(nixroot)/$(nixconf)
	rm -rf $(nixroot)/$(nixhconf)

link_nix_files:
	ln 

setup:
	ln -s $(nixpkgsdir) ~/.config/nixpkgs
