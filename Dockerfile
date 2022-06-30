FROM public.ecr.aws/bitnami/node:17 as webBuild
ARG REACT_APP_SERVER_URL
WORKDIR /tmp
COPY ./web ./web
WORKDIR /tmp/web
RUN npm install
RUN npm run build

FROM public.ecr.aws/bitnami/gradle:7 as serverBuild
WORKDIR /tmp
COPY ./server ./server
WORKDIR /tmp/server
COPY --from=webBuild /tmp/web/build /tmp/server/src/main/resources/public
RUN ./gradlew build -x test

FROM public.ecr.aws/docker/library/openjdk:19-jdk
COPY --from=serverBuild /tmp/server/build/libs/server-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE $PORT
CMD ["sh", "-c", "java -jar app.jar"]