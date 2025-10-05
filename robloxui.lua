local menu = {}

local coreui = game:GetService("CoreGui"); if not coreui then return end
local players = game:GetService("Players"); if not players then return end
local userinput = game:GetService("UserInputService"); if not userinput then return end
local run = game:GetService("RunService"); if not run then return end
local protectui = protectgui or (function() end)

local playerController = players.LocalPlayer; if not playerController then return end
local playerMouse = playerController:GetMouse(); if not playerMouse then return end


function menu:createWindow(windowInfo)
  if not windowInfo then return end
  if not windowInfo.key then windowInfo.key = Enum.KeyCode.Insert end
  local dragging = false
  local offset = nil
  local window = {}
  
  local screenui = Instance.new("ScreenGui", coreui)
  protectui(screenui)
  
  local windowFrame = Instance.new("Frame", screenui)
  windowFrame.Name = tostring(math.random(0, 100000))
  windowFrame.Size = UDim2.new(0, 460, 0, 400)
  windowFrame.Position = UDim2.new(0, 270, 0, 270)
  
  local tabs = {}
  
  function window:tab(tabInfo)
    if not tabInfo then return end
    local tab = {}
    tab.name = tabInfo.name or "tab"
    
    local tabButton = Instance.new("TextButton", windowFrame)
    tabButton.Name = tostring(math.random(0, 100000))
    tabButton.Text = tab.name
    tabButton.Size = UDim2.new()
    
    tab.tabButton = tabButton
    
    
    table.insert(tabs, tab)
    
    for i, t in ipairs(tabs) do
      t.tabButton.Size = UDim2.new(0, windowFrame.AbsoluteSize.X / #tabs, 0, 45)
      t.tabButton.Position = UDim2.new(0, (i - 1) * (windowFrame.AbsoluteSize.X / #tabs), 0, 0)
    end
    return tab
  end
  
  run.RenderStepped:Connect(function(delta)
    if (dragging) then
      windowFrame.Position = UDim2.new(
        0,
        (playerMouse.X - offset.X),
        0,
        (playerMouse.Y - offset.Y)
        )
    end
  end)
  
  windowFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1) then
      dragging = true
      offset = Vector2.new(
        playerMouse.X - windowFrame.AbsolutePosition.X,
        playerMouse.Y - windowFrame.AbsolutePosition.Y
        )
    end
  end)
  
  windowFrame.InputEnded:Connect(function(input)
    if(input.UserInputType == Enum.UserInputType.MouseButton1) then
      dragging = false
    end
  end)
  
  userinput.InputBegan:Connect(function(input, processed)
    if processed then return end
    if (input.KeyCode == windowInfo.key) then
      windowFrame.Visible = not windowFrame.Visible
    end
    
  end)
  return window
end



return menu

