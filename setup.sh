languages=(
    'Ada'
    'Bash'
    'Basic'
    'C'
    'C#'
    'D'
    'Dart'
    'E'
    '?Fatctor'
    '?Fasm'
    'Forth'
    'Go'
    'Groovy'
    'Haskell'
    'Java'
    'Julia'
    'Js'
    'Kotlin'
    'Lisp'
    'Lua'
    'Nim'
    'OCaml'
    'Odin'
    'Pascal'
    'PHP'
    '?Porth'
    'Python'
    'R'
    'Ruby'
    'Rust'
    'Scala'
    'Scratch'
    '?Seed7'
    'Smalltalk'
    '?Tcl'
    'V'
    'Zig'
)

languages=( $(shuf -e "${languages[@]}") )
printf "%s\n" "${languages[@]}" > languages.txt

for X in {2..25}
do
    F="$(printf %02d-%s ${X%} ${languages[$X]})"
    mkdir $F
    touch $F/test.txt $F/input.txt $F/README.md
done
