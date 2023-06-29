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
  tags       = ["${CONTAINER_REGISTRY}/substrate-based:${TAG}"]
  platforms  = ["linux/amd64"]
}

target "sccache" {
  dockerfile = "sccache/Containerfile"
  target     = "sccache"
  args = {
    SCCACHE_VERSION = "v0.5.4"
  }
  tags      = ["${CONTAINER_REGISTRY}/sccache:0.5.4"]
  platforms = ["linux/amd64"]
}
