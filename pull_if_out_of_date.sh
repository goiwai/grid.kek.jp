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

function print_both() {
    local msg="$script_name[$(date '+%Y-%m-%d %H:%M:%S')]: \"$*\""
    echo "$msg" >&1
    echo "$msg" >&2
}

function echo_eval() {
    local cmd="$*"
    print_both "$cmd"
    eval $cmd
    return $?
}

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

# first check
echo_eval "cvmfs_server transaction $repo"
if test $? -ne 0; then
    # Repository grid.kek.jp is already in a transaction
    print_both "Leave the state of transaction first:"
    print_both "cvmfs_server transaction $repo"
    exit 1
else
    echo_eval "cvmfs_server abort -f $repo"
fi

print_both "Begin."
if $(out_of_date); then
    echo_eval "cvmfs_server transaction $repo"
    echo_eval "cd $git_dir"
    echo_eval "git pull"
    echo_eval "cd $HOME"
    echo_eval "cvmfs_server publish $repo"
else
    print_both "$repo: up to date."
fi
print_both "End."

exit 0
