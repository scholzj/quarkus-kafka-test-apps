FROM registry.access.redhat.com/ubi8/ubi-minimal

WORKDIR /work/

COPY ./scripts/ /work
COPY target/*-runner /work/application

RUN chmod 775 /work

EXPOSE 8080
CMD ["./run.sh", "./application"]
#FROM registry.fedoraproject.org/fedora-minimal
#
#RUN microdnf -y install libxcrypt-compat && microdnf clean all
#
#WORKDIR /work/
#
#COPY ./scripts/ /work
##COPY --from=jrebuilder /tmp/tls-libs/ /work/
#COPY target/*-runner /work/application
#
#RUN chmod 775 /work
#
#EXPOSE 8080
#
#CMD ["./run.sh", "./application -Djava.library.path=/work/lib -Djavax.net.ssl.trustStore=/work/cacerts -Dquarkus.http.host=0.0.0.0"]