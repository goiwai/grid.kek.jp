This is a repository of grid.kek.jp hosted on the Stratum-0 of cvmfs-stratum-zero.cc.kek.jp.

# Usage

To see supported VOs, use the [`show_supported_vo.sh`](show_supported_vo.sh). This will show you supported VOs like:

```
./show_supported_vo.sh
cdfj
g4med
geant4
kagra
ppj
vo.france-asia.org
```

If the VO you are belonging is listed, read the file [`/cvmfs/grid.kek.jp/etc/profile.d/setup-cvmfs-ui.sh`](etc/profile.d/setup-cvmfs-ui.sh) like:

```
. /cvmfs/grid.kek.jp/etc/profile.d/setup-cvmfs-ui.sh
```

If you want to read it anytime at your work, insert a line above into your init file, e.g. `$HOME/.bashrc`.

For other larger-scale VOs like ATLAS, Belle2, ILC, T2K, read the file `/cvmfs/grid.cern.ch/etc/profile.d/setup-cvmfs-ui.sh` instead.

If there were no VO configuration under the `/cvmfs/grid.cern.ch` nor `/cvmfs/grid.kek.jp`, send a request to `consult@kek.jp`. You can also send pull requests to https://github.com/goiwai/grid.kek.jp. Either is OK.
