open(my $in,  "<",  "input1.txt")  or die "Can't open input.txt: $!";

my %numbers = (
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9
);
# First and last can now be words as well
my $sum = 0;
while (<$in>) {
    # Get first and last numbers
    $_ =~ /^[^0-9]*([0-9])/;
    my $d1 = $1;
    $_ =~ /([0-9])[^0-9]*$/;
    my $d2 = $1;
    # Track the index of the numbers
    $id1 = index($_, $d1);
    $id2 = rindex($_, $d2);
    # Check for each of the number strings
    foreach my $word (keys(%numbers)) {
        # Check for word existance
        $i = index($_, $word);
        # If the the word exists and (it occurs sooner or there was no first numebr)
        if ($i != -1 and ($i < $id1 or $id1 == -1)) {
            $id1 = $i;
            $d1 = $numbers{$word};
        }
        # Get last occurrance of word
        $li = rindex($_, $word);
        # If the the word exists and (it occurs later or there was no first numebr)
        if ($li != -1 and ($li > $id2 or $id2 == -1)) {
            $id2 = $li;
            $d2 = $numbers{$word};
        }
    }
    $sum += $d1 * 10 + int($d2);
}
print "$sum\n";