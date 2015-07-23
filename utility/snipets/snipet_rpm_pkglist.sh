#!/usr/bin/env bash
exit 0;

# create

rpm -qa --qf "%{NAME}\n" > pkg.list