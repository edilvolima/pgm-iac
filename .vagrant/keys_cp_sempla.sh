#!/bin/bash

rm -f ~/.ssh/known_hosts

# Declaração de um array associativo para armazenar os nomes das máquinas e seus IPs correspondentes
declare -A hosts=(
  ["artefatos"]="10.98.12.63"
  ["dados"]="10.98.12.62"
  ["k8s-tools-controlplane"]="10.98.12.64"
  ["k8s-tools-worker1"]="10.98.12.61"
)

# Nome do usuário SSH. Substitua 'user' pelo nome do usuário apropriado.
USER="pgm_user"

# Loop para copiar a chave pública para cada máquina
for name in "${!hosts[@]}"; do
  echo "Copiando chave privada do diretorio do Vagrant no Windows \n        para o projeto: máquina $name com IP ${hosts[$name]}..."

  # Copia do diretorio do Vagrant no Windows: C:/Vagrant
  # cp -Rf /mnt/c/IAC/.vagrant/machines/$name/virtualbox/private_key ./.vagrant/pgm_$name
  ssh-copy-id -f $USER@${hosts[$name]}
  chmod 600 ./.vagrant/pgm_$name

  # Verificação de sucesso
  if [ $? -eq 0 ]; then
    echo "Chave privada copiada com sucesso"
  else
    echo "Erro ao copiar a chave privada."
  fi
done
