FROM docker.elastic.co/logstash/logstash:7.9.0
USER root
RUN yum update -y && yum install -y ImageMagick-devel
COPY logstash/plugins/dist/filter-tainacan-submission-stable.gem /filter-tainacan-submission-stable.gem
RUN logstash-plugin install /filter-tainacan-submission-stable.gem
USER 1000
