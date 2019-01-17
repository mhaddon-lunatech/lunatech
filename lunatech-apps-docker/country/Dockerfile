FROM store/oracle/serverjre:8
WORKDIR /app
COPY countries-assembly-1.0.1.jar ./
EXPOSE 8080
CMD ["/usr/bin/java", "-jar","countries-assembly-1.0.1.jar"]