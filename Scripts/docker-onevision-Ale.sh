clear
echo && echo "Criando Container Docker OneVision"
read -p "Press Enter to continue ..."

docker run -d -p 3309:3306 --name DBOneVision -e "MYSQL_DATABASE=onevision" -e "MYSQL_ROOT_PASSWORD=urubu100" -e "MYSQL_USER=userOneVision" -e "MYSQL_PASSWORD=urubu100" mysql

echo "Aguarde 20 segundos..."
sleep 20
read -p "Press Enter to continue ..."

docker exec -i DBOneVision sh -c 'exec mysql -u root -purubu100 onevision' <"onevision-oficial.sql"

# remove container
# docker rm $(docker ps -aq) -f

# remove volumes
# docker volume rm $(docker volume ls -q)