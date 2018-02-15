#Adding github token for homebrew
set -x HOMEBREW_GITHUB_API_TOKEN '7c6083df6c0665bb024d1440b298b33ef829565b'

#IDA path vars to make it easy to access
set -x IDA32PATH "$HOME/.wine/drive_c/Program Files (x86)/IDA 6.8/idaq.exe"
set -x IDA64PATH "$HOME/.wine/drive_c/Program Files (x86)/IDA 6.8/idaq64.exe"
set -x IDAPATH "$HOME/.wine/drive_c/Program Files (x86)/IDA 6.8"

#My Python2.7 library path
set -x MYLIBPATH "$HOME/.tools/mylib"

#This one need for stable working RLS
set -x RUST_SRC_PATH "(rustc --print sysroot)/lib/rustlib/src/rust/src"

#Setting GOvars to valid values
set -x GOPATH $HOME/gowork
set -x GOROOT /usr/local/Cellar/go@1.6/1.6.4/libexec
set -x PATH $PATH $GOROOT/bin

set -x PATH $PATH "$HOME/.tools/pwnbox/stop-scripts"

#Aliases
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias lf="ls -F"
alias vim="nvim"
alias gdb="gdb -q"
alias avr-gdb="avr-gdb -q"
alias pycdc="$HOME/.tools/pycdc/pycdc"
alias pycdas="$HOME/.tools/pycdc/pycdas"
alias signapk="java -jar $HOME/.tools/signapk.jar"
alias sign="java -jar $HOME/.tools/sign.jar"
alias xortool="$HOME/.tools/xortool/xortool/xortool"
alias xortool-xor="$HOME/.tools/xortool/xortool/xortool-xor"


#Be careful with this alias, it's private apple framework
#alias airport='~/.tools/airport'
#alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'

function subl -a file
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $file
end

function ihex
    open /Applications/iHex.app --args (pwd)/$argv
end

function start-docker-daemon
    open /Applications/Docker.app/
end

function safari
	open /Applications/Safari.app --args $argv
end

function parallels
	open /Applications/Parallels\ Desktop.app/ --args $argv
end

function vkcli
    open /Applications/VK.app/ --args $argv
end

function winvm
	open /Users/mostobriv/Parallels/Windows\ 7.pvm
end

function extract
	for elem in $argv
		if test -e $elem
			switch $elem
				case '*.tar.bz2'
					tar xjvf $elem
				case '*tar.gz'
					tar zxvf $elem
				case '*.bz2'
					bunzip2 $elem
				case '*.rar'
					unrar x $elem
				case '*.gz'
					gunzip $elem
				case '*.tar'
					tar xvf $elem		
				case '*.xz'
					xz -dv $elem
                case '*.tbz2'
					tar xjf $elem		
				case '*.tbz'
				    tar -xjvf $elem	
                case '*.tgz'
                    tar xzf $elem		
				case '*.zip'
                    unzip $elem		
				case '*.Z'
                    uncompress $elem	
                case '*.7z'
                    7za x $elem		
                case '*'
                    echo 'Unknown file extension'
            end
        else
            echo 'No such file'
		end
	end
end


function transfer -a target
    if test (count $argv) -eq 0
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    end
    
    if test -d $target
        set tmp (basename $target | sed -e 's/[^a-zA-Z0-9._-]/-/g')
        set tmp "/tmp/$tmp.tar.gz"
        tar zcf $tmp $target
        set target $tmp
    end
    
    set tmpfile (mktemp -t transferXXX)
    if test -t 0
        set basefile (basename $target | sed -e 's/[^a-zA-Z0-9._-]/-/g')
        curl --progress-bar --upload-file $target "https://transfer.sh/$basefile" >> $tmpfile; 
    else 
        curl --progress-bar --upload-file "-" "https://transfer.sh/"$target >> $tmpfile ; 
    end
	
    cat $tmpfile
	echo
	rm -f $tmpfile
end

function angrdocker
	docker run -it \
	--name angrdocker \
    --rm \
	-v /Users/mostobriv/Pllshar:/home/angr/share \
    angr/angr 
end

function pwndocker -a name
	fish /Users/mostobriv/.tools/pwnbox/run.fish $name
end

function copy-to-clipboard
	cat $argv[1] | pbcopy
end

function ida32
    wine  $IDA32PATH $argv > /dev/null ^&1 &
end

function ida64
    wine $IDA64PATH $argv > /dev/null ^&1 &
end

function binaryninja
	open /Applications/Binary\ Ninja.app --args (pwd)/$argv
end

function burpsuite
	set BURP_PATH '/Users/mostobriv/.tools/burpsuite'
	java -cp $BURP_PATH/BurpLoader.jar:$BURP_PATH/burpsuite_pro.jar larry.lau.BurpLoader
end

function mywebproxy -a mode
	switch $mode
		case 'on'
			networksetup -setwebproxystate Wi-Fi on
		case 'off'
			networksetup -setwebproxystate Wi-Fi off
		case 'help'
			echo -e 'To set system webhttpproxy on | off\nOPTIONS: on | off'
		case '*'
			echo 'Ti chto durak blyat?'
	end
end

source $HOME/.cargo/env
