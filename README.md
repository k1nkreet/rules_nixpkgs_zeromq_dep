This example demonstrates possible failure when using `rules_nixpkgs` for bringing external C/C++
shared library without changing the whole toolchain to the one provided by `rules_nixpkgs`

To reproduce I've provided Docker file with libc 2.27 coming from Ubuntu 18.04 and nix installed.

```bash
$ ./docker-shell.sh
root@f681174f7964:/workspace$ bazel build //:zmq_example
root@f681174f7964:/workspace$ ./bazel-bin/zmq_example
```

Output:
```
./bazel-bin/zmq_example: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by /root/.cache/bazel/_bazel_root/eab0d61a99b6696edb3d2aff87b585e8/execroot/__main__/bazel-out/k8-fastbuild/bin/_solib_k8/_U@zeromq_S_S_Czeromq___Ulib/libzmq.so.5)
./bazel-bin/zmq_example: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by /root/.cache/bazel/_bazel_root/eab0d61a99b6696edb3d2aff87b585e8/execroot/__main__/bazel-out/k8-fastbuild/bin/_solib_k8/_U@zeromq_S_S_Czeromq___Ulib/libzmq.so.5)
./bazel-bin/zmq_example: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by /root/.cache/bazel/_bazel_root/eab0d61a99b6696edb3d2aff87b585e8/execroot/__main__/bazel-out/k8-fastbuild/bin/_solib_k8/_U@zeromq_S_S_Czeromq___Ulib/libzmq.so.5)
./bazel-bin/zmq_example: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by /root/.cache/bazel/_bazel_root/eab0d61a99b6696edb3d2aff87b585e8/execroot/__main__/bazel-out/k8-fastbuild/bin/_solib_k8/_U@zeromq_S_S_Czeromq___Ulib/libzmq.so.5)
./bazel-bin/zmq_example: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by /nix/store/0s6mxy78gwhhcdjb3zwa7yy9ah8xfg1z-libsodium-1.0.18/lib/libsodium.so.23)
```

```
root@f681174f7964:/workspace$ ldd ./bazel-bin/zmq_example
linux-vdso.so.1 (0x00007fffba31b000)
libzmq.so.5 => /workspace/./bazel-bin/_solib_k8/_U@zeromq_S_S_Czeromq___Ulib/libzmq.so.5 (0x00007f1bd86b5000)
libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f1bd81f2000)
libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f1bd7e54000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1bd7a63000)
libsodium.so.23 => /nix/store/0s6mxy78gwhhcdjb3zwa7yy9ah8xfg1z-libsodium-1.0.18/lib/libsodium.so.23 (0x00007f1bd8655000)
librt.so.1 => /nix/store/lyl6nysc3i3aqhj6shizjgj0ibnf1pvg-glibc-2.34-210/lib/librt.so.1 (0x00007f1bd864e000)
libgcc_s.so.1 => /nix/store/lyl6nysc3i3aqhj6shizjgj0ibnf1pvg-glibc-2.34-210/lib/libgcc_s.so.1 (0x00007f1bd8634000)
/lib64/ld-linux-x86-64.so.2 (0x00007f1bd857b000)
libpthread.so.0 => /nix/store/lyl6nysc3i3aqhj6shizjgj0ibnf1pvg-glibc-2.34-210/lib/libpthread.so.0 (0x00007f1bd862f000)
```
The output of `LD_DEBUG=all ./bazel-bin/zmq_example` could be found in this repo
