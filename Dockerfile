FROM maven:3.2.5-jdk-7

RUN apt-get update && apt-get upgrade -y && apt-get install -y git

ADD pha pha

RUN ./pha

RUN git clone https://github.com/camelot-framework/camelot-yandexer.git && cd camelot-yandexer

ADD yandexer.properties yandexer.properties

RUN mvn clean compile

ENV MAVEN_OPTS="-XX:MaxPermSize=512m -Xmx2048m -Xbootclasspath/a:."

RUN mvn clean compile camelot-test:run

EXPOSE 8080
