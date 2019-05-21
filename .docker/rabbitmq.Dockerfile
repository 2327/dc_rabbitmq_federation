FROM rabbitmq:3.7-management-alpine

ARG TIMEZONE
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
    && date

RUN rabbitmq-plugins enable rabbitmq_federation_management
