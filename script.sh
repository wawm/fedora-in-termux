#!/bin/bash

yum install busybox -y && cd /sbin/ && ln -s /sbin/busybox clear && exit