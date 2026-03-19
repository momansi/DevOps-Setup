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

