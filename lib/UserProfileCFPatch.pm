package UserProfileCFPatch;

use strict;
use warnings;
use base qw( Data::ObjectDriver::BaseObject MT::ErrorHandler );

sub post_init {
    my ( $cb, $mt, $logger ) = @_;

    # Melody doesn't have this problem...
    return if $mt->product_code eq 'OM';

    # Check that UserProfileCFPatchEnabled config value matches
    # the current MT version. This ensures that the plugin is disabled
    # initially by default and is always automatically disabled upon
    # upgrade unless the sysadmin updates the config to the new version
    # number to re-enable it until next upgrade.
    if ( my $enabled_for_version = $mt->config->UserProfileCFPatchEnabled ) {
        return unless $enabled_for_version
                  and $enabled_for_version == $mt->version_number;
        
        require Sub::Install;
        Sub::Install::reinstall_sub({
                                       code => 'column_func_patched',
                                       from => __PACKAGE__,
                                       into => 'MT::Object',
                                       as   => 'column_func'
                                     });
    }
}

sub column_func_patched {
    my $obj = shift;
    my ($col) = @_;
    return if !$col;

    return $obj->SUPER::column_func(@_) if !$obj->is_meta_column($col);

    return sub {
        my $obj = shift;
        if (@_) {
            $obj->{__meta}->set( $col, @_ );
        }
        else {
            $obj->{__meta}->get($col);
        }
    };
}

1;