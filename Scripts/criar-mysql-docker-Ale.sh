#!/bin/bash
clear

pressEnterContinue() {
    echo && read -p "===  Press Enter to continue ..."
    clear
}

errorValidationScriptSql() {
    if [ $? -eq 0 ]; then
        echo && echo "============== SUCESS.. ============"
        echo && echo "===  SCRIPT INSERIDO COM SUCESSO..." && pressEnterContinue
    else
        echo && echo "============== ERRO.. ==============" && pressEnterContinue
    fi
}

errorValidationContainer() {
    if [ $? -eq 0 ]; then
        echo && echo "============== SUCESS.. ============" && echo && pressEnterContinue
        for ((i = 15; i > 0; i--)); do
            clear
            echo
            echo "Aguarde... Efetuando Entrypoint do Container... $i"
            sleep 1
        done
        echo && echo "===  CONTAINER CRIADO COM SUCESSO..." && pressEnterContinue
    else
        echo && echo "============== ERRO.. ==============" && echo && pressEnterContinue
    fi
}

echo && echo "===  SCRIPT MAKER CONTAINER - DOCKER MYSQL   |  Autor: Alexandre Gavazzi" && echo
echo "===  Antes de Continuar, certifique-se que:"
echo
echo "   1 - O script 'criar-mysql-docker.sh' está na mesma pasta que o script.sql"
echo "   2 - O terminal bash deve estar aberto na pasta onde está o script.sql"
echo "   3 - Só pode existir 1 arquivo.sql dentro da pasta!"
echo "   4 - O arquivo sql não deve ter nenhum 'CREATE DATABASE' pois será criado neste shell script."
echo "   5 - O aqruivo sql não pode ter nenhum 'USE <database>' pois o script também já faz essa função..."
echo "   obs: O arquivo sql deve ter somente do primeiro 'CREATE TABLE...' pra baixo..."
pressEnterContinue

echo && echo "===  Nome do Container:" && read nomeContainer && pressEnterContinue

echo && echo "===  Nome do Banco de Dados:" && read nomeBanco && pressEnterContinue

echo && echo "===  Senha de root do Banco de Dados:" && read senhaRootBanco && pressEnterContinue

echo && echo "===  Usuario para o Banco de Dados:" && read userBanco && pressEnterContinue

echo && echo "===  Senha para o usuario do Banco de Dados:" && read senhaUserBanco && pressEnterContinue

echo && echo "===  Porta do Banco de Dados: (ex: 3330 ou 8080) você escolhe!" && read portaBanco && pressEnterContinue

docker run -d -p $portaBanco:3306 --name $nomeContainer -e "MYSQL_DATABASE=$nomeBanco" -e "MYSQL_ROOT_PASSWORD=$senhaRootBanco" -e "MYSQL_USER=$userBanco" -e "MYSQL_PASSWORD=$senhaUserBanco" mysql
errorValidationContainer

echo && echo "===  INSERIR SCRIPT.SQL NO BANCO DE DADOS: $nomeBanco" && echo
echo "===  Obs: Caso não for adicionar um script sql, fechar o terminal." && pressEnterContinue

dir_atual=$(pwd)
file_sql=$(find *.sql)

# COMANDO USADO PARA TESTE
# docker exec -i bdteste sh -c 'exec mysql -uroot -proot --init-command="SET SESSION FOREIGN_KEY_CHECKS=0"' < "script.sql"

# COMANDO PARA INICIAR JUNTO AO SCRIPT, COMO O DE CIMA, ESTE COMANDO SETA QUE AS FOREIGN_KEY_CHECKS NÃO SERÃO CHECADAS
# --init-command="SET SESSION FOREIGN_KEY_CHECKS=0"

docker exec -i $nomeContainer sh -c 'exec mysql -u'$userBanco' -p'$senhaUserBanco' '$nomeBanco'' <"$dir_atual/$file_sql"
errorValidationScriptSql

echo
echo "===  FIM DO SCRIPT 'criar-mysql-docker.sh', OBRIGADO.  ==="
echo "----------------------------------------------------------"
echo "===                    CRÉDITOS                        ==="
echo "===                 Alexandre Gavazzi                  ==="
echo "----------------------------------------------------------"
