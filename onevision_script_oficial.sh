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


echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Olá Aluno, serei seu assistente para instalação do Java!;"
sleep 2
echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Verificando aqui se você possui o Java instalado...;"
sleep 2

java -version
if [ $? -eq 0 ]
	then
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Olá você já tem o java instalado!!"
		sleep 2
	else
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
		sleep 2
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Confirme para mim se realmente deseja instalar o Java (Y/n)?"		
	read inst
	if [ \"$inst\" == \"Y\" ]
		then
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ok! Você escolheu instalar o Java ;D"
			sleep 2
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Adicionando o repositório!"
			sleep 2
			sudo sdk install java 11.0.11-open
			clear
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Atualizando Pacotes! Quase lá."
			sleep 2
			sudo apt update -y
			sudo apt upgrade -y
			clear
			
			if [ $VERSAO -eq 11 ]
				then
					echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Preparando para instalar a versão 11 do Java. Confirme a instalação quando solicitado ;D"
					sleep 1
					sudo apt install default-jre ; apt install openjdk-11-jre-headless; -y
					clear
					echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Java instalado com sucesso!"
					sleep 1
				fi
		else 	
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Você optou por não instalar o Java por enquanto, até a próxima então!"
		sleep 1
	fi
	fi
echo "atualizando os pacotes"
sudo apt update -y
sudo apt upgrade -y


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
sudo docker pull mysql

echo && echo "Criando Container Docker OneVision"
sudo docker run -d -p 3309:3306 --name onevisionBD -e "MYSQL_DATABASE=onevision" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql
echo "Aguarde 30 segundos..."
sleep 30
sudo docker exec -i onevisionBD sh -c 'exec mysql -uroot -purubu100 onevision' <"bd-onevision.sql"
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

