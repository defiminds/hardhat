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
echo -ne -n -e "# Usar uma imagem base mínima e atualizada do Ubuntu
FROM ubuntu:20.04

# Atualizar a lista de pacotes e instalar o curl com suporte HTTPS
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y gnupg && \
    apt-get install -y ca-certificates && \
    apt-get install -y apt-transport-https && \
    rm -rf /var/lib/apt/lists/*

# Adicionar chaves de repositório do Node.js e adicionar fontes de pacote
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -

# Instalar o Node.js e o npm
RUN apt-get update && \
    apt-get install -y nodejs && \
    npm install -g npm && \
    rm -rf /var/lib/apt/lists/*

# Instalar o hardhat
RUN npm install -g hardhat

# Configurando hardhat para zksync e mumbai testnet
RUN npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle @nomiclabs/hardhat-etherscan hardhat-gas-reporter

# Crie um usuário não-root
RUN groupadd -r hardhat && useradd -r -g hardhat hardhat
USER hardhat

# Definir o diretório de trabalho
WORKDIR /app

# Limite as permissões de arquivo
RUN chmod 500 /app

# Execute o contêiner em um ambiente isolado
USER hardhat:nogroup
ENTRYPOINT ["hardhat"]" > Dockerfile
sudo docker build -t ${image} . --network=host
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
