StarCitizen-VoiceAttack-AutoHotkey
==================================
### Table of contents:
1. [What is Star Citizen? VoiceAttack?](#intro)
2. [VoiceAttack and AutoHotkey](#ahk)
3. [Instructions](#instructions)
4. [Command List](#command_list)
5. [Requirements](#requirements)

*NOTE: if you're already familiar with Star Citizen and VoiceAttack, feel free to skip this section.*

<a name="intro"></a>
## What is Star Citizen? VoiceAttack?

For the uninitiated, [Star Citizen][star_citizen] is a massive single- and multi-player crowdfunded space sim that is currently in development. It's broken all sorts of records in funding, and as of June 15, 2014, it has raised $46,386,468 (NOTE: I'm pretty sure that by the time you're reading this, that number will be much, much higher).

Anyways, the dogfighting module, Arena Commander, was released on June 6, 2014, and those of us who are backers have been enthusiastically playing the game ever since. If you haven't pledged yet but want to join in on the fun, it isn't terribly expensive to get your ship and an Arena Commander pass. You can get a ship [here][pledge], and a pass [here][pass]. Make sure your ship package says "Game Package"; otherwise, you won't get the final game! *WARNING: The game is still in a pre-alpha state. While it is nicely polished and really pretty, expect some bugs if you decide to play now.*

VoiceAttack, the main focus of this repository, is a Windows program that lets you assign keyboard macros and other similar tasks to voice commands. This really improves gameplay in Arena Commander, especially if you are using a joystick, like me (Thrustmaster T.16000M).

<a name="ahk"></a>
## VoiceAttack and AutoHotkey
Some of you may already know about [AutoHotkey][autohotkey], and I'm sure some of you have way more experience with it than I do! If you don't know what it is, it's basically a free and open-source keyboard macro and automation project. If you thought VoiceAttack was powerful, wait til you see what you can do with AutoHotkey!

It's got a bit of a learning curve, but I made two sample scripts that several of my VoiceAttack commands use. I've documented them thoroughly, and they're pretty efficient as well! Let's take a look at the two scripts:

### [flightmode.ahk][flightmode]
This script is my favorite of the two! You know how you have to cycle through each combination of Comstab and G-Safe toggles one by one? It gets rather confusing, especially if you want voice commands, in which case you pretty much have to reset everything before chosing another flight mode. Not any more! 

Just use one of the commands in my VoiceAttack profile, and *flightmode.ahk* will keep track of the state of each toggle. All you have to do is reset the state of everything whenever you spawn (my command is "reset flight modes"), and then you can toggle all three flight modes on and off, and it will behave as expected.

If you want to know what is going on under the hood, I'm basically representing each possible state for the flight mode with its corresponding binary number. For each mode, *off* means 0, and *on* means one. so, if you're in Coupled Mode with G-Safe and Comstab on, that number is 111. And then I do some clever bitwise operations to change the state of each of those digits as needed. It behaves really well, provided you start off with the reset command. Now, on to the second script:

### [spotify.ahk][spotify]
I know that a lot of twitch streamers like to play music while they stream. I've not streamed on twitch yet, but I certainly like to cycle through some different styles of music while I game. So I've come up with a pretty nice solution. This script, also interfaced with VoiceAttack commands, is able to play and pause your Spotify music, skip to the next track, and even adjust the music's volume. It does this by specifically sending keystrokes [defined here by Spotify][spotify_shortcuts] directly to the Spotify window, whether it's open but not in focus, or even minimized to the system tray. I imagine it wouldn't too hard to add scripts for additional music players using my sample, as long as that player has sufficient keyboard shortcuts. Now, let's check out the instructions:

<a name="instructions"></a>
## Instructions

### "Just give me the files!"
1. If you don't need or want AutoHotkey, go to [releases tab][releases] and download the zip file that's there.
2. Unzip and run Setup.exe, which will guide you through customizing your profile.
3. Click the first Browse button and navigate to the folder you just downloaded:
<img src="http://i.imgur.com/Ie6pjJm.png" width="400" />
4. Click the second Browse button and choose a folder to save the profile and scripts.
5. Click "Yes" at the prompt to navigate to the newly created folder.
6. Import that profile into VoiceAttack. If you don't have the TTS engine that I use (IVONA 2 voice Brian), then AutoHotkey will attempt to use your default engine (I may add an option to choose your engine in the Setup script in a future release).
7. It doesn't matter where you keep your scripts, just make sure you don't change them after you've run the Setup script; otherwise, you'll have to manually point VoiceAttack to their new location.
8. Enjoy the game, and enjoy your spiffy new voice commands!

### "Great, but I could make these scripts even better."
Awesome! You have a few options:

Provided you have [git for Windows][git_for_windows] ([instructions here][git_windows_instructions]) installed, you can clone the repository locally (repository URL: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey.git).

Add your own scripts, modify the Spotify script to work with other media players ... The sky is the limit! (except for when you have a spaceship)

Also, I encourage you to fork this repository if you're a developer, or even come up with your own! And as always, if you find a bug or issue, please let me know. This is my first true public-facing programming project, and it's likely far from perfect.

<a name="command_list"></a>
## Command List
*NOTE: My profile has 36 hand-crafted commands. If you have a trial version of VoiceAttack, you'll have to be picky!*

| Package         | Name                                | Category       | Description                                       |
| --------------- | ----------------------------------- | -------------- | ------------------------------------------------- |
| Flight Modes    | Comstab off                         | Flight Modes   | Turns Comstab off                                 |
| Flight Modes    | Comstab on                          | Flight Modes   | Turns Comastab on                                 |
| Flight Modes    | Couple                              | Flight Modes   | Activates coupled flight                          |
| Flight Modes    | De-Couple                           | Flight Modes   | Activates de-coupled flight                       |
| Flight Modes    | G-Safe off                          | Flight Modes   | Turns G-Safe off                                  |
| Flight Modes    | G-Safe on                           | Flight Modes   | Turns G-Safe on                                   |
| Flight Modes    | Reset flightmodes                   | Flight Modes   | Resets all the above. NOTE: Must be said first    |
| Spotify         | Spotify less volume                 | Spotify        | Turns down the Spotify volume                     |
| Spotify         | Spotify more volume                 | Spotify        | Turns up the Spotify volume                       |
| Spotify         | Spotify next track                  | Spotify        | Goes to the next track in a station or playlist   |
| Spotify         | Pause / Play (multipart)            | Spotify        | Pauses the current song                           |
| Other           | 300i weapon loadout                 | Combat         | My personal weapon loadout (default weapons)      |
| Other           | Fire / Launch Missile (multipart)   | Combat         | Fires a missile                                   |
| Other           | Nearest hostile                     | Combat         | Targets the nearest hostile                       |
| Other           | Next target                         | Combat         | Targest the nearest ship                          |
| Other           | Overview                            | HUD            | Displays the Overview tab                         |
| Other           | Power                               | HUD            | Displays the Power tab                            |
| Other           | Shields                             | HUD            | Displays the Shields tab                          |
| Other           | Weapons                             | HUD            | Displays the Weapons tab                          |
| Other           | Power to shields                    | Power          | Reroutes power to the shields                     |
| Other           | Power to thrusters                  | Power          | Reroutes power to the thrusters                   |
| Other           | Power to weapons                    | Power          | Reroutes power to the weapons                     |
| Other           | Powergrid normal                    | Power          | Resets powergrid                                  |
| Other           | 300i shields                        | Ship           | Focuses shields on the aft side (my preference)   |
| Other           | Eject eject / Eject now (multipart) | Ship           | Eject (sorry, Aurora owners)                      |
| Other           | Flares / Launch flares (multipart)  | Ship           | Launches flares to throw off heatseeking missiles |
| Other           | Full throttle                       | Ship           | Increases the throttle to 100%                    |
| Other           | Match Target / Match Velocity (multipart) | Ship     | Matches the target's velocity                     |
| Other           | Reset shields                       | Ship           | Resets the shields to their default state         |
| Other           | Zero throttle                       | Ship           | Bring the ship to a stop                          |

<a name="requirements"></a>
## Requirements
If you aren't planning to install AutoHotkey, you should be good to go. I think the requirements would be XP or higher, but if you're reading this and can play Star Citizen, you likely have a more modern PC.

If you want to modify the source or just run the AutoHotkey scripts directly (which is totally fine and even a bit faster), just go ahead and make sure you have [AutoHotkey v1.1.15.00 or higher][autohotkey_download]. Then, you're good to go.

[star_citizen]: https://robertsspaceindustries.com/
[pledge]: https://robertsspaceindustries.com/pledge/single-ship-packages
[pass]: https://robertsspaceindustries.com/pledge/module-passes
[autohotkey]: http://ahkscript.org/
[autohotkey_download]: http://ahkscript.org/download/
[flightmode]: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey/blob/master/scripts/flightmode.ahk
[spotify]: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey/blob/master/scripts/spotify.ahk
[spotify_shortcuts]: https://support.spotify.com/us/learn-more/faq/#!/article/Keyboard-shortcuts
[releases]: https://github.com/dsmith86/StarCitizen-VoiceAttack-AutoHotkey/releases
[git_for_windows]: http://git-scm.com/downloads
[git_windows_instructions]: http://guides.beanstalkapp.com/version-control/git-on-windows.html
