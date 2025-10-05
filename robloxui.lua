local menu = {}

local coreui = game:GetService("CoreGui"); if not coreui then return end
local players = game:GetService("Players"); if not players then return end
local userinput = game:GetService("UserInputService"); if not userinput then return end
local run = game:GetService("RunService"); if not run then return end
local protectui = protectgui or (function() end)
if not Drawing then return end

local playerController = players.LocalPlayer; if not playerController then return end
local playerMouse = playerController:GetMouse(); if not playerMouse then return end


function menu:createWindow(windowInfo)
  if not windowInfo then return end
  local dragging = false
  local offset = nil
  
  local screenui = Instance.new("ScreenGui", coreui)
  protectui(screenui)
  
  local window = Instance.new("Frame", screenui)
  window.Name = tostring(math.random(0, 100000))
  window.Size = UDim2.new(0, 440, 0, 380)
  window.Position = UDim2.new(0, 270, 0, 270)
  
  local tabs = {}
  
  function tabs:tab(tabInfo)
    if not tabInfo then return end
    
  end
  
  run.RenderStepped:Connect(function(delta)
    if (dragging) then
      window.Position = UDim2.new(
        0,
        (playerMouse.X - offset.X),
        0,
        (playerMouse.Y - offset.Y)
        )
    end
  end)
  
  window.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1) then
      dragging = true
      offset = Vector2.new(
        playerMouse.X - window.AbsolutePosition.X,
        playerMouse.Y - window.AbsolutePosition.Y
        )
    end
  end)
  
  window.InputEnded:Connect(function(input)
    if(input.UserInputType == Enum.UserInputType.MouseButton1) then
      dragging = false
    end
  end)
  
  userinput.InputBegan:Connect(function(input, processed)
    if processed then return end
    if (input.KeyCode == windowInfo.key) then
      window.Visible = not window.Visible
    end
    
  end)
end



return menu
