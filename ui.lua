-- loadstring(game:HttpGet("https://raw.githubusercontent.com/pnnrrr/robloxui/refs/heads/main/robloxui.lua"))()

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
  windowFrame.BackgroundColor3 = colors.menuMain
  windowFrame.BorderColor3 = colors.outline
  windowFrame.BorderSizePixel = 1
  
  local tabs = {}
  
  function window:tab(tabInfo)
    if not tabInfo then return end
    local tab = {}
    tab.name = tabInfo.name or "tab"
    
    local tabButton = Instance.new("TextButton", windowFrame)
    tabButton.Name = tostring(math.random(0, 100000))
    tabButton.TextSize = 9
    tabButton.Text = tab.name
    tabButton.TextColor3 = colors.textUnselected
    tabButton.TextStrokeTransparency = 0.6
    tabButton.BackgroundColor3 = colors.tabUnselected
    tabButton.BorderColor3 = colors.outline
    tabButton.BorderSizePixel = 1
    
    tab.tabButton = tabButton
    table.insert(tabs, tab)
    
    for i, t in ipairs(tabs) do
      t.tabButton.Size = UDim2.new(1 / #tabs, 0, 0, 45)
      t.tabButton.Position = UDim2.new((i - 1) / #tabs, 0, 0, 0)
    end
    
    local tabHolder = Instance.new("Frame", windowFrame)
    tabHolder.Name = tostring(math.random(0, 100000))
    tabHolder.Visible = false
    tabHolder.BackgroundColor3 = colors.holderMain
    tabHolder.BorderColor3 = colors.outline
    tabHolder.BorderSizePixel = 1
    tabHolder.Size = UDim2.new(0, 400, 0, 280)
    tabHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    tabHolder.Size = UDim2.new(0, 420, 0, 310)
    tabHolder.Position = UDim2.new(0.5, 0, 0.5, 45 / 2)
    
    tab.tabHolder = tabHolder
    
    local holderTitle = Instance.new("TextLabel", tabHolder)
    holderTitle.Name = tostring(math.random(0, 100000))
    holderTitle.Text = tab.name
    holderTitle.TextSize = 8
    holderTitle.TextColor3 = colors.textSelected
    holderTitle.TextStrokeTransparency = 0.6
    holderTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    holderTitle.Position = UDim2.new(0.5, 0, 0.5, -130)
    
    if(#tabs == 1) then
      tabButton.BackgroundColor3 = colors.tabSelected
      tabButton.TextColor3 = colors.textSelected
      tabHolder.Visible = true
    end
    
    local columnLeft = Instance.new("Frame", tabHolder)
    columnLeft.Name = tostring(math.random(0, 100000))
    columnLeft.AnchorPoint = Vector2.new(0.5, 0.5)
    columnLeft.Size = UDim2.new(0, 170, 0, 230)
    columnLeft.Position = UDim2.new(0.27, 0, 0.55, 0)
    columnLeft.BackgroundTransparency = 1
    
    local leftLayout = Instance.new("UIListLayout", columnLeft)
    leftLayout.Padding = UDim.new(0, 8)
    
    local columnRight = Instance.new("Frame", tabHolder)
    columnRight.Name = tostring(math.random(0, 100000))
    columnRight.AnchorPoint = Vector2.new(0.5, 0.5)
    columnRight.Size = UDim2.new(0, 170, 0, 230)
    columnRight.Position = UDim2.new(0.725, 0, 0.55, 0)
    columnRight.BackgroundTransparency = 1
    
    local rightLayout = Instance.new("UIListLayout", columnRight)
    rightLayout.Padding = UDim.new(0, 8)
    
    
    
    tabButton.MouseButton1Click:Connect(function()
      for _, t in ipairs(tabs) do
        t.tabButton.BackgroundColor3 = colors.tabUnselected
        t.tabButton.TextColor3 = colors.textUnselected
        t.tabHolder.Visible = false
      end
      tabButton.BackgroundColor3 = colors.tabSelected
      tabButton.TextColor3 = colors.textSelected
      tabHolder.Visible = true
    end)
    
    
    
    function tab:check(checkInfo)
      if not checkInfo then return end
      local checkHolder = Instance.new("Frame")
      checkHolder.Name = tostring(math.random(0, 100000))
      checkHolder.Size = UDim2.new(0, 170, 0, 25)
      checkHolder.BackgroundTransparency = 1
      checkHolder.BorderSizePixel = 0
      
      if (checkInfo.column == 0) then checkHolder.Parent = columnLeft end
      if (checkInfo.column == 1) then checkHolder.Parent = columnRight end
      
      local checkButton = Instance.new("TextButton", checkHolder)
      checkButton.Text = ""
      checkButton.Size = UDim2.new(0, 20, 0, 20)
      checkButton.BorderColor3 = colors.outline
      checkButton.BorderSizePixel = 1
      
      local checkText = Instance.new("TextLabel", checkHolder)
      checkText.Text = checkInfo.text
      checkText.TextSize = 9
      checkText.TextColor3 = colors.textUnselected
      checkText.TextStrokeTransparency = 0.6
      checkText.BackgroundTransparency = 1
      checkText.Size = UDim2.new(0, 20, 0, 20)
      checkText.Position = UDim2.new(0, 40, 0, 0)
      checkText.TextXAlignment = Enum.TextXAlignment.Left
      checkText.BackgroundTransparency = 1
      
      if (checkInfo.bool == false) then checkButton.BackgroundColor3 = colors.itemGray end
      if (checkInfo.bool == true) then checkButton.BackgroundColor3 = colors.itemPurple end
      
      checkButton.MouseButton1Click:Connect(function()
        checkInfo.bool = not checkInfo.bool
        if (checkInfo.bool == false) then checkButton.BackgroundColor3 = colors.itemGray end
        if (checkInfo.bool == true) then checkButton.BackgroundColor3 = colors.itemPurple end
        end)
    end
    
    function tab:slider(sliderInfo)
      if not sliderInfo then return end
    end
    
    function tab:dropdown(dropdownInfo)
      if not dropdownInfo then return end
    end
    
    function tab:input(inputInfo)
      if not inputInfo then return end
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
