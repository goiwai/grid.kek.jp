#! /bin/sh
script_name=$(basename $0)
script_dir=$(cd $(dirname $0) && pwd)
dir_at_exec=$(cd . && pwd)

vomsdir=$script_dir/etc/grid-security/vomsdir

for f in $vomsdir/*; do
    if test -d $f; then
	ls $f/*.lsc > /dev/null 2>&1
	if test $? -eq 0; then
	    echo $(basename $f)
	fi
    fi
done

exit 0
