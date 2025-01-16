local VoidHub = {}

function VoidHub:CreateWindow(config)
    local gui = Instance.new("ScreenGui")
    gui.Name = config.Name or "VoidHub"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0.25, 0, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(0.75, 0, 1, 0)
    contentArea.Position = UDim2.new(0.25, 0, 0, 0)
    contentArea.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame

    local uiList = Instance.new("UIListLayout")
    uiList.Parent = sidebar
    uiList.SortOrder = Enum.SortOrder.LayoutOrder

    local tabs = {}

    function tabs:CreateTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 18
        tabButton.Parent = sidebar

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.Visible = false
        tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabFrame.BorderSizePixel = 0
        tabFrame.Parent = contentArea

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

            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = toggleName .. (state and ": ON" or ": OFF")
                callback(state)
            end)
        end

        return elements
    end

    return tabs
end

return VoidHub
