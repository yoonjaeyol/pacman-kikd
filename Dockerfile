FROM registry.access.redhat.com/ubi8/openjdk-11

RUN ls -al /
RUN ls -al
RUN ls -al /home/jboss
RUN cd /workspace/source/target/
RUN ls -al

COPY target/*-runner.jar /deployments/
