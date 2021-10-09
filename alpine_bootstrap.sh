#!/usr/bin/env bash

# Set bash to exit on error
set -e

# Install all needed apks
echo "apk add zsh git curl ncurses python3"

# Request a username to use with the node, defaults to `k8s`
read -p "Creating new user, input name [k8s]: " NEWUSER

if [ -z ${NEWUSER} ]; then
	NEWUSER=k8s;
fi

# Add the new user with matching group
echo "addgroup -S $NEWUSER && adduser -S $NEWUSER -G $NEWUSER -s /bin/zsh"

# Add user to sudoers
echo "Adding user $NEWUSER to sudoers"
echo "echo \"$NEWUSER ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/$NEWUSER && chmod 0440 /etc/sudoers.d/$NEWUSER"

# Become the user
echo "su $NEWUSER"

# Install ohmyzsh for a nicer experience in the terminal
echo "Installing ohmyzsh"
echo "sh -c \"$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""

echo "Node is ready for initializing k3s"
