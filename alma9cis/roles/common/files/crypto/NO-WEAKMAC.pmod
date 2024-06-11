# This is a subpolicy to disable weak macs
mac = -*-64
mac@SSH = -HMAC-MD5* -UMAC-64* -UMAC-128*
