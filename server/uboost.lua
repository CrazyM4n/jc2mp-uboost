function Vector3:IsNaN()
	return (self.x ~= self.x) or (self.y ~= self.y) or (self.z ~= self.z)
end

playerBoost = {}

Network:Subscribe("Boost",
	function(args, sender)
		if sender:GetWorld() ~= DefaultWorld then return end
		if not sender:InVehicle() then return end
		if sender:GetState() ~= PlayerState.InVehicle then return end

		local v = sender:GetVehicle()
		local forward = v:GetAngle() * Vector3(0, 0, -1)
		local vel = v:GetLinearVelocity()
		local new_vel = vel + (forward * playerBoost[sender:GetName()])
		print("Boosting")

		if new_vel:IsNaN() then
			new_vel = Vector3( 0, 0, 0 )
		end

		v:SetLinearVelocity( new_vel )
	end)

function SetBoost(args)
	local chatCommand = args.text:split(" ")
	if #chatCommand == 2 and chatCommand[1] == "/boost" and tonumber(chatCommand[2]) > -1 then
		playerBoost[args.player:GetName()] = tonumber(chatCommand[2])
		args.player:SendChatMessage("Your boost is now: "..playerBoost[args.player:GetName()], Color(255, 120, 0))
	elseif #chatCommand == 1 and chatCommand[1] == "/boost" then
		args.player:SendChatMessage("Your boost is: "..playerBoost[args.player:GetName()], Color(255, 120, 0))
	end
end

function SetTable(args) 
	playerBoost[args.player:GetName()] = 10
	print("added to table "..args.player:GetName())
end

function StartLoop()
	for p in Server:GetPlayers() do
		playerBoost[p:GetName()] = 10
	end
end

StartLoop()

Events:Subscribe( "PlayerChat", SetBoost )
Events:Subscribe( "PlayerJoin" , SetTable )