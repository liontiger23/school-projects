$m = 'abcdefghijklmnopqrstuvwxyz';
$s = join '', sort split '', lc $ARGV[0];
$s =~ s/ //g;
$s =~ s/(.)\1*/$1/g;
print $s eq $m ? 'pangram' : 'non-pangram';