---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# matrixxx-initrd-build
- This repository is primarily a shell script collection to generate a special
  initramfs for matrixxx (a D.I.Y linux live system)
  - scripts to generate a **customized busybox**
  - scripts to generate a **customized initramfs**
    (regardless of the kernel used)
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

#### briefly:
- see [readme: about][]
- see [readme: content][]
- see [readme: usage][]

#### links:
- home page of [busybox][]

#### license:
- *GNU GENERAL PUBLIC LICENSE* [[text]](LICENSE)

<!-- *********************************************************************** -->
[readme: about]: doc/readme-matrixxx.md
[readme: content]: doc/readme-content.md
[readme: usage]: doc/readme-usage.md

[busybox]: https://www.busybox.net/

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE
> AUTHOR CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE
> OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
> USE OF THIS SOFTWARE.
> YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.

********************************************************************************
> [!NOTE]
> All markdown files contain a `pandoc` specific extension:
> **yaml_metadata_block**. This block is displayed as a table by GitHub,
> but is useful (for me) for checking the appearance.

> [!NOTE]
> Regarding external links:
> This description may contain links to external websites operated by third
> parties, over which I have no control. Therefore, I cannot be held responsible
> for the content of these external websites. The sole responsibility for the
> content of these linked pages lies with the respective provider or operator.

********************************************************************************
