local s_rs = game:GetService("RunService")
local l_plr = game:GetService("Players").LocalPlayer

local l_humrp = l_plr.Character and l_plr.Character:FindFirstChild("HumanoidRootPart")
local l_hum = l_plr.Character and l_plr.Character:FindFirstChild("Humanoid")

local resp_con = l_plr.CharacterAdded:Connect(function(c) 
    l_humrp = c:WaitForChild("HumanoidRootPart",3)
    l_hum = c:WaitForChild("Humanoid",3)
end)

local function dnec(signal) 
    local s = {}
    for _, con in ipairs(getconnections(signal)) do 
        local func = con.Function
        if (func and islclosure(func)) then
            if (not is_synapse_function(func)) then 
                s[#s+1] = con
                con:Disable() 
            end
        end
    end
    return s
end

local speed_amnt = 5

do
    local a,b

    a = dnec(l_humrp.Changed)
    b = dnec(l_humrp:GetPropertyChangedSignal("CFrame"))

    s_rs:BindToRenderStep("speed",2000,function(dt)
        l_humrp.CFrame += l_hum.MoveDirection*dt*5*speed_amnt
    end)
end

resp_con:Disconnect()
