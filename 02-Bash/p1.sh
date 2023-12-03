MaxRed=12
MaxGreen=13
MaxBlue=14

# Add up the id's of the games that are impossible
# Format: Game %d: %d Color, %d Color; %d Color 

text=$(cat $1)

sum=0

setWasBad=false

handleSet () {
    set=$1

    local redSum=0
    local blueSum=0
    local greenSum=0

    # Split by ,
    while IFS=',' read -ra ADDR; do
        for pair in "${ADDR[@]}"; do
            # Extract values
            num=$(echo $pair | cut -d ' ' -f 1)
            color=$(echo $pair | cut -d ' ' -f 2)
            # Check the colors
            if [ $color = "red" ]; then
                redSum=$((redSum+num))
            elif [ $color = "green" ]; then
                greenSum=$((greenSum+num))
            elif [ $color = "blue" ]; then
                blueSum=$((blueSum+num))
            else
                echo "What color is this?? $color"
            fi
        done
    done <<< "$set"
    # Check if it was good
    if [ "$redSum" -gt "$MaxRed" ]; then
        # echo "Red Over"
        setWasBad=true
    fi
    if [ "$greenSum" -gt "$MaxGreen" ]; then
        # echo "Green Over"
        setWasBad=true
    fi
    if [ "$blueSum" -gt "$MaxBlue" ]; then
        # echo "Blue Over"
        setWasBad=true
    fi
}

resolveGame () {
    local id=$1
    setWasBad=false
    # echo "Game Id: $id"
    game=$2
    # Split by ;
    while IFS=';' read -ra ADDR; do
        for set in "${ADDR[@]}"; do
            # process "$i"
            # echo "Game Set: $i"
            handleSet "$set"
        done
    done <<< "$game"
    if ! $setWasBad ; then 
        # echo "$sum += $id"
        sum=$((sum+id))
    fi
}

while IFS= read -r line || [[ -n $line ]]; do
    id=$(echo $line | cut -d ' ' -f 2 | cut -d ':' -f 1)
    game=$(echo $line | cut -d ':' -f 2)
    resolveGame "$id" "$game"
done < <(printf '%s' "$text")

# Calculate running sum of ids that are possible
#  Possible = Max cubes of all colors at a time is < the number of avail cubes

echo "Sum: $sum"