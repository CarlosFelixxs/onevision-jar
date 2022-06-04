#!/bin/bash

x="teste"

menu() {
    while true $x != "teste"; do
        clear
        echo
        echo "BEM-VINDO AO ASSISTENTE DO ONE-VISION"
        echo
        echo "OPCOES: "
        cd /./onevision-jar
        if [ -e "onevision.jar" ]; then
            echo "  1) INICIAR ONE-VISION   "
            echo "  2) LISTAR CONTAINERS    "
            echo "  3) EXIBIR LOGS CPU (BANCO LOCAL)  "
            echo "  4) EXIBIR LOGS RAM (BANCO LOCAL) "
            echo "  5) EXIBIR LOGS DISCO (BANCO LOCAL) "
            echo "  6) CRIAR CONTAINERS "
            echo "  7) REMOVER TODOS OS CONTAINERS "
            echo "  exit) SAIR "
        else
            echo "  install) INSTALACAO COMPLETA DO ONE-VISION  "
            echo "  exit) SAIR "
        fi
        echo
        echo "Digite uma opcao:"
        read x

        sleep 1

        case "$x" in
        install) # instalação
            clear

            echo "Atualizando pacotes do sistema(1/5)"
            sleep 3
            sudo apt update && sudo apt upgrade -y
            sudo apt install zip -y
            curl -s "https://get.sdkman.io" | bash
            source "/home/$USER/.sdkman/bin/sdkman-init.sh"
            clear

            echo "Instalando java(2/5)"
            sleep 3
            sudo apt install openjdk-11-jre -y
            sudo apt update && sudo apt upgrade -y
            clear

            echo "Instalando docker(3/5)"
            sleep 3
            sudo apt install docker.io -y
            sudo apt install docker-compose -y
            sudo apt-get install \
                ca-certificates \
                curl \
                gnupg \
                lsb-release -y
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
             $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
            sudo apt-get update
            sudo systemctl start docker
            sudo systemctl enable docker
            clear

            echo "Iniciando container docker e mysql local(4/5)"
            sleep 3
            git checkout main bd-onevision.sql
            chmod +777 bd-onevision.sql
            echo && echo "Criando Container Docker OneVision"
            sudo docker run -d -p 3309:3306 --name onevisionBD -e "MYSQL_DATABASE=onevision" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql
            echo "Aguarde 30 segundos..."
            sleep 30
            sudo docker exec -i onevisionBD sh -c 'exec mysql -uroot -purubu100 onevision' <"bd-onevision.sql"

            echo "Fazendo download do One-Vision(5/5)"
            sleep 3
            git clone https://github.com/CarlosFelixxs/onevision-jar.git
            cd /./onevision-jar
            git checkout main onevision.jar
            chmod +777 onevision.jar
            chmod +777 script-mestre.sh

            echo "Instalação efetuada com sucesso!"
            read -p "Pressione Enter para continuar"
            echo "================================================"
            ;;
        1) # INICIAR ONE VISION
            clear
            cd /./onevision-jar
            echo "ABRINDO APLICACAO .JAR ..."
            sleep 2
            clear
            echo "LOGS GERADOS PELA A APLICACAO"
            echo
            java -jar onevision.jar
            # TRAVA POR CONTA QUE A APLICACAO ESTÁ ABERTA GERANDO LOGS, PORÉM QUANDO FECHADA OPÇÃO 1) CONTINUA SENDO EXECUTADA.
            echo "FECHANDO APLICACAO .JAR ..."
            sleep 2
            ;;
        2) # LISTAR CONTAINERS
            clear
            echo "LISTA DE CONTAINERS DO DOCKER"
            sudo docker ps
            read -p "Pressione Enter para continuar"
            ;;
        3) # EXIBIR LOGS DA CPU
            clear
            exit 0
            ;;
        4) # EXIBIR LOGS DA RAM
            clear
            exit 0
            ;;
        5) # EXIBIR LOGS DO DISCO
            clear
            exit 0
            ;;
        6) # CRIAR CONTAINERS
            clear
            echo && echo "Criando Container Docker OneVision"
            docker run -d -p 3309:3306 --name onevisionBD -e "MYSQL_DATABASE=onevision" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql
            echo "Aguarde 30 segundos..."
            sleep 30
            docker exec -i onevisionBD sh -c 'exec mysql -uroot -purubu100 onevision' <"bd-onevision.sql"
            echo "SCRIPT EFETUADO"
            sleep 3
            ;;
        7) # REMOVER TODOS OS CONTAINERS
            clear
            echo "REMOVENDO TODOS OS CONTAINERS"
            sleep 1
            docker rm $(docker ps -aq) -f
            echo "SCRIPT EFETUADO"
            sleep 3
            ;;
        exit) # SAIR
            clear
            echo "Saindo ..."
            sleep 3
            exit 0
            ;;
        *)
            clear
            echo "   ERRO - OPCAO INVALIDA"
            sleep 3
            ;;
        esac
    done
    menu
}
menu
