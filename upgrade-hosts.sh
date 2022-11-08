#!/bin/bash

TYPE=$1;
HOSTLIST=$2;

case $TYPE in
  "serial")
    echo "serial"
    forks=1
  ;;
  "parallel")
    echo "parallel"
    forks=128
  ;;
  "independent")
    echo "independent"
    forks=128
    strat=free
  ;;
  *)
    echo 'Usage: upgrade.sh <strategy> <group or hostname> [strategy: serial|parallel|independent, default=serial], [you see group or hostname from inventory]'
    echo ""
    exit 1
  ;;
esac

[[ ! -n "$HOSTLIST" ]] && {
    echo 'Usage: upgrade.sh <strategy> <group or hostname> [strategy: serial|parallel, default=serial], [you see group or hostname from inventory]'
    echo ""
    echo -e "groups and hostnames available in inventory:\n"
    cat ansible/inventory
    exit 1
}
echo "Upgrading host/group:" $HOSTLIST
cd ansible/ && ansible-playbook upgrade-hosts.yml --extra-vars forks=$forks --extra-vars strat=${strat:-linear} --extra-vars hostlist=$HOSTLIST && cd ..

echo "===== upgraded ====="
