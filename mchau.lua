-- ====================================================================
-- PHẦN 1: TỰ KHỞI TẠO GIAO DIỆN TRỰC TIẾP (Không dùng loadstring/GitHub)
-- ====================================================================
local MyLibrary = {}

function MyLibrary:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KyyuuunoproPrivateUI"
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 220)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Text = titleText or "Menu Của Tôi"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -20, 1, -65)
    Container.Position = UDim2.new(0, 10, 0, 55)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Container

    local Elements = {}
    
    function Elements:CreateToggle(config)
        local toggleName = config.Name or "Toggle"
        local callback = config.Callback or function() end
        local isToggled = config.CurrentValue or false

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(1, 0, 0, 45)
        ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(60, 60, 60)
        ToggleButton.Text = toggleName .. " : " .. (isToggled and "BẬT" or "TẮT")
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.TextSize = 15
        ToggleButton.Font = Enum.Font.SourceSansBold
        ToggleButton.Parent = Container

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = ToggleButton

        ToggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            if isToggled then
                ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
                ToggleButton.Text = toggleName .. " : BẬT"
            else
                ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                ToggleButton.Text = toggleName .. " : TẮT"
            end
            callback(isToggled)
        end)
    end

    return Elements
end

-- ====================================================================
-- PHẦN 2: KHỞI CHẠY MENU VÀ SETUP TÍNH NĂNG AUTO FARM TOÀN MAP
-- ====================================================================
local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")

local _G = _G or {}
_G.AutoFarm = false

local targetNPCs = {
    "Bandit",
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

local function isTargetNPC(name)
    local lowerName = string.lower(name)
    for _, target in pairs(targetNPCs) do
        if string.find(lowerName, string.lower(target)) then
            return true
        end
    end
    return false
end

local PlayersService = game:GetService("Players")

MainMenu:CreateToggle({
    Name = "Auto Farm Custom Mobs (Toàn Map)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.05)
                    
                    local player = PlayersService.LocalPlayer
                    if player then
                        local character = player.Character
                        if character then
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            
                            if rootPart and humanoid and humanoid.Health > 0 then
                                local targetNPC = nil
                                
                                for _, obj in pairs(workspace:GetDescendants()) do
                                    if isTargetNPC(obj.Name) and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                        if obj:FindFirstChild("HumanoidRootPart") then
                                            targetNPC = obj
                                            break
                                        end
                                    end
                                end
                                
                                if targetNPC then
                                    local npcRoot = targetNPC.HumanoidRootPart
                                    
                                    -- Dịch chuyển ra sau lưng quái
                                    rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                    
                                    -- Tự động vung vũ khí
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if tool then 
                                        tool:Activate() 
                                    else
                                        local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
                                        if backpackTool then 
                                            backpackTool.Parent = character 
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})
