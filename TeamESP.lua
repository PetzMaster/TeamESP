if #game.Teams:GetChildren() < 1 then
	game:GetService("Players").LocalPlayer:Kick("This game does utilize teams.")
end


local Markers = {}
local frame = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer.PlayerGui)
local Screen = frame.AbsoluteSize
local T = game:GetService("TweenService")


local BurstRings = Instance.new("ImageLabel", script)
local Sample = Instance.new("ImageLabel", script)
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local RotateLabel = Instance.new("Frame")
local Arrow = Instance.new("ImageLabel")
local Icon = Instance.new("ImageLabel")
local Holder = Instance.new("Frame", frame)

Holder.Name = "Holder"
Holder.AnchorPoint = Vector2.new(0.5, 0.5)
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0.5, 0, 0.5, 0)
Holder.Size = UDim2.new(1, -25, 1, -25)

BurstRings.Name = "BurstRings"
BurstRings.AnchorPoint = Vector2.new(0.5, 0.5)
BurstRings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BurstRings.BackgroundTransparency = 1.000
BurstRings.Position = UDim2.new(0.5, 0, 0.5, 0)
BurstRings.Size = UDim2.new(1, 0, 1, 0)
BurstRings.Image = "rbxassetid://2681945588"

Sample.Name = "Sample"
Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sample.BackgroundTransparency = 1.000
Sample.Position = UDim2.new(0.5, 0, 0.5, 0)
Sample.Size = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
Sample.Image = "rbxassetid://2681945588"

UIAspectRatioConstraint.Parent = Sample

RotateLabel.Name = "RotateLabel"
RotateLabel.Parent = Sample
RotateLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RotateLabel.BackgroundTransparency = 1.000
RotateLabel.Size = UDim2.new(1, 0, 1, 0)

Arrow.Name = "Arrow"
Arrow.Parent = RotateLabel
Arrow.AnchorPoint = Vector2.new(0.5, 1)
Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Arrow.BackgroundTransparency = 1.000
Arrow.Position = UDim2.new(0.5, 0, 0, 0)
Arrow.Size = UDim2.new(0.5, 0, 0.400000006, 0)
Arrow.Image = "rbxassetid://2800468809"

Icon.Name = "Icon"
Icon.Parent = Sample
Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
Icon.Size = UDim2.new(1, -6, 1, -6)
Icon.ZIndex = 2

local function createMarker(character)
	local Marker = Sample:Clone()
	Marker.Parent = Holder
	Marker.ImageColor3 = Color3.fromRGB(255,255,255)
	Marker.RotateLabel.Arrow.ImageColor3 = Color3.fromRGB(255,255,255)
	Marker.Icon.Image = "nil"
	table.insert(Markers,{Marker,character:WaitForChild("Head")})
end

function ClampMarkerToBorder(X,Y,Absolute)
	X = Screen.X - X
	Y = Screen.Y - Y

	local DistanceToXBorder = math.min(X,Screen.X-X)
	local DistanceToYBorder = math.min(Y,Screen.Y-Y)

	if DistanceToYBorder < DistanceToXBorder then 
		if Y < (Screen.Y-Y) then
			return math.clamp(X,0,Screen.X-Absolute.X),0
		else
			return math.clamp(X,0,Screen.X-Absolute.X),Screen.Y - Absolute.Y
		end
	else
		if X < (Screen.X-X) then
			return 0,math.clamp(Y,0,Screen.Y-Absolute.Y)
		else
			return Screen.X - Absolute.X,math.clamp(Y,0,Screen.Y-Absolute.Y)
		end
	end
end

for _, player in pairs(game:GetService("Players"):GetChildren()) do
	print(player)
	local highlight = Instance.new("Highlight", player.Character)
	createMarker(player.Character)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.OutlineTransparency = 1 
	highlight.FillTransparency = 0.6
	if player.Team.Name ~= game:GetService("Players").LocalPlayer.Team.Name then
		highlight.FillColor = Color3.fromRGB(255,0,0)
	else
		highlight.FillColor = Color3.fromRGB(0,255,0)
	end
	spawn(function()
		while true do
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.OutlineTransparency = 1 
			highlight.FillTransparency = 0.6
			if player.Team.Name ~= game:GetService("Players").LocalPlayer.Team.Name then
				highlight.FillColor = Color3.fromRGB(255,0,0)
			else
				highlight.FillColor = Color3.fromRGB(0,255,0)
			end
			wait(10)
		end
	end)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
	print(player)
	local highlight
	player.CharacterAdded:Connect(function(character)
		createMarker(character)
		highlight = Instance.new("Highlight", player.Character)
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.OutlineTransparency = 1 
		highlight.FillTransparency = 0.6
		if player.Team.Name ~= game:GetService("Players").LocalPlayer.Team.Name then
			highlight.FillColor = Color3.fromRGB(255,0,0)
		else
			highlight.FillColor = Color3.fromRGB(0,255,0)
		end
	end)
	while true do
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.OutlineTransparency = 1 
		highlight.FillTransparency = 0.6
		if player.Team.Name ~= game:GetService("Players").LocalPlayer.Team.Name then
			highlight.FillColor = Color3.fromRGB(255,0,0)
		else
			highlight.FillColor = Color3.fromRGB(0,255,0)
		end
		wait(10)
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	for i,Stat in pairs(Markers) do
		local Marker = Stat[1]
		local Location = Stat[2]
		local player = game:GetService("Players"):GetPlayerFromCharacter(Location.Parent)
		Marker.Visible = true

		local MarkerPosition , MarkerVisible = game.Workspace.CurrentCamera:WorldToScreenPoint(Location.Position)
		local MarkerRotation = game.Workspace.CurrentCamera.CFrame:Inverse()*Location.CFrame
		local MarkerAbsolute = Marker.AbsoluteSize

		local MarkerPositionX = MarkerPosition.X - MarkerAbsolute.X/2
		local MarkerPositionY = MarkerPosition.Y - MarkerAbsolute.Y/2

		if MarkerPosition.Z < 0  then
			MarkerPositionX,MarkerPositionY = ClampMarkerToBorder(MarkerPositionX,MarkerPositionY,MarkerAbsolute)
		else
			if MarkerPositionX < 0 then
				MarkerPositionX = 0
			elseif MarkerPositionX > (Screen.X - MarkerAbsolute.X) then
				MarkerPositionX = Screen.X - MarkerAbsolute.X
			end
			if MarkerPositionY < 0 then
				MarkerPositionY = 0
			elseif MarkerPositionY > (Screen.Y - MarkerAbsolute.Y) then
				MarkerPositionY = Screen.Y - MarkerAbsolute.Y
			end
		end

		Marker.RotateLabel.Visible = not MarkerVisible
		Marker.RotateLabel.Rotation = 90 + math.deg(math.atan2(MarkerRotation.Z,MarkerRotation.X))
		Marker.Position = UDim2.new(0,MarkerPositionX,0,MarkerPositionY)

		local CurrentTime = tick()
		if math.floor((CurrentTime%1.5)*100)/100 <= .01 then
			local Burst = BurstRings:Clone()
			if player.Team.Name ~= game:GetService("Players").LocalPlayer.Team.Name then
				Marker.Visible = true
				Marker.Icon.Image = game:GetService("Players"):GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				T:Create(Marker,TweenInfo.new(.5),{ImageColor3 = Color3.fromRGB(255,0,0)}):Play()
				T:Create(Marker.RotateLabel.Arrow,TweenInfo.new(.5),{ImageColor3 = Color3.fromRGB(255,0,0)}):Play()
			else
				Marker.Visible = false
			end
			Burst.Parent = Marker
			T:Create(Burst,TweenInfo.new(1),{Size = UDim2.new(2,0,2,0),ImageTransparency = 1}):Play()
			game.Debris:AddItem(Burst,1)
		end
	end
end)