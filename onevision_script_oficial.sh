#!/bin/bash

echo "procurando o zip Instalador zip"
which zip
if [ $? = 0 ]
then echo "Já possui zip instalado"
else echo "Instalando zip"
sudo apt install zip


echo "adicionando o caminho sdk ao curl"
curl -s "https://get.sdkman.io" | bash
fi
echo "reiniciando o terminal"
source "/home/$usuario/.sdkman/bin/sdkman-init.sh"


echo "Checando se Java já esta instalado"
which java
if [ $? = 0 ]
then echo "Já possui java instalado"
else echo "Instalando java"
sudo apt install openjdk-11-jre -y
fi
echo "versão do instalada: "
java -version

echo "atualizando os pacotes"
sudo apt update && sudo apt upgrade.


echo "procurando o docker"
which docker
if [ $? = 0 ]
then echo "Já possui docker instalado"
else echo "Instalando docker"
sudo apt install docker.io
fi
echo "iniciando o docker no sistema"
sudo systemctl start docker
sudo systemctl enable docker


echo "baixando mysql"
sudo docker pull mysql:8.0.16

echo && echo "Criando Container Docker OneVision"
read -p "Press Enter to continue ..."
docker run -d -p 3306:3306 --name onevision -e "MYSQL_DATABASE=onevision" -e "MYSQL_ROOT_PASSWORD=urubu100" -e "MYSQL_USER=carlos-01212078" -e "MYSQL_PASSWORD=urubu100" mysql

echo "Aguarde 20 segundos..."
sleep 20
read -p "Press Enter to continue ..."

docker exec -i onevision sh -c 'exec mysql -u root -purubu100 onevision' <"bd-onevision.sql"

echo "Clonando o repositorio da aplicação OneVision."
git clone https://github.com/CarlosFelixxs/onevision-jar.git
echo "Entrando no repositorio do projeto."
cd onevision-jar
echo "Executando o jar"
chmod +x onevision.jar
java -jar onevision.jar 
echo "jar executado com sucesso."

chmod +x onevision.jar
java -jar onevision.jar