variable "TAG" {
  default = "develop"
}

variable "CONTAINER_REGISTRY" {
  default = "ghcr.io/thxnet/ci-containers"
}

group "default" {
  targets = [
    "substrate-based",
    "sccache",
  ]
}

target "substrate-based" {
  dockerfile = "substrate-based/Containerfile"
  target     = "substrate-based"
  contexts = {
    sccache = "target:sccache"
    ubuntu  = "docker-image://docker.io/library/ubuntu:22.04"
  }
  args = {
    RUST_NIGHTLY_TOOLCHAIN = "2022-11-16"
  }
  tags      = ["${CONTAINER_REGISTRY}/substrate-based:${TAG}"]
  platforms = ["linux/amd64"]
}

target "sccache" {
  dockerfile = "sccache/Containerfile"
  target     = "sccache"
  contexts = {
    alpine     = "docker-image://docker.io/library/alpine:3.18"
    distroless = "docker-image://gcr.io/distroless/cc-debian11:latest"
  }
  args = {
    SCCACHE_VERSION = "v0.5.4"
  }
  tags      = ["${CONTAINER_REGISTRY}/sccache:0.5.4"]
  platforms = ["linux/amd64"]
}
