-- This might not work on most games, so beware.

local function getService(serviceName)
    return cloneref(game:GetService(serviceName))
end

local Players = getService("Players")
local Module = {}

local selfPlayer = Players.LocalPlayer
local Character = nil
local Humanoid = nil

local function apply(character)
    Character = character or selfPlayer.Character
    Humanoid = Character.Humanoid
end

apply()

selfPlayer.CharacterAdded:Connect(apply)

function Module:Teleport(Position, Reverse, Delay)
    local posType = typeof(Position)
    if posType == "CFrame" then
        local Root = Character:WaitForChild("HumanoidRootPart")
        if not Root then
            return
        end

        local lastPos = Root.CFrame

        Humanoid.PlatformStand = true
        Humanoid.Sit = true
        Root.CFrame = Position

        task.delay(Delay or 1, function()
            if Reverse == true then
                Root.CFrame = lastPos
            end

            Humanoid.PlatformStand = true
            Humanoid.Sit = true
        end)
    elseif posType == "Vector3" then
        if not Character then
            return
        end

        local lastPos = Character.PrimaryPart.Position

        Humanoid.PlatformStand = true
        Humanoid.Sit = true
        Character:MoveTo(Position)

        task.delay(Delay or 1, function()
            if Reverse == true then
                Character:MoveTo(lastPos)
            end

            Humanoid.PlatformStand = true
            Humanoid.Sit = true
        end)
    end
end

return Module
