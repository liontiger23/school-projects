use List::Util qw{ shuffle };
sub inorder (&@) {
	my $sub = shift;
	while (scalar(@_) > 1) {
		return unless $sub->(shift,$_[0]);
	}
	return 1;
}
my @list = @ARGV;
@list = do {shuffle @list} until inorder(sub{ $_[0]<=$_[1] }, @list);
print join(' ', @list) . "\n";