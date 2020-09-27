FROM registry.access.redhat.com/ubi8/ubi-minimal

WORKDIR /work/

COPY ./scripts/ /work
COPY target/*-runner /work/application

RUN chmod 775 /work

EXPOSE 8080
CMD ["./run.sh", "./application"]