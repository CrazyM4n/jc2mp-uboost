land_vehicles = {}
function AddVehicle(id)
	land_vehicles[id] = true
end
AddVehicle(1)
AddVehicle(2)
AddVehicle(4)
AddVehicle(7)
AddVehicle(8)
AddVehicle(9)
AddVehicle(10)
AddVehicle(11)
AddVehicle(12)
AddVehicle(13)
AddVehicle(15)
AddVehicle(18)
AddVehicle(21)
AddVehicle(22)
AddVehicle(23)
AddVehicle(26)
AddVehicle(29)
AddVehicle(31)
AddVehicle(32)
AddVehicle(33)
AddVehicle(35)
AddVehicle(36)
AddVehicle(40)
AddVehicle(41)
AddVehicle(42)
AddVehicle(43)
AddVehicle(44)
AddVehicle(46)
AddVehicle(47)
AddVehicle(48)
AddVehicle(49)
AddVehicle(52)
AddVehicle(54)
AddVehicle(55)
AddVehicle(56)
AddVehicle(60)
AddVehicle(61)
AddVehicle(63)
AddVehicle(66)
AddVehicle(68)
AddVehicle(70)
AddVehicle(71)
AddVehicle(72)
AddVehicle(73)
AddVehicle(74)
AddVehicle(76)
AddVehicle(77)
AddVehicle(78)
AddVehicle(79)
AddVehicle(83)
AddVehicle(84)
AddVehicle(86)
AddVehicle(87)
AddVehicle(89)
AddVehicle(90)
AddVehicle(91)
AddVehicle(5)
AddVehicle(6)
AddVehicle(16)
AddVehicle(19)
AddVehicle(25)
AddVehicle(27)
AddVehicle(28)
AddVehicle(38)
AddVehicle(45)
AddVehicle(50)
AddVehicle(69)
AddVehicle(80)
AddVehicle(88)
AddVehicle(53)

local timer = Timer()
local nos_enabled = true

function InputEvent(args)

	if LocalPlayer:InVehicle() and 
		LocalPlayer:GetState() == PlayerState.InVehicle and 
		IsValid(LocalPlayer:GetVehicle()) and
		timer:GetSeconds() > 0.2 and 
		LocalPlayer:GetWorld() == DefaultWorld and
		land_vehicles[LocalPlayer:GetVehicle():GetModelId()] then

		if args.input == Action.PlaneIncTrust then
			Network:Send("Boost", true)
			timer:Restart()
		end
	end
end
function RenderEvent()
	if not nos_enabled then return end
	if LocalPlayer:InVehicle() and LocalPlayer:GetState() ~= PlayerState.InVehicle then return end
	if not IsValid(LocalPlayer:GetVehicle()) then return end
	if land_vehicles[LocalPlayer:GetVehicle():GetModelId()] == nil then return end
	if LocalPlayer:GetWorld() ~= DefaultWorld then return end

	local boost_text = "Boost Upgraded - /boost [number] to change boost. Made by jc2mp team, forked by CrazyM4n."
	local boost_size = Render:GetTextSize( boost_text )

	local boost_pos = Vector2( 
		(Render.Width - boost_size.x)/2, 
		Render.Height - boost_size.y )

	Render:DrawText( boost_pos, boost_text, Color( 255, 255, 255 ) )
end
function ModulesLoad()
	Events:FireRegisteredEvent( "HelpAddItem",
        {
            name = "Boost Upgraded",
            text = 
                "The boost lets you increase the speed of your car/boat.\n\nTo use it, tap Shift.\n\nTo change boost, type /boost [multiplier] (default is 10)\n\nTo disable the script, type /boost 0." } )
end
function ModuleUnload()
    Events:FireRegisteredEvent( "HelpRemoveItem",
        {
            name = "Upgraded Boost"
        } )
end
Events:Subscribe("LocalPlayerInput", InputEvent)
Events:Subscribe("Render", RenderEvent)
Events:Subscribe("ModulesLoad", ModulesLoad)
Events:Subscribe("ModuleUnload", ModuleUnload)