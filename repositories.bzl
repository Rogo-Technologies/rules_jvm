load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//java/private:zip_repository.bzl", "zip_repository")
load("//third_party:protobuf_version.bzl", "PROTOBUF_VERSION")

def contrib_rules_jvm_deps():
    # We need the latest version of `rules_license`, but many of our deps pull in an older version
    maybe(
        http_archive,
        name = "rules_license",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
            "https://github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
        ],
        sha256 = "26d4021f6898e23b82ef953078389dd49ac2b5618ac564ade4ef87cced147b38",
    )

    maybe(
        http_archive,
        name = "apple_rules_lint",
        strip_prefix = "apple_rules_lint-0.4.0",
        sha256 = "483ea03d73d5fb33275d029da8d36811243fc32dfa4dc73a43acbb6f4b1af621",
        url = "https://github.com/apple/apple_rules_lint/releases/download/0.4.0/apple_rules_lint-0.4.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "1f21e46909fc5ed9e5c9a78d3c5f6a6fc1b3bb4a0f5b0f043c4070fd279e95d1",
        url = "https://github.com/bazelbuild/bazel-skylib/releases/download/1.8.1/bazel-skylib-1.8.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "75be42bd736f4df6d702a0e4e4d30de9ee40eac024c4b845d17ae4cc831fe4ae",
        strip_prefix = "protobuf-{}".format(PROTOBUF_VERSION),
        urls = ["https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(PROTOBUF_VERSION)],
    )

    # The `rules_java` major version is tied to the major version of Bazel that it supports,
    # so this is different from the version in the MODULE file.
    major_version = native.bazel_version.partition(".")[0]
    if major_version == "5":
        maybe(
            http_archive,
            name = "rules_java",
            urls = [
                "https://github.com/bazelbuild/rules_java/releases/download/5.5.1/rules_java-5.5.1.tar.gz",
            ],
            sha256 = "73b88f34dc251bce7bc6c472eb386a6c2b312ed5b473c81fe46855c248f792e0",
        )

    elif major_version == "6":
        maybe(
            http_archive,
            name = "rules_java",
            urls = [
                "https://github.com/bazelbuild/rules_java/releases/download/6.5.2/rules_java-6.5.2.tar.gz",
            ],
            sha256 = "16bc94b1a3c64f2c36ceecddc9e09a643e80937076b97e934b96a8f715ed1eaa",
        )

    else:
        maybe(
            http_archive,
            name = "rules_java",
            urls = [
                "https://github.com/bazelbuild/rules_java/releases/download/8.16.1/rules_java-8.16.1.tar.gz",
            ],
            sha256 = "1b30698d89dccd9dc01b1a4ad7e9e5c6e669cdf1918dbb050334e365b40a1b5e",
        )

    maybe(
        zip_repository,
        name = "contrib_rules_jvm_deps",
        path = "@contrib_rules_jvm//java/private:contrib_rules_jvm_deps.zip",
    )

    # This is required by `rules_jvm_external`
    maybe(
        http_archive,
        name = "bazel_features",
        sha256 = "2cd9e57d4c38675d321731d65c15258f3a66438ad531ae09cb8bb14217dc8572",
        strip_prefix = "bazel_features-1.20.0",
        url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.20.0/bazel_features-v1.20.0.tar.gz",
    )

    # Required by the frozen deps as this is referenced from the build file in the zips we ship
    maybe(
        http_archive,
        name = "rules_shell",
        sha256 = "a5cab01dea5779d97815ad5ab67df33e7d6be4f02b4f0d59b3a5c7e01fa20d1f",
        strip_prefix = "rules_shell-0.6.0",
        url = "https://github.com/bazelbuild/rules_shell/releases/download/v0.6.0/rules_shell-v0.6.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_jvm_external",
        sha256 = "4146faa4755de4a24103f26f93693a9efb7eab91a80a8b5b8e1a06ff67e72c0a",
        strip_prefix = "rules_jvm_external-6.7",
        url = "https://github.com/bazel-contrib/rules_jvm_external/releases/download/6.7/rules_jvm_external-6.7.tar.gz",
    )

def contrib_rules_jvm_gazelle_deps():
    io_grpc_grpc_java()

    http_archive(
        name = "googleapis",
        sha256 = "9d1a930e767c93c825398b8f8692eca3fe353b9aaadedfbcf1fca2282c85df88",
        strip_prefix = "googleapis-64926d52febbf298cb82a8f472ade4a3969ba922",
        urls = [
            "https://github.com/googleapis/googleapis/archive/64926d52febbf298cb82a8f472ade4a3969ba922.zip",
        ],
    )

    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "7dfe96c4816e8e29715a0988b5edcaa6f7c0e17ebaf9b92ad4ecfb3fa4bcac8a",
        url = "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.42.0/bazel-gazelle-v0.42.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "com_github_bazelbuild_buildtools",
        sha256 = "061472b3e8b589fb42233f0b48798d00cf9dee203bd39502bd294e6b050bc6c2",
        strip_prefix = "buildtools-7.1.0",
        url = "https://github.com/bazelbuild/buildtools/archive/refs/tags/v7.1.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "f7a2bb7abdb0c9ff0c6e0c29f2a84b41f9f7d8be88f2dde8fdb0b12e8c2e94e3",
        url = "https://github.com/bazelbuild/rules_go/releases/download/v0.52.0/rules_go-v0.52.0.zip",
    )

    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "303e86e722a520f6f326a50b41cfc16b98fe6d1955ce46642a5b7a67c11c0f5d",
        strip_prefix = "rules_proto-7.0.2",
        url = "https://github.com/bazelbuild/rules_proto/releases/download/7.0.2/rules_proto-7.0.2.tar.gz",
    )

    # We need to expand the contents of `@rules_proto//proto:repositories.bzl" here so
    # we can continue the two-step initialisation process
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "2df25bb76bd0d539b3e6c35eb6a15a5fc39e2c22bb1cddb7adc14a4f7b3badb5",
        strip_prefix = "rules_cc-0.1.1",
        url = "https://github.com/bazelbuild/rules_cc/releases/download/0.1.1/rules_cc-0.1.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "eb88a3b0cbf23cf83e73d29f2cdb4c9e08c1ab945c18e34f0db4eb58e17ea1ce",
        strip_prefix = "rules_python-1.5.4",
        url = "https://github.com/bazelbuild/rules_python/releases/download/1.5.4/rules_python-1.5.4.tar.gz",
    )

    # And other repos we need, apparently

    maybe(
        http_archive,
        name = "bazel_features",
        sha256 = "2cd9e57d4c38675d321731d65c15258f3a66438ad531ae09cb8bb14217dc8572",
        strip_prefix = "bazel_features-1.20.0",
        url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.20.0/bazel_features-v1.20.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/1.0.1/rules_pkg-1.0.1.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/1.0.1/rules_pkg-1.0.1.tar.gz",
        ],
        sha256 = "d20c951960ed77cb7b341c2a59488534e494d5ad1d30c4818c736d57772a9fef",
    )

def io_grpc_grpc_java():
    maybe(
        http_archive,
        name = "io_grpc_grpc_java",
        sha256 = "29a5732d5a93cbccfa8f46d59c67c549c26d66ee0498a4be07ac99df09e88620",
        strip_prefix = "grpc-java-1.71.0",
        patch_args = ["-p1"],
        patches = ["//third_party:grpc-java.patch"],
        urls = ["https://github.com/grpc/grpc-java/archive/v1.71.0.tar.gz"],
    )
