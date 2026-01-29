# force-shift-figura

A minimal pose correction script for Minecraft Figura avatars.

## Description
This script automatically applies a fixed pose to your avatar when crouching (Shift) and resets it when standing up. Includes a height correction fix for standard Minecraft crouch drop.

## Usage
1. Require the script in your main `script.lua`:
   ```lua
   local forceShift = require("forceShift")
   ```
2. Initialize it with your model paths:
   ```lua
   forceShift({
     modelPaths = {
       root = function() return models.model.root end,
       -- ...other parts
     }
   })
   ```

## License
MIT License - See [LICENSE](LICENSE) for details.
