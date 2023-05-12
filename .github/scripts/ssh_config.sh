#!/usr/bin/env bash
mkdir -p ~/.ssh
touch ~/.ssh/id_rsa
echo "${RSA_KEY}" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
ssh-keyscan 47.93.230.57 >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub