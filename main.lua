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

local AntiLua = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ukrubojvo/Modules/main/AntiLua.lua"))()

if not AntiLua then
    print("[ANTILUA DEFENDER] Failed to load AntiLua library.")
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

AntiLua.Notify("⚠️ Warning! If you are using luarmor's script, we recommend that you do not use this script.", 10, Color3.fromRGB(255, 100, 100), "AntiLua Defender")

local start_time = tick()
local HttpService = game:GetService("HttpService")
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
            log_content = log_content .. string.format("[ANTILUA DEFENDER]\n", name)
            log_content = log_content .. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
            log_content = log_content .. "URL: " .. url .. "\n"
            log_content = log_content .. "Method: " .. method .. "\n\n"
            log_content = log_content .. "== Headers ==\n" .. format_table(headers) .. "\n"
            log_content = log_content .. "== Body ==\n" .. tostring(body) .. "\n\n"
    
            local log_filename = HttpService:GenerateGUID(false) .. ".log"
            writefile(log_filename, log_content)
    
            AntiLua.Notify(string.format("Blocked request to: %s\nFile Saved: %s", url, log_filename), 10, Color3.fromRGB(255, 100, 100), "Request Blocked")
    
            return {
                Success = false,
                StatusCode = 403,
                Body = "Request Blocked"
            }
        end)
    end)
end

local ui = AntiLua.CreateUI({
    title = "AntiLua Defender",
    button_text = "Real-time Protection",
    button_text_active = "Protected!",
    background_color = Color3.fromRGB(16, 16, 16),
    text_color = Color3.fromRGB(255, 255, 255),
    button_color = Color3.fromRGB(82, 82, 91),
    toggle_key = Enum.KeyCode.Insert,
    on_toggle = function(enabled)
        if enabled then
            make_defender("request", request)
            make_defender("http_request", http_request)
            make_defender("syn.request", syn and syn.request)
            make_defender("http.request", http and http.request)
            make_defender("krnl_request", krnl_request)
            make_defender("fluxus.request", fluxus and fluxus.request)
            AntiLua.Notify(((type(hookfunction) == "function") and "Protection Enabled!" or "Protection Failed"), 5, (type(hookfunction) == "function") and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(255, 100, 100), "AntiLua Defender")
        else
            AntiLua.Notify("Protection Disabled", 5, Color3.fromRGB(255, 100, 100), "AntiLua Defender")
        end
    end,
    custom_code = function()
        print("[ANTILUA DEFENDER] Protection logic started.")
    end
})

print("[ANTILUA DEFENDER] Loaded in "..tick() - start_time.."s!")

print("[REQUEST DEFENDER] Loaded in "..tick() - start_time.."s!")
