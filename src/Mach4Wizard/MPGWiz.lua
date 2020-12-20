frame = wx.wxFrame (wx.NULL, wx.wxID_ANY, "MPG Handwheel Diagnostic", wx.wxDefaultPosition, wx.wxSize(489,300), wx.wxDEFAULT_FRAME_STYLE+wx.wxSTAY_ON_TOP+wx.wxTAB_TRAVERSAL)
frame:SetSizeHints(wx.wxDefaultSize, wx.wxDefaultSize)

fgSizer2 = wx.wxFlexGridSizer(0, 1, 0, 0)
fgSizer2:SetFlexibleDirection(wx.wxBOTH)
fgSizer2:SetNonFlexibleGrowMode(wx.wxFLEX_GROWMODE_SPECIFIED)

bSizer6 = wx.wxBoxSizer(wx.wxHORIZONTAL)

bSizer6:Add(100, 0, 1, wx.wxEXPAND, 5)

m_staticText5 = wx.wxStaticText(frame, wx.wxID_ANY, "MPG Status", wx.wxDefaultPosition, wx.wxDefaultSize, 0)
m_staticText5:Wrap(-1)

m_staticText5:SetFont(wx.wxFont(35, wx.wxFONTFAMILY_DEFAULT, wx.wxFONTSTYLE_NORMAL, wx.wxFONTWEIGHT_BOLD, False, ""))

bSizer6:Add(m_staticText5, 0, wx.wxALL, 5)

bSizer6:Add(100, 0, 1, wx.wxEXPAND, 5)

fgSizer2:Add(bSizer6, 1, wx.wxEXPAND, 5)

sbSizer1 = wx.wxStaticBoxSizer(wx.wxStaticBox(frame, wx.wxID_ANY, "Connection"), wx.wxHORIZONTAL)

m_staticText6 = wx.wxStaticText(sbSizer1:GetStaticBox(), wx.wxID_ANY, "Status:", wx.wxDefaultPosition, wx.wxDefaultSize, 0)
m_staticText6:Wrap(-1)

sbSizer1:Add(m_staticText6, 0, wx.wxALIGN_CENTER + wx.wxALL, 5)

connected_btn = wx.wxButton(sbSizer1:GetStaticBox(), wx.wxID_ANY, "Connected", wx.wxDefaultPosition, wx.wxDefaultSize, 0)
sbSizer1:Add(connected_btn, 0, wx.wxALL, 5)

sbSizer1:Add(0, 0, 1, wx.wxEXPAND, 5)

reconnect_btn = wx.wxButton(sbSizer1:GetStaticBox(), wx.wxID_ANY, "Reconnect", wx.wxDefaultPosition, wx.wxDefaultSize, 0)
sbSizer1:Add(reconnect_btn, 0, wx.wxALL, 5)

fgSizer2:Add(sbSizer1, 1, wx.wxEXPAND, 5)

sbSizer2 = wx.wxStaticBoxSizer(wx.wxStaticBox(frame, wx.wxID_ANY, "Selected Axis"), wx.wxHORIZONTAL)

x_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "X", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(x_axis_btn, 0, wx.wxALL, 5)

y_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "Y", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(y_axis_btn, 0, wx.wxALL, 5)

z_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "Z", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(z_axis_btn, 0, wx.wxALL, 5)

a_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "A", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(a_axis_btn, 0, wx.wxALL, 5)

b_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "B", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(b_axis_btn, 0, wx.wxALL, 5)

c_axis_btn = wx.wxButton(sbSizer2:GetStaticBox(), wx.wxID_ANY, "C", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer2:Add(c_axis_btn, 0, wx.wxALL, 5)

fgSizer2:Add(sbSizer2, 1, wx.wxEXPAND, 5)

sbSizer3 = wx.wxStaticBoxSizer(wx.wxStaticBox(frame, wx.wxID_ANY, "Increment"), wx.wxHORIZONTAL)

inc_1_btn = wx.wxButton(sbSizer3:GetStaticBox(), wx.wxID_ANY, "1", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer3:Add(inc_1_btn, 0, wx.wxALL, 5)

inc_2_btn = wx.wxButton(sbSizer3:GetStaticBox(), wx.wxID_ANY, "10", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer3:Add(inc_2_btn, 0, wx.wxALL, 5)

inc_3_btn = wx.wxButton(sbSizer3:GetStaticBox(), wx.wxID_ANY, "100", wx.wxDefaultPosition, wx.wxSize(50,-1), 0)
sbSizer3:Add(inc_3_btn, 0, wx.wxALL, 5)

fgSizer2:Add(sbSizer3, 1, wx.wxEXPAND, 5)

frame:SetSizer(fgSizer2)
frame:Layout()

frame:Centre(wx.wxBOTH)

inst = mc.mcGetInstance()

local green = wx.wxColour(0, 255, 128)
local red = wx.wxColour(255, 0, 0)
local gray = wx.wxColour(224, 224, 224)

lastSelectedInc = 0
lastSelectedAxis = -1
lastState = -1
currentState = 0

function setMPGIncrement()
	inc_1_btn:SetBackgroundColour(gray)
	inc_2_btn:SetBackgroundColour(gray)
	inc_3_btn:SetBackgroundColour(gray)
	
	if lastSelectedInc == 1 then
		inc_1_btn:SetBackgroundColour(green)
	elseif lastSelectedInc == 2 then
		inc_2_btn:SetBackgroundColour(green)
	elseif lastSelectedInc == 3 then 
		inc_3_btn:SetBackgroundColour(green)
	end
end

function setSelectedMPGAxis()
	x_axis_btn:SetBackgroundColour(gray)
	y_axis_btn:SetBackgroundColour(gray)
	z_axis_btn:SetBackgroundColour(gray)
	a_axis_btn:SetBackgroundColour(gray)
	b_axis_btn:SetBackgroundColour(gray)
	c_axis_btn:SetBackgroundColour(gray)

	if ModbusMPG.mpgSelectedAxis == 1 then
		x_axis_btn:SetBackgroundColour(green)
	elseif ModbusMPG.mpgSelectedAxis == 2 then
		y_axis_btn:SetBackgroundColour(green)
	elseif ModbusMPG.mpgSelectedAxis == 3 then
		z_axis_btn:SetBackgroundColour(green)
	elseif ModbusMPG.mpgSelectedAxis == 4 then
		a_axis_btn:SetBackgroundColour(green)
	elseif ModbusMPG.mpgSelectedAxis == 5 then
		b_axis_btn:SetBackgroundColour(green)
	elseif ModbusMPG.mpgSelectedAxis == 6 then
		c_axis_btn:SetBackgroundColour(green)
	end
end

function grayOutBtns()
	x_axis_btn:SetBackgroundColour(gray)
	y_axis_btn:SetBackgroundColour(gray)
	z_axis_btn:SetBackgroundColour(gray)
	a_axis_btn:SetBackgroundColour(gray)
	b_axis_btn:SetBackgroundColour(gray)
	c_axis_btn:SetBackgroundColour(gray)

	inc_1_btn:SetBackgroundColour(gray)
	inc_2_btn:SetBackgroundColour(gray)
	inc_3_btn:SetBackgroundColour(gray)
end

function setStatusButton()
	if ModbusMPG.modbusRunning then
		connected_btn:SetBackgroundColour(green)
		connected_btn:SetLabel("Connected")
	else
		connected_btn:SetBackgroundColour(red)
		connected_btn:SetLabel("Disconnected")
		grayOutBtns()
	end
end

frame:Connect(wx.wxEVT_UPDATE_UI, function(event)
	if lastState ~= ModbusMPG.modbusRunning then
		lastState = ModbusMPG.modbusRunning
		setStatusButton()
	end
	
	if lastSelectedAxis ~= ModbusMPG.mpgSelectedAxis then
		setSelectedMPGAxis()
		lastSelectedAxis = ModbusMPG.mpgSelectedAxis
	end

	if lastSelectedInc ~= ModbusMPG.mpgSelectedInc then
		lastSelectedInc = ModbusMPG.mpgSelectedInc
		setMPGIncrement(lastSelectedInc)
	end

	event:Skip()
end)

frame:Connect(wx.wxEVT_CLOSE_WINDOW, function(event)
	frame:Show(false)
end)

reconnect_btn:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, function(event)
	 ModbusMPG.restartModbusConnection()
	event:Skip()
end)

frame:Fit()
frame:Show(true)
wx.wxGetApp():MainLoop()
