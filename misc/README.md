`be_grid_then_git_pull.sh` is a script to become a user such as `grid`, who is an owner of a repository `grid.kek.jp` on `cvmfs.cc.kek.jp`. Once becoming a user `grid`, this script process procedures below:

1. `cvmfs_server transaction grid.kek.jp`
1. `cd /cvmfs/grid.kek.jp && git pull`
1. `cvmfs_server publish grid.kek.jp`

Precautions:

- Don't execute this file directly like: `$ /cvmfs/grid.kek.jp/misc/be_grid_then_git_pull.sh`.
- Don't execute a symbolic link to `/cvmfs/grid.kek.jp/misc/be_grid_then_git_pull.sh`.
- Otherwise, CVMFS will be failed at `mount` and/or `unmount` the repository.
- Firstly hard copy to anywhere, e.g. home directory, other than in the repository, and then execute it.
- The PAM requires a tty at sudo-ing on `cvmfs.cc.kek.jp`. Periodic update by cron, therefore, is always failed with the message like: "sudo: sorry, you must have a tty to run sudo".
- Running a command through `ssh` from a remote host is also failed because of the same reason.
- SSH with `-t` option virtually allocates a tty so that it may be useful to avoid trapping.
