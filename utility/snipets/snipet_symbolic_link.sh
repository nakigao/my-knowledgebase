#!/usr/bin/env bash
exit 0;

# create

`ln -s /path/to/target_dir /path/to/symbolic_dir`

# update

`ln -nfs /path/to/target_dir /path/to/symbolic_dir`

# delete

`unlink /path/to/target_dir`
