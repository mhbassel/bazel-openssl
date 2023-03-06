"""A module defining the third party dependency OpenSSL"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def openssl_repositories():
    maybe(
        http_archive,
        name = "openssl",
        build_file = Label("//openssl:BUILD.openssl.bazel"),
        sha256 = "9f54d42aed56f62889e8384895c968e24d57eae701012776d5f18fb9f2ae48b0",
        strip_prefix = "openssl-openssl-3.0.2",
        urls = [
		"https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.2.tar.gz",
        ],
    )

