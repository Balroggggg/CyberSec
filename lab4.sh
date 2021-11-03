#!/bin/bash 
cat $1 | tr -d " \t\n\r" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' > prepared.txt 
var=$(wc -m < prepared.txt) 
echo "$var" 
sed 's/\(.\)/\1\n/g' prepared.txt | sort | uniq -ic | sort -k1 -n -r
echo "--------------------------------" 
cat prepared.txt | sort | uniq -c > allwords.txt 
rm -f bigrams.txt 
bigramtime=`wc -l allwords.txt | sed 's/[^0-9]* //'|sed 's/ .*//'` cat allwords.txt | while read line 
do 
word=`echo "$line" | sed 's/^[0-9]* //'` 
freq=`echo "$line" | sed 's/ [^0-9]*//'` 
 
for ((i=0;i<${#word}-1;i++))  
do  
 
echo $freq " " ${word:(i):2} >> bigrams.txt  
done 
done 
sort bigrams.txt | 
sort -k1,1nr -k2 | 
sed 's/^ *//' bigrams.txt | cut -d" " -f2- | sort | uniq -ic > fr1.txt 
sort -k1 -n fr1.txt | tail -30 
echo "----------------------------------" 
rm -f trigrams.txt 
cat allwords.txt | while read line 
do 
word=`echo "$line" | sed 's/^[0-9]* //'` 
freq=`echo "$line" | sed 's/ [^0-9]*//'` 
for ((i=0;i<${#word}-1;i++)) 
do 
trigram=${word:(i):3} 
length=${#trigram} 
if [ "$length" == "3" ]; 
 
then 
echo $freq " " $trigram >> trigrams.txt;  
fi 
done 
done 
sort trigrams.txt | 
sort -k1,1nr -k2 | 
sed 's/^ *//' trigrams.txt | cut -d" " -f2- | sort | uniq -ic > fr2.txt 
sort -k1 -n fr2.txt | tail -30 
