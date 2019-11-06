#!/bin/bash

# WhatsMyScreenSize: A Shell Script to Compute the Display Size in inches
# Author: Abhishek Potnis
# Github: https://github.com/abhishekvp

#Get Length and Height in mm
myOutput=$(xdpyinfo | grep dimensions)

#Extract the Length and Height from the string output of the previous step
sIndex1=$(awk -v a="$myOutput" -v b="(" 'BEGIN{print index(a,b)}')
firstPart="${myOutput:$sIndex1:${#myOutput}}"
eIndex1=$(awk -v a="$firstPart" -v b="x" 'BEGIN{print index(a,b)}')

len="${firstPart:0:$eIndex1-1}"

eIndex2=$(awk -v a="$firstPart" -v b=" " 'BEGIN{print index(a,b)}')

ht="${firstPart:$eIndex1:$eIndex2-$eIndex1}"

#Conversion factor to convert from mm to inches
qty="25.4"

#Compute Lengh and Height in Inches
lenInches=$(awk -v len="${len}" -v qty="${qty}" 'BEGIN{res=(len/qty); print res}')
htInches=$(awk -v ht="${ht}" -v qty="${qty}" 'BEGIN{res=(ht/qty); print res}')

#Compute Diagonal for the Display Size
lenSquare=$(awk -v lenInches="${lenInches}" 'BEGIN{res=(lenInches*lenInches); print res}')
htSquare=$(awk -v htInches="${htInches}" 'BEGIN{res=(htInches*htInches); print res}')
squareTotal=$(awk -v lenSquare="${lenSquare}" -v htSquare="${htSquare}" 'BEGIN{res=(htSquare+lenSquare); print res}')
squareRoot=$(awk -v squareTotal="${squareTotal}" 'BEGIN{res=sqrt(squareTotal); print res}')

#Print Display Size in inches
echo "Your display size: "$squareRoot" inches"
