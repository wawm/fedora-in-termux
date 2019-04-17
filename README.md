# fedora-in-termux
This is a script by which you can install Fedora in your termux application without rooted phone

# Includes Fedora 28 [arm, aarch64(arm64), x86_64, amd64]
# and
# Includes Fedora 29 [arm, aarch64(arm64), x86_64, amd64]

Steps
1. Update termux: apt-get update && apt-get upgrade -y
2. Install wget: apt-get install wget -y
3. Install proot: apt-get install proot -y
4. Install git: apt-get install git -y
5. Go to HOME folder: cd ~
6. Download script: git clone https://github.com/MFDGaming/fedora-in-termux.git
7. Go to script folder: cd fedora-in-termux
8. Give execution permission: chmod +x ubuntu.sh
9. Run script: ./fedora.sh {architecture}

For example: ./fedora.sh arm

11. Now just start fedora: ./start.sh
