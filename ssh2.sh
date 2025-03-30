#!/bin/bash

declare -A hosts=(
  ["artefatos"]="192.168.1.100"
  ["dados"]="192.168.1.101"
  ["desenvolvimento"]="192.168.1.102"
  ["monitoramento"]="192.168.1.103"
  ["orquestracaoControl"]="192.168.1.104"
  ["orquestracaoWorker1"]="192.168.1.105"
  ["orquestracaoWorker2"]="192.168.1.106"
)

USER="vagrant"

# Gerar chaves (se necessário)
for name in "${!hosts[@]}"; do
  if [ ! -f ~/.ssh/pgm_$name ]; then
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/pgm_$name -N "" -C "Chave para $name"
  fi
done

# Copiar chaves
for name in "${!hosts[@]}"; do
  echo "Copiando chave para $name (${hosts[$name]})..."
  ssh-copy-id -i ~/.ssh/pgm_$name $USER@${hosts[$name]}
  
  if [ $? -eq 0 ]; then
    echo "Sucesso em $name!"
  else
    echo "Erro em $name!"
  fi
done