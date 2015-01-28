FROM maven:3.2.5-jdk-7

RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget telnet

#ADD JavaInstall /home/JavaInstall
#RUN chmod +x /home/JavaInstall
#RUN /home/JavaInstall



ADD phantom-js /home/phantom-js


RUN chmod +x /home/phantom-js

RUN /home/phantom-js

RUN rm /home/phantom-js



RUN cd /home && git clone https://github.com/yandex-qatools/camelot-yandexer.git
RUN rm -f /home/camelot-yandexer/yandexer.properties


#RUN cd /home/camelot-yandexer && mvn clean compile

RUN export MAVEN_OPTS="-XX:MaxPermSize=512m -Xmx2048m -Xbootclasspath/a:."

EXPOSE 8080 18082
