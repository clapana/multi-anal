#! /bin/sh
(echo "lily = [\"$1\"; \"$2\"; \"$3\"; \"$4\"];"; cat multi_finder.m)| octave -q