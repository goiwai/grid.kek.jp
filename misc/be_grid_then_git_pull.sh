#! /bin/sh
script_name=$(basename $0)
script_dir=$(cd $(dirname $0) && pwd)
dir_at_exec=$(cd . && pwd)

LANG=POSIX
repo=grid.kek.jp
cvmfs_dir=/cvmfs/$repo
git_dir=$cvmfs_dir
to_user=${repo%%.*}

cvmfs_server list | grep -q "^$repo.*stratum0.*local.*$"
if test $? -eq 0; then
    cd $git_dir && git remote show origin | tail -n 1 | grep -q 'out of date'
    if test $? -eq 0; then # out of date, hence to be updated
	sudo -u $to_user /bin/sh -c "cvmfs_server transaction $repo && cd $git_dir && git pull && cd && cvmfs_server publish $repo"
	if test $? -ne 0; then
	    echo "Fatal: encountered a fatal error while transaction..." >&2
	    cvmfs_server list >&2
	    exit 1
	fi
    else
	echo "A git repository $repo is up to date. No need to git pull. Successfully exiting."
    fi
else
    echo "Fatal: a repository $repo is in unexpected state..." >&2
    cvmfs_server list >&2
    exit 1
fi

exit 0