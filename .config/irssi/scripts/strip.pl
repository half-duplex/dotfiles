use strict;
use vars qw($VERSION %IRSSI);
use Irssi qw(settings_get_str settings_add_str);

$VERSION = '0.1';
%IRSSI = (
    authors     => 'mal',
    contact     => 'mal@sec.gd',
    name        => 'Strip',
    description => 'Strip colors and control chars from messages. Based on cut\'s Cloud to Butt.',
    license     => 'GPLv3'
    );

sub dispatch {
    my ($server, $data, $nick, $host, $channel) = @_;
    my ($target, $text) = split(/ :/, $data, 2);
    #$data =~ s/[^[:print:]](?:\d{1,2}(?:,\d{1,2})?)?//g;
    $data =~ s/([^[:print:]])(?:(\d{1,2})(?:,\d{1,2})?)?/\1\2/g;
    Irssi::signal_continue($server, $data, $nick, $host, $channel);
}

Irssi::signal_add ('message public', \&dispatch);
