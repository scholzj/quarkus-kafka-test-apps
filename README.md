# Kafka test applications

This repository contains simple clients which can be used for testing of Apache Kafka deployments. 
The clients are written using [Quarkus](https://quarkus.io/)
They are also dockerized and can be used in Kubernetes / OpenShift. See the [`deployment.yaml`](deployment.yaml) file as examples.

The [`deployment.yaml`](deployment.yaml) file contains a full deployment of Producer, Consumer and Topic definition for [Strimzi Topic Operator](http://strimzi.io). 
There are also additional variants for different authentication options. 
