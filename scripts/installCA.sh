#!/bin/bash
TREE='/usr/bin/tree'

sudo yum install epel-release -y && sudo yum update -y
sudo yum install easy-rsa openssl 
sleep 1s
mkdir ~/easy-rsa
ln -s /usr/share/easy-rsa/3/* ~/easy-rsa/
$TREE ~/easy-rsa
sleep 1s

tput setaf 2;
echo " Alterando Permissões e Iniciando Diretório PKI";tput sgr0 

chmod 700 /home/$USER/easy-rsa
cd ~/easy-rsa
sleep 1s

bash easyrsa init-pki

tput setaf 2;
echo "Criando o arquivo vars da CA";tput sgr0
echo "Digite a sigla do país BR - Brasil"
read pais
echo "Digite o nome estado"
read estado
echo "Digite o nome Cidade"
read cidade
echo "Digite o nome da Organização"
read organizacao
echo "Digite o email do SystemAdmin"
read email

sleep 1s

cat <<EOF >vars
set_var EASYRSA_REQ_COUNTRY    "$pais"
set_var EASYRSA_REQ_PROVINCE   "$estado"
set_var EASYRSA_REQ_CITY       "$cidade"
set_var EASYRSA_REQ_ORG        "$organizacao"
set_var EASYRSA_REQ_EMAIL      "$email"
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
     
      
      
      
