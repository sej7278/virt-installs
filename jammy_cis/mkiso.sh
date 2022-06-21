#!/bin/sh

touch meta-data
cloud-localds seed.iso user-data meta-data
rm meta-data
