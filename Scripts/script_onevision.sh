
#!/bin/bash
echo "você está no passo 1 - Instalando um compactador de arquivo."
sudo apt install zip
echo "você está no passo 2 - Adicionando o caminho do SDK ao Curl."
curl -s "https://get.sdkman.io" | bash
echo "você está no passo 3 - Executando SDK"
source "/home/urubu100/.sdkman/bin/sdkman-init.sh"
echo "você está no passo 4 - Instalando o java"
sdk install java 8.0.282.j9-adpt
echo "Versão do java instalado"
java -version
echo "Você está no passo 5 - clonando o repositorio da aplicação OneVision."
git clone https://github.com/gitguilherme/one-vision
echo "você está no passo 6 - Entrar no repositorio do projeto."
cd One-Vision
echo "você está no passo 7 - Execute o jar"
java -jar One-Vision-1.0-SNAPSHOT-jar-with-dependencies.jar 
echo "você está no passo 8 - jar executado com sucesso."

