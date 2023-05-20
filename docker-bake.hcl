variable "TAG" {
    default = "develop"
}

variable "REPOSITORY" {
    default = "ghcr.io"
}

group "default" {
    targets = [
        "substrate-based",
    ]
}

target "substrate-based" {
    dockerfile = "substrate-based/Containerfile"
    platforms = ["linux/amd64"]
    target = "substrate-based"
    tags = ["${REPOSITORY}/ci-containers/substrate-based:${TAG}"]
}
