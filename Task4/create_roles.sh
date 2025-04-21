#!/bin/bash

# 1. viewer (только чтение)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: viewer
  namespace: default
rules:
- apiGroups: ["", "apps", "batch"]
  resources: ["pods", "deployments", "services", "jobs"]
  verbs: ["get", "list", "watch"]
EOF

# 2. editor (чтение + запись)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: editor
  namespace: default
rules:
- apiGroups: ["", "apps", "batch"]
  resources: ["pods", "deployments", "services", "jobs"]
  verbs: ["get", "list", "watch", "create", "update", "delete"]
EOF

# 3. secret_keeper (чтение логов + доступ к тестовому окружению)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: secret_keeper
  namespace: default
rules:
- apiGroups: [""]
  resources: ["secrets", "pods/log"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list"]  # Ограниченный доступ к deployments
EOF

# 4. admin (полный доступ в Namespace)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: admin
  namespace: default
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
EOF

# 5. cluster-admin (полный доступ ко всему кластеру)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
EOF

echo "Роли созданы: viewer, editor, secret_keeper, admin, cluster-admin"