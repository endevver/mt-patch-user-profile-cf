# 'User profiles custom field bug' patch plugin for Movable Type 4.3x #

This plugin implements a patch for Movable Type v4.3x installations running Custom Fields to resolve a bug in which values for user custom fields are not displayed on the user profile page.

## INSTALLATION ##

### Prerequisites ###

* Movable Type v4.3x with Custom Fields

### Download ###

The latest version of the plugin can be downloaded from the its
[Github repo][]. [Packaged downloads][] are also available if you prefer.

After downloading and unpacking the distribution archive, you will likely have
a directory called `mt-patch-user-profile-cf` containing the plugin's
`config.yaml` file, `lib` and `extlib` directories and a copy of this
`README`.

To install the plugin, simply move this directory to your MT installation's `plugins` directory.

[Github repo]: https://github.com/endevver/mt-patch-user-profile-cf
[Packaged downloads]:
 https://github.com/endevver/mt-patch-user-profile-cf/downloads

## CONFIGURATION ##

Upon installation, the plugin must be configured properly in order to be
activated. This is done by adding the following line to your `mt-config.cgi`
(replacing 4.35 with your current version of MT if it differs):

    UserProfileCFPatchEnabled 4.35

This activates the plugin for the specified version of Movable Type
***only***. Upon upgrade or removal of that line, the plugin resets to an
inactive state. 

This **explicit, release-specific activation** ensures that the
patch is not active after an upgrade in which the issue is finally resolved.

## USAGE ##

Once the plugin is in place and properly configured for the current version of
Movable Type, there's really nothing more to do. However, you can test that
it's working by doing the following:

   1. Create a user custom field if you don't yet have one
   2. Navigate to your user profile
   3. Add a value to your custom field and save your profile
   4. Note that when the page reloads, your value is shown
   5. Now, move this plugin out of the plugins directory and reload the page.
      You'll discover that your value has vanished. (If you're running 
      FastCGI, restart your webserver as well obviously)
   6. Restore the plugin, reload the page and voila, your value is back.

Next, you can simulate an upgrade by decrementing your
`UserProfileCFPatchEnabled` value to the last version or any previous version
of Movable Type:

    UserProfileCFPatchEnabled 4.0

Upon doing this, the plugin is rendered inactive and the bug will be
re-appear. Eventually, when the Movable Type team fixes this issue, the bug
will stay fixed even after an upgrade. At that point, you're free to remove
the plugin and the configuration directive although since it's disabled by
each upgrade there's no harm done if it's there.

<!--
-----------------------------------------------------------------------------
-->


## KNOWN ISSUES AND LIMITATIONS ##

None.

<!--
-----------------------------------------------------------------------------
-->

## SUPPORT, BUGS AND FEATURE REQUESTS ##

Please see <http://help.endevver.com/> for all of the above.

<!--
-----------------------------------------------------------------------------
-->

## LICENSE ##

This program is distributed under the terms of the GNU General Public License,
version 2.

<!--
-----------------------------------------------------------------------------
-->

## COPYRIGHT ##

Copyright 2011, [Endevver LLC](http://endevver.com). All rights reserved.

