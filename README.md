To use irssi pushover you will need an account at [pushover.net](https://pushover.net/)

#### Install requirements on Ubuntu ####
    sudo apt-get install liblwp-useragent-determined-perl
    sudo apt-get install libssl-dev

    sudo cpan -i Crypt::SSLeay

#### Creat a link to the script ####
    ln -s /path/to/irssi-pushover/pushover.pl ~/.irssi/scripts/autorun/

#### Load the script in irssi ####
    /script load autorun/pushover.pl

#### Configure ####
    /pushover [user_key]
    /save
