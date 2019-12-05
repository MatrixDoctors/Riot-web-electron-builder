# Riot-web-electron builder

This dockerfile creates an image that can be used to build the develop branch of [riot-web](https://github.com/vector-im/riot-web) with electron (also known as riot-desktop) for both linux and windows.

It may be possible to extend this for macOS, but this requires the use of a macOS device.

## Usage

To build for linux

`docker run --rm -v /path/to/riot/:/data mvgorcum/riotbuilder:latest linux`

To build for windows:

`docker run --rm -v /path/to/riot/:/data mvgorcum/riotbuilder:latest windows`

