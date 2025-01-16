local VoidHub = {}

-- Function to create the main UI window
function VoidHub:CreateWindow(config)
    -- Remove any existing Void Hub instances
    for _, gui in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if gui.Name == "VoidHub" then
            gui:Destroy()
        end
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "VoidHub"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    -- UI Corner for Rounded Edges
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0.25, 0, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    -- Sidebar Corners
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 10)
    sidebarCorner.Parent = sidebar

    -- Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(0.75, 0, 1, 0)
    contentArea.Position = UDim2.new(0.25, 0, 0, 0)
    contentArea.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 10)
    contentCorner.Parent = contentArea

    -- Sidebar List Layout
    local uiList = Instance.new("UIListLayout")
    uiList.Parent = sidebar
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Padding = UDim.new(0, 5)

    local tabs = {}

    function tabs:CreateTab(tabName)
        -- Sidebar Button
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 18
        tabButton.Parent = sidebar

        -- Button Corners
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = tabButton

        -- Tab Content Frame
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.Visible = false
        tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabFrame.BorderSizePixel = 0
        tabFrame.Parent = contentArea

        local tabFrameCorner = Instance.new("UICorner")
        tabFrameCorner.CornerRadius = UDim.new(0, 10)
        tabFrameCorner.Parent = tabFrame

        tabButton.MouseButton1Click:Connect(function()
            for _, frame in ipairs(contentArea:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            tabFrame.Visible = true
        end)

        local elements = {}

        function elements:CreateToggle(toggleName, callback)
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0.9, 0, 0, 40)
            toggle.Position = UDim2.new(0.05, 0, 0, 0)
            toggle.Text = toggleName .. ": OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Font = Enum.Font.SourceSans
            toggle.TextSize = 18
            toggle.Parent = tabFrame

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 8)
            toggleCorner.Parent = toggle

            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = toggleName .. (state and ": ON" or ": OFF")
                callback(state)
            end)
        end

        return elements
    end

    -- Create "UI" Tab for Closing
    local uiTab = tabs:CreateTab("UI")
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.9, 0, 0, 40)
    closeButton.Position = UDim2.new(0.05, 0, 0.1, 0)
    closeButton.Text = "Close UI"
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.SourceSans
    closeButton.TextSize = 18
    closeButton.Parent = uiTab

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton

    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
        for k, v in pairs(getgenv()) do
            if type(v) == "boolean" then
                getgenv()[k] = false
            end
        end
    end)

    return tabs
end

return VoidHub
