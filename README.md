# Gazprom Intelligence Cup
### Devops

При выполнении кейса использовался образ Ubuntu 20.04.3 LTS (Focal Fossa)

### Запуск с нуля

- Взять проект:
```sh
git clone https://github.com/vvleonov/devopsgpn_cup
```
- Запустить установочный скрипт:
```sh
./Scripts/jenkins_docker_heroku_install.sh
```
- В Jenkins установить рекомендуемые плагины
- Скачать Jenkins CLI:
```sh
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
```
- Установить плагины:
```sh
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth <login>:<password> \
install-plugin docker-workflow slack snyk-security-scanner git-parameter
```
- Перезагрузить Jenkins
- В Global Tool Configuration выбрать Snyk (Name = Snyk)
- Запустить скрипт, который положит данные для аутентификации в нужную папку:
```sh
./Scripts/creds.sh
```
- В Jenkins создать запись с id 'GitHub' в credentials (username = API token) и Pipeline с ссылкой на `https://github.com/vvleonov/devopsgpn_cup` (branches to build: \*/\*).
- Перезапустить машину
- Можно запускать пайплайн (при первом запуске может возникнуть ошибка)
##### Ссылка на канал в Slack (для получения уведомлений):
`https://join.slack.com/t/devops-gn/shared_invite/zt-yirs3elz-lStFXdPNyhi18d_qL0z8_Q`
##### После завершения работы конвейера приложение будет доступно по адресу :
##### `https://devopsgn.herokuapp.com/`
