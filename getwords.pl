#!/usr/bin/perl
use warnings;
use strict;
use Text::Unaccent::PurePerl;
use List::MoreUtils qw(uniq);
use JSON;

use open ':locale';

# Definimos los ficheros necesarios
my $filename = './es_ANY.dic';
my $outfile = './words.json';

# Los abrimos
open(FH, '<', $filename) or die "Error al leer el fichero";
open(FHO, '>', $outfile) or die $!;

my $first = 0;
my $coma = 0;

#print FHO "[";

my @wordsArray = qw();

# Recorremos el diccionario...
while(<FH>){

   # Cortamos la palabra de su sufijo...
   my @words = split('/', $_);
   # y nos quedamos con la palabra 
   my $word = $words[0];
   # eliminamos espacios a los lados...
   $word =~ s/^\s+|\s+$//g;
   # ...y las tildes   
   $word = unac_string($word);

   if (($first eq 1) && (length($word) eq 5)) {
      push(@wordsArray, uc $word);
   }

   $first = 1;
}


my @cleanwords = uniq @wordsArray ;

my $json = encode_json(\@cleanwords);

print FHO $json;

#print FHO "]";

# Cerramos ficheros
close(FH);
close(FHO);