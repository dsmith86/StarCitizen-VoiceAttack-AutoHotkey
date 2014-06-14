StarCitizen-VoiceAttack-AutoHotkey
==================================
### Table of contents:
1. [What is Star Citizen? VoiceAttack?](#intro)
2. [VoiceAttack and AutoHotkey](#ahk)
3. [Instructions](#instructions)

*NOTE: if you're already familiar with Star Citizen and VoiceAttack, feel free to skip this section.*

<a name="intro"></a>
# What is Star Citizen? VoiceAttack?

For the uninitiated, [Star Citizen][star_citizen] is a massive single- and multi-player crowdfunded space sim that is currently in development. It's broken all sorts of records in funding, and as of June 13, 2014, it has raised $46,234,125 (NOTE: I'm pretty sure that by the time you're reading this, that number is much, much higher).

Anyways, the dogfighting module, Arena Commander, was released on June 6, 2014, and those of us who are backers have been enthusiastically playing the game ever since. If you haven't pledged yet but want to join in on the fun, it isn't terribly expensive to get your ship and an Arena Commander pass. You can get a ship [here][pledge], and a pass [here][pass]. Make sure your ship package says "Game Package"; otherwise, you won't get the final game!

VoiceAttack, the main focus of this repository, is a Windows program that lets you assign keyboard macros and other similar tasks to voice commands. This really improves gameplay in Arena Commander, especially if you are using a joystick, like me (Thrustmaster T.16000M).

<a name="ahk"></a>
## VoiceAttack and AutoHotkey
Some of you may already know about [AutoHotkey][autohotkey], and I'm sure some of you have way more experience with it than I do! If you don't know what it is, it's basically a free and open-source macro and automation tool for Windows. If you thought VoiceAttack was powerful, wait til you see what you can do with AutoHotkey!

It's got a bit of a learning curve, but I made two sample scripts that several of my VoiceAttack commands use. I've documented them thoroughly, and they're pretty efficient as well! Let's take a look at the two scripts:

### [flightmode.ahk][flightmode]
This script is my favorite of the two! You know how you have to cycle through each combination of Comstab and G-Safe toggles one by one? It gets rather confusing, especially if you want voice commands, in which case you pretty much have to reset everything before chosing another flight mode. Not any more! 

Just use one of the commands in my VoiceAttack profile, and *flightmode.ahk* will keep track of the state of each toggle. All you have to do is reset the state of everything whenever you spawn (my command is "reset flight modes"), and then you can toggle all three flight modes on and off, and it will behave as expected.

If you want to know what is going on under the hood, I'm basically representing each possible state for the flight mode with its corresponding binary number. For each mode, *off* means 0, and *on* means one. so, if you're in Coupled Mode with G-Safe and Comstab on, that number is 111. And then I do some clever bitwise operations to change the state of each of those digits as needed. It behaves really well, and it's clean code! Now, on to the second script:

### [spotify.ahk][spotify]
I know that a lot of twitch streamers like to play music while they stream. I've not streamed on twitch yet, but I certainly like to cycle through some different styles of music while I game. So I've come up with a pretty nice solution. This script, also backed by VoiceAttack commands, is able to play and pause your Spotify music, skip to the next track, and even adjust the music's volume. It does this by specifically sending keystrokes [defined here by Spotify][spotify_shortcuts] directly to the Spotify window, whether it's open but not in focus, or even minimized to the system tray. I imagine it wouldn't too hard to add scripts for additional music players using my sample, as long as that player has sufficient keyboard shortcuts. Now, let's check out the instructions:

<a name="instructions"></a>

1. Download and install AutoHotkey: [Link to download page][autohotkey].
2. Download this repository either [here] or by cloning the repository with git.
3. Unzip if needed and save the folder somewhere on your hard drive.
4. Use the following script to set up the VoiceAttack profile to point to the right directory for the AutoHotkey scripts: [incoming].
5. Import the profile into VoiceAttack.
6. Enjoy! Also, let me know if there are any bugs or anything you think is wrong. Also, feel free to suggest new features, or fork the repository yourself!

*NOTE: My profile has 37 hand-crafted commands. Ifyou have a trial version of VoiceAttack, you'll have to be picky! Some of my commands are duplicates, just so that I can use multiple phrases to accomplish the same thing.*

[star_citizen]: https://robertsspaceindustries.com/
[pledge]: https://robertsspaceindustries.com/pledge/single-ship-packages?sortBy=price
[pass]: https://robertsspaceindustries.com/pledge/module-passes
[autohotkey]: http://www.autohotkey.com/
[flightmode]: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey/blob/master/flightmode.ahk
[spotify]: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey/blob/master/spotify.ahk
[spotify_shortcuts]: https://support.spotify.com/us/learn-more/faq/#!/article/Keyboard-shortcuts
