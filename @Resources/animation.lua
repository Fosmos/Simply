function Initialize()
    coverSize   = tonumber(SKIN:GetVariable('CoverSize')) -- User specified skin size
    skinwidth   =  coverSize * 7 -- Since the 'Width' variable has a variable in it, Lua can't get that number so I'm harcoding it here
    divider     = 5 -- Update speed
    direction   = getDirection() -- Direction (can be -1 or 1)
    state       = 'paused' -- State variables
    playpause   = SKIN:GetMeasure('MeasureState') -- Measure what state the player is in (play, pause, stop)
    
    -- All the animated meters
    meters = {'MeterCover', 'MeterPrevious', 'MeterPlayPause', 'MeterNext', 'MeterPosition', 'MeterDuration', 'MeterHeart', 'HeartInteract', 'MeterArtist', 'MeterTrack'}
    -- The important meters
    importantMeters = {'MeterArtist', 'MeterTrack', 'ProgressBarR', 'ProgressBarL', 'ProgressBar'}
    
    if SKIN:GetVariable('Orientation') ~= "Vertical" then
        -- Only 1 progress bar in horizontal mode
        table.insert(meters, 'ProgressBar')
        count = 11
    else
        -- 2 in vertical mode
        table.insert(meters, 'ProgressBarR')
        table.insert(meters, 'ProgressBarL')
        count = 12
    end

    meter   = {} -- Will hold meter objects
    hidden  = {} -- The position to go to when the player is in 'hidden' state
    pos     = {} -- Current position for each meter object
    home    = {} -- The 'home' position of each meter object

    -- Populate all the tables
    for i=1, count do
        meter[i] = SKIN:GetMeter(meters[i]) -- Get the meter object
        if meter == nil then SKIN:Bang('!Refresh') end 

        if SKIN:GetVariable('Orientation') == "Horizontal" then
            -- Horizontal
            if table_contains(importantMeters, meter[i]:GetName()) then
                -- Direction is Right
                if direction == 1 then
                    -- Set the home (with some padding)
                    home[i] = skinwidth * 0.98

                    if meter[i]:GetName() == "ProgressBar" then
                        -- Give the progress bar less padding (so it doesn't touch the text)
                        home[i] = skinwidth * 0.99
                    end
                -- Direction is Left
                else
                    home[i] = coverSize * 0.2

                    if meter[i]:GetName() == "ProgressBar" then
                        home[i] = coverSize * 0.1
                    end
                end
                
                -- Position to shift info towards
                hidden[i] = home[i] - (coverSize*direction)
            else
                -- All the other objects
                if direction == 1 then 
                    hidden[i] = skinwidth + 1   -- Shift the elements right
                else 
                    hidden[i] = -(coverSize + 1)  -- Shift them left
                end

                -- Set the home
                home[i] = meter[i]:GetX()
            end
            pos[i] = hidden[i]
        else
            home[i] = meter[i]:GetY() -- Get starting position as home
            pos[i] = home[i]

            if table_contains(importantMeters, meter[i]:GetName()) then
                hidden[i] = (coverSize + 1)*direction
            else
                hidden[i] = (-coverSize - 1)*direction
            end
        end
    end
end

function animate()
    for i=1, count do
        -- Only show the info
        if state == "playing" then
            if table_contains(importantMeters, meter[i]:GetName()) then
                -- Push it back to its home position
                pos[i] = pos[i] - (pos[i] - home[i])/divider
            else
                -- Push the cover to its hidden position
                pos[i] = pos[i] - (pos[i] - hidden[i])/divider
            end
        -- Show everything
        elseif state == "playing_Hover" then
            if table_contains(importantMeters, meter[i]:GetName()) then
                pos[i]= pos[i] - (pos[i] - hidden[i])/divider
            else
                pos[i]= pos[i] - (pos[i] - home[i])/divider
            end
        -- Only show the cover
        elseif state == "paused_Hover" then
            if table_contains(importantMeters, meter[i]:GetName()) then
                if SKIN:GetVariable('Orientation') == "Vertical" then
                    pos[i]= pos[i] - (pos[i] + hidden[i] - 1)/divider
                else
                    pos[i]= pos[i] - (pos[i] - (skinwidth*2*direction))/divider
                end
            else
                pos[i]= pos[i] - (pos[i] - home[i])/divider
            end
        -- Hide everything
        else
            if table_contains(importantMeters, meter[i]:GetName()) then
                if SKIN:GetVariable('Orientation') == "Vertical" then
                    pos[i]= pos[i] - (pos[i] + hidden[i] - 1)/divider
                else
                    pos[i]= pos[i] - (pos[i] - (skinwidth*2*direction))/divider 
                end
            else
                pos[i]= pos[i] - (pos[i] - hidden[i])/divider
            end
        end

        if (SKIN:GetVariable('Orientation') == "Vertical") then 
            meter[i]:SetY(pos[i])
        else 
            meter[i]:SetX(pos[i]) 
        end
    end
end

function setState(isInfo)
    -- Mouse off of skin
    if isInfo == 0 then
        -- Music not playing
        if playpause:GetValue() == 2 then
            state = 'paused'
        else
            state = 'playing'
        end
    -- Mouse over skin
    else
        if playpause:GetValue() == 2 then
            state = 'paused_Hover'
        else
            state = 'playing_Hover'
        end 
    end
end

function getDirection()
    local val = tonumber(SKIN:GetVariable('Direction'))
    if val == 0 then val = -1 end -- Inverted Direction

    if SKIN:GetVariable("Orientation") == "Horizontal" then
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