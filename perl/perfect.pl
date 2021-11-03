use bigint;

my $N = $ARGV[0];

my %primes;
#$primes{$_} = 1 for 2..$N;

for (2..$N) {
	unless (defined $primes{$_}) {
		# Prime

		my $x = $_*$_;
		while ($x <= $N) {
			$primes{$x} = 1;
			$x += $_;
		}

		# Still Prime

		print make_perfect($_) . "\n";
	}
}

sub second_grade {
	my $x = shift;
	return 1 if $x == 1;
	return (1 << ($x-1)) + second_grade($x-1);
}

sub make_perfect {
	my $x = shift;
	return second_grade($x) << ($x-1);
}