tty -s || return;

NORMAL=$(tput sgr0);
BOLD=$(tput bold);
RED=$(tput setaf 1);
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
BLUE=$(tput setaf 4);
MAGENTA=$(tput setaf 5);
CYAN=$(tput setaf 6);

parse_git_branch () {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    else
        if [ -d CVS ]; then
            gitver=$(cat CVS/Root | cut -d'/' -f3)
        else
            return 0
        fi
    fi
    echo -e $gitver
}

branch_color () {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        color=""
        if [ -z "$(git status -s)" ]; then
            color=${GREEN}
        else
            color="$BOLD$RED"
        fi
    else
        if [ -d CVS ]; then
            color="$BOLD$CYAN"
        else
            return 0
        fi
    fi
    echo -ne $color
}
#echo -ne $NORMAl
#echo -ne $BOLD
#PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]][casdev-\u@\h \w]$ '
#PS1="[\[$BOLD$BLUE\]\u\[$NORMAL\]@\[$BOLD\]\[$RED\]\h RVD !!! \[$BOLD$YELLOW\]\W\[$NORMAL\]][\[\$(branch_color)\]\$(parse_git_branch)\[$NORMAL\]]\\\$ "
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#rvandam@rvd-lenovo:~/git/p5-Compiler-Lexer$
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
PS1='[\[$BOLD${GREEN}\]\u@\h\[$NORMAL\]:\[$BLUE$BOLD\]\w\[$NORMAL\]][\[$(branch_color)\]$(parse_git_branch)\[$NORMAL\]]\$ '
