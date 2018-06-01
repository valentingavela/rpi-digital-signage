#!/usr/local/bin/perl
use strict ;
use warnings ;

my $mac = qx(cat /sys/class/net/wlan0/address);
$mac =~ tr/\r\n//d;

my $mac2 = qx(cat /sys/class/net/eth0/address);
$mac2 =~ tr/\r\n//d;

my $ip = qx(hostname -I) ;
# $ip =~ tr/\r\n//d ;

my $uptime = substr(qx(uptime), 1, 8);

my $cmd = qq { curl --data "mac=$mac&mac2=$mac2&uptime=$uptime&ip=$ip" https://benteveo.com/cgi-bin/inmoping.pl } ;

print "$cmd \n" ;

my $res = qx($cmd) ;

# qx(cat /var/www/html/cgi-bin/dis_number.txt) ;

if($res ne "ERROR")
{
  file_write("/var/www/html/cgi-bin/dis_number.txt", $res) ;
  system("chown pi:www-data /var/www/html/cgi-bin/dis_number.txt") ;
}
else
{
  file_write("/var/www/html/cgi-bin/dis_number.txt", "NOT_AVAILABLE") ;
}


sub file_write
{
  my $filename = shift ;
  my $text = shift ;
  open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
  print $fh $text ;
  close $fh;
}
