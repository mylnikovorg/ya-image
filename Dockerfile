FROM maven:3.2.5-jdk-7
#FROM ubuntu:14.04



RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget

#ADD JavaInstall /home/JavaInstall
#RUN chmod +x /home/JavaInstall
#RUN /home/JavaInstall

#RUN apt-get remove -y maven2 && echo "deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" >>/etc/apt/sources.list && apt-get update &&  apt-get install -y --force-yes maven3 && sudo ln -s /usr/share/maven3/bin/mvn /usr/bin/mvn 


ADD PhantomJS /home/PhantomJS


RUN chmod +x /home/PhantomJS

RUN /home/PhantomJS  

ENV JAVA_HOME /home/jdk1.7.0_76/jre


RUN cd /home && git clone https://github.com/yandex-qatools/camelot-yandexer.git && cd camelot-yandexer

RUN ls -l /home/camelot-yandexer

ADD yandexer.properties /home/camelot-yandexer/yandexer.properties

RUN cat /home/camelot-yandexer/yandexer.properties



RUN cd /home/camelot-yandexer && mvn clean compile

RUN ls -l /home/camelot-yandexer


RUN export MAVEN_OPTS="-XX:MaxPermSize=512m -Xmx2048m -Xbootclasspath/a:."
CMD cd /home/camelot-yandexer && mvn clean compile camelot-test:run 

EXPOSE 8080 18082
