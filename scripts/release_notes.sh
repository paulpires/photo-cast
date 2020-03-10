#!/bin/bash

# Stop on failure
set -e

# http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
for i in "$@"
do
case $i in
    --from=*)
    FROM="${i#*=}"
    ;;

    --to=*)
    TO="${i#*=}"
    ;;

    *)
        # unknown option
    ;;
esac
done

if [ -z "${FROM}" ] || [ -z "${TO}" ]; then
    read -p "Enter FROM tag: " FROM
    read -p "Enter TO tag: " TO
fi

git --no-pager log $FROM..$TO --merges --first-parent $TO --format="%C(auto) %h %s"
