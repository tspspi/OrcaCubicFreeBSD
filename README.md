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

## Running it

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
patch, and configure were checked. Staging and packaging were checked using
an already-built binary; a complete build from a fresh port work directory
has not yet been run. This is a local port snapshot, not a FreeBSD Ports
submission.

Kobra X LAN upload and print start have been tested with pre-engage disabled;
completion of a print has not been verified. The Kobra X camera stream is not
working yet. Please keep an eye on the printer during initial tests.
