#!/bin/bash
TREE='/usr/bin/tree'

sudo yum install epel-release -y
sleep 1s

sudo yum update -y
sleep 1s

sudo yum install easy-rsa openssl
sleep 2s

mkdir ~/easy-rsa
sleep 1s

ln -s /usr/share/easy-rsa/3/* ~/easy-rsa/
sleep 1s

$TREE ~/easy-rsa
sleep 1s

tput setaf 2;
echo " Alterando Permissões e Iniciando Diretório PKI";tput sgr0 
sleep 2s

chmod 700 /home/$USER/easy-rsa
cd ~/easy-rsa
sleep 1s

bash easyrsa init-pki

tput setaf 2;
echo "Criando o arquivo vars da CA";tput sgr0

sleep 1s

cat <<EOF >vars
set_var EASYRSA_REQ_COUNTRY    "BR"
set_var EASYRSA_REQ_PROVINCE   "SaoPaulo"
set_var EASYRSA_REQ_CITY       "Itapetininga"
set_var EASYRSA_REQ_ORG        "Estudo"
set_var EASYRSA_REQ_EMAIL      "sidney.o@outlook.com.br"
set_var EASYRSA_REQ_OU         "Community"
set_var EASYRSA_ALGO           "ec"
set_var EASYRSA_DIGEST         "sha512" "
EOF

tput setaf 2;
echo "Confira o arquivo vars";tput sgr0
cat vars

tput setaf 2;
echo "Agora vamos finalizar a construção da Autoridade Certicadora.
      Você deseja dar o build com senha ou sem a senha? 1-sem senha 2-com senha";tput sgr0
        read resposta;
        if [ "$resposta" = "1" ]; then
      	  tput setaf 2;
		      echo "Construir sem senha" 
		      echo "======================";tput sgr0
		      echo ""
          bash easyrsa build-ca nopass
	            else
 		            tput setaf 2;
 		            echo "Construir com senha"
 		            echo "======================";tput sgr0
		            echo ""
	            	bash easyrsa build-ca 
	      fi

cat ~/easy-rsa/pki/ca.crt
     
      
      
      
