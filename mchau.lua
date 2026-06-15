-- ====================================================================
-- 1. NẠP GIAO DIỆN TỪ LINK MAIN.LUA CHÍNH CHỦ CỦA BẠN
-- ====================================================================
local linkFile1 = "https://githubusercontent.com" 
local myLibrary = loadstring(game:HttpGet(linkFile1))()

-- ====================================================================
-- 2. KHỞI TẠO CỬA SỔ MENU (Sửa đúng theo cấu trúc file main.lua của bạn)
-- ====================================================================
local Window = myLibrary:CreateWindow({
    Name = "Kyyuuunopro Private ⚔️",
    LoadingTitle = "Đang cấu hình hệ thống...",
    LoadingUser = "Chào mừng người dùng"
})

-- Tạo Tab mới (Sửa lại cấu trúc truyền tham số chuẩn cho file main.lua)
local FarmTab = Window:CreateTab("Auto Farm")

-- Cấu hình hệ thống mặc định
local _G = _G or {}
_G.AutoFarm = false

-- Danh sách các NPC bạn muốn săn lùng trên toàn bộ map
local targetNPCs = {
    "Bandit",
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

-- Hàm kiểm tra thông minh xem tên quái có nằm trong danh sách yêu cầu không
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
-- 3. TẠO NÚT BẬT/TẮT (Sửa đúng cấu trúc hàm CreateToggle của file main.lua)
-- ====================================================================
FarmTab:CreateToggle({
    Name = "Auto Farm Custom Mobs (Toàn Map)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.05) -- Giới hạn vòng lặp tối ưu chống đứng game
                    
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            local targetNPC = nil
                            
                            -- Quét không giới hạn khoảng cách trên toàn bộ Workspace
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if isTargetNPC(obj.Name) and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChildOfClass("Humanoid").Health > 0 then
                                    if obj:FindFirstChild("HumanoidRootPart") then
                                        targetNPC = obj
                                        break -- Tóm ngay con đầu tiên tìm thấy trên bản đồ
                                    end
                                end
                            end
                            
                            -- Tiến hành áp sát từ sau lưng và xả sát thương
                            if targetNPC then
                                local npcRoot = targetNPC.HumanoidRootPart
                                
                                -- Dịch chuyển ra sau lưng cách quái 2.5 studs và xoay mặt vào quái
                                rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0)
                                
                                -- Tự động kích hoạt công cụ vũ khí trên tay
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then 
                                    tool:Activate() 
                                else
                                    -- Nếu chưa cầm sẵn vũ khí, tự động móc từ balo (Backpack) ra trang bị
                                    local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
                                    if backpackTool then 
                                        backpackTool.Parent = character 
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
