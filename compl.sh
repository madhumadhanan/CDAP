#!/bin/sh
PAT[0]=0
PAT[1]=0
PAT[2]=0
c=0
for p in 'Starting task' 'Skipping execution of task .* as it is disabled' ; do
  PAT[c]=$(grep -E -r -e "$p" "${1}" | wc -l)
  c=($c+1)
done
PAT[2]=$((${PAT[0]:-0}+${PAT[1]:-0}))
echo "Compliance is " ${PAT[0]} "/" ${PAT[2]} " : " $((100*${PAT[0]:-0}/${PAT[2]:-0})) "%"
