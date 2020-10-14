function Initialize()
    coverSize = tonumber(SKIN:GetVariable('CoverSize'))
    skinwidth = (coverSize*7)
    divider = 5
    width = skinwidth
    height = skinheight
    direction = getDirection()
    playpause = SKIN:GetMeasure('MeasureState')
    meters = {'MeterCover', 'MeterPrevious', 'MeterPlayPause', 'MeterNext', 'MeterPosition', 'MeterDuration', 'MeterHeart', 'HeartInteract'}
    table.insert(meters, 'ProgressBar')
    table.insert(meters, 'MeterArtist')
    table.insert(meters, 'MeterTrack')
    count = 11
    meter = {}
    xto = {}
    x = {}
    xHome = {}

    -- Create all the meter objects
    for i=1, count do
        meter[i] = SKIN:GetMeter(meters[i])
        if meter == nil then SKIN:Bang("!Refresh") end

        if i > (count - 3) then
            if direction == 1 then
                xto[i] = (skinwidth-(coverSize*0.1*direction))
            else xto[i] = (coverSize*0.1) end
            xHome[i] = xto[i]
            if i < (count - 1) then 
                xHome[i] = xHome[i] + (5*direction)
                xto[i] = xHome[i]
            end
        else
            if direction == 1 then xto[i] = (skinwidth+1)
            else xto[i] = -coverSize-1 end
            xHome[i] = meter[i]:GetX()
        end
        x[i] = xto[i]
    end        
end

function animate()
    for i=1, count do
        x[i]=(x[i]-( (x[i]-xto[i])/(divider) )) -- Move to the xto coordinate
        meter[i]:SetX(x[i])
    end
end

function hide(isInfo)
    for i=1, count do
        if i > (count - 3) then
            if playpause:GetValue() == 2 then 
                xto[i] = skinwidth*2*direction
            else xto[i] = xHome[i]-(5*direction) end
        elseif not(isInfo == 1) then
            if direction == 1 then xto[i] = (skinwidth+1)
            else xto[i] = -coverSize-1 end
        end
    end
end

function show(isInfo)
    for i=1, count do
        if i > (count - 3) then
            if isInfo == 1 then xto[i] = xHome[i]-(5*direction)
            elseif playpause:GetValue() == 1 then xto[i] = xHome[i]-(coverSize*direction) end
        elseif not(isInfo == 1) then
            xto[i] = xHome[i] -- Reset back to the starting position
        end
    end
end

function getDirection()
    local val = SKIN:GetVariable('Direction')
    local dir = 1
    if val == "Left" then dir=-1 end
    return dir
end