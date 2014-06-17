
$a=0;
$b="String";
@c=(1,2, 5..10,$a);

@d=("abc", "def");

$joind= join ":", @d;

push @d, $joind;

foreach $element (sort {$b cmp $a} @d){
	print "$element\n";
}

if ($joind =~ /([a-z]:)/){
	print "matched $1\n";
}

@e=split //, $joind;

foreach $element (sort {$b cmp $a} @e){
	print "$element\n";
}

$length=@e;
%freqs=();
if (@ARGV==2){
	$input=$ARGV[0];
	$output=$ARGV[1];
	open (INFILE, $input) or die "cannot open file $input\n";
	open (OUTFILE, ">$output") or die "cannot open file $output\n";
	
	while (<INFILE>){
		$line=$_;
		chomp $line;
		$line =~ s/^\s+//; 
		@words = split /\s+/, $line;
		@list = map substr($_,0,4), @words;
		@list2= grep /.i./, @list;
		foreach $word (@words){
			$freqs{$word}++;
		}
	}
	
	close(INFILE);
	foreach $key (sort {$freqs{$a} <=> $freqs{$b}} keys %freqs){
		print OUTFILE "$key $freqs{$key}\n";
	}
	
	close(OUTFILE);
	
	&test (1,10);
	
}else {
	print "we need two arguments\n";
}

sub test {
	$a= shift @_;
	$b= shift @_;
	print "sub $a $b\n";

}