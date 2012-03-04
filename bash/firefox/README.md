Firefox scripts
===============

get-firefox
-----------
Script for download latest Firefox binaries from Mozilla's ftp.

Usage:

 ./get-firefox release/aurora/nightly

select-firefox
--------------
Script for select Firefox binary. You must have $HOME/bin in path. It looks for folders created by get-firefox and system firefox binary.

Usage:

 ./select-firefox list

 ./select-firefox set :number: (n)

n - if you want to make $HOME/bin/firefox symlink instead of firefox-bin.


License:
GPL-3
beerware
