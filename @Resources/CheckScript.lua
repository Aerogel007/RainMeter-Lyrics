function Update()
    local jsonData = SKIN:GetMeasure("MeasureFetchLyricsJSON"):GetStringValue()
    if jsonData ~= "" then
        SKIN:Bang('!Log', 'JSON fetched, triggering Demo measure...', 'Debug')
        local path = GetPathFromJSON(jsonData)
         SKIN:Bang('!SetOption', 'MeasurePathToLyrics', 'String', path)
         SKIN:Bang('!UpdateMeasure', 'MeasurePathToLyrics')
         SKIN:Bang('!UpdateMeasure', 'MeasureFullLinkToLyrics')
         SKIN:Bang('!Log', 'Demo measure triggered.', 'Debug')

        
    else
        SKIN:Bang('!Log', 'No JSON data yet.', 'Debug')

    end
end
function GetPathFromJSON(jsonString)
    -- Find the start and end of the path value in the JSON
    local pathStart, pathEnd = string.find(jsonString, '"path":"(.-)"')
    
    -- If the path is found, return it
    if pathStart and pathEnd then
        return string.sub(jsonString, pathStart + 8, pathEnd - 1)  -- Extract the path string
    else
        return "Path not found"
    end
end

