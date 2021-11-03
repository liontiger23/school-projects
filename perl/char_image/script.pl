use GD;

my @elements = reverse(' ', qw(
.
,
-
+
$
@
#
));

my $name = $ARGV[0];

my $img = GD::Image->newFromPng($name);

open OUT, ">$name.txt";

for my $y(0..$img->height-1) {
	for my $x(0..$img->width-1) {
		print OUT colortochar($img->rgb($img->getPixel($x,$y))) . ' ';
	}
	print OUT "\n";
}

sub colortochar {
	my $color = 0.2126 * shift() + 0.7152 * shift() + 0.0722 * shift();
	return $elements[sprintf "%.0f", ($color / 255) * $#elements];
}

close OUT;

@elements = reverse(' ', qw(
.
,
-
+
$
@
#
));

@elements = (' ', qw(
.
,
:
;
+
=
o
a
e
O
$
@
A
#
M
));