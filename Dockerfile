FROM maven:3.8.6-jdk-8 as builder

WORKDIR /app

COPY src ./src
COPY pom.xml ./pom.xml

RUN mvn -e -B package

FROM tomcat:8.5
COPY --from=builder /app/target/demo.war /usr/local/tomcat/webapps/demo.war

RUN echo "export JAVA_OPTS=\"-Dapp.env=staging\"" > /usr/local/tomcat/bin/setenv.sh

EXPOSE 8080

CMD ["catalina.sh", "run"]
