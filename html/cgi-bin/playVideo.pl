#!/usr/bin/perl -w
use CGI;
my $cgi = CGI->new() ;
my $video_name = $cgi->param('video') ;
print $cgi->header() ;
print $video_name ;
system("sh /var/www/html/cgi-bin/playVideo.sh /var/www/html/siguitds/inmobiliarias/videos/$video_name >/dev/null 2>/dev/null") ;
