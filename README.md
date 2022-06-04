# Script_Instalacao

# Inserir o comando abaixo para baixar o repositório de assistente de instalação.

```sh
cd / && git clone -n https://github.com/CarlosFelixxs/onevision-jar.git && cd /./onevision-jar/ && git checkout main script-mestre.sh && chmod +777 script-mestre.sh && ./script-mestre.sh
```

# Remove todos os containers

docker rm $(docker ps -aq) -f

# Interage com o container via bash

docker exec -it contsmart bash

# Conecta com o mysql local

mysql -h localhost -uroot -proot smart_sac

# select dos registros

select \* from log_registros;
