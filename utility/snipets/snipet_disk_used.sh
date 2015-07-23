#!/usr/bin/env bash
exit 0;

du -h / | sort -nr | grep [0-9]G
du -h / | sort -nr | grep [0-9][0-9]M
