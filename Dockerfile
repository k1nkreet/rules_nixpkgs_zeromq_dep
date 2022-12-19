from ubuntu:18.04

run apt-get update
run apt-get install --no-install-recommends -y \
  bash-completion \
  openjdk-8-jdk-headless \
  g++ \
  git \
  patch \
  unzip \
  wget \
  zlib1g-dev \
  python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y bzip2 gnupg perl curl sudo xz-utils
RUN curl -L https://nixos.org/nix/install | /bin/sh /dev/stdin --daemon

RUN wget https://github.com/bazelbuild/bazel/releases/download/5.0.0/bazel-5.0.0-linux-x86_64
RUN cp bazel-5.0.0-linux-x86_64 /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

RUN wget https://github.com/fullstorydev/grpcurl/releases/download/v1.8.6/grpcurl_1.8.6_linux_x86_64.tar.gz && \
    tar xzvf grpcurl_1.8.6_linux_x86_64.tar.gz && \
    mv grpcurl /usr/local/bin/grpcurl

ENTRYPOINT [ ]
