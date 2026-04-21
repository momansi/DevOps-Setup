## install vscode

sudo apt update
sudo apt install software-properties-common apt-transport-https wget -y

# Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

# Add repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Install VS Code
sudo apt update
sudo apt install code -y


code  # to open it


#######################################


## install git
sudo apt install git -y


# Configure GIT (IMPORTANT!!!)
# Set your identity (used in commits):
git config --global user.name "Muhammad Elmansi"
git config --global user.email "muhammad.elmansi7@gmail.com"

# Setup SSH for GitHub
# Generate SSH key:
ssh-keygen -t ed25519 -C "muhammad.elmansi7@gmail.com"

cat ~/.ssh/id_ed25519.pub      #  Add it to GitHub → Settings → SSH Keys

# Verify it
ssh -T git@github.com

#######################################

## install ansible

apt install ansible -y

# @ edge servers
useradd -m  -s /bin/bash ansible 
passwd ansible 

sudo visudo -f /etc/sudoers.d/ansible
    ansible ALL=(ALL:ALL) NOPASSWD: ALL
sudo chmod 440 /etc/sudoers.d/ansible


# @ Control Node
useradd -m  -s /bin/bash ansible 
passwd ansible 

sudo visudo -f /etc/sudoers.d/ansible
    ansible ALL=(ALL:ALL) NOPASSWD: ALL
sudo chmod 440 /etc/sudoers.d/ansible

ssh-keygen
ssh-copy-id -i ~/.ssh/id_ed25519.pub ansible@192.168.1.5

#######################################

## install docker

## uninstall all conflicting packages

sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# run docker without sudo
sudo usermod -aG docker $USER
newgrp docker

#######################################

## install minikube & kubectl

sudo apt update
sudo apt install -y curl wget apt-transport-https

wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

minikube start --driver=docker

minikube version

# enable auto complition for kubectl and minikube commands

# @ runtime
source <(kubectl completion bash)

# permanent
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'source <(minikube completion bash)' >> ~/.bashrc

minikube addons enable ingress      # enable ingress

#######################################

## install jenkins in docker container

docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --restart on-failure -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --user root jenkins/jenkins:lts

docker exec -it jenkins bash

#######################################

## install prometheus and grafana using helm (kube-prometheus-stack)

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create ns monitoring 

helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring

# access prometheus UI

kubectl port-forward service/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090

# access grafana UI
# username is admin and get password from this command 
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode

kubectl port-forward service/monitoring-grafana -n monitoring 8082:80

#######################################
