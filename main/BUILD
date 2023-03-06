load("@rules_cc//cc:defs.bzl", "cc_binary")

# Read https://wiki.openssl.org/index.php/Compilation_and_Installation

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    deps = ["@openssl//:openssl"],
)
