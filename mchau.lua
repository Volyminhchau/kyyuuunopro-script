-- ====================================================================
-- 1. NẠP GIAO DIỆN TỪ LINK MAIN.LUA CHÍNH CHỦ CỦA BẠN
-- ====================================================================
local linkFile1 = "https://raw.githubusercontent.com/Volyminhchau/kyyuuunopro-script/refs/heads/main/main.lua" 
local myLibrary = loadstring(game:HttpGet(linkFile1))()
-- ====================================================================
-- 2. KHỞI TẠO CỬA SỔ MENU
-- ====================================================================
local MainMenu = myLibrary:CreateWindow("Kyyuuunopro Private ⚔️")

-- Cấu hình hệ thống mặc định
local _G = _G or {}
_G.AutoFarm = false

-- Danh sách quái vật yêu cầu của bạn
local targetNPCs = {
    "Bandit",
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

-- Hàm kiểm tra tên quái thông minh
local function isTargetNPC(name)
    local lowerName = string.lower(name)
    for _, target in pairs(targetNPCs) do
        if string.find(lowerName, string.lower(target)) then
            return true
        end
    end
    return false
end

-- ====================================================================
-- 3. TẠO NÚT BẬT/TẮT VÀ LOGIC FIX LỖI "PLAYERS"
-- ====================================================================
-- Sửa lỗi gọi Players an toàn bằng GetService
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
                    
                    -- Sử dụng PlayersService đã được sửa lỗi ở trên
                    local player = PlayersService.LocalPlayer
                    if player then
                        local character = player.Character
                        if character then
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            
                            if rootPart and humanoid and humanoid.Health > 0 then
                                local targetNPC = nil
                                
                                -- Quét toàn bộ map để tìm quái vật
                                for _, obj in pairs(workspace:GetDescendants()) do
                                    if isTargetNPC(obj.Name) and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                        if obj:FindFirstChild("HumanoidRootPart") then
                                            targetNPC = obj
                                            break
                                        end
                                    end
                                end
                                
                                -- HÀNH ĐỘNG DỊCH CHUYỂN VÀ VUNG VŨ KHÍ
                                if targetNPC then
                                    local npcRoot = targetNPC.HumanoidRootPart
                                    
                                    -- Dịch chuyển ra sau lưng quái cách 2.5 studs
                                    rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                    
                                    -- Tự động vung vũ khí trên tay
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if tool then 
                                        tool:Activate() 
                                    else
                                        -- Tự động lấy vũ khí từ Backpack ra nếu chưa cầm sẵn
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
