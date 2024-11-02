# dumb-os &nbsp; [![bluebuild build badge](https://github.com/coolingtool/dumb-os/actions/workflows/build.yml/badge.svg)](https://github.com/coolingtool/dumb-os/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository.

This is my personal OS image for the HP OMEN X16 (`HP OMEN by HP Laptop 16-b0xxx`).
It doesn't have any crazy customizations so far except things I stole from [Bluefin](https://projectbluefin.io/) and [Bazzite](https://bazzite.gg/).
I don't know how to build images locally so instead I rely on [github.dev](https://github.dev/CoolingTool/dumb-os) and test everything on the main GitHub action.
I wouldn't recommend running this image yourself.

# Secure Boot
It was as easy as having Secure Boot enabled in the bios, running `ujust enroll-secure-boot-key` in Console and following the instructions.
I can't test that again though cause the "Clear all Secure Boot keys" button in BIOS doesn't seem to do anything.

NOTE: I've added the DKMS module [acpi_ec](https://github.com/saidsay-so/acpi_ec) to add support for the [omen-fan](https://github.com/alou-S/omen-fan) script. You will have to have secure boot disabled for now to use that script till I find a way to handle signing. (I don't understand how module signing works at all)

## ISO

You can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). Replace `octocat` with `coolingtool` and `weird-os` with `dumb-os`. It should look like this:
```
# iso command:
mkdir ./iso-output
sudo podman run --rm --privileged --volume ./iso-output:/build-container-installer/build --security-opt label=disable --pull=newer \
ghcr.io/jasonn3/build-container-installer:latest \
# iso config:
IMAGE_REPO=ghcr.io/coolingtool \
IMAGE_NAME=dumb-os \
IMAGE_TAG=latest \
VARIANT=Silverblue # should match the variant your image is based on
```

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/coolingtool/dumb-os:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/coolingtool/dumb-os:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/coolingtool/dumb-os
```
