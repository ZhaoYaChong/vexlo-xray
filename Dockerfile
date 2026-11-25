FROM alpine:3.21
RUN apk add --no-cache curl unzip ca-certificates \
  && curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.3.27/Xray-linux-64.zip \
  && unzip /tmp/xray.zip -d /usr/local/bin/ \
  && chmod +x /usr/local/bin/xray \
  && rm /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
