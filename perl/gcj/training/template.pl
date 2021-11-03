open IN, 'in.txt';
open OUT, '>out.txt';
$t = <IN>;
chomp $t;
for (1..$t) {
	$s = <IN>;
	chomp $s;
	$s =~ tr/ynficwlbkuomxsevzpdrjgthaq/abcdefghijklmnopqrstuvwxyz/;
	print OUT "Case #$_: $s\n";
}
close IN;
close OUT;