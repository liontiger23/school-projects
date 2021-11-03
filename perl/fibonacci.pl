use bigint;
sub fibonacci { 
	($a,$b) = (0,1);
	return sub { ($a,$b) = ($b,$a+$b); return $b; };
}
my $f = fibonacci();
print $f->(), "\n" for 1..1000;