Coda Wing Man 
=============

**Wing Man** displays a floating window that contains the list of files currently open in the foremost [Coda](http://panic.com/coda) window. Click on a file name to switch to the corresponding tab in Coda. This can be helpful when working with lots of files that would otherwise be squished in the tab bar.

Two targets are configured in the Xcode project; compile as a Coda plug-in or as a standalone app.

To install the plug-in, copy it into your _~/Library/Application Support/Coda/Plug-ins/_ directory and re-start Coda.

Features
--------
* Optionally show file path
* Abridge file path when file is inside the current site directory (plug-in only)
* Choose a custom font/color for the list
* Optionally always keep window visible

Known Limitations
-----------------
* The list does not automatically update when a tab is opened or closed in Coda. Please use the refresh button/menu item/key command or close and re-open the window as needed.