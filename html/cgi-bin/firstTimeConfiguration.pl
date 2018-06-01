#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use CGI;
my $cgi = CGI->new() ;

my $filename = '../firstTimeConfiguration';
my $status = read_file($filename) ;

if($status eq 'PRODUCTION')
{
  print $cgi->redirect('/cgi-bin/play3.pl');
  exit ;
}
else
{

  #Checkeo las leases en el servidor dhcdp para determinar si estoy en
  #status WIFI_CONFIGURATION


  print $cgi->header() ;
  print qq {
    <head>
      <meta http-equiv="refresh" content="5">
    </head>
  } ;

  if($status eq 'FIRST_TIME')
  {
    print "1. Conectate a la red siguit-ap-conf con cualquier dispositivo." ;
    print "<br>" ;
    print "2. Aceptá la conexión aunque el teléfono advierta que no tiene internet." ;
    checkLeasesAndSetStatus() ;
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
    print "<br>" ;
    print "Espere por favor. Este proceso puede tardar unos minutos." ;
  }
  # elsif($status eq 'SYNCHRONIZED')
  # {
  # }

}
exit ;


########
sub read_file
{
  my $filename = shift ;
  open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";
    return <$fh> ;
}

sub file_write
{
  my $filename = shift ;
  my $text = shift ;
  open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
  print $fh $text ;
  close $fh;
}

sub checkLeasesAndSetStatus
{
  my $leases = qx(cat /var/lib/misc/dnsmasq.leases | wc -l);
  my $filename = '/var/www/html/firstTimeConfiguration';

  if ($leases > '0')
  {
    system("echo -n WIFI_CONFIGURATION > $filename") ;
    print "pepe" ;
  }
}
