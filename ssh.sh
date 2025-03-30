#!/bin/bash

# Declaração de um array associativo para armazenar os nomes das máquinas e seus IPs correspondentes
declare -A hosts=(
  ["artefatos"]="192.168.1.100"
  ["dados"]="192.168.1.101"
  ["desenvolvimento"]="192.168.1.102"
  ["monitoramento"]="192.168.1.103"
  ["orquestracaoControl"]="192.168.1.104"
  ["orquestracaoWorker1"]="192.168.1.105"
  ["orquestracaoWorker2"]="192.168.1.106"
)

# Nome do usuário SSH. Substitua 'user' pelo nome do usuário apropriado.
USER="vagrant"

# Loop para copiar a chave pública para cada máquina
for name in "${!hosts[@]}"; do
  echo "Copiando chave pública para a máquina $name com IP ${hosts[$name]}..."

  # Comando para copiar a chave pública para o IP correspondente
  ssh-copy-id -i ~/.ssh/pgm_$name.pub $USER@${hosts[$name]}
  #ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@${hosts[$name]}
  
  # Verificação de sucesso
  if [ $? -eq 0 ]; then
    echo "Chave pública copiada com sucesso para $name (${hosts[$name]})."
  else
    echo "Erro ao copiar a chave pública para $name (${hosts[$name]}). Verifique a conexão SSH."
  fi
done


sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMhG1md3EnS6qGN59gTH4U5Qz6ETGoBo4h7Ac0yHk833 vagrant