
open IN, 'in.txt';
open OUT, '>out.txt';
$n = <IN>;
chomp $n;
my ($m,$s,$p,@t,@pairs);
for (1..$n) {
	$str = <IN>;
	chomp $str;
	
	($m,$s,$p,@t) = split ' ', $str;
	@pairs = ();
	@pairs = map [ sort($_ ? $_<30 ? int($_/3)+1 : 10 : 0, $_<29 ? int($_/3)+$_%3 : 10) ],  @t;
	
	print OUT "Case #$_: ".slurp(0,0)."\n";
}
close IN;
close OUT;


sub slurp {
	my ($x,$ss) = @_;
	
	return -1 if $ss > $s;
	return 0 if $x > $#pairs;

	@pair = @{$pairs[$x]};
	
	#print join(' , ', @pair) . "\n";
	
	if (@pair[0] >= $p) {
		return $r+1 if ($r = slurp($x+1,$ss)) >= 0;
	} elsif (@pair[1] >= $p) {
		return $r+1 if ($r = slurp($x+1,$ss+1)) >= 0;
		return $r if ($r = slurp($x+1,$ss)) >= 0;
	} else {
		return $r if ($r = slurp($x+1,$ss)) >= 0;
	}
}

