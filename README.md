dokuwikistick-systraymenu
=========================

DokuWikiStick systray Menu

Replacement for bundled run.bat script.

Features are :
* Minimized MicroApache when it starts
* A systray icon with menu offering a quick access to these commands :
  * Browse DokuWikiStick website (the wiki)
  * Restart MicroApache
  * Explore DokuWikiStick folder
  * Browse GitHub website (only available if Documents\GitHub folder exists)
  * Explore Documents\GitHub folder (only available if Documents\GitHub folder exists)
  * Exit (kill MicroApache and exit from the script)

Command line parameters :
  * /sleep:n : sleep n seconds between MicroApache and browser start (must be an integer between 0 and 10)
  * /nb : no browsing launched automatically

Windows' default browser will be used unless you change the settings values in *DokuwikiStick.ini* file :
  * set *Force* value to 1
  * adapt the *Browser* value to reflect the path to desired browser executable

The only file you need is the executable.
If you don't want to download the exe file, here is how to compile the provided source file:
* Got to that page: https://www.autoitscript.com/site/autoit/downloads/
* Download and install AutoIt Full Installation (choose Edit when the install asks what to do when opening au3 files)
* Download and install AutoIt Script Editor
* Download the script source file (DokuWikiStick.au3) and one of the icons (DokuWikiStick.ico comes from http://www.splitbrain.org/blog/2007-12/01-dokuwiki_on_a_stick while I made DokuWikiStickGeekitude.ico)
* Open DokuWikiStick.au3 in AutoIt Script Editor
* In [Tools] menu, select [Compile]
* Make sure the icon you want is selected
* Click [Compile Script] (if an error about target file that can't be opened occurs, just try again)

