FROM gradle:8.0.1-jdk11 as build
ARG NEXUS_USER
ARG NEXUS_PASS
COPY . /workspace
WORKDIR /workspace

RUN gradle test publish
