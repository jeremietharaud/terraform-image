FROM alpine:latest

ENV TERRAFORM_VERSION=0.11.14
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV PATH="~/.local/bin:${PATH}"

RUN apk add --update curl jq unzip coreutils python3 py3-pip && \
    pip3 install --upgrade pip awscli && rm /var/cache/apk/* && cd /tmp && \
    curl ${TERRAFORM_URL} > terraform.zip && unzip terraform.zip -d /usr/bin && \
	mkdir -p ~/.terraform.d/plugins/ && \
    curl $(curl -sL https://releases.hashicorp.com/terraform-provider-aws/index.json | \
    jq -r '.versions[].builds[].url' | egrep 'terraform-provider-aws_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | \
    sort -V | tail -1) > terraform-provider-aws.zip && unzip terraform-provider-aws.zip -d ~/.terraform.d/plugins/ && \
    curl $(curl -sL https://releases.hashicorp.com/terraform-provider-archive/index.json | \
    jq -r '.versions[].builds[].url' | egrep 'terraform-provider-archive_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | \
    sort -V | tail -1) > terraform-provider-archive.zip && unzip terraform-provider-archive.zip -d ~/.terraform.d/plugins/ && \
    curl $(curl -sL https://releases.hashicorp.com/terraform-provider-null/index.json | \
    jq -r '.versions[].builds[].url' | egrep 'terraform-provider-null_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | \
    sort -V | tail -1) > terraform-provider-null.zip && unzip terraform-provider-null.zip -d ~/.terraform.d/plugins/ && \
    curl $(curl -sL https://releases.hashicorp.com/terraform-provider-template/index.json | \
    jq -r '.versions[].builds[].url' | egrep 'terraform-provider-template_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | \
    sort -V | tail -1) > terraform-provider-template.zip && unzip terraform-provider-template.zip -d ~/.terraform.d/plugins/ && \
    curl $(curl -sL https://releases.hashicorp.com/terraform-provider-random/index.json | \
    jq -r '.versions[].builds[].url' | egrep 'terraform-provider-random_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | \
    sort -V | tail -1) > terraform-provider-random.zip && unzip terraform-provider-random.zip -d ~/.terraform.d/plugins/ && \
    rm -rf /tmp/*

WORKDIR /terraform