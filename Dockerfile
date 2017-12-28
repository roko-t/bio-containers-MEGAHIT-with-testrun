# MEGAHIT on ubuntu 16.04
#
# VERSION    0.0.1

# Use ubuntu as a parent image
FROM ubuntu:16.04

MAINTAINER Hiroko Tanaka <hiroko@hgc.jp>


LABEL Description="MEGAHIT v1.1.2 with test data SRR341725" \
      Project="Genomon-Project Dockerization" \
      Version="1.0"
# Install required libraries in order to create MEGAHIT
# build-essential package : the set of developement tools (gcc,g++ e.t.c) 
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python \
    wget \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tools
RUN git clone https://github.com/voutcn/megahit.git \
 && cd /tools/megahit && make && make test && cd ..

# Download the data
RUN wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR341/SRR341725/SRR341725_[12].fastq.gz -P /tools/megahit/example_SRR341725 \
 && megahit/megahit -1 /tools/megahit/example_SRR341725/SRR341725_1.fastq.gz -2 /tools/megahit/example_SRR341725/SRR341725_2.fastq.gz -o /tools/megahit/example_SRR341725/SRR341725.megahit_asm

