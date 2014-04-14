use strict;
use warnings;

use Irssi;

our $VERSION = '1.00';
our %IRSSI = (
        authors     => 'mal',
        contact     => 'mal@sec.gd',
        name        => 'IdleRPG NoMsg',
        description => 'Prevents messages from being accidentally sent to an idlerpg channel',
        license     => 'GPLv3'
);

Irssi::signal_add_first 'send text', 'my_handler';

sub my_handler {
    my ($text, $server, $win_item) = @_;
    if(defined($win_item->{name}) && $win_item->{name} eq '#irpg'){
        print 'Preventing message from being sent to quiet channel!';
        Irssi::signal_stop();
    };
};

