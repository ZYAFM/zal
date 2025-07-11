local u1,u2,u3,u4,u5,u6,u7=game:GetService("Players"),game:GetService("Players").LocalPlayer,game:GetService("RunService"),game:GetService("UserInputService"),game:GetService("StarterGui"),workspace.CurrentCamera,true
local u8=Enum.KeyCode.E
local u9=100
local u10=0.15
local u11=0.12
local u12="HumanoidRootPart"
local u13=true
local u14=true
local u15=true

local c1=Drawing.new("Circle")
c1.Visible=true
c1.Color=Color3.fromRGB(255,0,0)
c1.Radius=u9
c1.Thickness=1
c1.Transparency=0.75
c1.Position=u7.ViewportSize/2

pcall(function()
    u5:SetCore("SendNotification",{Title="Aimbot Loaded",Text="Press [E] to toggle",Duration=5})
end)

local function f1()
    local p1,p2=nil,u9
    for _,plr in pairs(u1:GetPlayers()) do
        if plr~=u2 and plr.Character and plr.Character:FindFirstChild(u12) and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Health<=0 then continue end
            if u13 and plr.Team==u2.Team then continue end
            local p3,onScreen=u7:WorldToViewportPoint(plr.Character[u12].Position)
            if not onScreen then continue end
            local d=(Vector2.new(p3.X,p3.Y)-u7.ViewportSize/2).Magnitude
            if d<p2 then
                if u15 then
                    local r=RaycastParams.new()
                    r.FilterDescendantsInstances={u2.Character,plr.Character}
                    r.FilterType=Enum.RaycastFilterType.Blacklist
                    r.IgnoreWater=true
                    local res=workspace:Raycast(u7.CFrame.Position,(plr.Character[u12].Position-u7.CFrame.Position),r)
                    if res and res.Instance then continue end
                end
                p1,p2=plr,d
            end
        end
    end
    return p1
end

local function f2(part)
    if not part then return nil end
    return part.Position + (part.Velocity*u11)
end

local h
u4.InputBegan:Connect(function(i,gpe)
    if not gpe and i.KeyCode==u8 then
        u6=not u6
        pcall(function()
            u5:SetCore("SendNotification",{Title="Aimbot",Text="Aimbot "..(u6 and "Enabled" or "Disabled"),Duration=3})
        end)
    end
end)

local function hlt(plr)
    if not u14 then return end
    if h then h:Destroy() end
    local hl=Instance.new("Highlight")
    hl.Adornee=plr.Character
    hl.FillColor=Color3.fromRGB(0,255,0)
    hl.OutlineColor=Color3.fromRGB(255,0,0)
    hl.Parent=plr.Character
    h=hl
end
local function rhlt()
    if h then h:Destroy() h=nil end
end

u3.RenderStepped:Connect(function()
    c1.Position=u7.ViewportSize/2
    if not u6 then rhlt() return end
    local t=f1()
    if t and t.Character and t.Character:FindFirstChild(u12) then
        local pos=f2(t.Character[u12])
        if pos then
            u7.CFrame=u7.CFrame:Lerp(CFrame.new(u7.CFrame.Position,pos),u10)
            hlt(t)
            c1.Color=Color3.fromRGB(0,255,0)
        end
    else
        c1.Color=Color3.fromRGB(255,0,0)
        rhlt()
    end
end)

