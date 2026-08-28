#!/bin/bash

sites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
  "https://www.example.com"
  "https://www.lolthissiteisabsent.com"
  "https://www.lol.com"
)

log_file="site-checker.log"

if [ ! -f "$log_file" ]; then
    echo "Log file (${log_file}) missing. Creating it now..."
    touch "./${log_file}"
else
    echo "Log file (${log_file}) already exists. Updating timestamp..."
    touch -ac "./${log_file}"
fi
echo -e "\n"

for site in "${sites[@]}"; do
    status_code=$(curl -o /dev/null -s -w "%{http_code}\\n" $site)
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    if [[ ($status_code -eq 0) || ($status_code -ge 500) ]]
    then
      echo "${timestamp} [${site}](${site}) is DOWN" | tee -a "${log_file}"
    else
      echo "${timestamp} [${site}](${site}) is UP" | tee  -a "${log_file}"
    fi
done

echo -e "\n\nLogs are printed to $log_file"