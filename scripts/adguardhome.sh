#!/bin/bash
OK="\e[0;32mOK\e[0m"
ERR="\e[0;31mERRO\e[0m"


printf "\n"
printf " ##############################################\n"
printf " #      AdGuard Home + StevenBlack Lists      #\n"
printf " ##############################################\n"
printf "\n"

# =========================================
# Definir diretório de trabalho
# =========================================
WORK_DIR="$HOME/GitHub"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

printf " Baixando e descompactando o AdGuard Home"
wget -q https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz
tar -xzf AdGuardHome_linux_amd64.tar.gz > /dev/null 2>&1
rm AdGuardHome_linux_amd64.tar.gz
printf "$OK\n"

printf " Instalando o AdGuard Home"
cd AdGuardHome
sudo ./AdGuardHome -s install > /dev/null 2>&1
printf "$OK\n"

printf " Configurando o AdGuard Home como serviço systemd"
sudo systemctl enable AdGuardHome > /dev/null 2>&1
sudo systemctl start AdGuardHome
printf "$OK\n"

printf " Configurando DNS para utilizar o AdGuard Home"
sudo tee /etc/NetworkManager/conf.d/dns.conf > /dev/null <<EOL
[main]
dns=none
EOL

# Reiniciar o NetworkManager e ajustar o /etc/resolv.conf
sudo systemctl restart NetworkManager > /dev/null 2>&1
sudo tee /etc/resolv.conf > /dev/null <<EOL
nameserver 127.0.0.1
EOL
printf "$OK\n"

# Limpar e finalizar
cd ..
rm -rf AdGuardHome
printf "\nInstalação e configuração do AdGuard Home concluídas!\n"

# =========================================
# CONFIGURAÇÕES
# =========================================
ADGUARD_URL="http://127.0.0.1:3000"

# =========================================
# CREDENCIAIS
# =========================================
read -p "Usuário do AdGuard: " USER
read -s -p "Senha do AdGuard: " PASS
printf "\n\n"

# =========================================
# LOGIN E TOKEN
# =========================================
printf " -> Autenticando no AdGuard... "

TOKEN=$(curl -s -X POST "$ADGUARD_URL/control/login" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$USER\",\"password\":\"$PASS\"}" | jq -r '.token')

if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
  printf "$ERR\n"
  echo "Falha na autenticação. Verifique usuário/senha."
  exit 1
else
  printf "$OK\n"
fi

# =========================================
# FUNÇÃO PARA ADICIONAR LISTA
# =========================================
add_list () {
  NAME="$1"
  URL="$2"

  printf " -> Adicionando lista: $NAME ... "

  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$ADGUARD_URL/control/filtering/add_url" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "{
      \"name\": \"$NAME\",
      \"url\": \"$URL\"
    }")

  if [[ "$RESPONSE" == "200" ]]; then
    printf "$OK\n"
  else
    printf "$ERR (HTTP $RESPONSE)\n"
  fi
}

# =========================================
# LISTAS STEVENBLACK
# =========================================

add_list "StevenBlack - Unified hosts (adware + malware)" \
"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"

add_list "StevenBlack - Fakenews" \
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts"

add_list "StevenBlack - Gambling" \
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-only/hosts"

add_list "StevenBlack - Porn" \
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-only/hosts"

add_list "StevenBlack - Social" \
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/social-only/hosts"

printf "\n"
printf " Todas as listas foram processadas.\n"
printf "\n"

# =========================================
# FUNÇÃO PARA ADICIONAR OS PERMITIDOS
# =========================================
add_allow () {
  RULE="$1"

  printf " -> Allow: $RULE ... "

  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$ADGUARD_URL/control/filtering/add_allow_rule" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "{\"rule\": \"$RULE\"}")

  if [[ "$RESPONSE" == "200" ]]; then
    printf "$OK\n"
  else
    printf "$ERR (HTTP $RESPONSE)\n"
  fi
}

add_allow "@@||whatsapp.com^"
add_allow "@@||whatsapp.net^"

