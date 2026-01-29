# forceShift - FiguraMOD

MinecraftのFiguraMODで使うスクリプト

## 説明
このスクリプトは、しゃがんだ状態の時のアバターのズレなどを自動的に修正するのを目的として作られたスクリプト。
アニメーションなどのものには一切干渉せず、邪魔なズレだけをなくすことができる。

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
Copyright (c) 2026 Takudesu - All Rights Reserved.
詳細は [LICENSE](LICENSE) ファイルを確認してください。
