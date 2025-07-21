if typeof(hookfunction) ~= "function" then
	warn("[REQUEST DEFENDER] This executable is not supported.")
end

print([[

                            ,--.
                           {    }
                           K,   }
                          /  ~Y`
                     ,   /   /
                    {_'-K.__/
                      `/-.__L._
                      /  ' /`\_}
                     /  ' /
             ____   /  ' /
      ,-'~~~~    ~~/  ' /_
    ,'             ``~~~  ',
   (                        Y
  {                         I
 {      -                    `,
 |       ',                   )
 |        |   ,..__      __. Y
 |    .,_./  Y ' / ^Y   J   )|
 \           |' /   |   |   ||
  \          L_/    . _ (_,.'(
   \,   ,      ^^""' / |      )
     \_  \          /,L]     /
       '-_~-,       ` `   ./`
          `'{_            )
              ^^\..___,.--`     
]])

local start_time = tick()
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local function format_table(tbl)
	local result = ""
	for k, v in pairs(tbl) do
		result = result .. string.format("%s: %s\n", tostring(k), tostring(v))
	end
	return result ~= "" and result or "None\n"
end

local function make_defender(name, target_func)
	if typeof(target_func) ~= "function" then return end

	hookfunction(target_func, function(args)
		local url = args and args.Url or "unknown"
		local method = args and args.Method or "unknown"
		local headers = args and args.Headers or {}
		local body = args and args.Body or "nil"

		local log_content = ""
		log_content = log_content .. string.format("[%s DEFENDER]\n", name)
		log_content = log_content .. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
		log_content = log_content .. "URL: " .. url .. "\n"
		log_content = log_content .. "Method: " .. method .. "\n\n"
		log_content = log_content .. "== Headers ==\n" .. format_table(headers) .. "\n"
		log_content = log_content .. "== Body ==\n" .. tostring(body) .. "\n\n"

		local log_filename = HttpService:GenerateGUID(false) .. ".txt"
		writefile(log_filename, log_content)

		warn(string.format("[REQUEST DEFENDER] Blocked request to: %s", url))

		return {
			Success = false,
			StatusCode = 403,
			Body = "Request Blocked"
		}
	end)
end

local player = Players.LocalPlayer
local player_gui = player:WaitForChild("PlayerGui")

local screen_gui = Instance.new("ScreenGui")
screen_gui.Name = "RequestBlockerUI"
screen_gui.ResetOnSpawn = false
screen_gui.IgnoreGuiInset = true
screen_gui.Parent = player_gui

local main_frame = Instance.new("Frame")
main_frame.Size = UDim2.new(0, 260, 0, 110)
main_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
main_frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main_frame.BorderSizePixel = 0
main_frame.AnchorPoint = Vector2.new(0.5, 0.5)
main_frame.Parent = screen_gui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(100, 100, 100)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = main_frame

local corner = Instance.new("UICorner", main_frame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.BorderSizePixel = 0
title.Text = "🛡️ Request Hooker"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Parent = main_frame

local title_corner = Instance.new("UICorner", title)
title_corner.CornerRadius = UDim.new(0, 12)

local dragging = false
local drag_input, drag_start, start_pos

local function update_drag(input)
	local delta = input.Position - drag_start
	main_frame.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X,
									start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		drag_start = input.Position
		start_pos = main_frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
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
hook_button.BackgroundColor3 = Color3.fromRGB(55, 100, 200)
hook_button.TextColor3 = Color3.new(1, 1, 1)
hook_button.Font = Enum.Font.GothamBold
hook_button.TextSize = 16
hook_button.Text = "Hook Request"
hook_button.AutoButtonColor = true
hook_button.BorderSizePixel = 0
hook_button.ZIndex = 2
hook_button.Parent = main_frame

local hook_corner = Instance.new("UICorner", hook_button)
hook_corner.CornerRadius = UDim.new(0, 8)

local original_request = request
local vr = 0
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
	print("[REQUEST DEFENDER] Done!")
	hook_button.Text = "✅ Hooked"
	hook_button.BackgroundColor3 = Color3.fromRGB(30, 150, 80)
	hook_button.AutoButtonColor = false
end)

print("[REQUEST DEFENDER] Loaded in "..tick() - start_time.."s!")
