# Работа с zabbix и автоматика добавления агентов на ноды

1. имеем конфигурацию rke для разворачивания кластера и собственно сам развернутый кластер
2. задача - просадить на ноды zabbix-агентов

## что нужно доставить

1. ansible (в том числе ansible-vault)
2. роли, любезно созданные командой [zabbix](https://github.com/ansible-collections/community.zabbix?ysclid=la8038qs3a456887161)

```bash
ansible-galaxy collection install community.zabbix
```

3. создать себе парольный файлик для вольта
4. ключи ssh должны подходить к нодам кластера и работать с ансиблом, проверьте `ansible.cfg`

## что уже есть

1. роль для обновления хостов разом (или по очереди) - ./upgrade-hosts.sh
2. настроенная для примера роль для установки агентов заббикса с кредами от сервера заббикс, зашиврованными вольтом
3. скрипт для вытягивания инвентори из конфига rke ./update-inventory.sh

## план работы

1. имеем развернуный кластер и заполненный cluster.yml
2. запущенный сервер заббикс и созданного пользователя с правами добавления хостов
3. генерим инвентори для заббикса по шаблону в файлике `inventory-zabbix`
4. заполняем `api-creds.yml` и шифруем `ansible-vault encrypt ansible/api-creds.yml --vault-password-file ~/.ssh/.vault_pass.txt` (само собой у вас уже должен быть `.vault_pass.txt` с парольной строкой внутри)
5. запускаем установку `./install-zabbix-agents.sh`

## для удаления агентов для отдельной группы нод

1. zabbix_agent_host_state: present (Default) if the host needs to be created or absent is you want to delete it.

## Видео к курсу
- [видео]()

##### Автор
- **Vassiliy Yegorov**
- [школа](https://realmanual.ru)
- [youtube](https://youtube.com/realmanual)
- [группа в ТГ](https://t.me/realmanual_group)
