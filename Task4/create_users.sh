#!/bin/bash

# Пользователь 1: developer (для группы "developers")
openssl genrsa -out developer.key 2048
openssl req -new -key developer.key -out developer.csr -subj "/CN=developer/O=developers"
openssl x509 -req -in developer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out developer.crt -days 365

# Пользователь 2: auditor (для группы "secret-readers")
openssl genrsa -out auditor.key 2048
openssl req -new -key auditor.key -out auditor.csr -subj "/CN=auditor/O=secret-readers"
openssl x509 -req -in auditor.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out auditor.crt -days 365

# Добавляем пользователей в kubeconfig
kubectl config set-credentials developer --client-certificate=developer.crt --client-key=developer.key
kubectl config set-credentials auditor --client-certificate=auditor.crt --client-key=auditor.key

echo "Пользователи созданы: developer (developers), auditor (secret-readers)"
