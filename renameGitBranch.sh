#!/bin/bash

# This script goes renames the specified branch to the
# supplied name, then pushes the new branch to the specified
# remote.  Then it deletes the original remote branch.
error[1]="Too many arguments."
error[2]="Unable unable to checkout the master branch."
error[3]="Unable to rename the $1 branch to $2."
error[4]="Unable to push the new branch to the remote $3."
error[5]="Unable to delete the old branch $1 from the remote $3."

function Usage {
	echo "***********************************************************"
	echo "* USAGE:                                                  *"
	echo "***********************************************************"
	echo "*		renameGitBranch.sh <oldName> <newName> <remote>     *"
	echo "*		renameGitBranch.sh <null> (show this text)          *"
	echo "***********************************************************"
}
function Error {
    echo "***********************************************************" 2>&1
    echo "                          ERROR!!!!!" 2>&1
    echo "***********************************************************" 2>&1
    echo "Error: $1" 2>&1
    echo "${error[$1]}" 2>&1
    echo "***********************************************************" 2>&1
    exit "$1"
}

if [ "$#" -eq 3 ]; then
	git checkout master || Error 2
	git branch -m $1 $2 || Error 3
	git push --set-upstream $3 $2 || Error 4
	git push origin :$1 || Error 5
	exit 0
else
	if [ "$#" -gt 1 ]; then
		Usage
		Error 1
	fi
	Usage
	exit 0
fi
