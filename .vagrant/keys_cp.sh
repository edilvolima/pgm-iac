#!/bin/bash

rm -f ~/.ssh/known_hosts

# Declaração de um array associativo para armazenar os nomes das máquinas e seus IPs correspondentes
declare -A hosts=(
  ["artefatos"]="192.168.1.100"
  ["dados"]="192.168.1.101"
  ["k8s-tools-controlplane"]="192.168.1.102"
  ["k8s-tools-worker1"]="192.168.1.103"
  ["k8s-desenv-controlplane"]="192.168.1.104"
  ["k8s-desenv-worker1"]="192.168.1.105"
  ["k8s-desenv-worker2"]="192.168.1.106"
)

# Nome do usuário SSH. Substitua 'user' pelo nome do usuário apropriado.
USER="vagrant"

# Loop para copiar a chave pública para cada máquina
for name in "${!hosts[@]}"; do
  echo "Copiando chave privada do diretorio do Vagrant no Windows \n        para o projeto: máquina $name com IP ${hosts[$name]}..."

  # Copia do diretorio do Vagrant no Windows: C:/Vagrant
  cp -Rf /tmp/vagrant_machines/$name/virtualbox/private_key ./.vagrant/pgm_$name
  chmod 600 ./.vagrant/pgm_$name
  
  # Verificação de sucesso
  if [ $? -eq 0 ]; then
    echo "Chave privada copiada com sucesso"
  else
    echo "Erro ao copiar a chave privada."
  fi
done
