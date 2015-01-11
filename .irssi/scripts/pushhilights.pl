#
# Send push notification to phone/etc on hilight or private message
# By mal <mal@sec.gd>
# Released under GPLv3
#
# Uses Pushbullet, you must have that set up and your user token from
# https://www.pushbullet.com/account . Configure it using /set pushhilights
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

$VERSION = "2";
%IRSSI = (
    authors     => "mal",
    contact     => "mal\@sec.gd", 
    name        => "pushhilights",
    description => "Send push notification to pushbullet on hilight or PM",
    license     => "GPLv3",
    url         => "http://irssi.org/",
    changed     => "Sat Jan 10 20:00:00 UTC 2015"
);

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;
    my $outbody = $stripped;
    $outbody =~ s/([\\"])/\\\1/g;

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
            $outtitle = $dest->{server}->{tag}." ".$dest->{target};
        } else {
            $outtitle = $dest->{server}->{tag}." privmsg";
        }
        #Irssi::print("pushhilights: ".$outtitle." / ".$outbody, MSGLEVEL_NEVER);

        my $userAgent = LWP::UserAgent->new;
        $userAgent->env_proxy();

        my $response = $userAgent->post(
            "https://api.pushbullet.com/v2/pushes",
            authorization => "Bearer ".Irssi::settings_get_str('pushhilights_token'),
            content_type => "application/json",
            Content => '{"type":"note","title":"Hilight in '.$outtitle.'","body":"'.$outbody.'"}');
            # see https://docs.pushbullet.com/v2/pushes/

        if (!$response->is_success) {
            Irssi::print("pushhilights: Notification not posted: " . $response->content);
        }
    }
}

Irssi::settings_add_str('pushhilights','pushhilights_token','changeme');
Irssi::settings_add_bool('pushhilights','pushhilights_privmsg',1);
Irssi::settings_add_str('pushhilights','pushhilights_ignore_servers','');
Irssi::settings_add_str('pushhilights','pushhilights_ignore_channels','');

if(Irssi::settings_get_str('pushhilights_token') eq 'changeme') {
    Irssi::print("pushhilights: You have to configure me before use! See /set pushhilights and script comments.");
}

Irssi::signal_add('print text', 'sig_printtext');

# vim:set ts=4 sw=4 et:
