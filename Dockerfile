FROM java:8-jre

ENV PRESTO_VERSION 0.164
ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz presto-server.tar.gz

RUN apt-get update && \
  apt-get install -yf python && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  mkdir /opt/presto && \
  tar xf presto-server.tar.gz -C /opt/presto --strip-components=1 && \
  rm presto-server.tar.gz

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar /usr/local/bin/presto

RUN chmod a+x /usr/local/bin/presto

EXPOSE 8080

ENTRYPOINT ["/opt/presto/bin/launcher", "run"]
