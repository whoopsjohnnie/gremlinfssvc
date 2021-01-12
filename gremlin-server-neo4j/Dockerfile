FROM openjdk:8-alpine
# MAINTAINER gremlinorm <https://github.com/gremlin-orm>

RUN whoami

# ARG GREMLIN_VERSION=3.2.6
ARG GREMLIN_VERSION=3.3.7
# ARG GREMLIN_VERSION=3.4.2
# ARG GREMLIN_VERSION=3.3.11

# ARG BUILD_DATE
# ARG VCS_REF
# LABEL org.label-schema.build-date=$BUILD_DATE \
#       org.label-schema.vcs-ref=$VCS_REF \
#       org.label-schema.vcs-url="https://github.com/gremlin-orm/gremlin-orm-neo4j"

# https://archive.apache.org/dist/tinkerpop/3.3.7/apache-tinkerpop-gremlin-server-3.3.7-bin.zip
RUN apk add --update bash && rm -rf /var/cache/apk/* && \
     wget -O /tmp/gremlin-server.zip https://archive.apache.org/dist/tinkerpop/$GREMLIN_VERSION/apache-tinkerpop-gremlin-server-$GREMLIN_VERSION-bin.zip && \
     unzip /tmp/gremlin-server.zip -d / && \
     mv /apache-tinkerpop-gremlin-server-$GREMLIN_VERSION/ /gremlin-server/ && \
     chmod +x /gremlin-server/bin/gremlin-server.sh && \
     rm /tmp/gremlin-server.zip

# http://mirror.math.princeton.edu/pub/apache/tinkerpop/3.3.11/
# RUN apk add --update bash && rm -rf /var/cache/apk/* && \
#     wget -O /tmp/gremlin-server.zip http://mirror.math.princeton.edu/pub/apache/tinkerpop/$GREMLIN_VERSION/apache-tinkerpop-gremlin-server-$GREMLIN_VERSION-bin.zip && \
#     unzip /tmp/gremlin-server.zip -d / && \
#     mv /apache-tinkerpop-gremlin-server-$GREMLIN_VERSION/ /gremlin-server/ && \
#     chmod +x /gremlin-server/bin/gremlin-server.sh && \
#     rm /tmp/gremlin-server.zip

# WORKDIR /gremlin-server/

# RUN mkdir -p /.groovy/
RUN mkdir -p /root/.groovy/

# COPY grapeConfig.xml /.groovy/grapeConfig.xml
COPY grapeConfig.xml /root/.groovy/grapeConfig.xml

WORKDIR /gremlin-server/

# RUN /bin/bash -c "/gremlin-server/bin/gremlin-server.sh install org.apache.tinkerpop neo4j-gremlin $GREMLIN_VERSION-SNAPSHOT"

RUN /bin/bash -c "/gremlin-server/bin/gremlin-server.sh install org.apache.tinkerpop neo4j-gremlin $GREMLIN_VERSION"

COPY ./conf/gremlin-server-custom.yml /gremlin-server/conf/gremlin-server-custom.yml
COPY ./conf/neo4j.properties /gremlin-server/conf/neo4j.properties
COPY ./scripts/neo4j.groovy /gremlin-server/scripts/neo4j.groovy

CMD ["/bin/bash", "/gremlin-server/bin/gremlin-server.sh", "conf/gremlin-server-custom.yml", "-i", "init.groovy"]

EXPOSE 8182
