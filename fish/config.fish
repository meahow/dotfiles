if status --is-interactive;
    [ -e $HOME/src/icas-sow4-tools/bash/icas.fish ]; and . $HOME/src/icas-sow4-tools/bash/icas.fish

    set LINUXBREWPATH "$HOME/.linuxbrew"
    if [ -d $LINUXBREWPATH/bin ] ;
      set PATH $LINUXBREWPATH/bin $PATH
    end
    if [ -d $LINUXBREWPATH/share/man ] ;
      set MANPATH $LINUXBREWPATH/share/man $MANPATH
    end
    if [ -d $LINUXBREWPATH/share/info ] ;
      set INFOPATH $LINUXBREWPATH/share/info $INFOPATH
    end

    #if [ -d $LINUXBREWPATH/etc/bash_completion.d ];
    #  for file in $LINUXBREWPATH/etc/bash_completion.d/*
    #    . $file
    #  end
    #end

end
