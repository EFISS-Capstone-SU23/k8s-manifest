sudo apt update
sudo apt upgrade

# ======== #
echo "Installing Dependencies..."
sudo apt install software-properties-common apt-transport-https wget hub -y
sudo apt install htop -y

# ======== #
echo "Installing Git..."
sudo apt install git -y

# ======== #
echo "Installing NodeJS and NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install 18
nvm use 18
nvm alias default 18

node -v

# ======== #
sudo apt-get update
sudo apt-get install \
   ca-certificates \
   curl \
   gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# ======== #
echo "Installing Docker Compose..."
sudo apt install docker-compose -y

# clone the repo
echo "Cloning the repo..."
git clone git@github.com:EFISS-Capstone-SU23/Dynamic-Crawler-Tool.git

# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

