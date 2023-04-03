#!bin/bash
build() {
# Docker Container with HARDHAT
# Instalação do Docker e criação de um container
sudo apt-get update
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -it --name hardhat-container ubuntu:latest

# Instalação do Node.js e do npm
sudo apt-get install nodejs -y
sudo apt-get install npm -y

# Instalação do Hardhat
npm install --save-dev hardhat

# Criação de um projeto Hardhat
npx hardhat init my-project

# Configuração do arquivo hardhat.config.js
echo "module.exports = {
  solidity: {
    version: '0.8.9',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    hardhat: {},
  },
}" > my-project/hardhat.config.js
}
build
