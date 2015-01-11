#
# Send push notification to an android device on hilight or private message
# By mal <mal@sec.gd>
# Released under GPLv3
#
# Uses Pushover, you must have that set up, paid for (or on trial) and a user
# and app token. Configure the tokens using /set pushhilights
# Format for ignored channels/servers is comma separated no space: #ch1,#irpg
#
# TODO: Rate-limiting, and maybe retrying if not http 200
#
# Hilight finding logic from hilightwin.pl by cras and znx
#

use Irssi;
use LWP::UserAgent;
use POSIX;
use vars qw($VERSION %IRSSI); 

$VERSION = "1";
%IRSSI = (
    authors     => "mal",
    contact     => "mal\@sec.gd", 
    name        => "pushhilights",
    description => "Send push notification to android on hilight or PM",
    license     => "GPLv3",
    url         => "http://irssi.org/",
    changed     => "Sat Jan 10 18:00:00 UTC 2015"
);

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;
    my $output = $stripped;

    my $opt = MSGLEVEL_HILIGHT;
    if(Irssi::settings_get_bool('pushhilights_privmsg')) {
        $opt = $opt|MSGLEVEL_MSGS;
    }
    if(
        ($dest->{level} & ($opt)) &&
        ($dest->{level} & MSGLEVEL_NOHILIGHT) == 0
    ) {
        my @ignoreservers = split(',',Irssi::settings_get_str('pushhilights_ignore_servers'));
        my @ignorechannels = split(',',Irssi::settings_get_str('pushhilights_ignore_channels'));
        if(($dest->{server}->{tag} ~~ @ignoreservers)||($dest->{target} ~~ @ignorechannels)) {
            return();
        }
        if ($dest->{level} & MSGLEVEL_PUBLIC) {
            $output = $dest->{server}->{tag}." ".$dest->{target}." ".$output;
        } else {
            $output = $dest->{server}->{tag}." privmsg: ".$output;
        }
        #Irssi::print("pushhilights: ".$output, MSGLEVEL_NEVER);

        my $userAgent = LWP::UserAgent->new;
        $userAgent->env_proxy();

        my $response = $userAgent->post(
            "https://api.pushover.net/1/messages.json", [
                "token" => Irssi::settings_get_str('pushhilights_apptoken'),
                "user" => Irssi::settings_get_str('pushhilights_userkey'),
                "message" => $output,
                "priority" => Irssi::settings_get_int('pushhilights_priority'),
                "timestamp" => time(),
                # see https://pushover.net/api
        ]);

        if (!$response->is_success) {
            Irssi::print("pushhilights: Notification not posted: " . $response->content);
        }
    }
}

Irssi::settings_add_str('pushhilights','pushhilights_apptoken','changeme');
Irssi::settings_add_str('pushhilights','pushhilights_userkey','changeme');
Irssi::settings_add_bool('pushhilights','pushhilights_privmsg',1);
Irssi::settings_add_int('pushhilights','pushhilights_priority',0);
Irssi::settings_add_str('pushhilights','pushhilights_ignore_servers','');
Irssi::settings_add_str('pushhilights','pushhilights_ignore_channels','');

if((Irssi::settings_get_str('pushhilights_apptoken') eq 'changeme')
 ||(Irssi::settings_get_str('pushhilights_userkey') eq 'changeme')) {
    Irssi::print("pushhilights: You have to configure me before use! See /set pushhilights");
}

Irssi::signal_add('print text', 'sig_printtext');

# vim:set ts=4 sw=4 et:
