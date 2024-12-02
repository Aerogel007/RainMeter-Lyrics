function Update()
    SKIN:Bang('!Log', '........Script 2', 'Debug')

    local jsonData = SKIN:GetMeasure("MeasureFetchLyrics"):GetStringValue()
    -- TODO: why would not usng the code above cause it to run the script
    -- SKIN:Bang('!Log', '......Fetched JSON Data: ' .. jsonData, 'Debug')

    if jsonData ~= "" then
        local lyrics = GetLyricsFromJSON(jsonData)
        local final = replaceCRLF(lyrics)

        local title = SKIN:GetMeasure('MeasureTitle'):GetStringValue()
        SKIN:Bang('!Log', 'Title ' .. title, 'Debug')
        SKIN:Bang('!SetOption', 'MeterLyrics', 'Text', final)
        SKIN:Bang('!UpdateMeter', 'MeterLyrics')

        SKIN:Bang('!Log', 'Extracted Lyrics: ' .. final, 'Debug')
        
    else
        SKIN:Bang('!Log', 'No JSON data yet.', 'Debug')
    end

end

-- function to get the lyrics from the JSON string
function GetLyricsFromJSON(jsonString)
    -- SKIN:Bang('!Log', 'Parsing JSON String: ' .. jsonString, 'Debug')
    
    -- Find the start and end of the lyrics value in the JSON
    local lyricsStart, lyricsEnd = string.find(jsonString, '"lyrics":"(.-)"}')
    
    -- If the lyrics are found, return them
    if lyricsStart and lyricsEnd then
        local lyrics = string.sub(jsonString, lyricsStart + 10, lyricsEnd - 1)  -- Extract the lyrics string
        -- SKIN:Bang('!Log', 'Lyrics found: ' .. lyrics, 'Debug')
        return lyrics
    else
        SKIN:Bang('!Log', 'Lyrics not found in JSON.', 'Debug')
        -- return ""
    end
end


-- function to replace combinations of /r, /n, /r/n, /n/n with #CRLF#
function replaceCRLF(input)    
    local result = string.gsub(input, "\\r", "#CRLF#")  -- Replace \ralone
    result = string.gsub(result, "\\n", "#CRLF#")  -- Replace \n alone
    
    return result
end