# Registry Check Image

Verifica si una imagen existe en un registry determinado. En caso que exista el contenedor termina satisfactoriamente y en caso de error termina por error. Esta preparado para ser utilizado en drone.io para realizar un build condicional.

## Correr

Se necesitan 3 variables de entorno para correr el contenedor
  - REGISTRY_URL
  - IMAGE
  - TAG

```bash
export REGISTRY_URL=<url del registry>
export IMAGE=<nombre de la imagen en formato xxx/bbb>
export TAG=<etiqueta a probar si existe>

docker run orlandobrea/andes-check-image-exist
```

## Ejemplo de uso en drone.io

```yaml
---
kind: pipeline
type: docker
name: default

steps:
  - name: precheck
    image: orlandobrea/andes-check-image-exist:latest
    environment:
      REGISTRY_URL: new-docker-registry.192-168-0-8.nip.io:30443
      IMAGE: andes/api
      TAG: ${DRONE_BRANCH}-${DRONE_COMMIT_SHA}

  - name: build
    image: plugins/docker  
    when:
      status:
        - failure
    ...

```