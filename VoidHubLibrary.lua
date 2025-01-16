
--// Create UI Library
local VoidHubLib = {}

function VoidHubLib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TabsHolder = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local CloseButton = Instance.new("TextButton")
    
    ScreenGui.Name = "Void Hub"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.BorderSizePixel = 0
    
    TabsHolder.Name = "TabsHolder"
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabsHolder.Size = UDim2.new(0, 130, 1, 0)
    TabsHolder.BorderSizePixel = 0
    
    UIListLayout.Parent = TabsHolder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Text = "X"
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end)
    
    local self = {}
    self.MainFrame = MainFrame
    
    function self:CreateTab(Name)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabsHolder
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Text = Name
        TabButton.BorderSizePixel = 0
        return TabButton
    end
    
    function self:CreateSection(Parent, Title)
        local Section = Instance.new("Frame")
        local SectionTitle = Instance.new("TextLabel")
        
        Section.Parent = Parent
        Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Section.Size = UDim2.new(1, -140, 0, 60)
        Section.BorderSizePixel = 0
        
        SectionTitle.Parent = Section
        SectionTitle.Text = Title
        SectionTitle.Size = UDim2.new(1, 0, 0, 30)
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        return Section
    end
    
    function self:CreateToggle(Parent, Name, Callback)
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Parent = Parent
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ToggleButton.Size = UDim2.new(1, 0, 0, 40)
        ToggleButton.Text = Name .. " [OFF]"
        ToggleButton.BorderSizePixel = 0
        
        local toggled = false
        ToggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            ToggleButton.Text = Name .. (toggled and " [ON]" or " [OFF]")
            Callback(toggled)
        end)
        
        return ToggleButton
    end
    
    function self:CreateButton(Parent, Name, Callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Parent
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.Text = Name
        Button.BorderSizePixel = 0
        
        Button.MouseButton1Click:Connect(function()
            Callback()
        end)
        
        return Button
    end
    
    function self:CreateUIToggle()
        local UIToggleButton = self:CreateButton(MainFrame, "Toggle UI", function()
            ScreenGui.Enabled = not ScreenGui.Enabled
        end)
        return UIToggleButton
    end
    
    return self
end

return VoidHubLib
