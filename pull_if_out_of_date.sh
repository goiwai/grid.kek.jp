#! /bin/sh
# cvmfs_server tansaction grid.kek.jp && git pull && cvmfs_server publish grid.kek.jp if updated.
# Usage example of run every 15 minutes:
# */15 * * * * cd $HOME/cron && ./pull_if_out_of_date.sh >> std.out 2>> std.err
script_name=$(basename $0)
script_dir=$(cd $(dirname $0) && pwd)
dir_at_exec=$(cd . && pwd)

LANG=POSIX
repo=grid.kek.jp
cvmfs_dir=/cvmfs/$repo
git_dir=$cvmfs_dir

function out_of_date() {
    cd $git_dir
    git remote show origin | tail -n 1 | grep -q 'out of date'
    return $?
}

function up_to_date() {
    cd $git_dir
    git remote show origin | tail -n 1 | grep -q 'up to date'
    return $?
}

dtstr=$(date)
echo $dtstr >&1
echo $dtstr >&2

if $(out_of_date); then
    cmd="cvmfs_server transaction $repo"
    echo $cmd
    eval $cmd

    cd $git_dir

    cmd="git pull"
    echo $cmd
    eval $cmd

    cd $HOME

    cmd="cvmfs_server publish $repo"
    echo $cmd
    eval $cmd
else
    echo "$repo: up to date."
fi

dtstr=$(date)
echo $dtstr >&1
echo $dtstr >&2
echo "End." >&1
echo "End." >&2

exit 0
