# This is a subpolicy to disable the chacha20-poly1305 ciphers
# for the SSH protocol (libssh and OpenSSH)
cipher@SSH = -CHACHA20-POLY1305
