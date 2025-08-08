--[[
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '


			    Made by chae.r1n_1023
]]
-- ⚠️ Warning! If you are using luarmor's script, we recommend that you do not use this script.

local Fluent = loadstring(game:HttpGetAsync("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
Fluent:SetTheme("Darker")
local warn = function(...)
    warn(...)
    Fluent:Notify({
        Title = "Signal",
        Content = ...,
        SubContent = "streaming",
        Duration = 10
    })
end

if typeof(hookfunction) ~= "function" then
	warn(string.format("[REQUEST DEFENDER] %s executable is not supported.", identifyexecutor()))
    return
end

print([[

          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '


			                Made by chae.r1n_1023
]])

warn("⚠️ Warning! If you are using luarmor's script, we recommend that you do not use this script.")

local start_time = tick()
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local allowed_domains = {
    "sirius.menu",
    "luarmor.net",
}

local function get_host_from_url(url)
    local host = url:match("^https?://([^/]+)")
    return host or ""
end
            
local function is_allowed(url)
    local host = get_host_from_url(url)
    for _, domain in ipairs(allowed_domains) do
        if host == domain then
            return true
        end
        if host:sub(-#domain -1, -#domain -1) == "." and host:sub(-#domain) == domain then
            return true
        end
    end
    return false
end

local function format_table(tbl)
	local result = ""
	for k, v in pairs(tbl) do
		result = result .. string.format("%s: %s\n", tostring(k), tostring(v))
	end
	return result ~= "" and result or "None\n"
end

local function print_table(tbl, indent)
	indent = indent or 0
	local prefix = string.rep("  ", indent)

	if typeof(tbl) ~= "table" then
		print(prefix .. tostring(tbl))
		return
	end

	print(prefix .. "{")
	for k, v in pairs(tbl) do
		local key_str = "[" .. tostring(k) .. "]"

		if typeof(v) == "table" then
			print(prefix .. "  " .. key_str .. " = ")
			print_table(v, indent + 1)
		else
			print(prefix .. "  " .. key_str .. " = " .. tostring(v))
		end
	end
	print(prefix .. "}")
end

local function make_defender(name, target_func)
    if typeof(hookfunction) ~= "function" then return end
	if typeof(target_func) ~= "function" then return end

    pcall(function()
        hookfunction(target_func, function(args)
            local url = args and args.Url or "unknown"
            local method = args and args.Method or "unknown"
            local headers = args and args.Headers or {}
            local body = args and args.Body or "nil"

            if is_allowed(url) then
                return target_func(args)
            end
    
            local log_content = ""
            log_content = log_content .. string.format("[REQUEST DEFENDER]\n", name)
            log_content = log_content .. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
            log_content = log_content .. "URL: " .. url .. "\n"
            log_content = log_content .. "Method: " .. method .. "\n\n"
            log_content = log_content .. "== Headers ==\n" .. format_table(headers) .. "\n"
            log_content = log_content .. "== Body ==\n" .. tostring(body) .. "\n\n"
    
            local log_filename = HttpService:GenerateGUID(false) .. ".log"
            writefile(log_filename, log_content)
    
            warn(string.format("[REQUEST DEFENDER] Blocked request to: %s\nFile Saved: %s", url, log_filename))
    
            return {
                Success = false,
                StatusCode = 403,
                Body = "Request Blocked"
            }
        end)
    end)
end

local GUIParent = gethui and gethui() or game.CoreGui

local blocker_ui = GUIParent:FindFirstChild("RequestBlockerUI")
if blocker_ui then
	blocker_ui:Destroy()
end

local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = "RequestBlockerUI"
screen_gui.ResetOnSpawn = false
screen_gui.IgnoreGuiInset = true
screen_gui.Parent = GUIParent
screen_gui.DisplayOrder = 2147483647

local main_frame = Instance.new("Frame")
main_frame.Size = UDim2.new(0, 260, 0, 110)
main_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
main_frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
main_frame.BackgroundTransparency = 0.15
main_frame.BorderSizePixel = 0
main_frame.AnchorPoint = Vector2.new(0.5, 0.5)
main_frame.Draggable = true
main_frame.Active = true
main_frame.Parent = screen_gui

local corner = Instance.new("UICorner", main_frame)
corner.CornerRadius = UDim.new(0, 12)

local close_button = Instance.new("ImageButton")
close_button.Size = UDim2.new(0, 24, 0, 24)
close_button.Position = UDim2.new(1, -26, 0, 2)
close_button.BackgroundTransparency = 1
close_button.BorderSizePixel = 0
close_button.Image = "rbxassetid://82404346839314"
close_button.Parent = main_frame
close_button.ZIndex = 10

close_button.MouseButton1Click:Connect(function()
	screen_gui:Destroy()
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.BorderSizePixel = 0
title.Text = "Request Defender"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.ZIndex = 50
title.Parent = main_frame

local title_corner = Instance.new("UICorner", title)
title_corner.CornerRadius = UDim.new(0, 12)

local drag_btn = Instance.new("TextButton")
drag_btn.Size = UDim2.new(0.5, 0, 0, 10)
drag_btn.Position = UDim2.new(0.5, 0, 1.1, 0)
drag_btn.BackgroundTransparency = 1
drag_btn.BorderSizePixel = 0
drag_btn.AnchorPoint = Vector2.new(0.5, 0.5)
drag_btn.Text = ""
drag_btn.ZIndex = 999
drag_btn.Parent = main_frame

local drag_frame = Instance.new("Frame")
drag_frame.Size = UDim2.new(0.5, 0, 0, 4)
drag_frame.Position = UDim2.new(0.5, 0, 1.1, 0)
drag_frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
drag_frame.BackgroundTransparency = 0.5
drag_frame.BorderSizePixel = 0
drag_frame.AnchorPoint = Vector2.new(0.5, 0.5)
drag_frame.Parent = main_frame

local drag_corner = Instance.new("UICorner", drag_frame)
drag_corner.CornerRadius = UDim.new(0, 60)

local dragging = false
local drag_input, drag_start, start_pos
local tween_info = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
local drag_on = { BackgroundTransparency = 0 }
local drag_off = { BackgroundTransparency = 0.5 }

local function update_drag(input)
	local delta = input.Position - drag_start
	main_frame.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
end

drag_btn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local drag_starts = TweenService:Create(drag_frame, tween_info, drag_on)
        drag_starts:Play()
		dragging = true
		drag_start = input.Position
		start_pos = main_frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
                drag_starts:Cancel()
                local drag_stop = TweenService:Create(drag_frame, tween_info, drag_off)
                drag_stop:Play()
				dragging = false
			end
		end)
	end
end)

drag_btn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		drag_input = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == drag_input then
		update_drag(input)
	end
end)

local hook_button = Instance.new("TextButton")
hook_button.Size = UDim2.new(1, -30, 0, 40)
hook_button.Position = UDim2.new(0, 15, 0, 55)
hook_button.BackgroundColor3 = Color3.fromRGB(82, 82, 91)
hook_button.BackgroundTransparency = 0.5
hook_button.TextColor3 = Color3.new(1, 1, 1)
hook_button.Font = Enum.Font.GothamBold
hook_button.TextSize = 16
hook_button.Text = "Real-time Protection"
hook_button.AutoButtonColor = true
hook_button.BorderSizePixel = 0
hook_button.ZIndex = 2
hook_button.Parent = main_frame

local hook_corner = Instance.new("UICorner", hook_button)
hook_corner.CornerRadius = UDim.new(0, 8)

local hooked = false

hook_button.MouseButton1Click:Connect(function()
	if hooked then return end
	hooked = true

	make_defender("request", request)
	make_defender("http_request", http_request)
	make_defender("syn.request", syn and syn.request)
	make_defender("http.request", http and http.request)
	make_defender("krnl_request", krnl_request)
	make_defender("fluxus.request", fluxus and fluxus.request)
	print("[REQUEST DEFENDER] ".. ((type(hookfunction) == "function") and "Done!" or "Failed."))
	hook_button.Text = ((type(hookfunction) == "function") and "Protected!" or "Protect Failed")
	hook_button.AutoButtonColor = false
end)

print("[REQUEST DEFENDER] Loaded in "..tick() - start_time.."s!")
