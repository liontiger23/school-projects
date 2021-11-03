$r = search(@ARGV);
print "\n$r\n";

sub search {
	my ($val,@arr) = @_;
	my ($l,$r) = (-1,scalar @arr);
	while ($r - $l > 1) {
		my $m = int(($r+$l)/2);
		if ($arr[$m] > $val) {
			$r = $m;
		} else {
			$l = $m;
		}
	}
	return -1 if ($l == -1 || $arr[$l] != $val);
	return $l;
}