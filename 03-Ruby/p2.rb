#!/usr/bin/ruby
lines = []
File.open("input.txt", "r").each_line do |line|
    lines << line
end
def numeric?(line, index)
    if line == nil || index < 0 then
        return false
    elsif index >= line.length() then
        return false
    else
        return line[index].match?(/[[:digit:]]/)
    end
end
# Checks the bounds before checking
def gear?(line, index)
    if line == nil || index < 0 then
        return false
    elsif index >= line.length() then
        return false
    else
        return line[index].match?(/\*/)
    end
end
# Gets the number value if one is at that location 
# Returns nil | string
def getNumber(line, index, wasSentBack=false, wasSendFoward=false)
    if line == nil || index < 0 then
        # Out of bounds
        return nil
    elsif index >= line.length() then
        # Out of bounds
        return nil
    elsif numeric?(line, index)
        # Get number by going back and then forward
        value = line[index]
        prev = nil
        # Only grab previous number if you weren't sent foward. This stops recursion
        if !wasSendFoward then
            prev = getNumber(line, index - 1, true, false)
        end
        if prev != nil then
            # Number extends backwards
            value = prev + value
        end
        nxt = nil
        if !wasSentBack then
            nxt = getNumber(line, index + 1, false, true)
        end
        if nxt != nil then
            # Slap on digits after
            value = value + nxt
        end
        return value
    else
        # Not a number
        return nil
    end
end

def max(a,b)
    if a > b then
        return a
    end
    return b
end
def min(a,b)
    if a < b then
        return a
    end
    return b
end
# Checks for 
def getRatio(prevRow, curRow, nextRow, gearIndex)
    # Check for gear
    if !gear?(curRow, gearIndex) then
        return 0
    end
    # Clamp values within the bounds of the strings
    startIdx = max(0, gearIndex - 1)
    endIdx = min(gearIndex + 1, curRow.length() - 1)
    ratios = []
    # Used for checking for numbers after each other
    prevTopVal = -1
    prevBotVal = -1
    for i in startIdx..endIdx do
        val = getNumber(prevRow, i)
        if val != nil && val != prevTopVal then
            ratios.push(val)
            prevTopVal = val
        end
        val = getNumber(nextRow, i)
        if val != nil && val != prevBotVal then
            ratios.push(val)
            prevBotVal = val
        end
    end
    # Check ones at the ends of the number
    leftNum = getNumber(curRow, startIdx)
    rightNum = getNumber(curRow, endIdx)
    if leftNum != nil then
        ratios.push(leftNum)
    end
    if rightNum != nil then
        ratios.push(rightNum)
    end
    if ratios.length == 2 then
        return ratios[0].to_i * ratios[1].to_i
    end
    return 0
end

sum = 0

lines.each_with_index { | line, y |
    line.each_char.with_index { | char, x |
        prev = nil
        if y != 0 then
            prev = lines[y - 1]
        end
        r = getRatio(prev, line, lines[y+1], x).to_i
        sum = sum + r
    }
    # print "Line\n"
}

# 415206 - 554887
print sum, "\n"
