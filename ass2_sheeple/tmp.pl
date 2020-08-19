#!/usr/bin/perl -w
$one = "one";
$two = "two";
$three = "three";
print "$one $two $three\n";
foreach $n ("$one","$two","$three") {
    $line = <STDIN>;
    chomp $line;
    print "Line $n $line\n";
}
 
