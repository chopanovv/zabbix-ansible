#!/bin/bash

cd ansible && ansible-playbook -i inventory-zabbix install-zabbix-agent.yml --vault-password-file ~/.ssh/.vault_pass.txt
