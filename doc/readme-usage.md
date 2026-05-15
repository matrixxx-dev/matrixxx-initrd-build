---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# initrd-build process
### brief description of the work steps
#### '01-scripts-build-initrd-busybox': <a name="build-initrd-busybox"/>
> [!CAUTION]
> The copilation of (complete) busybox does not work with any kernel!
> Linux kernel 6.8 removed a number of traffic control related symbols.
> Temporary workaround: the scripts remove `tc` from the build (for all kernels)

> [!NOTE]
> The current configuration of busybox is oversized for the matrixxx
> initramfs and could be much leaner. But this way there's plenty of room
> to experiment.

> [!TIP]
> To find a new version check `git branch -a` on repository level.
> If you found a new version you can adapt RELEASE_BRANCH="1_37_stable"
> in ./init to generate this new version.
> Otherwise jump to [02-scripts-build-initrd](#build-initrd) and use the
> saved version.

- **manually:** use a 32 bit system for compilation
- **execute:** 00-script-get-busybox-repository.sh
  - will only be executed if the kernel repository in this environment has
     not yet been cloned (creates the `build-initrd-busybox` directory with the
     kernel repository `busybox.git`)
- **manually:** adapt the init file with the desired 'RELEASE_BRANCH'
  - check the repository on new branches by `git branch -a`
  - please read the home page of [busybox](https://busybox.net/)
- **execute:** 00-script-set-busybox-repository-default.sh
  - sets up the git repository with the selected view (branch version)
- **execute:** 01-script-build-busybox\--transcription.sh
  - wrapper over `script-build-busybox.sh` to generate a transcription of the
    build output (used tool is `script`)
- **execute:** 02-script-build-busybox-pack.sh
  - generates a tar.xz file of the generated BusyBox structure
    - (can be copied to dir: archives as a basis for creating the initramfs)

********************************************************************************
#### '02-scripts-build-initrd': <a name="build-initrd"/>
- **manually:** populate the archives directory
  - tar files which contain the parts of the initramfs
    - busybox-install.tar.xz
    - initrd-matrixxx-init.tar.xz
    - initrd-matrixxx-structure.tar.xz
  - or include a initrd file (initrd.gz a gziped cpio-archiv)
- **manually:** check the configuration in the init file
- **execute:** 00-script-build-working-dir.sh
  - generates the basic output directory in which a working directory is created
  - unpacking files from archives directory in the working directory
- **execute:** 01-script-set-working-link.sh
  - create a working link to working directory
- **manually:**
  - update the content of the initramfs_version file in the working directory
  - customize the initrd to your own preferences.
- **execute:** 02-script-build_InitalRD.sh
  - build the new initramfs - a cpio archive (compressed with gzip)
    (directory 'new' contains the output)
- **execute:** 03-script-store-working-dir.sh
  - create TAR files for update the archive directory
    (splited versions of current release version)

********************************************************************************
