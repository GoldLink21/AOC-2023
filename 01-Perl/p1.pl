open(my $in,  "<",  "input1.txt")  or die "Can't open input.txt: $!";
# Get first and last digit in each line and keep a running sum of them
# sum += firstD * 10 + lastD
my $sum = 0;
while (<$in>) {
    $_ =~ /^[^0-9]*([0-9])/;
    my $a = int($1);
    $_ =~ /([0-9])[^0-9]*$/;
    $sum += $a * 10 + int($1);
}
print "$sum\n";