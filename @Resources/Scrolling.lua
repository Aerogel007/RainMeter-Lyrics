-- Variables to store the duration and position
local duration = 0
local position = 0
local ratio = 0
--match updateRate with updateRate from [MeasureScroll] 

function Update()
    SKIN:Bang('!Log', 'Scrolling.lua: Update() called', 'Debug')
    -- Get the duration and position from the measures
    duration = SKIN:GetMeasure("MeasureDuration"):GetStringValue()
    position = SKIN:GetMeasure("MeasurePosition"):GetStringValue()
    SKIN:Bang('!Log', 'Duration: ' .. duration, 'Debug')
    SKIN:Bang('!Log', 'Position: ' .. position, 'Debug')

    -- Convert duration and position to seconds
    local durationSeconds = ConvertToSeconds(duration)
    local positionSeconds = ConvertToSeconds(position)
    SKIN:Bang('!Log', 'Duration in seconds: ' .. durationSeconds, 'Debug')
    SKIN:Bang('!Log', 'Position in seconds: ' .. positionSeconds, 'Debug')


    -- Get the total height of the lyrics text
    local lyricsHeight = CalculateTextHeight("MeterLyrics")
    SKIN:Bang('!Log', 'Lyrics height: ' .. lyricsHeight, 'Debug')

    ratio = lyricsHeight / durationSeconds

    SKIN:Bang('!Log', 'Ratio: ' .. ratio, 'Debug')
    --ratio is for each second how much pixel should be scrolled

    -- Calculate the scroll position
    local scrollPosition = CalculateScrollPosition(positionSeconds)
    SKIN:Bang('!Log', 'Scroll position: ' .. scrollPosition, 'Debug')

    -- Update the Y position of the MeterLyrics
    SKIN:Bang('!SetOption', 'MeterLyrics', 'Y', scrollPosition)
    SKIN:Bang('!UpdateMeter', 'MeterLyrics')
    SKIN:Bang('!Redraw')
end

-- Function to convert time in minutes:seconds format to seconds
function ConvertToSeconds(time)
    local minutes, seconds = string.match(time, "(%d+):(%d+)")
    return tonumber(minutes) * 60 + tonumber(seconds)
end

-- Function to calculate the scroll position
function CalculateScrollPosition(positionSeconds)
    local scrollPosition = (1000 - positionSeconds * ratio)
    return scrollPosition
end

-- Function to calculate the height of the text inside the meter
function CalculateTextHeight(meterName)
    local meter = SKIN:GetMeter(meterName)
    local text = meter:GetOption("Text")
    local fontSize = tonumber(meter:GetOption("FontSize"))
    SKIN:Bang('!Log', 'font size ' .. fontSize, 'Debug')

    -- Calculate the number of lines the text will occupy
    local lines = 1
    local height = 0
    for word in string.gmatch(text, "#CRLF#") do
        lines = lines + 1
    end

    -- Calculate the total height based on the number of lines and font size
    height = lines * (fontSize + (fontSize / 2))
    return height
end