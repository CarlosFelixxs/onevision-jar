# Script_Instalacao

# Inserir o comando abaixo para baixar o repositório de assistente de instalação.

```sh
cd / && git clone -n https://github.com/CarlosFelixxs/onevision-jar.git && cd /./onevision-jar/ && git checkout main script-mestre.sh && chmod +777 script-mestre.sh && ./script-mestre.sh
```

# Remove todos os containers
```sh
docker rm $(docker ps -aq) -f
```
# Interage com o container via bash
```sh
docker exec -it onevisionBD bash
```
# Conecta com o mysql local
```sh
mysql -h localhost -uroot -proot onevision
```
# select dos registros
```sql
select * from registroComponente;
```