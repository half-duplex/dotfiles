#
# Send push notification to an android device on hilight or private message
# By mal <mal@sec.gd>
# Released under GPLv3
#
# Uses Pushover, you must have that set up, paid for (or on trial) and a user
# and app token. Configure the tokens using /set pushhilights
#
# TODO: Rate-limiting, and maybe retrying if not http 200
#
# Hilight finding logic from hilightwin.pl by cras and znx
#

use Irssi;
use LWP::UserAgent;
use POSIX;
use vars qw($VERSION %IRSSI); 

$VERSION = "0.2";
%IRSSI = (
    authors     => "mal",
    contact     => "mal\@sec.gd", 
    name        => "pushhilights",
    description => "Send push notification to android on hilight or PM",
    license     => "GPLv3",
    url         => "http://irssi.org/",
    changed     => "Sat Sep 6 18:00:00 UTC 2014"
);

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;
    my $output = $stripped;

    my $opt = MSGLEVEL_HILIGHT;
    if(Irssi::settings_get_bool('pushhilights_privmsg')) {
        $opt = MSGLEVEL_HILIGHT|MSGLEVEL_MSGS;
    }
    if(
        ($dest->{level} & ($opt)) &&
        ($dest->{level} & MSGLEVEL_NOHILIGHT) == 0
    ) {
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
                "timestamp" => time(),
                # optional: device, title, url, url_title, priority (-2 to 1 or 2 + retry + expire), sound
                # see https://pushover.net/api
        ]);

        if (!$response->is_success) {
            Irssi::print("pushhilights: Notification not posted: " . $response->content);
        }
    }
}

Irssi::settings_add_str('pushhilights','pushhilights_apptoken', 'changeme');
Irssi::settings_add_str('pushhilights','pushhilights_userkey', 'changeme');
Irssi::settings_add_bool('pushhilights','pushhilights_privmsg', 1);

if((Irssi::settings_get_str('pushhilights_apptoken') eq 'changeme')
 ||(Irssi::settings_get_str('pushhilights_userkey') eq 'changeme')) {
    Irssi::print("pushhilights: You have to configure me before use! See /set pushhilights");
}

Irssi::signal_add('print text', 'sig_printtext');

# vim:set ts=4 sw=4 et:
