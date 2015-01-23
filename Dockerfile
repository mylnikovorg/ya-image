FROM maven:3.2.5-jdk-7
#RUN echo "deb http://mirror.yandex.ru/debian/ jessie main\ndeb-src http://mirror.yandex.ru/debian/ jessie-updates main" >> /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y && apt-get install -y git

ADD PhantomJS /home/PhantomJS

#RUN ls /home

RUN chmod +x /home/PhantomJS

RUN /home/PhantomJS  
#RUN  apt-get install -y phantomjs

RUN cd /home && git clone https://github.com/camelot-framework/camelot-yandexer.git && cd camelot-yandexer

ADD yandexer.properties /home/camelot-yandexer/yandexer.properties

#RUN pwd && ls -l /home/camelot-yandexer

RUN cd /home/camelot-yandexer && mvn clean compile

#ENV MAVEN_OPTS="-XX:MaxPermSize=512m -Xmx2048m -Xbootclasspath/a:."
RUN export MAVEN_OPTS="-XX:MaxPermSize=512m -Xmx2048m -Xbootclasspath/a:."
RUN cd /home/camelot-yandexer && mvn clean compile camelot-test:run

EXPOSE 8080
