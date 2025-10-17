#!/bin/bash

# Configura o Ubuntu para máxima permissividade
# Específico para ambiente de desenvolvimento, principalmente em processadores arm64.

# Desabilitar AppArmor completamente
sudo systemctl stop apparmor
sudo systemctl disable apparmor
sudo aa-teardown

# Configurar umask mais permissivo globalmente
echo "umask 000" | sudo tee -a /etc/profile
echo "umask 000" | sudo tee -a /etc/bash.bashrc
echo "session optional pam_umask.so umask=000" | sudo tee -a /etc/pam.d/common-session

# Desabilitar firewall
sudo ufw disable

# Configurar limites do sistema mais altos
cat << 'EOF' | sudo tee -a /etc/security/limits.conf
* soft nofile 64000
* hard nofile 64000
* soft nproc 32000
* hard nproc 32000
EOF

# Configurar sysctl para ser mais permissivo
cat << 'EOF' | sudo tee -a /etc/sysctl.conf
fs.file-max = 2097152
fs.inotify.max_user_watches = 524288
fs.inotify.max_user_instances = 512
vm.max_map_count = 262144
net.core.somaxconn = 65535
EOF

sudo sysctl -p

echo "Setup completo! Faça logout e login novamente ou execute: source ~/.bashrc"
