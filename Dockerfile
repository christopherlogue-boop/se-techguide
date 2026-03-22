FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY ehr-integration.html /usr/share/nginx/html/ehr-integration.html
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    sed -i 's/listen\s*80;/listen 8080;/' /etc/nginx/conf.d/default.conf
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
