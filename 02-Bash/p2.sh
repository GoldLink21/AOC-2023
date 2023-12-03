# Format: Game %d: %d Color, %d Color; %d Color 

text=$(cat $1)

pow=0

redMax=0
blueMax=0
greenMax=0

handleSet () {
    redSum=0
    blueSum=0
    greenSum=0
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
    done <<< "$1"
    # Keep if > maximum
    if [ $redSum -gt $redMax ]; then
        redMax=$redSum
    fi
    if [ $greenSum -gt $greenMax ]; then
        greenMax=$greenSum
    fi
    if [ $blueSum -gt $blueMax ]; then
        blueMax=$blueSum
    fi
}

resolveGame () {
    local id=$1

    redMax=0
    blueMax=0
    greenMax=0

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
    # echo "r:$redMax g:$greenMax b:$blueMax"

    pow=$((pow + redMax*blueMax*greenMax))
}

while IFS= read -r line || [[ -n $line ]]; do
    id=$(echo $line | cut -d ' ' -f 2 | cut -d ':' -f 1)
    game=$(echo $line | cut -d ':' -f 2)
    resolveGame "$id" "$game"
done < <(printf '%s' "$text")

echo "Pow: $pow"