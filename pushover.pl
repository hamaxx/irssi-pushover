# Push highlighted private messages to pushover.net service
# Author: Jure Ham (jure@hamsworld.net)
# Based on hilightwin code by Timo Sirainen

# Install requirements on ubuntu:
# sudo apt-get install liblwp-useragent-determined-perl
# sudo apt-get install libssl-dev
#
# sudo cpan -i Crypt::SSLeay

use Irssi;
use vars qw($VERSION %IRSSI);
use LWP::UserAgent;

$VERSION = "0.1";
%IRSSI = (
	authors	=> "Jure Ham",
	contact	=> "jure\@hamsworld.net",
	name	=> "pushover for irssi",
	description	=> "Push highlighted & private messages to pushover.net",
	license	=> "Public Domain",
	url		=> "http://irssi.org/",
	changed	=> "2012-10-04"
);

my ($user_token, $interval, %last_message);

$interval = 60; #TODO make it user configurable
%last_message = {};

sub sig_sendmsg {
	my ($dest, $text, $stripped) = @_;
	my $room = $dest->{target};

	if (($dest->{level} & (MSGLEVEL_HILIGHT|MSGLEVEL_MSGS)) &&
			($dest->{level} & MSGLEVEL_NOHILIGHT) == 0 &&
			$user_token) {

		if (!exists($last_message{$room}) || $last_message{$room} + $interval < time) {
			LWP::UserAgent->new()->post(
				"https://api.pushover.net/1/messages", [
				"token" => "uhkTxjW8gexkVMazXAj2CNBN4qPB7W",
				"user" => $user_token,
				"title" => $room,
				"message" => $stripped,
			]);
		}

		$last_message{$room} = time;

	}
}

sub cmd_pushover {
	my ($data, $server, $channel) = @_;

	if (!($data =~ /^[a-zA-Z0-9]{30}$/)) {
		Irssi::print("Invalid user token.");
		return 1;
	}

	$user_token = $data;

	Irssi::settings_set_str("pushover_user", $user_token);
	Irssi::print("pushover user: $user_token");
}

Irssi::settings_add_str("misc", "pushover_user", "");
$user_token = Irssi::settings_get_str("pushover_user");
if (!($user_token =~ /^[a-zA-Z0-9]{30}$/)) {
	Irssi::print("Setup pushover with \"/pushover user_key\" command");
}

Irssi::signal_add('print text', 'sig_sendmsg');
Irssi::command_bind('pushover', 'cmd_pushover');
