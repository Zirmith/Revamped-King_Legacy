repeat task.wait() until game:isLoaded()

getgenv().version = "0.0.1"
-- init
Workspace = game.Workspace
local PlayerService = game:GetService'Players'
local Player = game.Players.LocalPlayer;
Hum = Player.Character:WaitForChild("Humanoid", 5)
local HumanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart", 5)
local teleport = game:GetService'TeleportService';
local Mouse = Player:GetMouse();
local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId);
local standardNcpFolder = Workspace:WaitForChild'Monster'
local utility = {}
local Path = require(game:GetService("ReplicatedStorage").Modules.QuestManager);
local npcs = {}
local bosses = {}
------



local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zirmith/Venyx-UI-Library/main/source.lua"))()
local util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zirmith/Util-Tools/main/source.lua"))()
local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name



local snowy = library.new("ZoraHub | " ..GetName, 5013109572)

local vu = game:GetService("VirtualUser")




local themes = {
	Background = Color3.fromRGB(135,136,138),
	Glow = Color3.fromRGB(66, 233, 245),
	Accent = Color3.fromRGB(19,17,17),
	LightContrast = Color3.fromRGB(167,167,167),
	DarkContrast = Color3.fromRGB(25,25,25),  
	TextColor = Color3.fromRGB(116,116,116)
}

_G.settings = {
    misc = {
        tpmethod = _G.farmtpmethod,
        farmingdistance = _G.farmdistance,
        autofarming = _G.isfarming,
        farmingwep = _G.farmweapon,
        autoequip = _G.autoequip,
        lastncp =  _G.selectedncp,
        lastisland = _G.selectedland,
        tweenspeed = _G.tweenspeed,
        autofruitcollect = _G.collectfruits,
        lastpos = _G.pos
    },
    options = {
        lastversion = getgenv().version or version
    }
}


--vars
selectedmethod = "";

version = getgenv().version;

wantedversion = getgenv().version;

_G.playeresp = false
_G.farmtpmethod = "";
_G.farmdistance = 0;
_G.isfarming = false;
_G.farmweapon = "";
_G.autoequip = false;
_G.selectedncp = ""
_G.selectedland = ""
_G.tweenspeed = .5
_G.collectfruits = false
_G.lastpos = nil
_G.pos = nil
_G.autosave = false
_G.getloco = true
_G.selectedplayer = nil
_G.playerhunting = nil

_G.ncplist = {
    "Soldier",
    "Smoky",
    "Tashi",
    "Clown",
    "Clown Pirate",
    "The Clown",
    "Marine",
    "Dark Leg", 
    "Weapon Man",
    "Trainer Chef",
    "Commander",
    "Captain",
    "Axe",
    "SharkMan",
    "True Karate Fishman",
    "Karate Fishman",
    "Fishman",
    "Quake Woman",
    "New World Pirate",
    "Rear Admiral",
    "Leader",
    "Pasta",
    "Leo",
    "Wolf",
    "Giraffe",
    "Shadow Master",
    "Bomb Man",
    "Zombie",
    "Oars",
    "Rumble Man",
    "Ball Man",
    "Sky Soldier",
    "King of Sand",
    "Candle Man",
    "Heavy Man",
    "King Snow",
    "Snow Soldier",
    "Shanks",
    "Seasoned Fishman",
    "Sword Fishman",
    "Combat Fishman",
    "Fishman Soldier"
} 

_G.islands = {
    "Stone Rain Sea",
    "Town",
    "Pirate Island",
    "Soldier Town",
    "Chef Ship",
    "Snow Island",
    "Desert Island",
    "Skyland",
    "Bubbleland",
    "Lobby Island",
    "War Island",
    "Fishland",
    "Stone Arena",
    "Zombie Island",
    "Shark Island",
    "Board"
}
--functions


utility.reload = function()
    task.wait()
    game.CoreGui["ZoraHub | " ..GetName]:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zirmith/Revamped-King_Legacy/main/main.bruhwhatareyoudoingheregomakeourownscriptkiddies.lua.ff"))()
end

utility.rejoin = function()
     teleport:teleport(game.PlaceId, Player)
end

utility.teleportTo = function(pos)
    HumanoidRootPart.CFrame = pos.CFrame + Vector3.new(_G.farmdistance, 2, 2)
end

utility.farmFruits = function()
for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
        if v.ClassName == "Tool" then -- if you want to to find a player by short user
           util.makeEsp(v.Handle, Color3.new(34, 122, 0), 13, UDim2.new(0, 200, 0, 50), v.Name, "Code", {
               ['distance'] = true,
           })
           _G.lastpos = HumanoidRootPart.CFrame
           utility.warp(.2, v.Handle.CFrame)
           task.wait(0.10)
           utility.warp(.2, _G.lastpos)
           end
        end
    end
end


utility.getSafePlace = function()
    if Humanoid.Health > 100 then

    end
end

utility.tween = function(time, pos) -- Regular tween
    game:GetService("TweenService"):Create(HumanoidRootPart,
        TweenInfo.new(time, Enum.EasingStyle.Quart), {
            CFrame = pos + Vector3.new(0, 2, 0)
        }):Play()
    task.wait(time)
end

utility.warp = function(time, pos) -- tiny tween
    game:GetService("TweenService"):Create(HumanoidRootPart,
        TweenInfo.new(time, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {
            -- CFrame = pos + Vector3.new(0, 2, 0)
            CFrame = pos + Vector3.new(0, 2, 0)
        }):Play()
    task.wait(time)
end

utility.bounce = function(time, pos) -- tiny tween
    game:GetService("TweenService"):Create(HumanoidRootPart,
        TweenInfo.new(time, Enum.EasingStyle.Bounce), {
            CFrame = pos + Vector3.new(0, 2, 0)
        }):Play()
    task.wait(time)
end



utility.onSave = function()
    local json;
    local https = game:GetService'HttpService'
    if(writefile) then
       json = https:JSONEncode(_G.settings)
       local hub = "Zora0"
        if not isfolder(hub) then
        makefolder(hub)
        end
       local path = hub .. "/config.json"
       writefile(path ,json, null, 2)
       
       else
       snowy:Notify('Error','[writefile]')
       end   
end

utility.onLoad = function()
    local json;
    local https = game:GetService'HttpService'
     local path = "Zora0/config.json"
    if(isfile(path)) then
    if(readfile) then
      
        json = https:JSONDecode(readfile(path, null, 2))
      

        _G.farmtpmethod = json['misc'].tpmethod
        _G.farmdistance = json['misc'].farmingdistance
        _G.isfarming = json['misc'].autofarming
        _G.farmweapon = json['misc'].farmingwep
        _G.autoequip = json['misc'].autoequip
        _G.selectedncp = json['misc'].lastncp
        _G.selectedland = json['misc'].lastisland
        _G.tweenspeed = json['misc'].tweenspeed
        _G.collectfruits = json['misc'].autofruitcollect
        
         for i,v in pairs(json['misc']) do 
            warn(i,v)
         end

        if json['misc'].lastpos then
            HumanoidRootPart.CFrame = CFrame.new(Vector3.new(json['misc'].lastpos)) 
        end

        warn('Loaded Config')
        else
        snowy:Notify('Error','[readfile]')
        end
        else
            return false
    end
end


	game:GetService("Players").LocalPlayer.Idled:connect(function()
     utility.onSave()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)

-- get ncp list
utility.getncplist = function()
    for _, v in pairs(Path) do
        if rawget(v, 'Mob') then
            if rawget(v, 'Ammount') == 1 then
                table.insert(bosses, v.Mob)
            else
                table.insert(npcs, v.Mob)
            end
        end
    end
end
utility.getncplist()
-- get island list
utility.getislandlist = function()
    local island = {}
    for i, v in pairs(_G.islands) do
        table.insert(island, v)
    end
    return island
end

utility.getPlayerList = function()
    local players = {}
    for i,v in pairs(game.Players:GetChildren()) do
       local final
        
        final = v.Name
           
        table.insert(players, final)
    end
    return players
end


-- get player inventory
utility.getInventory = function()
    local inventory = {}
    for i, v in pairs(Player.Inventory:GetChildren()) do
        if v:IsA("BoolValue") then
            table.insert(inventory, v.Name)
        end
    end
    return inventory
end


utility.getFruit = function()
    local fruit = {}
    for i, v in pairs(Player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            table.insert(fruit, v.Name)
        end
    end
    return fruit
end

utility.refresh = function(whatto)
    local whatto = whatto or {}
    if whatto['list'] == "ncp" then
        utility.getncplist()
    end
    if whatto['list'] == "island" then
        utility.getislandlist()
    end
    if whatto['list'] == "inventory" then
        utility.getInventory()
    end
    if whatto['list'] == "fruit" then
        utility.getFruit()
    end
end



utility.farm = function(mob)
    for i,v in pairs(standardNcpFolder:GetDescendants()) do
        if v:FindFirstChild('Humanoid') and v.HumanoidRootPart and v.Name == mob and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2000 then
            repeat task.wait(.1)
              utility.useSword()
                if _G.farmtpmethod == "Tween" then
                    utility.tween(.3, v.HumanoidRootPart.CFrame)
                    
                elseif _G.farmtpmethod == "Standard" then
                    utility.teleportTo(v.HumanoidRootPart)
                    
                else
                    if _G.farmtpmethod == "Warp" then
                        utility.warp(.3, v.HumanoidRootPart.CFrame)
                       
                    else
                        if _G.farmtpmethod == "Bounce" then
                            utility.bounce(.3, v.HumanoidRootPart.CFrame)
                          
                        end
                    end
                end
               
            until _G.isfarming == false or v.Humanoid.Health <= 0
        end
    end
end

utility.huntplayer = function(mob)
    for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:FindFirstChild('Humanoid') and v.HumanoidRootPart and v.Name == _G.selectedplayer and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2000 then
            repeat task.wait(.1)
                 utility.useSword()
                if _G.farmtpmethod == "Tween" then
                    utility.tween(.3, v.HumanoidRootPart.CFrame)
                   
                elseif _G.farmtpmethod == "Standard" then
                    utility.teleportTo(v.HumanoidRootPart)
                  
                else
                    if _G.farmtpmethod == "Warp" then
                        utility.warp(.3, v.HumanoidRootPart.CFrame)
                        
                    else
                        if _G.farmtpmethod == "Bounce" then
                            utility.bounce(.3, v.HumanoidRootPart.CFrame)
                           
                        end
                    end
                end
               
            until _G.playerhunting == false or v.Humanoid.Health <= 0
        end
    end
end

utility.useSword = function()
 local A_1 = "SW_".._G.farmweapon.."_M1"
 game:GetService("ReplicatedStorage").Remotes.Functions.SkillAction:InvokeServer(A_1)
end

utility.equip = function()
    local A_1 = _G.farmweapon
    game:GetService("ReplicatedStorage").Remotes.Functions.InventoryEq:InvokeServer(A_1)
    task.wait(.5)
    for _,v in next, Player.Backpack:GetChildren() do
        if v:IsA("Tool") and v.Name == _G.farmweapon then
           Player.Character.Humanoid:EquipTool(v)
    end
end
    
end

spawn(function()
    while task.wait(.1) do
         if _G.isfarming then
            utility.farm(_G.selectedncp)
         end
    end
 end)

 spawn(function()
    while task.wait(.1) do
         if _G.playerhunting then
            utility.huntplayer(_G.selectedplayer)
         end
    end
 end)

 


spawn(function()
    while task.wait(.3) do
         if _G.autosave then
            utility.onSave()
         end
    end
 end)



 spawn(function()
    while task.wait(.1) do
         if _G.collectfruits then
            utility.farmFruits()
         end
    end
 end)
 

spawn(function()
   while task.wait(.1) do
        if _G.autoequip then
            utility.equip()
        end
   end
end)

spawn(function()
   while task.wait(.3) do
        if _G.getloco then
         local loco = HumanoidRootPart.CFrame
            _G.pos = loco
          
        end
   end
end)




--Å


local page = snowy:addPage("Home", 5012544693)
local credits = page:addSection('Credits')
local owner = credits:addButton('Made By : Nebula Zora')
local uicreds = credits:addButton('Ui Design: Venyx')
local scripting = credits:addButton('Scripting By: ZoraHub Team')
local versionsec = page:addSection('Version')
local vb = versionsec:addButton('Using Version: v'..version)

local versionpicker = versionsec:addDropdown('Versions', {"0.0.1"}, function(text)
wantedversion = text
end)

local reload = versionsec:addButton('Reload Ui', function()
task.wait()
    utility.reload()
end)

local rejoin = versionsec:addButton('Rejoin', function()
utility.rejoin()
end)





local auto_save = versionsec:addToggle('Auto Save', false, function(state)
    _G.autosave = state
end)

local quit = versionsec:addButton('Quit', function()
    game.CoreGui["ZoraHub | " ..GetName]:Destroy()
end)


-- second page
local Autofarm = snowy:addPage('Farming',5012544693)
local farm = Autofarm:addSection('Farm Settings')

local farm_method = farm:addDropdown('Farm Method' or _G.farmtpmethod, {"Tween", "Warp", "Bounce", "Standard"}, function(text)
    _G.farmtpmethod = text
end)

local farming_weapon = farm:addDropdown('Farming Weapon' or _G.farmweapon, utility.getInventory() , function(text)
    _G.farmweapon = text
end)

local update_weaponlist = farm:addButton('Update Weaponlist', function()
   farm:updateDropdown(farming_weapon, "Farming Weapon" , utility.getInventory())
end)

local farming_fruit = farm:addDropdown('Farming Fruit' or _G.farmusingfruit, utility.getFruit() , function(text)
    _G.farmusingfruit = text
end)
local update_fruitlist = farm:addButton('Fruit Weaponlist', function()
    farm:updateDropdown(farming_fruit, "Farming Fruit" , utility.getFruit())
 end)

local farming_autoequip = farm:addToggle('Auto Equip', false or _G.autoequip, function(state)
    _G.autoequip = state
end)

--local farm_distance = farm:addSlider("Farming Distance", 0.5, -100.5, 100.5 , function(value)
--	_G.farmdistance = value
--end)

--local farm_tweenspeed = farm:addSlider("Tween Speed", 0.5, -100.5, 100.5 , function(value)
--	_G.tweenspeed = value
--end)


local farm_tp_island = farm:addDropdown('Islands', utility.getislandlist(), function(text)
    _G.selectedland = text
end)

local player_tp_list = farm:addDropdown('Players', utility.getPlayerList(), function(text)
        _G.selectedplayer = text
end)

local tpto_player = farm:addButton('To Player', function()
    for i,v in pairs(game.Workspace:GetDescendants()) do
       if v.ClassName == "Model" and string.find(v.Name, _G.selectedplayer) then
          for i,v in pairs(v:GetChildren()) do
              if string.find(v.Name, 'RootPart') then
                  utility.warp(.5, v.CFrame)
              end
          end
       end
    end
 end)

 local farm_toggle = farm:addToggle('Kill Player', false or _G.playerhunting,  function(text)
    _G.playerhunting = text
end)

 local tpto_player = farm:addButton('Refresh Players', function()
    farm:updateDropdown(player_tp_list, "Players" , utility.getPlayerList())
 end)





local toisland = farm:addButton('Teleport To Island', function()
 for i, land in pairs(Workspace.Island:GetChildren()) do
        if string.find(land.Name, _G.selectedland) then
           for i , part in pairs(land:GetDescendants()) do
                if part:IsA("Part") then
                    utility.warp(.5, part.CFrame)
                        return
            end
        end
    end
end
end)

local ncps_dropdown = farm:addDropdown('NPCs' or _G.selectedncp, npcs , function(text)
    _G.selectedncp = text
end)

local ncps_dropdown2 = farm:addDropdown('Bosses' or _G.selectedncp, bosses , function(text)
    _G.selectedncp = text
end)

 local refresh_ncps = farm:addButton('Refresh Mobs', function()
    farm:updateDropdown(ncps_dropdown, "NPCs" , utility.getncplist())
    farm:updateDropdown(ncps_dropdown2, "Bosses" , utility.getncplist())
 end)


local farm_toggle = farm:addToggle('Auto Farm', false or _G.isfarming,  function(text)
    _G.isfarming = text
end)



local farmfruit_toggle = farm:addToggle('Auto Fruit Farm', false or _G.collectfruits,  function(text)
    _G.collectfruits = text
end)


-- third page
local theme = snowy:addPage("Ui", 5012544693)

local keybind = theme:addSection('Keybind')
keybind:addKeybind("Keybind / Toggle Key", Enum.KeyCode.RightAlt, function(value)
	snowy:toggle()
end, function()
	snowy:Notify("Changed", "Keybind")
end)

local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do 
	colors:addColorPicker(theme, color, function(color3)
		snowy:setTheme(theme, color3)
	end)
end





-- load
snowy:SelectPage(snowy.pages[1], true)
