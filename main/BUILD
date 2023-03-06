load("@rules_cc//cc:defs.bzl", "cc_binary")

# Read https://wiki.openssl.org/index.php/Compilation_and_Installation

cc_binary(
    name = "test",
    srcs = ["test.cc"],
    deps = ["@openssl//:openssl"],
)
