function Update()
    SKIN:Bang('!Log', '........script 1', 'Debug')
    local artist = SKIN:GetMeasure("MeasureArtist"):GetStringValue()

    if artist ~= "" then
    local parsedArtist = GetTitleBeforeComma(artist)
    SKIN:Bang('!SetOption', 'MeasureParsedArtist', 'String', parsedArtist)
    -- !SetOption is used to set the value of a measure
    SKIN:Bang('!UpdateMeasure', 'MeasureParsedArtist')


    SKIN:Bang('!CommandMeasure', 'MeasureFetchLyrics', 'Update')
    local jsonData = SKIN:GetMeasure("MeasureFetchLyrics"):GetStringValue()


    -- if SKIN:GetMeasure("MeasureFetchLyrics"):GetStringValue() ~= "" then
    -- SKIN:Bang('!UpdateMeasure', 'Script2')
    -- end
    
        -- SKIN:Bang('!Log', 'No Artist yet.', 'Debug')
    end

    
end



-- function to get the artist before the comma if there are two artist because lyrics.ovh API only accepts one artist
    function GetTitleBeforeComma(artist)
        local commaIndex = string.find(artist, ",")
        if commaIndex then
            return string.sub(artist, 1, commaIndex - 1)
        else
            SKIN:Bang('!Log', 'No comma found in artist name.', 'Debug')
            return artist
        end
    end