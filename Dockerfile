FROM registry.access.redhat.com/ubi8/openjdk-11

RUN pwd && ls
RUN cd /home/jboss
RUN ls -al

COPY target/*-runner.jar /deployments/
