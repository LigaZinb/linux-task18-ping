#!/bin/bash

read -p "Enter address to ping (e.g. 8. 8. 8. 8 or google.com): " target
fail_counter=0

while true; do
result=$(ping -c -W 1 $target)

if [[ $? -ne 0 ]]; then
echo "Ping failed!"
((fail_counter++))
else 
time_ms=$(echo "$result" | grep "time=" | sed -E
's/ .*time=([0-9.]+) ms.*/\1/')
if (( $(echo "$time_ms > 100" | bc -l) )); then
echo "Ping time exceeded 100 ms: $time_ms ms"

((fail_counter++))
else 
echo "OK: $time_ms ms"
fail_counter=0
fi

fi

if [[ $fail_counteer -ge 3 ]]; then
echo "! 3 consecutive failures or high latency. Exiting."
break 
fi
sleep 1
done
