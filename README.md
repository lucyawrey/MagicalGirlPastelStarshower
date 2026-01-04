# Magical Girl Pastel Starshower
A visual novel about a Magical Girl's daily life, years after she has saved the world at great cost. Built with love in GameMaker.

## Credits
- Lucy Awrey: Writing, Game Design, Programming, UI.

## Setup

### For Linux

This is a hacky setup that uses the Windows version of GameMaker Studio on Linux running through Steam. 

1. Download the Windows LTS version of GameMaker (version 2024.14.2.213)
2. Open Steam. In the Library, click "Add a Game", then "Add Non-Steam Game"
3. Browse for and add the GameMaker exe file. This will be an installer, but will start GameMaker after installation is complete. Run through the Wizard; default settings are fine.
4. After completing the installation, GameMaker will start. 

**Note:** If starting GameMaker again, you will need to uninstall and reinstall GameMaker. This guide will be updated once a way of avoiding this is found.

Now we need to connect our project to the virtual filesystem. 

1. In your preferred terminal, go to `~/.steam/steam/steamapps/compatdata`. Run `ls -la` and identify the specific compatibility folder. It will most likely be the most-recently touched folder. If you're not sure, check that there is a `[compat_id]/pfx/drive_c/Program\ Files/GameMaker` directory.
2. Once the compat folder is identified, navigate to `[compat_id]/pfx/drive_c/users/steamuser/Documents`.
3. Create a symbolic link to where the game project folder is located in your Linux desktop (where this file is) using `ln -s -T [game_project_folder] [link_name]`. For example, `ln -s -T ~/Documents/games/MagicalGirl MagicalGirl`

You should now be able to open the project in GameMaker. 

#### Known Compatibility Issues

Using the `file_attributes` when attempting to read a file using `find_file_first` or similar functions will not work. Files and directories will only appear when using the `fa_directory` flag. Using `fa_directory | fa_none` for the file attribute will allow it to work on any system.