# cvmfs_root_dir=/cvmfs
script_dir=$(cd $(dirname $0) && pwd)
fqrn_ch_cern_grid=grid.cern.ch
fqrn_jp_kek_grid=grid.kek.jp
# cern_grid_setup=$cvmfs_root_dir/$repo_cern_grid/etc/profile.d/setup-cvmfs-ui.sh


function unset_vars_once() {
    unset script_dir fqrn_ch_cern_grid fqrn_jp_kek_grid mount_dir_cern cern_grid_setup is_mounted_grid_cern_ch
    unset unset_vars_once
}

cvmfs_config status | grep -q "$fqrn_ch_cern_grid"
is_mounted_grid_cern_ch=$?

if test $is_mounted_grid_cern_ch -eq 0; then
    mount_dir_cern=$(cvmfs_config status | grep "$fqrn_ch_cern_grid" | awk '{print $4}')
    cern_grid_setup=$mount_dir_cern/etc/profile.d/setup-cvmfs-ui.sh

    if test -f $cern_grid_setup; then
        . $cern_grid_setup

        # overwride some variables
    	export X509_VOMS_DIR=$(cd $script_dir/.. && pwd)/grid-security/vomsdir
    	export VOMS_USERCONF=$(cd $script_dir/.. && pwd)/grid-security/vomses
        # site specific (with default)
        # set these too someting more appropriate to your site/region
    	# export MYPROXY_SERVER=myproxy.cern.ch
    	export LCG_GFAL_INFOSYS=kek2-bdii.cc.kek.jp:2170,bdii.grid.sinica.edu.tw:2170
    	export BDII_LIST=$LCG_GFAL_INFOSYS

        # if need be
    	export PERL5LIB=$PERL5LIB:$LCG_LOCATION/share/perl5

        # KEKCC specific config for multiple tcp streams transfer
        export GLOBUS_TCP_PORT_RANGE=20000,25000
    else
        echo "Not found: $cern_grid_setup" >&2
        unset_vars_once
        return 1
    fi
else
    echo "Not mounted: $fqrn_ch_cern_grid" >&2
    unset_vars_once
    return 1
fi
unset_vars_once
