#!/usr/bin/perl
use warnings;
use strict;

# Definimos los ficheros necesarios
my $filename = './es_ANY.dic';
my $outfile = './words.json';

# Los abrimos
open(FH, '<', $filename) or die "Error al leer el fichero";
open(FHO, '>', $outfile) or die $!;

my $first = 0;
my $coma = 0;

print FHO "[";

# Recorremos el diccionario...
while(<FH>){

   # Cortamos la palabra de su sufijo...
   my @words = split('/', $_);
   # y nos quedamos con la palabra 
   my $word = $words[0];
   # eliminamos espacios a los lados...
   $word =~ s/^\s+|\s+$//g;
   # ...y las tildes
   $word =~ tr/áéíóúüçÁÉÍÓÚÜÇ/aeiouucAEIOUUC/;

   # Nos quedamos con las de cinco letras. La primera linea no nos sirve
   if ((length($word) eq 5) && ($first eq 1)) {
      # La primera fila no lleva coma, las siguientes si (eso me pasa por no usar JSON directamente)
      if ($coma eq 0) {
         print FHO "\'" . uc $word . "\'" . "\n";
         $coma = 1;
      }
      else {
         print FHO ",\'" . uc $word . "\'" . "\n";
      }
      
   }

   $first = 1;

}

print FHO "]";

# Cerramos ficheros
close(FH);
close(FHO);
