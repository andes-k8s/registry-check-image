FROM alpine

COPY entrypoint.sh /

CMD ['./entrypoint.sh', $REGISTRY_URL, $IMAGE, $TAG]