#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;
use HTML::Template;

use CGI;
my $cgi = CGI->new() ;

my $status = read_file('../firstTimeConfiguration') ;

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
  my $template = HTML::Template->new(filename => "/var/www/html/templates/messages/messages-T2.html") ; #$pth path del template
  my $message ;
  # print qq {
  #   <head>
  #     <meta http-equiv="refresh" content="5">
  #   </head>
  # }
  # ;

 # my $process_status = read_file( '/tmp/process_status' ) ;
 # if($process_status eq 'CONNECTED')
 # {
 #	system("echo -n SYNCHRO > ../firstTimeConfiguration") ;
 # }

 # <h2>Título del mensaje para siguit</h2>
 # <p>Lorem ipsum dolor sit amet <span>consectetur adipiscing elit</span> sed do eiusmod
  # tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris</p>
  my $loading = 0 ;

  if($status eq 'FIRST_TIME')
  {
    $message = "<p>Conectate a la red <span>siguit-ap-conf</span> con cualquier dispositivo." ;
    $message .= "<br>" ;
    $message .= "Aceptá la conexión aunque el teléfono advierta que no tiene internet.</p>" ;

    checkLeasesAndSetStatus() ;
  }
  elsif($status eq 'WIFI_CONFIGURATION')
  {
    $message = "<p>Abrí el navegador y escribí este número en el campo de dirección:" ;
    $message .= "<br>" ;
    $message .= "<span>192.168.4.1</span>" ;
    $message .= "<br>" ;
    $message .= "Elegí tu red wifi dentro de la lista y conectate.</p>"
  }
  elsif($status eq 'CLI_IS_SET')
  {
    $message = "<p>Intentando conectarse a la red</p>" ;
    $loading = 1 ;
  }
  elsif($status eq 'CANT_CONNECT')
  {
    $message = "<p> El sistema no pudo conectarse. Repita estos pasos" ;
    $message .= "<br>" ;
    $message .= "Conectate a la red <span>siguit-ap-conf</span> con cualquier dispositivo." ;
    $message .= "<br>" ;
    $message .= "Aceptá la conexión aunque el teléfono advierta que no tiene internet.</p>" ;

    checkLeasesAndSetStatus() ;
  }
  elsif($status eq 'SYNCHRO')
  {
    $message = "<p>¡Listo! Siguit comenzará su proceso de instalación." ;
    $message .= "<br>" ;
    $message .= "Espere por favor. <span>Este proceso puede tardar unos minutos.</span></p>" ;
    $loading = 1 ;
  }

  $template->param(message => $message );
  print $template->output() ;

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
  #Aca checkea si hay alguien conectado a la red.
  my $leases = qx(cat /var/lib/misc/dnsmasq.leases | wc -l);
  my $filename = '/var/www/html/firstTimeConfiguration';

  if ($leases > '0')
  {
    system("echo -n WIFI_CONFIGURATION > $filename") ;
    print "WIFI_CONFIGURATION" ;
  }
}
