# http-filesend
A file-sharing tool that uses a ping tunnel. You run the script and select a file; the other party then enters the generated URL into their browser to download the file.

## Installing Fish
Debian:
```bash
sudo apt install fish
```

Fedora:
```bash
sudo dnf install fish
```

Arch Linux:
```bash
sudo pacman -S fish
```

## Installing ssh
Debian:
```bash
sudo apt install openssh-server
```

Fedora:
```bash
sudo dnf install openssh-server
```

Arch Linux:
```bash
sudo pacman -S openssh
```

## Installing busybox
Debian:
```bash
sudo apt install busybox
```

Fedora:
```bash
sudo dnf install busybox
```

Arch Linux:
```bash
sudo pacman -S busybox
```

## Usage

When you run it, the script will ask you to provide a file. You need to specify the path to the file.
Then, it uses BusyBox to start an HTTP server on port 8086, which it subsequently forwards via a pinggy tunnel.

You can access the file—for example, on localhost—at: http://127.0.0.1:8086/FILENAME
You need to append the filename to the URL.
If Pinggy provides a URL, you should do the same there—for example: https://pinggytunnel.io/FILENAME

(the other party won't be able to reach the localhost address (127.0.0.1). you need to share the pinggy url with them)