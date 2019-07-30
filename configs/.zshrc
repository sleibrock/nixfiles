# steven's zshrc file
# contains aliases, memes, jokes, poorly-made hacks

# turn off dpms so screen never dims/turns off
xset s off -dpms

export ZSH=/home/steve/.oh-my-zsh


# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Add plugins here
plugins=(
  git
)


# Source the local ZSH programs
source $ZSH/oh-my-zsh.sh


# add any directories with binaries for development purposes
# If ruby version changes, update that path
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin   # ruby
export PATH=$PATH:$HOME/.cargo/bin            # rust
export GOPATH=$HOME/go                        # golang
export PATH=$PATH:$HOME/.opam/4.06.1/bin      # ocaml/opam

# OPAM environment ZSH hook
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


# google cloud related stuff (disable for the time being)
#export GCLOUD=$HOME/.gcloud
#source $GCLOUD/completion.zsh.inc
#source $GCLOUD/path.zsh.inc

# my personal gcloud dev appserver alias
alias dev_appserver="python2 $GCLOUD/bin/dev_appserver.py"

# My personal music directory
export MUSICDIR=/home/steve/Music


# Factorio related stuff
export FACTORIOPATH=$HOME/.factorio
export FACTORIOMODS=$FACTORIOPATH/mods

# try to set primary displays
#xrandr --output HDMI-A-1 --primary # desktop
xrandr --output eDP1 --primary     # thinkpad display


alias work_monitor="xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1600x900 --pos 1440x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1440x900 --pos 0x0 --rotate normal --output DP2 --off"
alias tv_output="xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1600x900 --pos 0x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080 --pos 1600x0 --rotate normal --output DP2 --off"

# Music replaygain tagging in current directory
alias replaygain_dir="mp3gain -r -s a *.mp3"

# Update pacman mirrors when they start acting slow
alias update_mirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syyu"


# Append more aliases and descriptions here as needed
alias halpmeh="echo \"HALPMEH Glyph activated\";
echo \"\";
echo \"Your personal commands:\";
echo \"SCREEN_ALWAYS_ON   - screen will never dim/fade\";
echo \"work_monitor       - turn on a secondary display\";
echo \"tv_output          - turn on secondary display (1080p)\";
echo \"replaygain_dir     - apply RG to an entire dir of MP3\";
echo \"update_mirrors     - update your pacman mirros\";
"



# actual bash functions go here

# Wine function to launch win32 binaries using a wine32 arch prefix
wine32(){
    WINEARCH=win32 WINEPREFIX=$HOME/.wine32 $@
}

# display temperatures in an infinite loop
# deprecated? requires third party "sensors" bin
temps(){
    while :;
    do
	clear
	sensors
	sleep 30
    done
}

# Convert any audio file to mp3 with ffmpeg
convert_mp3(){
    ffmpeg -i "$*" -b:a 320k -vn "$*.mp3"
}

# add a magnet uri string to the transmission tracker
tadd(){
    transmission-remote -a "$!"
}

# clear all entries from transmission
tclear(){
    transmission-remote -t all -r
}


# Download a youtube URL and convert it to mp3
ytdl(){
    last=$(pwd)
    if [ ! -d $HOME/.ytdl ]; then
	echo "Creating YTDL dir"
	mkdir -p $HOME/.ytdl
    fi

    echo "Entering YTDL dir"
    cd $HOME/.ytdl

    echo "Beginning YTDL"
    youtube-dl $1

    for f in *; do
	echo "Converting $f"
	convert_mp3 "$f"
	rm -rf "$f"
    done

    for m in *.mp3; do
	echo "Copying $m"
	cp "$m" $MUSICDIR
	rm -rf "$m"
    done

    cd $last
}

# display all active torrents in transmission
torrent_display(){
    count=`ps aux | grep transmission-daemon | wc -l`
    if [ $count -lt 2 ]; then
	echo "Starting Transmission"
	transmission-daemon &
	sleep 30;
    fi

    while :;
    do
	clear
	transmission-remote -l
	sleep 30
    done
}



# end
