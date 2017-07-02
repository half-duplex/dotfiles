#!/usr/bin/perl -w

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";

%IRSSI = (
    authors     => 'mal',
    contact     => 'mal@sec.gd',
    name        => 'noctcp.pl',
    description => 'Shows CTCPs but doesn\'t respond to them',
    license     => 'GNU General Public License',
    url         => '',
    changed     => '2017-07-01 00:00:00',
);

Irssi::theme_register([
        'ctcp_rcvd', '[$0] %_%g$1%n [%g$2%n] %grequested CTCP %_$3%_ from %_$4%_%n: $5'
    ]);

sub ctcpreply {
    my ($server, $data, $nick, $address, $target) = @_;
    my ($request, $extra) = split(/ /, $data, 2);
    if ($request ne "ACTION") {
        Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'ctcp_rcvd',
            $server->{tag}, $nick, $address, $request, $target, $extra);
        Irssi::signal_stop();
    }
}

Irssi::signal_add('ctcp msg', 'ctcpreply');
