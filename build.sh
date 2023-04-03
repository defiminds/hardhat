#!bin/bash
build() {
echo -ne -n -e "# Atualiza a lista de pacotes disponíveis
apt-get update
# Instala o Node.js
apt-get install -y nodejs
# Instala o npm
apt-get install -y npm
# Instala o Hardhat globalmente com npm
npm install -g hardhat
# Cria um diretório de trabalho para seus projetos
mkdir /app
# Entra no diretório de trabalho
cd /app
# Inicializa um novo projeto Hardhat
npx hardhat init" > install-hardhat.sh && sudo chmod +x install-hardhat.sh
docker run -it --network=host --rm -v $(pwd):/app node:latest /bin/bash -c "cd /app && ./install-hardhat.sh"
}
build
