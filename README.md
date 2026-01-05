# Magical Girl Pastel Starshower
A visual novel about a Magical Girl's daily life, years after she has saved the world at great cost. Built with love in GameMaker.

## Credits
- Lucy Awrey: Writing, Game Design, Programming, UI.
- Laura Wenning: Additional Programming

## Setup

### For Linux

This is a hacky setup that uses the Windows version of GameMaker Studio on Linux running through Steam. 

#### Installing GameMaker

This will install GameMaker in a virtual Windows filesystem so that it can be used on any Linux system and with the LTS version of GameMaker.

1. Download the Windows LTS version of GameMaker (version 2024.14.2.213)
2. Open Steam. In the Library, click "Add a Game", then "Add Non-Steam Game".
3. Browse for and add the GameMaker-Installer-[version].exe file. Once it's added, right-click the game and open the Properties menu. Under Compatibility, check "Force the use of a specific Steam Play Compatibility tool", then select any recent Proton version. Proton 9.0-4 is known to work well.
4. With compatibility enabled, run through the installation wizard. Default settings are fine, but additional options like desktop shortcuts can be disabled. After completing the installation, GameMaker will start. This *can* be used, but will require uninstalling and reinstalling GameMaker each time to turn it on. 

#### Running GameMaker through Steam

This will set up GameMaker to be easily run through Steam, allowing us to start it up with a single button click.

1. In your preferred terminal, go to `~/.steam/steam/steamapps/compatdata`. Run `ls -la` and identify the specific compatibility folder containing GameMaker's installation. These will print out folders with large numbers for names. While momentarily daunting, the most recently-touched folder will be the one containing GameMaker. Check that there is a `[compat_id]/pfx/drive_c/Program\ Files/GameMaker` directory inside of it.
2. Back in Steam, add a second Non-Steam game. This time, provide the path to the `GameMaker.exe` found within the Installer compatdata folder. This should be something like `home/[your-user]/.steam/steam/steamapps/compatdata/[compat_id]/pfx/drive_c/Program\ Files/GameMaker/GameMaker.exe`.
3. Once added, we need to configure Compatibility. Right click the GameMaker.exe entry and open the Properties menu. Under Compatibility, check "Force the use of a specific Steam Play compatibility tool". Select a Proton version (we use 9.0-4).
4. Click Play. GameMaker should now start up as if it were any other game on Steam.

#### Adding External Projects

Now we need to connect our project to the virtual filesystem. 

1. In your preferred terminal, go to `~/.steam/steam/steamapps/compatdata`. Run `ls -la` and identify the specific compatibility folder for the newly added GameMaker. This is _not_ the same folder as the GameMaker-Installer! Once again, though, it will most likely be the most-recently touched folder. There will be **no** `drive_c/Program\ Files/GameMaker` folder, but instead a `drive_c/users/steamuser/AppData/Local/GameMakerStudio2` folder.
2. Once the compat folder is identified, navigate to `[compat_id]/pfx/drive_c/users/steamuser/Documents`.
3. Create a symbolic link to where the game project folder is located in your Linux desktop (the folder containing this README) using `ln -s -T [game_project_folder] [link_name]`. For example, `ln -s -T ~/Documents/games/MagicalGirl MagicalGirl`
4. Finally, in GameMaker, open a project. Navigate to the Documents folder, and inside that will be a MagicalGirl folder and a `.ypp` GameMaker project file. Congrats! You're all ready to go!

#### Known Compatibility Issues

Using the `file_attributes` when attempting to read a file using `find_file_first` or similar functions will not work. Files and directories will only appear when using the `fa_directory` flag. Using `fa_directory | fa_none` for the file attribute will allow it to work on any system.