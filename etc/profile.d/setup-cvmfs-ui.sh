cvmfs_root_dir=/cvmfs
repo_cern_grid=grid.cern.ch
repo_kek_grid=grid.kek.jp
cern_grid_setup=$cvmfs_root_dir/$repo_cern_grid/etc/profile.d/setup-cvmfs-ui.sh
cvmfs_config status | grep -q "$repo_cern_grid"
is_mounted_grid_cern_ch=$?

function unset_vars_once() {
    unset cvmfs_root_dir repo_cern_grid repo_kek_grid cern_grid_setup is_mounted_grid_cern_ch
    unset unset_vars_once
}

if test $is_mounted_grid_cern_ch -eq 0; then
    if test -f $cern_grid_setup; then
        . $cern_grid_setup

        # overwride some variables
    	export X509_VOMS_DIR=$cvmfs_root_dir/$repo_kek_grid/etc/grid-security/vomsdir
    	export VOMS_USERCONF=$cvmfs_root_dir/$repo_kek_grid/etc/grid-security/vomses
        # site specific (with default)
        # set these too someting more appropriate to your site/region
    	# export MYPROXY_SERVER=myproxy.cern.ch
    	export LCG_GFAL_INFOSYS=kek2-bdii.cc.kek.jp:2170,bdii.grid.sinica.edu.tw:2170
    	export BDII_LIST=$LCG_GFAL_INFOSYS

        # if need be
    	export PERL5LIB=$PERL5LIB:$LCG_LOCATION/share/perl5
    else
        echo "Not found: $cern_grid_setup" >&2
        unset_vars_once
        return 1
    fi
else
    echo "Not mounted: grid.cern.ch" >&2
    unset_vars_once
    return 1
fi
unset_vars_once
