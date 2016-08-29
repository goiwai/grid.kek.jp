#! /bin/sh
script_name=$(basename $0)
script_dir=$(cd $(dirname $0) && pwd)
dir_at_exec=$(cd . && pwd)

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

if $(out_of_date); then
    cvmfs_server transaction $repo
    cd $git_dir
    git pull
    cd $HOME
    cvmfs_server publish $repo
else
    echo "$repo: up to date."
fi

exit 0
