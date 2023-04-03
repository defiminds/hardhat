#!bin/bash
build() {

install_docker() {
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io
}

dockerfile() {
echo -ne -n -e "# Usar uma imagem base do Ubuntu
FROM ubuntu:latest
# Atualizar a lista de pacotes e instalar o curl
RUN apt-get update && apt-get install -y curl
# Instalar o Node.js e o npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm
# Instalar o hardhat
RUN npm install -g hardhat
# Configurando hardhat para zksync e mumbai testnet
#RUN hardhat config --network zksync && \
#    hardhat config --network polygonmumbaitestnet && \
#    npm install @ethersproject/networks --save-dev && \
#    npm install @zksync/contracts@^0.4.0 && \
#    npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle chai @nomiclabs/hardhat-etherscan hardhat-gas-reporter && \
#    npm install @ethersproject/networks --save-dev
# Definir o diretório de trabalho
WORKDIR /app" > Dockerfile
sudo docker build -t ${image} .
sudo docker run -it --name hardhat --network=host ${image}
}

read -p "Create one new image with Docker/NodeJS/HardHat ? y/n " choice
if [ $choice == "y" ]; then
  read -p "You already have Docker installed? y/n " choice
  if [ $choice == "n" ]; then
  install_docker
  fi
  read -p "What the name of your image? " choice
  mkdir $choice && cd ./$choice &&  image="${choice}" && dockerfile
  docker build -t $choice .
  docker images
else
  read -p "You already have Docker installed? y/n " choice
  if [ $choice == "n" ]; then
  install_docker
  fi
dockerfile
fi

}
build
