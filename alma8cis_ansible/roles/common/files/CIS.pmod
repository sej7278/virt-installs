# This is a subpolicy to disable weak macs
mac = -*-64*

# This is a subpolicy dropping the SHA1 hash and signature support
hash = -SHA1
sign = -*-SHA1
sha1_in_certs = 0

# This is a subpolicy to disable all CBC mode ciphers for the SSH protocol
cipher@SSH = -*-CBC
