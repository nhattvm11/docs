# Get Docker CE for Raspberry


### 1. Uninstall old versions

```shell
sudo apt remove docker docker-engine docker.io
```

### 1. SET UP THE REPOSITORY

```shell
sudo apt update
sudo apt install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

echo "deb [arch=armhf] https://download.docker.com/linux/debian \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
```    


### 2. INSTALL DOCKER CE

```shell
sudo apt update
sudo apt install docker-ce
```

Verify that Docker CE is installed correctly by running the `hello-world` image.

```
sudo docker run armhf/hello-world
```