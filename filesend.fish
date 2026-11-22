#!/usr/bin/env fish

if not type -q ssh
    echo "ssh is not installed."
    echo "Do you want to install it now? (On Debian-based systems)"
    read -P "[y/n]" sshyn
    if test "$sshyn" = "y"
        sudo apt update
        set update 1
        sudo apt install openssh-client
        or exit 1
    else
        echo "Please install ssh and try again."
        exit
    end
end

if not type -q busybox
    echo "busybox is not installed."
    echo "Do you want to install it now? (On Debian-based systems)"
    read -P "[y/n]" bbyn
    if test "$bbyn" = "y"
        if test -z "$update"
            sudo apt update
            set update 1
        end
        sudo apt install busybox
        or exit 1
    else
        echo "Please install busybox and try again."
        exit
    end
end

read -P "Enter the path to the file you want to send: (e.g., /home/user/file.txt) " filepath

if not test -f "$filepath"
echo "File does not exist. Please check the path and try again."
    exit
end
set file (realpath "$filepath")
echo "selected file: $file"
set tmpdir (mktemp -d)
cp -- "$file" "$tmpdir/"
echo "Starting HTTP server on port 8086..."
busybox httpd -f -p 127.0.0.1:8086 -h "$tmpdir" &
set spid $last_pid
sleep 1

if not kill -0 $spid 2>/dev/null
    echo "HTTP server failed to start."
    rm -rf -- "$tmpdir"
    exit 1
end

echo "HTTP server started successfully."
echo "Starting Pinggy tunnel..."
ssh -p 443 -R0:127.0.0.1:8086 free.pinggy.io

echo "Stopping HTTP server..."
kill $spid 2>/dev/null
wait $spid 2>/dev/null

rm -rf -- "$tmpdir"
echo "Done."