if CLIENT then

---------------------------------------------------
-- POPUP CONFIGURATION
---------------------------------------------------
local main_color = Color(32, 34, 37) -- Main color
local secondary_color = Color(54, 57, 62) -- Secondary color
local text_color = Color(255, 255, 255) -- Main text color

local button_color = Color(47, 49, 54) -- Button color
local button_hovered_color = Color(66, 70, 77) -- Button color (if hovered)

local header_message = "Enable Multicore Rendering" -- Header message
local header_color = Color(255, 255, 255) -- Header text color

local subtext_color = Color(0, 195, 165) -- Subtext color
local subtext_message = "This could improve your FPS massively!" -- Subtext message

local width = 500 -- The width of the popup
local height = 150 -- The height of the popup

local disable_multicore_button = "No Thanks!"  -- Disable Multicore button text
---------------------------------------------------
-- CHAT MESSAGES 
---------------------------------------------------
local enable_multicore_message = "You have succesfully enabled Multicore Rendering"
local disable_multicore_message = "You have not enabled Multicore Rendering"

---------------------------------------------------
-- FONTS
---------------------------------------------------
surface.CreateFont( "Roboto_Title", { 
	font = "Roboto", 
	extended = false,
	size = 25,
	weight = 800,
	antialias = true,
})

surface.CreateFont( "Roboto_Button", {
	font = "Roboto", 
	extended = false,
	size = 15,
	weight = 500,
	antialias = true,
})

surface.CreateFont( "Roboto_Subtext", {
	font = "Roboto",
	extended = false,
	size = 18,
	weight = 400,
	antialias = true,
})	

	
local function enableCores()
	local popup = vgui.Create("DFrame")
	popup:SetTitle("")
	popup:SetSize( width, height )
	popup:Center()
	popup:MakePopup()
	popup:ShowCloseButton(false)
	function popup.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, main_color)
		draw.RoundedBox(0, 1, 1, w - 2, h - 2, secondary_color)
	end

	local btns = vgui.Create("DPanel", popup)
	btns:SetDrawBackground(false)
	btns:Dock(BOTTOM)
	btns:DockMargin(4, 4, 4, 4)
			
	local title = vgui.Create("DLabel", popup)
	title:SetText("Enable Multicore Rendering")
	title:SetFont("Roboto_Title")
	title:Center()
	title:SetTextColor( text_color )
	title:SetContentAlignment(8)
	title:Dock(FILL)
	title:DockMargin(0, 0, 0, 0)

	local subtext = vgui.Create("DLabel", popup)
	subtext:SetText( subtext_message )
	subtext:SetFont("Roboto_Subtext")
	subtext:Center()
	subtext:SetTextColor( subtext_color )
	subtext:SetContentAlignment(5)
	subtext:Dock(FILL)
	subtext:DockMargin(0, 0, 0, 0)
		
	local button_enable = vgui.Create("DButton", btns)
	button_enable:SetText( header_message )
	button_enable:SetFont("Roboto_Button")
	button_enable:Center()
	button_enable:SetTextColor( header_color )
	button_enable:SetWide(popup:GetWide() * 0.5 - 14)
	button_enable:Dock(LEFT)
	function button_enable.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, button_color)
		
		if (s.Hovered) then
			draw.RoundedBox(0, 0, 0, w, h, button_hovered_color)																																																			-- Copyright 76561198110511213
		end
	end
	button_enable:SetTextColor( text_color )
	button_enable.DoClick = function()
		LocalPlayer():ConCommand("gmod_mcore_test 1")
		LocalPlayer():ConCommand("mat_queue_mode -1")
		LocalPlayer():ConCommand("cl_threaded_bone_setup 1")
		LocalPlayer():ConCommand("cl_threaded_client_leaf_system 1")
		LocalPlayer():ConCommand("r_threaded_particles 1")
		LocalPlayer():ConCommand("r_threaded_renderables 1")
		LocalPlayer():ConCommand("r_queued_ropes 1")
		LocalPlayer():ConCommand("studio_queue_mode 1")
		popup:Remove()
		surface.PlaySound( "garrysmod/ui_click.wav" )
		LocalPlayer():ChatPrint( enable_multicore_message )
	end

	local button_disable = vgui.Create("DButton", btns)
	button_disable:SetText( disable_multicore_button )
	button_disable:SetFont("Roboto_Button")
	button_disable:Center()
	button_disable:SetWide(popup:GetWide() * 0.5 - 14)
	button_disable:Dock(RIGHT)
	function button_disable.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(47, 49, 54))
		
		if (s.Hovered) then
			draw.RoundedBox(0, 0, 0, w, h, Color(66, 70, 77))
		end
	end
	button_disable:SetTextColor( text_color )
	button_disable.DoClick = function()
		popup:Remove()
		surface.PlaySound( "garrysmod/ui_click.wav" )
		LocalPlayer():ChatPrint( disable_multicore_message )
	end
	
end		
				
hook.Add("InitPostEntity","MultiRenderingPopup",function()
	timer.Simple(5,function()
		enableCores()
	end)
end)
	
concommand.Add("mutlicore_enable", enableCores)
end


------------------------------------------------------------
------------------- CREATED BY OBITUS ----------------------
------------------------------------------------------------
