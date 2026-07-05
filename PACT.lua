local ADDON_NAME = ...

local PACT = CreateFrame("Frame", "PACTEventFrame")

local LOCALES = {
    enUS = {
        ADDON_NAME = "PACT",
        ADDON_LONG_NAME = "Pull And Check Tools",
        LOADED = "loaded. Use /pact to open options.",
        HELP = "commands: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini panel locked.",
        UNLOCKED = "Mini panel unlocked.",
        RESET_POSITION = "Position reset.",
        READY = "Ready Check",
        PULL = "Pull",
        ROLE = "Role Check",
        BREAK = "Break",
        CANCEL = "Cancel",
        NO_PERMISSION = "Requires leader or assistant.",
        DRAG_HANDLE = "Drag to move",
        OPTIONS_TITLE = "PACT",
        OPTIONS_DESC = "Pull And Check Tools for compact raid controls.",
        HIDE_RAID_MANAGER = "Hide Blizzard Raid Manager",
        HIDE_RAID_MANAGER_TIP = "Hides the Blizzard raid manager panel during this session.",
        SHOW_PANEL = "Show mini panel while solo",
        SHOW_PANEL_TIP = "Shows the mini panel while you are solo, so you can position and configure it.",
        LOCK_PANEL = "Lock mini panel",
        LOCK_PANEL_TIP = "Prevents moving the mini panel.",
        SHOW_CANCEL = "Show Cancel button",
        SHOW_CANCEL_TIP = "Adds a compact button that cancels the active countdown.",
        PULL_SECONDS = "Pull time",
        BREAK_MINUTES = "Break time",
        SECONDS = "seconds",
        MINUTES = "minutes",
        RESET_POS_BUTTON = "Reset position",
        RESET_DEFAULTS_BUTTON = "Restore defaults",
        READY_TIP = "Starts a ready check.",
        PULL_TIP = "Starts a %d second countdown.",
        TIME_LABEL = "Time: %s",
        ROLE_TIP = "Starts a role check.",
        BREAK_TIP = "Sends the configured break command.",
        CANCEL_TIP = "Cancels the active countdown.",
        READY_UNAVAILABLE = "Ready check is not available in this game version.",
        PULL_UNAVAILABLE = "Countdown is not available in this game version.",
        ROLE_UNAVAILABLE = "Role check is not available in this game version.",
        BREAK_UNAVAILABLE = "Break countdown is not available in this game version.",
        BREAK_PREVIEW = "Break sends: %s",
    },
    ptBR = {
        ADDON_NAME = "PACT",
        ADDON_LONG_NAME = "Ferramentas de Pull e Checks",
        LOADED = "carregado. Use /pact para abrir as opcoes.",
        HELP = "comandos: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini painel travado.",
        UNLOCKED = "Mini painel destravado.",
        RESET_POSITION = "Posicao resetada.",
        READY = "Ready Check",
        PULL = "Pull",
        ROLE = "Role Check",
        BREAK = "Break",
        CANCEL = "Cancel",
        NO_PERMISSION = "Requer lider ou assistente.",
        DRAG_HANDLE = "Arraste para mover",
        OPTIONS_TITLE = "PACT",
        OPTIONS_DESC = "Ferramentas de Pull e Checks para controles compactos de raid.",
        HIDE_RAID_MANAGER = "Esconder Raid Manager da Blizzard",
        HIDE_RAID_MANAGER_TIP = "Esconde o painel lateral de gerenciamento de raid durante esta sessao.",
        SHOW_PANEL = "Exibir mini painel fora de grupo/raid",
        SHOW_PANEL_TIP = "Mostra o mini painel enquanto voce esta solo, para posicionar e configurar.",
        LOCK_PANEL = "Travar mini painel",
        LOCK_PANEL_TIP = "Impede mover o mini painel.",
        SHOW_CANCEL = "Mostrar botao Cancel",
        SHOW_CANCEL_TIP = "Adiciona um botao compacto que cancela a contagem ativa.",
        PULL_SECONDS = "Tempo do pull",
        BREAK_MINUTES = "Tempo do break",
        SECONDS = "segundos",
        MINUTES = "minutos",
        RESET_POS_BUTTON = "Resetar posicao",
        RESET_DEFAULTS_BUTTON = "Restaurar padroes",
        READY_TIP = "Inicia um ready check.",
        PULL_TIP = "Inicia uma contagem de %d segundos.",
        TIME_LABEL = "Tempo: %s",
        ROLE_TIP = "Inicia um role check.",
        BREAK_TIP = "Envia o comando de break configurado.",
        CANCEL_TIP = "Cancela a contagem ativa.",
        READY_UNAVAILABLE = "Ready check nao esta disponivel nesta versao do jogo.",
        PULL_UNAVAILABLE = "Countdown nao esta disponivel nesta versao do jogo.",
        ROLE_UNAVAILABLE = "Role check nao esta disponivel nesta versao do jogo.",
        BREAK_UNAVAILABLE = "Countdown de break nao esta disponivel nesta versao do jogo.",
        BREAK_PREVIEW = "Break envia: %s",
    },
}

local L = LOCALES[GetLocale and GetLocale() or "enUS"] or LOCALES.enUS

local DEFAULT_DB = {
    version = 1,
    showPanel = true,
    locked = false,
    hideRaidManager = false,
    showCancelButton = false,
    pullSeconds = 10,
    breakMinutes = 5,
    breakCommand = "/pull {seconds} break",
    position = {
        point = "CENTER",
        relativePoint = "CENTER",
        x = 0,
        y = 120,
    },
}

local BUTTON_SIZE = 24
local GAP = 3
local PAD = 4
local HANDLE_WIDTH = 8

local db
local panel
local handle
local optionsPanel
local standaloneWindow
local settingsCategory
local pendingLayoutUpdate
local pendingRaidManagerUpdate

local buttons = {}
local buttonOrder = { "ready", "pull", "role", "break", "cancel" }

local hiddenParent = CreateFrame("Frame", nil, UIParent)
hiddenParent:Hide()

local raidManagerState = {}
local raidManagerToggleState = {}
local raidManagerHooked
local raidManagerUpdateHooked

local function CopyDefaults(source)
    local copy = {}
    for key, value in pairs(source) do
        if type(value) == "table" then
            copy[key] = CopyDefaults(value)
        else
            copy[key] = value
        end
    end
    return copy
end

local function MergeDefaults(target, defaults)
    for key, value in pairs(defaults) do
        if type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = CopyDefaults(value)
            else
                MergeDefaults(target[key], value)
            end
        elseif type(target[key]) ~= type(value) then
            target[key] = value
        end
    end
end

local function ClampInt(value, minimum, maximum, fallback)
    value = tonumber(value)
    if not value then
        value = fallback
    end
    value = math.floor(value + 0.5)
    if value < minimum then
        value = minimum
    elseif value > maximum then
        value = maximum
    end
    return value
end

local function EnsureDb()
    if type(PACTDB) ~= "table" then
        PACTDB = CopyDefaults(DEFAULT_DB)
    else
        MergeDefaults(PACTDB, DEFAULT_DB)
    end

    db = PACTDB
    db.pullSeconds = ClampInt(db.pullSeconds, 1, 3600, DEFAULT_DB.pullSeconds)
    db.breakMinutes = ClampInt(db.breakMinutes, 1, 1440, DEFAULT_DB.breakMinutes)

    if type(db.breakCommand) ~= "string" or db.breakCommand == "" then
        db.breakCommand = DEFAULT_DB.breakCommand
    end

    if type(db.position) ~= "table" then
        db.position = CopyDefaults(DEFAULT_DB.position)
    end
    db.position.point = db.position.point or DEFAULT_DB.position.point
    db.position.relativePoint = db.position.relativePoint or DEFAULT_DB.position.relativePoint
    db.position.x = tonumber(db.position.x) or DEFAULT_DB.position.x
    db.position.y = tonumber(db.position.y) or DEFAULT_DB.position.y

    return db
end

local function Print(message)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PACT:|r " .. tostring(message))
    else
        print("PACT: " .. tostring(message))
    end
end

local function InCombat()
    return InCombatLockdown and InCombatLockdown()
end

local function IsGrouped()
    if IsInRaid and IsInRaid() then
        return true
    end
    if IsInGroup and IsInGroup() then
        return true
    end
    if GetNumGroupMembers and GetNumGroupMembers() > 0 then
        return true
    end
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        return true
    end
    if GetNumPartyMembers and GetNumPartyMembers() > 0 then
        return true
    end
    return false
end

local function HasPermission()
    if not IsGrouped() then
        return true
    end
    if UnitIsGroupLeader and UnitIsGroupLeader("player") then
        return true
    end
    if UnitIsGroupAssistant and UnitIsGroupAssistant("player") then
        return true
    end
    if IsRaidLeader and IsRaidLeader() then
        return true
    end
    if IsRaidOfficer and IsRaidOfficer() then
        return true
    end
    return false
end

local function IsAvailable()
    if IsGrouped() then
        return HasPermission()
    end
    return db.showPanel
end

local function SavePosition()
    if not panel or not db then
        return
    end

    local point, _, relativePoint, x, y = panel:GetPoint(1)
    db.position.point = point or DEFAULT_DB.position.point
    db.position.relativePoint = relativePoint or DEFAULT_DB.position.relativePoint
    db.position.x = x or DEFAULT_DB.position.x
    db.position.y = y or DEFAULT_DB.position.y
end

local function LoadPosition()
    if not panel or not db then
        return
    end

    panel:ClearAllPoints()
    panel:SetPoint(db.position.point, UIParent, db.position.relativePoint, db.position.x, db.position.y)
end

local function FormatDuration(seconds)
    seconds = tonumber(seconds) or 0
    if seconds >= 60 and seconds % 60 == 0 then
        return tostring(seconds / 60) .. " min"
    end
    return tostring(seconds) .. " s"
end

local function SanitizeMacro(text)
    text = tostring(text or "")
    text = text:gsub("[\r\n]", " ")
    text = text:match("^%s*(.-)%s*$") or ""
    if text == "" then
        text = DEFAULT_DB.breakCommand
    end
    if text:sub(1, 1) ~= "/" then
        text = "/" .. text
    end
    return text
end

local function ExpandBreakCommand()
    local seconds = db.breakMinutes * 60
    local text = SanitizeMacro(db.breakCommand)
    text = text:gsub("{seconds}", tostring(seconds))
    text = text:gsub("{minutes}", tostring(db.breakMinutes))
    text = text:gsub("{pull}", tostring(db.pullSeconds))
    return text
end

local function ApplyBackdrop(frame, bgR, bgG, bgB, bgA, borderR, borderG, borderB, borderA)
    if not frame.SetBackdrop then
        return
    end

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 8,
        edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    frame:SetBackdropColor(bgR or 0, bgG or 0, bgB or 0, bgA or 0.75)
    frame:SetBackdropBorderColor(borderR or 0.45, borderG or 0.45, borderB or 0.45, borderA or 1)
end

local function ShowButtonTooltip(button, key)
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT")

    if key == "ready" then
        GameTooltip:SetText(L.READY)
        GameTooltip:AddLine(L.READY_TIP, 1, 1, 1, true)
    elseif key == "pull" then
        GameTooltip:SetText(L.PULL)
        GameTooltip:AddLine(L.PULL_TIP:format(db.pullSeconds), 1, 1, 1, true)
        GameTooltip:AddLine(L.TIME_LABEL:format(FormatDuration(db.pullSeconds)), 0.8, 0.8, 0.8, true)
    elseif key == "role" then
        GameTooltip:SetText(L.ROLE)
        GameTooltip:AddLine(L.ROLE_TIP, 1, 1, 1, true)
    elseif key == "break" then
        GameTooltip:SetText(L.BREAK)
        GameTooltip:AddLine(L.BREAK_TIP, 1, 1, 1, true)
        GameTooltip:AddLine(L.TIME_LABEL:format(FormatDuration(db.breakMinutes * 60)), 0.8, 0.8, 0.8, true)
        GameTooltip:AddLine(ExpandBreakCommand(), 0.6, 0.9, 1, true)
    elseif key == "cancel" then
        GameTooltip:SetText(L.CANCEL)
        GameTooltip:AddLine(L.CANCEL_TIP, 1, 1, 1, true)
    elseif key == "handle" then
        GameTooltip:SetText(L.DRAG_HANDLE)
        GameTooltip:AddLine(db.locked and L.LOCKED or L.UNLOCKED, 1, 1, 1, true)
    end

    if IsGrouped() and not HasPermission() then
        GameTooltip:AddLine(L.NO_PERMISSION, 1, 0.35, 0.35, true)
    end

    GameTooltip:Show()
end

local function CreateFrameWithBackdrop(frameType, name, parent, template)
    local templateText = template and (template .. ",BackdropTemplate") or "BackdropTemplate"
    local ok, frame = pcall(CreateFrame, frameType, name, parent, templateText)
    if ok and frame then
        return frame
    end
    return CreateFrame(frameType, name, parent, template)
end

local function CreateIconButton(key, iconPath, secureMacro)
    local button = CreateFrameWithBackdrop(
        "Button",
        "PACT" .. key:gsub("^%l", string.upper) .. "Button",
        panel,
        secureMacro and "SecureActionButtonTemplate" or nil
    )

    button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    button:RegisterForClicks("LeftButtonUp")
    button.key = key

    ApplyBackdrop(button, 0.05, 0.05, 0.05, 0.92, 0.35, 0.35, 0.35, 1)

    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", 4, -4)
    button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -4, 4)
    button.icon:SetTexture(iconPath)
    button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    button.disabledOverlay = button:CreateTexture(nil, "OVERLAY")
    button.disabledOverlay:SetAllPoints(button.icon)
    button.disabledOverlay:SetColorTexture(0, 0, 0, 0.58)
    button.disabledOverlay:Hide()

    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    button:SetScript("OnEnter", function(self)
        ShowButtonTooltip(self, self.key)
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    button:SetScript("OnMouseDown", function(self)
        if not self:IsEnabled() then
            return
        end
        self.icon:ClearAllPoints()
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3, 3)
    end)
    button:SetScript("OnMouseUp", function(self)
        self.icon:ClearAllPoints()
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -4, 4)
    end)
    button:SetScript("OnEnable", function(self)
        self.icon:SetVertexColor(1, 1, 1)
        self.disabledOverlay:Hide()
    end)
    button:SetScript("OnDisable", function(self)
        self.icon:SetVertexColor(0.45, 0.45, 0.45)
        self.disabledOverlay:Show()
    end)

    if secureMacro then
        button:SetAttribute("type1", "macro")
    end

    buttons[key] = button
    return button
end

local function RunReadyCheck()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local fn = DoReadyCheck
    if not fn and C_PartyInfo then
        fn = C_PartyInfo.DoReadyCheck
    end

    if fn then
        fn()
    else
        Print(L.READY_UNAVAILABLE)
    end
end

local function RunRoleCheck()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local fn = InitiateRolePoll
    if not fn and C_PartyInfo then
        fn = C_PartyInfo.InitiateRolePoll
    end

    if fn then
        fn()
    else
        Print(L.ROLE_UNAVAILABLE)
    end
end

local function RunPullCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local seconds = db.pullSeconds

    if C_PartyInfo and C_PartyInfo.DoCountdown then
        C_PartyInfo.DoCountdown(seconds)
    elseif SlashCmdList and SlashCmdList.COUNTDOWN then
        SlashCmdList.COUNTDOWN(tostring(seconds))
    elseif SlashCmdList and SlashCmdList.PULL then
        SlashCmdList.PULL(tostring(seconds))
    elseif RunMacroText then
        RunMacroText("/pull " .. tostring(seconds))
    else
        Print(L.PULL_UNAVAILABLE)
    end
end

local function RunBreakCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local command = ExpandBreakCommand()
    local pullArgs = command:match("^/pull%s+(.+)$")

    if pullArgs and SlashCmdList and SlashCmdList.PULL then
        SlashCmdList.PULL(pullArgs)
    elseif RunMacroText then
        RunMacroText(command)
    elseif C_PartyInfo and C_PartyInfo.DoCountdown then
        C_PartyInfo.DoCountdown(db.breakMinutes * 60)
    else
        Print(L.BREAK_UNAVAILABLE)
    end
end

local function RunCancelCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    if C_PartyInfo and C_PartyInfo.DoCountdown then
        C_PartyInfo.DoCountdown(0)
    elseif SlashCmdList and SlashCmdList.COUNTDOWN then
        SlashCmdList.COUNTDOWN("0")
    elseif SlashCmdList and SlashCmdList.PULL then
        SlashCmdList.PULL("0")
    elseif RunMacroText then
        RunMacroText("/pull 0")
    else
        Print(L.PULL_UNAVAILABLE)
    end
end

local function UpdateLockState()
    if not panel or not handle then
        return
    end

    panel:SetMovable(not db.locked)
    handle:EnableMouse(not db.locked)
    handle:SetAlpha(db.locked and 0.35 or 1)
end

local function UpdatePanelState()
    if not panel then
        return
    end

    if InCombat() then
        pendingLayoutUpdate = true
        return
    end

    local available = IsAvailable()
    local enabled = available and HasPermission()

    panel:SetShown(available)
    for _, button in pairs(buttons) do
        button:SetEnabled(enabled)
    end
end

local function LayoutPanel()
    if not panel then
        return
    end

    if InCombat() then
        pendingLayoutUpdate = true
        return
    end

    pendingLayoutUpdate = nil

    local visibleCount = db.showCancelButton and 5 or 4
    local width = PAD + HANDLE_WIDTH + GAP + visibleCount * BUTTON_SIZE + (visibleCount - 1) * GAP + PAD
    local height = BUTTON_SIZE + PAD * 2

    panel:SetSize(width, height)
    handle:SetSize(HANDLE_WIDTH, BUTTON_SIZE)
    handle:ClearAllPoints()
    handle:SetPoint("TOPLEFT", panel, "TOPLEFT", PAD, -PAD)

    local x = PAD + HANDLE_WIDTH + GAP
    for _, key in ipairs(buttonOrder) do
        local button = buttons[key]
        local showButton = key ~= "cancel" or db.showCancelButton
        button:SetShown(showButton)
        if showButton then
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", panel, "TOPLEFT", x, -PAD)
            x = x + BUTTON_SIZE + GAP
        end
    end

    UpdateLockState()
    UpdatePanelState()
end

local function CreateHandleDot(parent, x, y)
    local dot = parent:CreateTexture(nil, "ARTWORK")
    dot:SetSize(2, 2)
    dot:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    dot:SetColorTexture(0.95, 0.82, 0.35, 0.85)
    return dot
end

local function CreatePanel()
    if panel then
        return
    end

    panel = CreateFrameWithBackdrop("Frame", "PACTFrame", UIParent)
    panel:SetFrameStrata("MEDIUM")
    panel:SetClampedToScreen(true)
    panel:EnableMouse(true)
    ApplyBackdrop(panel, 0.02, 0.02, 0.02, 0.72, 0.58, 0.45, 0.22, 0.95)

    handle = CreateFrame("Frame", nil, panel)
    handle:EnableMouse(true)
    handle:RegisterForDrag("LeftButton")
    handle:SetScript("OnDragStart", function()
        if db.locked then
            return
        end
        panel:StartMoving()
        panel:SetUserPlaced(false)
    end)
    handle:SetScript("OnDragStop", function()
        panel:StopMovingOrSizing()
        SavePosition()
    end)
    handle:SetScript("OnEnter", function(self)
        ShowButtonTooltip(self, "handle")
    end)
    handle:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    for y = -5, -17, -6 do
        CreateHandleDot(handle, 1, y)
        CreateHandleDot(handle, 5, y)
    end

    CreateIconButton("ready", "Interface\\RaidFrame\\ReadyCheck-Ready", false)
    CreateIconButton("pull", "Interface\\Icons\\Ability_Warrior_Charge", false)
    CreateIconButton("role", "Interface\\Icons\\Ability_Warrior_DefensiveStance", false)
    CreateIconButton("break", "Interface\\Icons\\INV_Misc_PocketWatch_01", false)
    CreateIconButton("cancel", "Interface\\RaidFrame\\ReadyCheck-NotReady", false)

    buttons.ready:SetScript("OnClick", RunReadyCheck)
    buttons.pull:SetScript("OnClick", RunPullCountdown)
    buttons.role:SetScript("OnClick", RunRoleCheck)
    buttons["break"]:SetScript("OnClick", RunBreakCountdown)
    buttons.cancel:SetScript("OnClick", RunCancelCountdown)

    LoadPosition()
    LayoutPanel()
end

local function SaveFrameState(frame, state)
    if not frame or state.saved then
        return
    end

    state.parent = frame:GetParent()
    state.shown = frame:IsShown()
    state.points = {}

    for i = 1, frame:GetNumPoints() do
        local point, relativeTo, relativePoint, x, y = frame:GetPoint(i)
        state.points[i] = { point, relativeTo, relativePoint, x, y }
    end

    state.saved = true
end

local function RestoreFrameState(frame, state)
    if not frame or not state.saved then
        return
    end

    frame:SetParent(state.parent or UIParent)
    frame:ClearAllPoints()

    if state.points and #state.points > 0 then
        for _, point in ipairs(state.points) do
            frame:SetPoint(point[1], point[2] or UIParent, point[3], point[4], point[5])
        end
    end

    if state.shown then
        frame:Show()
    else
        frame:Hide()
    end
end

local function HideBlizzardFrame(frame, state)
    if not frame then
        return
    end

    SaveFrameState(frame, state)
    frame:SetParent(hiddenParent)
    frame:Hide()
end

local function HookRaidManager()
    local manager = _G.CompactRaidFrameManager
    local toggle = _G.CompactRaidFrameManagerDisplayFrameHiddenModeToggle

    if manager and not manager.PACTHooked then
        manager:HookScript("OnShow", function(self)
            if db and db.hideRaidManager then
                if InCombat() then
                    pendingRaidManagerUpdate = true
                    return
                end
                self:SetParent(hiddenParent)
                self:Hide()
            end
        end)
        manager.PACTHooked = true
    end

    if toggle and not toggle.PACTHooked then
        toggle:HookScript("OnShow", function(self)
            if db and db.hideRaidManager then
                if InCombat() then
                    pendingRaidManagerUpdate = true
                    return
                end
                self:SetParent(hiddenParent)
                self:Hide()
            end
        end)
        toggle.PACTHooked = true
    end

    if not raidManagerUpdateHooked and type(CompactRaidFrameManager_UpdateOptionsFlowContainer) == "function" then
        hooksecurefunc("CompactRaidFrameManager_UpdateOptionsFlowContainer", function()
            if db and db.hideRaidManager and C_Timer then
                C_Timer.After(0, function()
                    PACT:ApplyRaidManagerVisibility()
                end)
            end
        end)
        raidManagerUpdateHooked = true
    end

    raidManagerHooked = true
end

function PACT:ApplyRaidManagerVisibility()
    if not db then
        return
    end

    if InCombat() then
        pendingRaidManagerUpdate = true
        return
    end

    pendingRaidManagerUpdate = nil
    HookRaidManager()

    local manager = _G.CompactRaidFrameManager
    local toggle = _G.CompactRaidFrameManagerDisplayFrameHiddenModeToggle

    if db.hideRaidManager then
        HideBlizzardFrame(manager, raidManagerState)
        HideBlizzardFrame(toggle, raidManagerToggleState)
    else
        RestoreFrameState(manager, raidManagerState)
        RestoreFrameState(toggle, raidManagerToggleState)
    end
end

local function CreateText(parent, text, template)
    local label = parent:CreateFontString(nil, "ARTWORK", template or "GameFontHighlight")
    label:SetText(text)
    label:SetJustifyH("LEFT")
    return label
end

local function CreateButton(parent, text, width)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(width or 140, 24)
    button:SetText(text)
    return button
end

local optionCheckIndex = 0

local function CreateCheckbox(parent, text, tooltip, onClick)
    optionCheckIndex = optionCheckIndex + 1
    local check = CreateFrame("CheckButton", "PACTOptionCheck" .. optionCheckIndex, parent, "InterfaceOptionsCheckButtonTemplate")
    local label = check.Text or _G[check:GetName() .. "Text"]
    if label then
        label:SetText(text)
    end
    check.tooltipText = tooltip
    check:SetScript("OnClick", function(self)
        onClick(self:GetChecked() and true or false)
    end)
    return check
end

local function CreateNumberStepper(parent, width, minimum, maximum, step, onValueChanged)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetSize(width, 24)
    frame.minimum = minimum
    frame.maximum = maximum
    frame.step = step

    local minus = CreateButton(frame, "-", 24)
    minus:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.minus = minus

    local plus = CreateButton(frame, "+", 24)
    plus:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    frame.plus = plus

    local valueBox = CreateFrameWithBackdrop("Frame", nil, frame)
    valueBox:SetPoint("LEFT", minus, "RIGHT", 4, 0)
    valueBox:SetPoint("RIGHT", plus, "LEFT", -4, 0)
    valueBox:SetHeight(22)
    ApplyBackdrop(valueBox, 0.02, 0.02, 0.02, 0.85, 0.55, 0.55, 0.55, 1)
    frame.valueBox = valueBox

    local valueText = CreateText(valueBox, "", "GameFontHighlight")
    valueText:SetPoint("CENTER", valueBox, "CENTER", 0, 0)
    valueText:SetJustifyH("CENTER")
    frame.valueText = valueText

    function frame:SetValue(value)
        value = ClampInt(value, self.minimum, self.maximum, self.minimum)
        self.value = value
        self.valueText:SetText(tostring(value))
    end

    function frame:Change(delta)
        self:SetValue((self.value or self.minimum) + delta)
        onValueChanged(self.value)
    end

    minus:SetScript("OnClick", function()
        frame:Change(-frame.step)
    end)
    plus:SetScript("OnClick", function()
        frame:Change(frame.step)
    end)

    frame:EnableMouse(true)
    frame:EnableMouseWheel(true)
    frame:SetScript("OnMouseWheel", function(self, delta)
        self:Change(delta > 0 and self.step or -self.step)
    end)

    return frame
end

local function RefreshOptions()
    if not optionsPanel or not db then
        return
    end

    optionsPanel.hideRaidManagerCheck:SetChecked(db.hideRaidManager)
    optionsPanel.showPanelCheck:SetChecked(db.showPanel)
    optionsPanel.lockCheck:SetChecked(db.locked)
    optionsPanel.showCancelCheck:SetChecked(db.showCancelButton)

    optionsPanel.pullSecondsStepper:SetValue(db.pullSeconds)
    optionsPanel.breakMinutesStepper:SetValue(db.breakMinutes)
    optionsPanel.breakPreview:SetText(L.BREAK_PREVIEW:format(ExpandBreakCommand()))
end

local function SetPullSeconds(value)
    db.pullSeconds = ClampInt(value, 1, 3600, DEFAULT_DB.pullSeconds)
    RefreshOptions()
end

local function SetBreakMinutes(value)
    db.breakMinutes = ClampInt(value, 1, 1440, DEFAULT_DB.breakMinutes)
    RefreshOptions()
end

local function ResetPosition()
    db.position = CopyDefaults(DEFAULT_DB.position)
    LoadPosition()
    Print(L.RESET_POSITION)
end

local function ResetDefaults()
    local oldPosition = CopyDefaults(db.position)
    PACTDB = CopyDefaults(DEFAULT_DB)
    PACTDB.position = oldPosition
    db = PACTDB

    LayoutPanel()
    PACT:ApplyRaidManagerVisibility()
    RefreshOptions()
end

local function CreateOptionsPanel()
    if optionsPanel then
        return optionsPanel
    end

    local panelFrame = CreateFrame("Frame", "PACTOptionsPanel", UIParent)
    panelFrame.name = L.ADDON_NAME
    panelFrame:SetSize(620, 360)

    local title = CreateText(panelFrame, L.OPTIONS_TITLE, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -16)

    local desc = CreateText(panelFrame, L.OPTIONS_DESC, "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)

    panelFrame.hideRaidManagerCheck = CreateCheckbox(panelFrame, L.HIDE_RAID_MANAGER, L.HIDE_RAID_MANAGER_TIP, function(value)
        db.hideRaidManager = value
        PACT:ApplyRaidManagerVisibility()
        RefreshOptions()
    end)
    panelFrame.hideRaidManagerCheck:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -64)

    panelFrame.showPanelCheck = CreateCheckbox(panelFrame, L.SHOW_PANEL, L.SHOW_PANEL_TIP, function(value)
        db.showPanel = value
        UpdatePanelState()
        RefreshOptions()
    end)
    panelFrame.showPanelCheck:SetPoint("TOPLEFT", panelFrame.hideRaidManagerCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.lockCheck = CreateCheckbox(panelFrame, L.LOCK_PANEL, L.LOCK_PANEL_TIP, function(value)
        db.locked = value
        UpdateLockState()
        RefreshOptions()
    end)
    panelFrame.lockCheck:SetPoint("TOPLEFT", panelFrame.showPanelCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.showCancelCheck = CreateCheckbox(panelFrame, L.SHOW_CANCEL, L.SHOW_CANCEL_TIP, function(value)
        db.showCancelButton = value
        LayoutPanel()
        RefreshOptions()
    end)
    panelFrame.showCancelCheck:SetPoint("TOPLEFT", panelFrame.lockCheck, "BOTTOMLEFT", 0, -8)

    local pullLabel = CreateText(panelFrame, L.PULL_SECONDS .. " (" .. L.SECONDS .. ")", "GameFontNormal")
    pullLabel:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 330, -64)

    panelFrame.pullSecondsStepper = CreateNumberStepper(panelFrame, 118, 1, 3600, 1, SetPullSeconds)
    panelFrame.pullSecondsStepper:SetPoint("TOPLEFT", pullLabel, "BOTTOMLEFT", 4, -6)

    local breakLabel = CreateText(panelFrame, L.BREAK_MINUTES .. " (" .. L.MINUTES .. ")", "GameFontNormal")
    breakLabel:SetPoint("TOPLEFT", panelFrame.pullSecondsStepper, "BOTTOMLEFT", -4, -24)

    panelFrame.breakMinutesStepper = CreateNumberStepper(panelFrame, 118, 1, 1440, 1, SetBreakMinutes)
    panelFrame.breakMinutesStepper:SetPoint("TOPLEFT", breakLabel, "BOTTOMLEFT", 4, -6)

    panelFrame.breakPreview = CreateText(panelFrame, "", "GameFontHighlightSmall")
    panelFrame.breakPreview:SetPoint("TOPLEFT", panelFrame.breakMinutesStepper, "BOTTOMLEFT", -4, -14)

    local resetPositionButton = CreateButton(panelFrame, L.RESET_POS_BUTTON, 130)
    resetPositionButton:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -318)
    resetPositionButton:SetScript("OnClick", function()
        ResetPosition()
        RefreshOptions()
    end)

    local resetDefaultsButton = CreateButton(panelFrame, L.RESET_DEFAULTS_BUTTON, 140)
    resetDefaultsButton:SetPoint("LEFT", resetPositionButton, "RIGHT", 8, 0)
    resetDefaultsButton:SetScript("OnClick", ResetDefaults)

    optionsPanel = panelFrame
    RefreshOptions()
    return optionsPanel
end

local function RegisterInterfaceOptions()
    local panelFrame = CreateOptionsPanel()

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        settingsCategory = Settings.RegisterCanvasLayoutCategory(panelFrame, panelFrame.name)
        Settings.RegisterAddOnCategory(settingsCategory)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panelFrame)
    end
end

local function DetachOptionsPanel()
    if not optionsPanel then
        return
    end

    optionsPanel:SetParent(UIParent)
    optionsPanel:ClearAllPoints()
    optionsPanel:Hide()
end

function PACT:OpenInterfaceOptions()
    CreateOptionsPanel()
    if standaloneWindow and standaloneWindow:IsShown() then
        standaloneWindow:Hide()
    elseif standaloneWindow and optionsPanel:GetParent() == standaloneWindow.content then
        DetachOptionsPanel()
    end
    RefreshOptions()

    if Settings and Settings.OpenToCategory and settingsCategory then
        local id = settingsCategory.GetID and settingsCategory:GetID() or settingsCategory.ID or settingsCategory
        Settings.OpenToCategory(id)
    elseif InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
    end
end

local function CreateStandaloneWindow()
    if standaloneWindow then
        return standaloneWindow
    end

    local ok, window = pcall(CreateFrame, "Frame", "PACTConfigWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not window then
        window = CreateFrame("Frame", "PACTConfigWindow", UIParent)
        ApplyBackdrop(window, 0.02, 0.02, 0.02, 0.94, 0.55, 0.55, 0.55, 1)
    end

    window:SetSize(660, 430)
    window:SetPoint("CENTER")
    window:SetFrameStrata("FULLSCREEN_DIALOG")
    window:SetToplevel(true)
    window:EnableMouse(true)
    window:SetMovable(true)
    window:RegisterForDrag("LeftButton")
    window:SetScript("OnDragStart", window.StartMoving)
    window:SetScript("OnDragStop", window.StopMovingOrSizing)
    window:SetScript("OnHide", function()
        if optionsPanel and optionsPanel:GetParent() == window.content then
            DetachOptionsPanel()
        end
    end)
    window:Hide()

    if UISpecialFrames then
        table.insert(UISpecialFrames, "PACTConfigWindow")
    end

    local title = CreateText(window, L.OPTIONS_TITLE, "GameFontHighlight")
    title:SetPoint("TOP", window, "TOP", 0, -6)

    local content = CreateFrame("Frame", nil, window)
    content:SetPoint("TOPLEFT", window, "TOPLEFT", 16, -34)
    content:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -16, 16)
    window.content = content

    standaloneWindow = window
    return standaloneWindow
end

function PACT:OpenStandaloneOptions()
    local window = CreateStandaloneWindow()
    local panelFrame = CreateOptionsPanel()

    panelFrame:SetParent(window.content)
    panelFrame:ClearAllPoints()
    panelFrame:SetPoint("TOPLEFT", window.content, "TOPLEFT", 0, 0)
    panelFrame:SetSize(620, 360)
    panelFrame:Show()

    RefreshOptions()
    window:Show()
    window:Raise()
end

local function RegisterSlashCommands()
    SLASH_PACT1 = "/pact"

    SlashCmdList.PACT = function(message)
        message = (message or ""):match("^%s*(.-)%s*$") or ""
        local command = string.lower(message)

        if command == "" or command == "config" or command == "options" or command == "opcoes" then
            PACT:OpenStandaloneOptions()
        elseif command == "lock" then
            db.locked = true
            UpdateLockState()
            RefreshOptions()
            Print(L.LOCKED)
        elseif command == "unlock" then
            db.locked = false
            UpdateLockState()
            RefreshOptions()
            Print(L.UNLOCKED)
        elseif command == "reset" then
            ResetPosition()
        elseif command == "blizzard" then
            PACT:OpenInterfaceOptions()
        elseif command == "help" then
            Print(L.HELP)
        else
            Print(L.HELP)
        end
    end
end

function PACT:PLAYER_REGEN_ENABLED()
    if pendingLayoutUpdate then
        LayoutPanel()
    end
    if pendingRaidManagerUpdate then
        self:ApplyRaidManagerVisibility()
    end
    UpdatePanelState()
end

function PACT:PLAYER_ENTERING_WORLD()
    UpdatePanelState()
    self:ApplyRaidManagerVisibility()
    if C_Timer then
        C_Timer.After(1, function()
            PACT:ApplyRaidManagerVisibility()
        end)
    end
end

function PACT:GROUP_ROSTER_UPDATE()
    UpdatePanelState()
    self:ApplyRaidManagerVisibility()
end

function PACT:PARTY_LEADER_CHANGED()
    UpdatePanelState()
end

function PACT:RAID_ROSTER_UPDATE()
    UpdatePanelState()
end

function PACT:ADDON_LOADED(addonName)
    if addonName ~= ADDON_NAME then
        return
    end

    self:UnregisterEvent("ADDON_LOADED")

    EnsureDb()
    CreatePanel()
    RegisterInterfaceOptions()
    RegisterSlashCommands()
    RefreshOptions()

    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("PARTY_LEADER_CHANGED")
    self:RegisterEvent("RAID_ROSTER_UPDATE")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")

    self:ApplyRaidManagerVisibility()
    Print(L.LOADED)
end

PACT:SetScript("OnEvent", function(self, event, ...)
    if self[event] then
        self[event](self, ...)
    end
end)

PACT:RegisterEvent("ADDON_LOADED")
