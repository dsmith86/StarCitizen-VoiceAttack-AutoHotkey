For more detailed instructions, you can go to https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey

=== Instructions ===
1. Navigate to the bin folder and double-click Setup.exe
2. In the newly opened window, choose an input directory (the directory that you downloaded to. Make sure it's unzipped, and make sure you choose the root directory with the "assets" and "bin" folders, among others).
3. Choose an output directory (that is, where you want to store your custom profile and scripts).
4. Select the packages you want to include and press "Convert Files and Finish"
5. Open VoiceAttack and import the profile in the output directory. You can find lots of information on how to do this. Try this guide: http://www.reddit.com/r/starcitizen/comments/28456x/tldr_how_to_install_voice_attack_for_star_citizen/
6. Enjoy!

=== Known Issues ===

+ GUI will not show a banner image if the assets folder is not present in the parent directory
+ Older versions of AutoHotkey may not be able to use the uncompiled version of the Setup script
+ Executable scripts seem to lose their custom icons when copied to the output folder with Setup.exe
+ Flight modes must be reset manually. I might add a feature later that corrects this.

=== Release Notes ===
v0.8.0 prerelease
2014/06/15
Initial release

+ Added a script for controlling Spotify from within Star Citizen (or any game, for that matter)
+ Added a script for better voice control of the IFCS flight modes within Star Citizen
+ Added a GUI that helps convert the scripts to properly configure dependencies and paths
+ Added a compile script that builds an executable from source