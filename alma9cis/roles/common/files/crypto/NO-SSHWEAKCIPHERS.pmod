# This is a subpolicy to disable weak ciphers
# for the SSH protocol (libssh and OpenSSH)
cipher@SSH = -3DES-CBC -AES-128-CBC -AES-192-CBC -AES-256-CBC -CHACHA20-POLY1305
