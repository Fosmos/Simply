function Initialize()
    coverSize   = tonumber(SKIN:GetVariable('CoverSize')) -- User specified skin size
    skinwidth   =  coverSize * 7 -- Since the 'Width' variable has a variable in it, Lua can't get that number so I'm harcoding it here
    divider     = 5 -- Update speed
    state       = 'paused' -- State variables
    playpause   = SKIN:GetMeasure('MeasureState') -- Measure what state the player is in (play, pause, stop)
    hidecover   = tonumber(SKIN:GetVariable('AutoHide')) -- either 1 or 0
    orientation = SKIN:GetVariable('Orientation')
    direction   = getDirection() -- Direction (can be -1 or 1)

    -- All the animated meters
    meters = {'MeterCover', 'MeterPrevious', 'MeterPlayPause', 'MeterNext', 'MeterPosition', 'MeterDuration', 'MeterHeart', 'HeartInteract', 'MeterArtist', 'MeterTrack'}
    -- Fading meters
    mediaControls = {'MeterCover', 'MeterPrevious', 'MeterPlayPause', 'MeterNext', 'MeterPosition', 'MeterDuration', 'MeterHeart'}
    -- The important meters
    importantMeters = {'MeterArtist', 'MeterTrack', 'ProgressBarR', 'ProgressBarL', 'ProgressBar'}

    if orientation ~= "Vertical" then
        -- Only 1 progress bar in horizontal mode
        table.insert(meters, 'ProgressBar')
        count = 11
    else
        -- 2 in vertical mode
        table.insert(meters, 'ProgressBarR')
        table.insert(meters, 'ProgressBarL')
        count = 12
    end

    meterObjs  = {} -- Will hold meter objects
    hover      = {} -- The position to go to when the player is in 'hover' state
    notHover   = {} -- The 'notHover' position of each meter
    hidden     = {} -- Position to completely hide the meter
    pos        = {} -- Current position for each meter object

    -- Populate all the tables
    for i=1, count do
        meter = SKIN:GetMeter(meters[i]) -- Get the meter object
        meterObjs[i] = meter

        -- Horizontal
        if orientation == "Horizontal" then
            -- Song info and progress bars
            if table_contains(importantMeters, meter:GetName()) then
                -- Direction is Right
                if direction == 1 then
                    -- Set the notHover (with some padding)
                    notHover[i] = skinwidth * 0.98

                    if meter:GetName() == "ProgressBar" then
                        -- Give the progress bar less padding (so it doesn't touch the text)
                        notHover[i] = skinwidth * 0.99
                    end
                -- Direction is Left
                else
                    notHover[i] = coverSize * 0.2

                    if meter:GetName() == "ProgressBar" then
                        notHover[i] = coverSize * 0.1
                    end
                end

                -- Position to shift info towards
                hover[i] = notHover[i] - (coverSize*direction)
            -- Cover and media controls
            else
                -- All the other objects
                if direction == 1 then
                    notHover[i] = skinwidth + 1 -- Shift the elements right
                else
                    notHover[i] = -(coverSize + 1) -- Shift them left
                end

                hover[i] = meter:GetX()
            end

            hidden[i] = skinwidth * 2 * direction
        -- Vertical
        else
            -- Song info and progress bars
            if table_contains(importantMeters, meter:GetName()) then
                notHover[i] = meter:GetY()
                hover[i]    = (coverSize + 1)*direction
                hidden[i]   = hover[i]
            -- Cover and media controls
            else
                notHover[i] = (-coverSize - 1)*direction
                hover[i]    = meter:GetY()
                hidden[i]   = notHover[i]
            end

        end

        -- Floor everything
        notHover[i] = math.floor(notHover[i])
        hover[i]    = math.floor(hover[i])
        hidden[i]   = math.floor(hidden[i])

        -- Set the position
        pos[i] = notHover[i]
        UpdatePos(meter, i)
    end
end

function animate()
    for i=1, count do
        meter = meterObjs[i]

        update = true

        -- Auto Hide
        if hidecover == 1 then
            -- Only show the info
            if state == "playing" then
                update = InterpTowardNotHover(i)
            -- Show everything
            elseif state == "playing_Hover" then
                update = InterpTowardHover(i)
            -- Only show the cover
            elseif state == "paused_Hover" then
                -- TODO: This state forever updates
                if not table_contains(importantMeters, meter:GetName()) then
                    update = InterpTowardHover(i)
                end
            -- Hide everything
            else
                update = InterpTowardHidden(i)
            end
        -- No Auto-Hide
        else
            -- Show everything while playing
            if state == "playing" or state == "playing_Hover" then
                update = InterpTowardHover(i)
            -- Paused states
            else
                -- Hide the song info
                if table_contains(importantMeters, meter:GetName()) then
                    update = InterpTowardHidden(i)
                -- Show the cover and media controls
                else
                    update = InterpTowardHover(i)
                end
            end
        end

        if table_contains(mediaControls, meter:GetName()) then
            fade(meter)
        end

        -- If the position was changed, then write it to the
        -- meter, otherwise don't waste time doing it
        if update then
            -- print("updating...")
            UpdatePos(meter, i)
        end
    end
end

function setState(isHover)
    -- Mouse off of skin
    if isHover == 0 then
        state = 'playing'

        -- Music not playing
        if playpause:GetValue() == 2 then
            state = 'paused'
        end
    -- Mouse over skin
    else
        state = 'playing_Hover'

        if playpause:GetValue() == 2 then
            state = 'paused_Hover'
        end
    end
end

function getDirection()
    local val = tonumber(SKIN:GetVariable('Direction'))
    if val == 0 then val = -1 end -- Inverted Direction

    if orientation == "Horizontal" then
        SKIN:Bang('!SetOption', 'ProgressBar', 'Hidden', 0)
        SKIN:Bang('!SetOption', 'ProgressBarR', 'Hidden', 1)
        SKIN:Bang('!SetOption', 'ProgressBarL', 'Hidden', 1)
    else
        SKIN:Bang('!SetOption', 'ProgressBar', 'Hidden', 1)
        SKIN:Bang('!SetOption', 'ProgressBarR', 'Hidden', 0)
        SKIN:Bang('!SetOption', 'ProgressBarL', 'Hidden', 0)
    end

    return val
end

function table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then return true end
    end
    return false
end

function fade(meter)
    if meter:GetName() == 'MeterCover' then
        ApplyTintToCover(meter)
        return
    end

    alpha = 255

    if meter:GetName() == 'MeterPosition' or meter:GetName() == 'MeterDuration' then
        alpha = tonumber(string.match(meter:GetOption('FontColor', '255,255,255,255'), ',(%w+)$'))
    else
        alpha = tonumber(meter:GetOption("ImageAlpha", '255'))
    end

    if state == "playing_Hover" or state == "paused_Hover" then
        if alpha >= 255 then return end

        alpha = alpha + 15
    else
        if alpha <= 0 then return end

        alpha = alpha - 15
    end

    if meter:GetName() == 'MeterPosition' or meter:GetName() == 'MeterDuration' then
        SKIN:Bang('!SetOption', meter:GetName(), 'FontColor', "255,255,255,"..alpha)
    else
        SKIN:Bang('!SetOption', meter:GetName(), 'ImageAlpha', alpha)
    end
end

function ApplyTintToCover(cover)
    tint = tonumber(string.match(cover:GetOption('ImageTint', '255,255,255,255'), '([^,]+)'))

    if state == "playing_Hover" or state == "paused_Hover" then
        if tint <= 79 then return end
        tint = tint - 15
    else
        if tint >= 255 then return end
        tint = tint + 15
    end

    SKIN:Bang('!SetOption', cover:GetName(), 'ImageTint', tint..","..tint..","..tint..",255")
end

function InterpTowardNotHover(i)
    if pos[i] == notHover[i] then return false end

    pos[i] = pos[i] - (pos[i] - notHover[i])/divider

    if math.abs(notHover[i] - pos[i]) < .5 then
        pos[i] = notHover[i]
    end

    -- print(i .. ": " .. pos[i] .. " -> " .. notHover[i])

    return true
end

function InterpTowardHover(i)
    if pos[i] == hover[i] then return false end

    pos[i] = pos[i] - (pos[i] - hover[i])/divider

    if math.abs(hover[i] - pos[i]) < .5 then
        pos[i] = hover[i]
    end

    -- print(i .. ": " .. pos[i] .. " -> " .. hover[i])

    return true
end

function InterpTowardHidden(i)
    if pos[i] == hidden[i] then return false end

    pos[i] = pos[i] - (pos[i] - hidden[i])/divider

    if math.abs(hidden[i] - pos[i]) < .5 then
        pos[i] = hidden[i]
    end

    -- print(i .. ": " .. pos[i] .. " -> " .. hidden[i])

    return true
end

function UpdatePos(meter, i)
    if (orientation == "Horizontal") then
        meter:SetX(pos[i])
    else
        meter:SetY(pos[i])
    end
end
