# forceShift - FiguraMOD

MinecraftのFiguraMODで使うスクリプト

## 説明
このスクリプトは、しゃがんだ状態の時のアバターのズレなどを自動的に修正するのを目的として作られたスクリプト。
アニメーションなどのものには一切干渉せず、邪魔なズレだけをなくすことができる。

> [!IMPORTANT]
> **BlockBenchでの注意点**
> TIMELINEの中で修正して欲しくない部位には、必ず **Rotation（ローテーション）** と **Position（ポジション）** の両方に、最低1つはキーフレームを置いてください。これを行わないと、意図しない挙動が発生する可能性があります。

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
