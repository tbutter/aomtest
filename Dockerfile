FROM ubuntu

RUN apt update
RUN apt install -y cmake git perl yasm python clang curl
RUN git clone https://aomedia.googlesource.com/aom
WORKDIR /aom
RUN mkdir -p ../aom_build
WORKDIR /aom_build
RUN cmake /aom
RUN mkdir -p /aom_test_data
ENV LIBAOM_TEST_DATA_PATH=/aom_test_data
RUN make testdata
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]