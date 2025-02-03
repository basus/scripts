#!/usr/bin/env sh

reset='\033[0m'       # Reset
green='\033[0;32m'    # Green
blue='\033[0;34m'     # Blue
purple='\033[0;35m'   # Purple

# If there is a directory argument given, go to that directory
if [ ! -z $1 ] && [ -d $1 ]; then
    cd $1
fi;

# Clear the positional arguments array so we can use it to store the directories
# with uncommitted changes
set --

for dir in $(ls);
do
    if [ -d $dir ]; then
        pushd $dir > /dev/null 2>&1

        # Check if there is a .git directory
        if [ -d .git ]; then

            # Get all commit messages since midnight
            # The format adds 4 spaces before every line
            msgs=$(git log --since=midnight --pretty=format:%w\(0,4,4\)%s 2>&1)

            # Also get the git status for uncommitted changes
            changed=$(git status -s)
            ahead=$(git log --branches --not --remotes --oneline)

            # If the msgs are non-empty and don't start with "fatal", print them
            # The "fatal" check is required for git repos that have no commits yet
            # Print +more at the end if there are uncommitted changes
            if [ ! -z "$msgs" ] && [ "$msgs" = "${msgs#fatal}" ]; then
                [ ! -z "$changed" ] && c=" (${blue}changed$reset)" || c=""
                [ ! -z "$ahead" ] && a=" (${purple}ahead$reset)" || a=""
                echo "In $green$dir$reset:$c$a"
                echo "$msgs"
                echo ""
            fi;

            # Check if there are uncommitted changes, save the dir if there are
            if [ ! -z "$changed" ]; then
                set -- "$@" $dir
            fi;
        fi;
        popd > /dev/null 2>&1
    fi;
done

# Print directories with uncommitted changes, if any:
if [ ! -z $1 ]; then
    echo "${blue}Uncommitted changes in:${reset}"
    for dir in "$@";
    do
        echo "    $dir"
    done
fi;
