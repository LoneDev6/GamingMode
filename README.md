# GamingMode

## Features
- Works only on Steam games
- Automatically enables Windows 10/11 "Game Mode" 
- Automatically sets game process priority to "High"
- Runs in background, no need to manually do anything


## Limits
- Currently tested only with a few games
- May not detect games with totally different folder name or window title name



## How to install?
1. Save the `.ps1` file inside any folder you want
2. Create a Windows scheduled task
2. Set it to start on boot
3. Set the action to start `powershell` and set arguments to `-WindowStyle Hidden -file "STEP 1 PATH"`
4. Run the task manually
