# Input
# 3
# ejp mysljylc kd kxveddknmc re jsicpdrysi
# rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd
# de kr kd eoya kw aej tysr re ujdr lkgc jv
#
#
# Output
# Case #1: our language is impossible to understand
# Case #2: there are twenty six factorial possibilities
# Case #3: so it is okay if you want to just give up

open IN, 'in.txt';
open OUT, '>out.txt';
$n = <IN>;
chomp $n;
for (1..$n) {
	$s = <IN>;
	chomp $s;
	$s =~ tr/ynficwlbkuomxsevzpdrjgthaq/abcdefghijklmnopqrstuvwxyz/;
	print OUT "Case #$_: $s\n";
}
close IN;
close OUT;
# abcdefghijklmnopqrstuvwxyz
# ynficwlbkuomxsev-pdrj-thaq
# abcdef-hijklmnopqrstuvwxy-