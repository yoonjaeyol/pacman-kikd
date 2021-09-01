FROM k8s.gcr.io/kustomize/kustomize:v3.8.7

WORKDIR /workdir
RUN apk --update add git less openssh && rm -rf /var/lib/apt/lists/* && rm /var/cache/apk/*

CMD /bin/sh