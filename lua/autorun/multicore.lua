if CLIENT then

surface.CreateFont( "Roboto_Title", { 
	font = "Roboto", 
	extended = false,
	size = 25,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	outline = false,
})

surface.CreateFont( "Roboto_Button", {
	font = "Roboto", 
	extended = false,
	size = 15,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	outline = false,
})
surface.CreateFont( "Roboto_Subtext", {
	font = "Roboto",
	extended = false,
	size = 18,
	weight = 400,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	outline = false,
})	
	
local function Multicore()
	local popup = vgui.Create("DFrame")
	popup:SetTitle("")
	popup:SetSize(500, 150)
	popup:Center()
	popup:MakePopup()
	popup:ShowCloseButton(false)
	function popup.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(32, 34, 37))
		draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(54, 57, 62))
	end

	local buttons = vgui.Create("DPanel", popup)
	buttons:SetDrawBackground(false)
	buttons:Dock(BOTTOM)
	buttons:DockMargin(4, 4, 4, 4)
			
	local title = vgui.Create("DLabel", popup)
	title:SetText("Enable Multicore Rendering")
	title:SetFont("Roboto_Title")
	title:Center()
	title:SetTextColor(Color(255, 255, 255))
	title:SetContentAlignment(8)
	title:Dock(FILL)
	title:DockMargin(0, 0, 0, 0)

	local subtext = vgui.Create("DLabel", popup)
	subtext:SetText("This will enabled Multicore Rendering!")
	subtext:SetFont("Roboto_Subtext")
	subtext:Center()
	subtext:SetTextColor(Color(0, 195, 165))
	subtext:SetContentAlignment(5)
	subtext:Dock(FILL)
	subtext:DockMargin(0, 0, 0, 0)
		
	local button_enable = vgui.Create("DButton", buttons)
	button_enable:SetText("Enable Multicore Rendering")
	button_enable:SetFont("Roboto_Button")
	button_enable:Center()
	button_enable:SetWide(popup:GetWide() * 0.5 - 14)
	button_enable:Dock(LEFT)
	function button_enable.Paint(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(47, 49, 54))
		
		if (s.Hovered) then
			draw.RoundedBox(0, 0, 0, w, h, Color(66, 70, 77))																																																			-- Copyright 76561198110511213
		end
	end
	button_enable:SetTextColor(Color(255, 255, 255))
	button_enable.DoClick = function()
		LocalPlayer():ConCommand("gmod_mcore_test 1")
		LocalPlayer():ConCommand("mat_queue_mode -1")
		LocalPlayer():ConCommand("studio_queue_mode 1")
		LocalPlayer():ConCommand("cl_threaded_bone_setup 1")
		LocalPlayer():ConCommand("cl_threaded_client_leaf_system 1")
		LocalPlayer():ConCommand("r_threaded_particles 1")
		LocalPlayer():ConCommand("r_threaded_renderables 1")
		LocalPlayer():ConCommand("r_queued_ropes 1")
		popup:Remove()
		LocalPlayer():ChatPrint( "You have succesfully enabled Multicore Rendering" )
	end

	local button_disable = vgui.Create("DButton", buttons) -- Yes i know it doesn't DISABLE it, but i needed a name :P
	button_disable:SetText("No thanks")
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
	button_disable:SetTextColor(Color(255, 255, 255))
	button_disable.DoClick = function()
		popup:Remove()
		LocalPlayer():ChatPrint( "You have not enabled Multicore Rendering" )
	end
	
end		
				
hook.Add("InitPostEntity","MulticorePopup",function()
	timer.Simple(3,function()
		Multicore()
	end)
end)
	
concommand.Add("mutlicore_enable", Multicore)
end
