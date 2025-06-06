# matrixxx-initrd-build
- This repository is primarily a shell script collection to generate a special
  initramfs for matrixxx (a D.I.Y linux live system)
  - scripts to generate a customized busybox
  - scripts to generate a customized initramfs (regardless of the kernel used)
- The result is an initramfs in the form of a gzip cpio file that can be
  started by the Linux kernel and can be controlled via kernel parameters
  - Including a 32-bit busybox executable with associated file structure
    and program softlinks
  - This initramfs is specialized to mount
    - the USB-Stick (or similar) on which the initramfs is located (boot device)
    - an 'union-mouted-filesystem' in overlay structure
      - consisting of a variety of writing-protected images (type of squasfs)
        and a layer above, which can be written
  - Furthermore, this initramfs is designed for (simple) remastering

## briefly about the matrixxx project:
- see [readme: matrixxx.md](./doc/readme-matrixxx.md)

## briefly about the initrd-build process and usage:
- see [readme: initrd-build process](./doc/readme-process.md)
- see [readme: usage](./doc/readme-usage.md)

#### links:
- home page of [busybox][]

<!-- *********************************************************************** -->
[busybox]: https://www.busybox.net/
