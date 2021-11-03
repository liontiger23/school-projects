$|++;
use Term::ReadKey;
eval "use $ARGV[0]";

$path = shift @ARGV;
$path =~ s/::/\//g;
$path .= ".pm";

system 'clear || cls';

open IN, $INC{$path};
while (1) {
	ReadMode 4;
	while (!defined ($key = ReadKey -1)) {}
	ReadMode 0;
	last if ord $key == 27;
	print getc IN;
}
close IN;

system 'clear || cls';