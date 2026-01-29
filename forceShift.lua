-- ============================================================================
-- forceShift.lua
-- Copyright (c) 2026 Takudesu
-- Released under the MIT License.
-- ============================================================================

-- 
-- forceShift: 指定されたポーズを適用する最小構成
-- 

local config = {
    modelPaths = {
        root     = nil,
        head     = nil,
        body     = nil,
        leftArm  = nil,
        rightArm = nil,
        leftLeg  = nil,
        rightLeg = nil,
    },
    
    pose = {
        rootPosition = vec(0, 2.21, 0),
        rotation = {
            head     = vec(0, 0, 0),
            body     = vec(28.648, 0, 0),
            leftArm  = vec(20.716, 0, 0),
            rightArm = vec(25.120, 0, 0),
            leftLeg  = vec(0, 15.286, 0),
            rightLeg = vec(0, -15.286, 0),
        },
        position = {
            head     = vec(0, 4.200, 0),
            body     = vec(0, 3.200, 0),
            leftArm  = vec(0, 3.200, 0),
            rightArm = vec(0, 3.200, 0),
            leftLeg  = vec(0, 0.200, -4.000),
            rightLeg = vec(0, 0.200, -4.000),
        }
    }
}

------------------

local parts = {}

local function resolvePart(getFunc)
    if type(getFunc) ~= "function" then return nil end
    local ok, result = pcall(getFunc)
    return ok and result or nil
end

function forceShift(settings)
    if not settings then return end
    if settings.modelPaths then
        for k, v in pairs(settings.modelPaths) do config.modelPaths[k] = v end
    end
end

function events.ENTITY_INIT()
    for name, pathFunc in pairs(config.modelPaths) do
        parts[name] = resolvePart(pathFunc)
    end
end

-- パーツを強制制御（リセット/適用）する内部関数
local function applyPose(name, isCrouching, rot, pos)
    local part = parts[name]
    if not part then return end
    
    if isCrouching then
        if rot then part:setOffsetRot(rot) end
        if pos then part:setPos(pos) end
    else
        part:setOffsetRot(0, 0, 0)
        part:setPos(0, 0, 0)
    end
end

function events.RENDER(delta, context)
    if not player:isLoaded() then return end
    
    local crouching = player:isCrouching()
    local p = config.pose
    
    -- オーバーレイ検知 (エモートなどの高優先度アニメーションを確認)
    local isOverlay = false
    local playingAnims = animations:getPlaying()
    for _, anim in ipairs(playingAnims) do
        local name = anim:getName()
        -- 基本の「しゃがみ」「しゃがみ歩き」以外のアニメーションをチェック
        if name ~= "animations.model.crouch" and name ~= "animations.model.crouchWalk" then
            if anim:getPriority() > 0 or anim:getOverridePos() or anim:getOverrideRot() then
                isOverlay = true
                break
            end
        end
    end
    
    -- オーバーレイ再生中は手足や体の補正を解除し、アニメーションに道を譲る。
    -- ただしRoot（高さ）の補正だけは、埋まり防止のため常に維持します。
    local active = crouching and not isOverlay
    
    -- 各パーツにポーズを適用
    applyPose("root",     crouching, nil, p.rootPosition)
    applyPose("head",     active, p.rotation.head,     p.position.head)
    applyPose("body",     active, p.rotation.body,     p.position.body)
    applyPose("leftArm",  active, p.rotation.leftArm,  p.position.leftArm)
    applyPose("rightArm", active, p.rotation.rightArm, p.position.rightArm)
    applyPose("leftLeg",  active, p.rotation.leftLeg,  p.position.leftLeg)
    applyPose("rightLeg", active, p.rotation.rightLeg, p.position.rightLeg)
end

_G.forceShift = forceShift
return forceShift
