FROM nginx:1.19.6
ENV DEBIAN_FRONTEND noninteractive
# COPY 20-envsubst-on-templates.sh /docker-entrypoint.d
COPY default.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]