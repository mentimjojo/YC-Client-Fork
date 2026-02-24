# YC-Client-Fork
This fork contains the library for the YC client to run on computercraft.

Additional features:
- Lots of bug fixes.
- Radio links support. (Radio stations for example like qmusic (dutch radio station))
- Streaming support. (Streams from Youtube, twitch, etc)

## Custom server
This server may or may not support video playback. If not just use --nv to disable video. Audio works good.

Installer: `wget run https://raw.githubusercontent.com/YC-Fork/YC-Client-Fork/main/installer.lua`



## CLI

Usage: `yc-fork-client [options] [URL or search term...]`

Arguments:
- `URL or search term` (optional): If omitted, the client will prompt interactively.

Options:
- `-v`, `--verbose`: Enable verbose output.
- `-V`, `--volume <0-300>`: Set audio volume (default `300`).
- `-s`, `--server <address>`: Force a specific server to use.
- `--nv`, `--no-video`: Disable video output. Note: video is always disabled in this fork.
- `--na`, `--no-audio`: Disable audio output.
- `--sh`, `--shuffle`: Shuffle playlist before playing.
- `-l`, `--loop`: Loop the current media item.
- `--lp`, `--loop-playlist`: Loop the current playlist.
- `--fps <number>`: Force Sanjuuni to use a specific frame rate.

# Hosting your own server
The server fork for this client fork.

https://github.com/YC-Fork/YC-Server-Fork
