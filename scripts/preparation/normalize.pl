#!/usr/bin/env perl

# This script is distributed along with the datasets for the
# shared translation task of the NAACL 2012 Workshop on Statistical Machine
# Translation.  We include it here for convenience.

use strict;
use warnings;
use utf8;
use v5.12;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my ($language) = shift(@ARGV) || "en";

my $have_html_entities = eval
{
  require HTML::Entities;
  HTML::Entities->import();
  1;
};

while(<STDIN>) {
  s/\r//g;
  # remove extra spaces
  s/\(/ \(/g;
  s/\)/\) /g; s/ +/ /g;
  s/\) ([\.\!\:\?\;\,])/\)$1/g;
  s/\( /\(/g;
  s/ \)/\)/g;
  s/(\d) \%/$1\%/g;
  s/ :/:/g;
  s/ ;/;/g;
  # normalize unicode punctuation
  s/„/\"/g;
  s/“/\"/g;
  s/”/\"/g;
  s/–/-/g;
  s/−/-/g;
  s/—/ - /g;
  s/ +/ /g;
  s/´/\'/g;
  s/′/\'/g;
  s/’/\'/g;
  s/([a-z])‘([a-z])/$1\'$2/gi;
  s/([a-z])’([a-z])/$1\'$2/gi;
  s/‘/\"/g;
  s/‚/\"/g;
  s/’/\"/g;
  s/''/\"/g;
  s/´´/\"/g;
  s/…/.../g;
  s/°/º/g;
  # Replace non-breaking spaces (which are surprisingly prevalent, and don't
  # count as whitespace) with spaces.
  # French quotes
  s/\xA0«\xA0/ \"/g;
  s/«\xA0/\"/g;
  s/«/\"/g;
  s/\xA0»\xA0/\" /g;
  s/\xA0»/\"/g;
  s/»/\"/g;
  # handle pseudo-spaces
  s/\xA0\%/\%/g;
  s/nº\xA0/nº /g;
  s/\xA0:/:/g;
  s/\xA0ºC/ ºC/g;
  s/\xA0cm/ cm/g;
  s/\xA0\?/\?/g;
  s/\xA0\!/\!/g;
  s/\xA0;/;/g;
  s/,\xA0/, /g; s/ +/ /g;
  
  # English "quotation," followed by comma, style
  if ($language eq "en") {
    s/\"([,\.]+)/$1\"/g;
  }
  # Czech is confused
  elsif ($language eq "cs" || $language eq "cz") {
  }
  # German/Spanish/French "quotation", followed by comma, style
  else {
    s/,\"/\",/g;
    s/(\.+)\"(\s*[^<])/\"$1$2/g; # don't fix period at end of sentence
  }

#  print STDERR "BAD LINE (with <feff>): $_" if /﻿/;

  if ($language eq "de" || $language eq "es" || $language eq "cz" || $language eq "cs" || $language eq "fr") {
    s/(\d)\xA0(\d)/$1,$2/g;
  }
  else {
    s/(\d)\xA0(\d)/$1.$2/g;
  }
  # Replace the rest of the nonbreaking spaces with a regular space.
  s/[\xA0]+/ /g;

  if ($have_html_entities) {
    $_ = decode_entities($_);
  }

  # Get rid of unicode directional indicators
  s/[\x{200E}\x{200F}\x{202B}]//;

  print $_;
}
