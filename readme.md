if you want of one image already with hardhat installed ignore the build and  
input only: docker pull defiminds/hardhat  
to clone the image and use in one container.  

Run Build to install docker and create one image with hardhat preconfigured  
then after make the image, the script start one container with npx,npm,hardhat  
latest version installed  To compile and build your projects or interact with others  

Create one secure container to use with defiminds/hardhat image to docker with this command:  
create first the network in bridge mode to use with container:  
```  
sudo docker network create --driver bridge --subnet=172.25.0.0/16 --gateway=172.25.0.1 hardhatnet  
```  
```  
sudo docker run -d --name hardhat --network hardhatnet --publish 80:80 --publish 443:443 --publish 8545:8545 --publish 30303:30303 --publish 7545:7545 --publish 8546:8546 --publish 8547:8547 --publish 3035:3035 --publish 8548:8548 --publish 3036:3036 --publish 3034:3034 --publish 3037:3037 --publish 3038:3038 --publish 3039:3039 --publish 3040:3040 --publish 3041:3041 --publish 3042:3042 --publish 3043:3043 --publish 3044:3044 --publish 3045:3045 --publish 3046:3046 --publish 3047:3047 --publish 3048:3048 --publish 3049:3049 --publish 3050:3050 --publish 3051:3051 --publish 3052:3052 --publish 3053:3053 --publish 3054:3054 --publish 3055:3055 --publish 3056:3056 --publish 3057:3057 --publish 3058:3058 --publish 3059:3059 --publish 3060:3060 --publish 3061:3061 --publish 3062:3062 --publish 3063:3063 --publish 3064:3064 --publish 3065:3065 --publish 3066:3066 --publish 3067:3067 --publish 3068:3068 --publish 3069:3069 --publish 3070:3070 --publish 3071:3071 --publish 3072:3072 --publish 3073:3073 --publish 3074:3074 --publish 3075:3075 --publish 3076:3076 --publish 3077:3077 --publish 3078:3078 --publish 3079:3079 --publish 3080:3080 --publish 3081:3081 --publish 3082:3082 --publish 3083:3083 --publish 3084:3084 --publish 3085:3085 --publish 3086:3086 --publish 3087:3087 --publish 3088:3088 --publish 3089:3089 --publish 3090:3090 --publish 3091:3091 --publish 3092:3092 --publish 3093:3093 --publish 3094:3094 --publish 3095:3095 --publish 3096:3096 --publish 3097:3097 --publish 3098:3098 --publish 3099:3099 --publish 3100:3100 --publish 3101:3101 --publish 3102:3102 --publish 3103:3103 --publish 3104:3104 --publish 3105:3105 --publish 3106:3106 --publish 3107:3107 --publish 3108:3108 --publish 3109:3109 --publish 3110:3110 --publish 3111:3111 --pids-limit 100 --cap-drop ALL defiminds/hardhat  
```  
```  
sudo docker exec -it hardhat sh  
```  
```  
# Docker installation:  
# Update the package index and install necessary dependencies  
  
sudo apt-get update && sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Add Docker's official GPG key  
  
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  
# Add the Docker repository to the apt sources list  
  
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"  
  
# Update the package index again and install Docker CE  
  
sudo apt-get update && sudo apt-get -y install docker-ce docker-ce-cli containerd.io  
  
```  

```
# Docker installation ubuntu:  
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg  
    
# Add Docker’s official GPG key:
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg  
# Use the following command to set up the repository:  
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null  
  sudo apt-get update && sudo chmod a+r /etc/apt/keyrings/docker.gpg && sudo apt-get update  
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
  ```
