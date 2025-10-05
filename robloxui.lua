local menu = {}

local coreui = game:GetService("CoreGui"); if not coreui then return end
local players = game:GetService("Players"); if not players then return end
local userinput = game:GetService("UserInputService"); if not userinput then return end
local run = game:GetService("RunService"); if not run then return end
local protectui = protectgui or (function() end)

local playerController = players.LocalPlayer; if not playerController then return end
local playerMouse = playerController:GetMouse(); if not playerMouse then return end

local colors = {
  outline = Color3.fromRGB(129, 129, 128),
  menuMain = Color3.fromRGB(42, 42, 42),
  tabSelected = Color3.fromRGB(48, 48, 48),
  tabUnselected = Color3.fromRGB(79, 83, 94),
  textSelected = Color3.fromRGB(144, 99, 161),
  textUnselected = Color3.fromRGB(189, 192, 195),
  holderMain = Color3.fromRGB(48, 48, 48),
  itemPurple = Color3.fromRGB(205, 114, 214),
  itemGray = Color3.fromRGB(121, 121, 121)
}

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
  windowFrame.BorderColor3 = colors.outline
  windowFrame.BorderSizePixel = 1
  
  local tabs = {}
  
  function window:tab(tabInfo)
    if not tabInfo then return end
    local tab = {}
    tab.name = tabInfo.name or "tab"
    
    local tabButton = Instance.new("TextButton", windowFrame)
    tabButton.Name = tostring(math.random(0, 100000))
    tabButton.Text = tab.name
    tabButton.BackgroundColor3 = colors.tabUnselected
    tabButton.TextColor3 = colors.textUnselected
    tabButton.BorderColor3 = colors.outline
    tabButton.BorderSizePixel = 1
    
    tab.tabButton = tabButton
    
    
    table.insert(tabs, tab)
    
    for i, t in ipairs(tabs) do
      t.tabButton.Size = UDim2.new(1 / #tabs, 0, 0, 45)
      t.tabButton.Position = UDim2.new((i - 1) / #tabs, 0, 0, 0)

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
