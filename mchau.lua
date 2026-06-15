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

-- Danh sách quái vật yêu cầu
local targetNPCs = {
    "Bandit",
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

-- Hàm kiểm tra tên quái thông minh (không phân biệt chữ hoa/thường)
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
-- 3. TẠO NÚT BẬT/TẮT VÀ LOGIC QUÉT QUÁI TOÀN DIỆN
-- ====================================================================
MainMenu:CreateToggle({
    Name = "Auto Farm Custom Mobs (Toàn Map)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.05)
                    
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            local targetNPC = nil
                            
                            -- 🌟 CẢI TIẾN: Quét sâu vào toàn bộ game (cả Workspace và các thư mục lưu trữ ẩn)
                            local scanObjects = {}
                            for _, v in pairs(workspace:GetDescendants()) do table.insert(scanObjects, v) end
                            for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do table.insert(scanObjects, v) end
                            
                            for _, obj in pairs(scanObjects) do
                                if isTargetNPC(obj.Name) and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                    -- Đảm bảo quái phải có bộ phận gốc để dịch chuyển tới
                                    if obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") then
                                        targetNPC = obj
                                        break
                                    end
                                end
                            end
                            
                            -- HÀNH ĐỘNG DỊCH CHUYỂN VÀ GIẢ LẬP ĐÁNH
                            if targetNPC then
                                -- Ưu tiên dùng HumanoidRootPart, nếu không có thì lấy phần Đầu (Head) của quái
                                local npcPart = targetNPC:FindFirstChild("HumanoidRootPart") or targetNPC:FindFirstChild("Head")
                                
                                if npcPart then
                                    -- Dịch chuyển ra sau lưng quái
                                    rootPart.CFrame = npcPart.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                    
                                    -- Tự động vung vũ khí trên tay
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if tool then 
                                        tool:Activate() 
                                    else
                                        local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
                                        if backpackTool then backpackTool.Parent = character end
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
