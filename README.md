# FreeBSD port for OrcaCubic

__Note__: This is an unofficial port. It is not maintained or endorsed by the
OrcaCubic project or the FreeBSD Ports project.

The port is pinned to [OrcaCubic](https://github.com/marcodiniz/OrcaCubic/) commit
`822ae314016642d0ed2a362d38ebf15f03852300`. It fetches that source and
`wxInspector`, applies the FreeBSD changes from `files/`, and builds the GUI
application. No modified OrcaCubic source tree has to be copied along with the
port.

## Installing

Copy this whole directory to `/usr/ports/print/orcacubic` and run, as root:

```
cd /usr/ports/print/orcacubic
make install
```

The ports framework will fetch and install missing dependencies. This is a
large build; `make MAKE_JOBS_NUMBER=4 install` limits it to four jobs. The
source download can also take a while. On FreeBSD 13.5, whose release is no
longer supported by the current Ports tree, add `ALLOW_UNSUPPORTED_SYSTEM=yes`
to the make command.

This snapshot no longer builds or directly depends on OpenCV. PNG and JPEG
textures use libpng and libjpeg; the GUI uses its existing wxWidgets image
handlers for other supported formats, including BMP. OpenCascade still brings
in FreeImage indirectly on FreeBSD, so this does not remove every imaging
library from the complete dependency tree.

## Running it

OrcaCubic needs access to the graphics device nodes. Each user who runs it
must be a member of the `video` group. As root, add a user with:

```
pw groupmod video -m username
```

Log out and back in before starting OrcaCubic so the desktop session picks up
the new group membership.

Run `orcacubic` from a terminal or use the OrcaCubic entry in the applications
menu. The port deliberately does not install an `orca-slicer` command, so it
does not replace an existing OrcaSlicer installation. The application binary
and resources live under `/usr/local/libexec/OrcaCubic` (or the corresponding
path under a different ports prefix).

By default the launcher uses `~/.OrcaSlicer` for its data. If that directory
already contains `OrcaSlicer.conf`, the launcher refuses to start instead of
using an existing OrcaSlicer configuration. In that case, give OrcaCubic its
own directory:

```
orcacubic --datadir ~/.OrcaCubic
```

## Status

The application has been built and run on FreeBSD 13.5/amd64. Port fetch,
patch, configure, build, stage, `check-plist`, and package creation have been
checked. The final patch also applied cleanly to a separate fresh source
extraction. The port-built executable imports a test model, and the GUI
successfully imported a BMP-textured OBJ using an isolated test configuration.
This is a local port snapshot, not a FreeBSD Ports submission.

Kobra X LAN upload and print start have been tested with pre-engage disabled;
completion of a print has not been verified. The Kobra X camera stream is not
working yet. Please keep an eye on the printer during initial tests.
