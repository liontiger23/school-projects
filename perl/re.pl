use Term::ReadLine;
$t = Term::ReadLine->new(1);
open($IN,"<con") && $t->newTTY($IN,$t->OUT);
while (defined ($_ = $t->readline(">>> ")) ) {
	$r = eval($_);
	warn $@ if $@;
	print $r,"\n" if !$@ && /\S/;
	$t->addhistory($_) if /\S/;
}