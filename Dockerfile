FROM alpine:3.10
RUN apk --no-cache add curl
RUN cd /bin && curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && chmod 755 kubectl
COPY install.sh /install.sh
ENTRYPOINT ["/install.sh"]
