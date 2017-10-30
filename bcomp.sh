#!/bin/sh
# Specify Bamboo plan Stage name as 2nd Argument ; usage --> sh bcomp.sh "stage Name" 
PAT[0]=0
PAT[1]=0
PAT[2]=0
c=0
line=$(head -1 ${1} | awk -F'[()]' '{print $2}')
line2=$(head -1 ${1})
line2=$(echo "${line2% #*}")
line2=$(echo "${line2#*Build }")
line2=$(echo "${line2//\ - /|}")
#echo $line2 
for p in 'Starting task' 'Skipping execution of task .* as it is disabled' ; do
  PAT[c]=$(grep -E -r -e "$p" "${1}" | wc -l)
  c=($c+1)
done
PAT[0]=$((${PAT[0]:-0}+0))
PAT[2]=$((${PAT[0]:-0}+${PAT[1]:-0}))
#echo "Compliance is " ${PAT[0]} "/" ${PAT[2]} " : " $((100*${PAT[0]:-0}/${PAT[2]:-0})) "%"
echo $line2"|"${2}"|"$line"|"${PAT[0]}"|"${PAT[2]}
