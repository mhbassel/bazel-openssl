load("@rules_foreign_cc//foreign_cc:defs.bzl", "configure_make", "configure_make_variant")

# Read https://wiki.openssl.org/index.php/Compilation_and_Installation

filegroup(
    name = "all_srcs",
    srcs = glob(
        include = ["**"],
        exclude = ["*.bazel"],
    ),
)

CONFIGURE_OPTIONS = [
    "no-comp",
    "no-idea",
    "no-weak-ssl-ciphers",
    "shared",
]

LIB_NAME = "openssl"

MAKE_TARGETS = [
    "build_libs",
    "install_dev",
    #"build_programs",
    #"install_sw",
]


config_setting(
    name = "clang_cl_compiler",
    flag_values = {
        "@bazel_tools//tools/cpp:compiler": "clang-cl",
    },
    visibility = ["//visibility:public"],
)

alias(
    name = "openssl",
    actual = select({
        ":clang_cl_compiler": "openssl_clang_cl",
        "//conditions:default": "openssl_default",
    }),
    visibility = ["//visibility:public"],
)

configure_make_variant(
    name = "openssl_clang_cl",
    build_data = [
        "@perl//:perl",
    ],
    configure_command = "Configure",
    configure_in_place = True,
    configure_options = CONFIGURE_OPTIONS + [
        # Target
        "VC-WIN64A",
        # Override environment variables set by higher-level Bazel targets.
        # Most importantly, set the C++ compiler to be `cl` (as opposed to 
        #`clang-cl`). We're unsure whether OpenSSL can be built using
        # clang-cl. 
        # TODO(#3): Investigate whether OpenSSL can
        # build with clang-cl.
        "CC=\"cl\"",
        "ASFLAGS=\"-g\"",
        "CFLAGS=\"/W3 /wd4090 /nologo /O2 /Zi /MP\"",
        "LDFLAGS=\"/nologo /debug /Zi\"",
        "ARFLAGS=\"/nologo\"",
        "LD=\"link\"",
    ],
    configure_prefix = "$PERL",
    env = {
        "PERL": "$(execpath @perl//:perl)",
    },
    lib_name = LIB_NAME,
    lib_source = ":all_srcs",
    out_static_libs = [
        "libssl.lib",
        "libcrypto.lib",
    ],
    targets = MAKE_TARGETS,
    toolchain = "@rules_foreign_cc//toolchains:preinstalled_nmake_toolchain",
)

configure_make(
    name = "openssl_default",
    configure_command = "config",
    configure_in_place = True,
    configure_options = CONFIGURE_OPTIONS,
    env = select({
        "@platforms//os:macos": {"AR": ""},
        "//conditions:default": {},
    }),
    lib_name = LIB_NAME,
    lib_source = ":all_srcs",
    # Note that for Linux builds libssl must be listed before
    # libcrypto on the linker command-line.
    out_static_libs = [
        "libssl.a",
        "libcrypto.a",
    ],
    targets = MAKE_TARGETS,
)

#configure_make(
#    name = "openssl",
#    configure_command = "Configure",
#    configure_in_place = True,
#    configure_options = CONFIGURE_OPTIONS,
#    lib_name = LIB_NAME,
#    lib_source = ":all_srcs",
#    # Note that for Linux builds, libssl must come before libcrypto on the linker command-line.
#    # As such, libssl must be listed before libcrypto
#    out_lib_dir = "lib",
##    out_shared_libs = ["libssl.so", "libcrypto.so",],
 #   targets = MAKE_TARGETS,
 #   visibility = ["//visibility:public"], 
#)
#
filegroup(
    name = "gen_dir",
    srcs = [":openssl"],
    output_group = "gen_dir",
    visibility = ["//visibility:public"],
)

