#!/bin/bash
# ACTION: Install Termiantor term and themes
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"


# INSTALL OPENOX AND DEPENDENCES
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y terminator

# INSTALL CONFIG
for d in /etc/skel/  /home/*/; do
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/terminator/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	
	cp -v "$base_dir"/config "$d/"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/config";
done