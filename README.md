# Tools
Tools for Ethical Hacking / Penetration Testing

# Download & Install
rm -rf ~/eh-tools

#git config --global http.proxy $http_proxy

git clone https://github.com/lisandre33/eh-tools.git ~/eh-tools

chmod u+x ~/eh-tools/*.sh

cd ~/eh-tools

# Update configuration files
nano ~/eh-tools/config/IPs.txt

# Update git repository (restricted to contributors)
cd ~/eh-tools

git pull

#make your changes

git status

git add --all

git status

git commit -m "Commit comments"

git push origin master
