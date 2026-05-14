---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
### Content of matrixxx-initrd-build.git:
- **[dir]**
  **[01-scripts-build-initrd-busybox](#build-initrd-busybox)**
  - contains the scripts for busybox build
- **[dir]**
  **[02-scripts-build-initrd](#build-initrd)**
  - contains the scripts for initrd (resp. initramfs) build
- **[dir]** **archives**
  - contains the input for 02-scripts-build-initrd
- **[dir]** doc
  - contains additional readme files
- **[dir]** lib
  - contains some libraries of common script functions
- **[dir]**
 [scripts-extract-initrd](#extract-initrd)
  - contains a script for extraction existing initrd (resp. initramfs) files
- LICENSE
  - *GNU GENERAL PUBLIC LICENSE* [[text]](../LICENSE)
- README.md
  - *briefly description about the matrixxx-initrd-build.git*

********************************************************************************
#### Content of '01-scripts-build-initrd-busybox': <a name="build-initrd-busybox"/>
- 00-script-get-busybox-repository.sh
- 00-script-set-busybox-repository-default.sh
- 01-script-build-busybox\--transcription.sh
- 02-script-build-busybox-pack.sh
- init
- script-build-busybox.sh
- script-build-busybox\--transcription_show_result.sh
- script-get-c-libraries-repository.sh (*TODO*)
- XX-build-process.sh

********************************************************************************
#### Content of '02-scripts-build-initrd': <a name="build-initrd"/>
- 00-script-build-working-dir.sh
- 01-script-set-working-link.sh
- 02-script-build_InitalRD.sh
- 03-script-store-working-dir.sh
- init
- script-del-new-dir.sh
- script-del-working-link.sh

********************************************************************************
#### Content of 'scripts-extract-initrd': <a name="extract-initrd"/>
- **[dir]** originals
- **01-script-extract_InitRD.sh**
- init


