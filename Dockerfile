FROM registry.access.redhat.com/ubi8/openjdk-11

RUN pwd && ls

COPY target/*-runner.jar /deployments/
