FROM registry.access.redhat.com/ubi8/openjdk-11

RUN ls -al /
RUN ls -al
RUN ls -al /home/jboss
RUN ls -al /deployments
RUN ls -al

COPY target/*-runner.jar /deployments/
