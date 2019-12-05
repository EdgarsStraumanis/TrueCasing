#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long "GetOptions";

# Correct word count for both methods
my $rightStandart = 0; 
my $rightUpgraded = 0;

my @WORD; # Storage for CASE SENSITIVE words in an ordered array
my $file1 = "fileCorrect.txt";
open(my $fh1, '<', $file1) or die "Can't open $file1: $!";
binmode($fh1, ":utf8");
my $counter = 0;
while(my $row = <$fh1>) {
    chomp $row; # Cuts off a line from document
    $row =~ s/[[:punct:]]//g;
    #print "$row\n";
    my @OPTIONS = split / /, $row; # Splits row into words
    for(my $i=0;$i<$#OPTIONS+1;$i+=1) {
        $WORD[$counter++] = $OPTIONS[$i]; # Stores words from correct file to use  in comparing of trueCasing algorythm
    }
}
close($fh1);

# To read and evaluate the standart version of moses statistical trueCasing
my $file2 = "fileStandart.txt";
open(my $fh2, '<', $file2) or die "Can't open $file2: $!";
binmode($fh2, ":utf8");
my $placeholder = 0;
while(my $row = <$fh2>) {
    chomp $row; # Cuts off a line from document
    $row =~ s/[[:punct:]]//g;
    #print "$row\n";
    my @OPTIONS = split / /, $row; # Splits row into words
    for(my $i=0;$i<$#OPTIONS+1;$i+=1) {
        # print "$placeholder $WORD[$placeholder] $OPTIONS[$i]\n";
        if ("$WORD[$placeholder++]" eq "$OPTIONS[$i]"){
            $rightStandart++; # Counts the right equal words CASING SENSITIVE
        }
    }
}
close($fh2);

# To read and evaluate the upgraded version of moses statistical trueCasing
my $file3 = "fileUpgraded.txt";
open(my $fh3, '<', $file3) or die "Can't open $file3: $!";
binmode($fh3, ":utf8");
$placeholder = 0;
while(my $row = <$fh3>) {
    chomp $row; # Cuts off a line from document
    $row =~ s/[[:punct:]]//g;
    #print "$row\n";
    my @OPTIONS = split / /, $row; # Splits row into words
    for(my $i=0;$i<$#OPTIONS+1;$i+=1) {
        # print "$placeholder $WORD[$placeholder] $OPTIONS[$i]\n";
        if ("$WORD[$placeholder++]" eq "$OPTIONS[$i]"){
            $rightUpgraded++; # Counts the right equal words CASING SENSITIVE
        }
    }
}
close($fh2);

# To see correct file words one by one when reviewing
# for(my $i=0;$i<$#WORD+1;$i+=1) {   
#         print "$i $WORD[$i]\n";
# }

my $standartcoefficient = $rightStandart / ($#WORD + 1);
my $upgradedcoefficient = $rightUpgraded / ($#WORD + 1);
print "Standart moses coefficient - $standartcoefficient\n";
print "Upgraded moses coefficient - $upgradedcoefficient\n";