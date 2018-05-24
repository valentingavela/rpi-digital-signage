#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use CGI;
my $cgi = CGI->new() ;

print $cgi->header() ;

my $filename = '../firstTimeConfiguration';
my $status = read_file($filename) ;

if($status eq 'FIRST_TIME')
{
  print "1. Conectate a la red XXXX con cualquier dispositivo." ;
  print "<br>" ;
  print "2. Aceptá la conexión aunque el teléfono advierta que no tiene internet." ;
}
elsif($status eq 'WIFI_CONFIGURATION')
{
  print "3. Abrí el navegador y escribí este número en el campo de dirección:" ;
  print "<br>" ;
  print "192.168.4.1" ;
  print "<br>" ;
  print "4. Elegí tu red wifi dentro de la lista y conectate."
}
elsif($status eq 'SYNCHRO')
{
  print "5. ¡Listo! Siguit comenzará su proceso de instalación." ;
}
elsif($status eq 'SYNCHRONIZED')
{
  print "Espere por favor. Este proceso puede tardar unos minutos." ;
}

########
sub read_file
{
  my $filename = shift ;
  open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";
    return <$fh> ;
}
