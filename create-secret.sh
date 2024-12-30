#!/bin/bash

# Nombre del secreto
SECRET_NAME="exoplanets-local-secrets"

# Eliminar el secreto si ya existe
echo "Eliminando el secreto existente '$SECRET_NAME'..."
kubectl delete secret $SECRET_NAME --ignore-not-found

# Crear el secreto con las variables de entorno
echo "Creando el secreto '$SECRET_NAME'..."
kubectl create secret generic $SECRET_NAME \
  --from-literal=BASE_URL="https://gist.githubusercontent.com" \
  --from-literal=PATH_SEGMENT="/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe" \
  --from-literal=ENDPOINT_EXOPLANETS="/exoplanets"

echo "Secreto '$SECRET_NAME' creado exitosamente."
