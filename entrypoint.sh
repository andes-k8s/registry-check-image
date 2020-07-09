#!/bin/sh
# Este script verifica si una imagen existe en el registry
# En caso que no exista finaliza con error (exit 1)
# En caso que exista finaliza sin error (exit 0)
# Parametros:
#       - REGISTRY_URL: la URL del registry al cual consultar (Ej: https://regitry:5000)
#       - IMAGE: nombre de la imagen (Ej: andes/api)
#       - TAG: tag a consultar si existe (Ej: 1.2.3 / master-3123123124124)

set -e

if [[ -z "${REGISTRY_URL}" || -z "${IMAGE}" || -z "${TAG}" ]]; then
    echo "Faltan parametros para ejecutar el script. "
    echo "Variables necesarias: \n - REGISTRY_URL \n - IMAGE \n - TAG"
    exit 10
fi

if [[ "$REGISTRY_URL" =~ ^http.* ]]; then
    echo "Registry tiene protocolo: OK"
else
    echo "Registry tiene protocolo: NO - agregando https"
    REGISTRY_URL="https://$REGISTRY_URL"
fi


if test "$(curl --insecure --silent $REGISTRY_URL/v2/$IMAGE/tags/list -u admin:admin | jq . | grep $TAG -c)" -gt 0
then
    echo "Imagen existe"
    exit 0
else
    echo "Imagen no existe"
    exit 1
fi
