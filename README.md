This is a repository of `grid.kek.jp` hosted on the Stratum-0 of `cvmfs-stratum-zero.cc.kek.jp`. This repository contains configuration files that 


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

## Example: Send a pull request for the VO: virtorg

Here is a typical sequence that you add the VO-specific configuration into the repository. Let's say the VO name is `virtorg` here. Firstly clone the repository and create a branch `virtorg` like:

```
git clone https://github.com/goiwai/grid.kek.jp.git
cd grid.kek.jp
git checkout -b virtorg
```

Then add/edit files like:

```
mkdir etc/grid-security/vomsdir/virtorg
echo <<EOF > etc/grid-security/vomsdir/virtorg/voms.grid.org.lsc
/C=ZZ/O=YYY/OU=XXX/CN=host/voms.grid.org
/C=ZZ/O=YYY/OU=XXX/CN=Grid Certificate Authority
EOF

echo '"virtorg" "voms.grid.org" "12345" "/C=ZZ/O=YYY/OU=XXX/CN=host/voms.grid.org" "virtorg"' > etc/grid-security/vomsdir/virtorg/virtorg-voms.grid.org
```

Then commit and push like:

```
git add .
git commit .               # You may leave the comment.
git push origin virtorg
```

In case of that your `git` doesn't accept a sub command `pull-request` since `pull-request` is a **github proprietary** function, you may send a pull-request via the browser instead. Visit https://github.com/goiwai/grid.kek.jp/tree/virtorg and find the word "Pull request" on the top-right of file list, and then click it. That's it!
