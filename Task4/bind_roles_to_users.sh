#!/bin/bash

# 1. developer -> editor
kubectl create rolebinding developer-editor \
  --role=editor \
  --user=developer \
  --namespace=default

# 2. auditor -> secret_keeper
kubectl create rolebinding auditor-secret-keeper \
  --role=secret_keeper \
  --user=auditor \
  --namespace=default

echo "Роли привязаны: developer=editor, auditor=secret_keeper"