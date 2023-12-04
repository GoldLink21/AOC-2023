#!/usr/bin/ruby
lines = []
File.open("input.txt", "r").each_line do |line|
    lines << line
end
def numeric?(lookAhead)
    lookAhead.match?(/[[:digit:]]/)
end
# Checks the bounds before checking
def symbol?(line, index)
    if index < 0 then
        return false
    elsif index >= line.length() then
        return false
    else
        # print "Checking '", line[index], "' ", line[index].match?(/[^0-9.]/),  "\n"
        return line[index].match?(/[^0-9.\n]/)
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
def hasAdj(prevRow, curRow, nextRow, startIdx, endIdx)
    # Clamp values within the bounds of the strings
    startIdx = max(0, startIdx - 1)

    # endIdx = min(endIdx, curRow.length() - 1)
    for i in startIdx..endIdx do
        # Make sure there is a previous row
        if prevRow != nil && symbol?(prevRow, i) then
            return true
        end
        # Make sure there is a next row
        if nextRow != nil &&  symbol?(nextRow, i) then
            return true
        end
    end
    # Check ones at the ends of the number
    if symbol?(curRow, startIdx) || symbol?(curRow, endIdx) then
        return true
    end
    return false
end

sum = 0

lines.each_with_index { | line, y |
    numStart = -1
    numVal = 0
    line.each_char.with_index { | char, x |
        if numeric?(char) then
            if numStart == -1 then 
                numStart = x
                numVal = char.ord - '0'.ord
            else
                numVal = numVal * 10 + char.ord - '0'.ord
            end
        elsif numStart != -1 then
            # print "End of number ", numVal, "\n"
            
            prev = nil
            if y != 0 then
                prev = lines[y - 1]
            end
            # Gives nil if out of bounds
            nxt = lines[y + 1]

            if hasAdj(prev, line, nxt, numStart, x) then
                sum = sum + numVal
            end

            numStart = -1
        end
    }
    # Handle numbers that are at the end of the line
    if numStart != -1 then
        # print "End of number ", numVal, "\n"
        
        prev = nil
        if y != 0 then
            prev = lines[y - 1]
        end
        # Gives nil if out of bounds
        nxt = lines[y + 1]

        if hasAdj(prev, line, nxt, numStart, line.length()) then
            # print "Had Adj: ", numVal, "\n"
            sum = sum + numVal
        end

        numStart = -1
    end
}

# 415206 - 554887

print sum, "\n"
