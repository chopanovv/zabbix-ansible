#!/bin/bash

echo "[cluster-nodes]" > ./ansible/inventory
echo "[cluster-nodes]" > ./ansible/inventory-zabbix

k=1
node_name=node

while read line; do
  ip="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$line")"
  [[ $ip ]] && {
    echo "$ip" >> ./ansible/inventory
    echo "$ip zabbix_agent_hostname=${node_name}$k" >> ./ansible/inventory-zabbix
    ((k++))
  }
done < cluster.yml
