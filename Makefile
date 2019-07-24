nixpkgsdir = $(shell pwd)/nixpkgs


setup:
	ln -s $(nixpkgsdir) ~/.config/nixpkgs
