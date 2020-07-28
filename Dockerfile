FROM maven:3-jdk-8

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

#COPY settings.xml /usr/share/maven/ref/
ADD pom.xml /usr/src/app
COPY lib /tmp/lib

ADD . /usr/src/app
ADD ./src/test/java/karate-config.js /usr/src/app/src/test/java/karate-config.js

#RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml prepare-package -DskipTests
#RUN mvn verify clean
RUN mvn clean test -Dtest=SCP -B -X

#CMD ["/usr/src/app/maven_runner.sh"]