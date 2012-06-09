#### Install requirements on ubuntu ####
    sudo apt-get install liblwp-useragent-determined-perl
    sudo apt-get install libssl-dev

    sudo cpan -i Crypt::SSLeay

#### Install ####
    Copy pushover.pl to .irssi/scripts/autorun/

#### Load script ####
    /script load autorun/pushover.pl

#### Configure ####
    Download https://pushover.net/ app and create account.
    In irssi run "/pushover [user_key]".
    To save settings run "/save".
