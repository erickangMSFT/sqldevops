FROM nginx:alpine

WORKDIR /etc/nginx/conf.d
COPY ./default.conf ./default.conf

EXPOSE 6000

CMD ["nginx", "-g", "daemon off;"]