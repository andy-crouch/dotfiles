#!/usr/bin/env bash
# The bashrc.symlink file is symlinked to the ~/.bashrc file.
#
# The bashrc.symlink file is responsible for sourcing the various configuration
# files in the .dotfiles/bash/ sub-directory as well as other bash specific dot files.
#
# This file will source any dot file or any file prefixed with .bash, in addition
# any file suffixed with _hostname (where hostname is the value of $HOSTNAME) will
# also be sourced (useful for creating host specific versions of files).

# Add directive to prevent warnings from shellcheck for dynamic (non constant) file paths.
# shellcheck source=/dev/null

# Check for an interactive session and return if not in one.
[ -z "$PS1" ] && return

# Enable bash completion.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# Get the path for the parent directory for this script (handling symlinks).
script_source="${BASH_SOURCE[0]}"
while [ -h "$script_source" ]; do 
  script_dir="$( cd -P "$( dirname "$script_source" )" && pwd )"
  script_source="$(readlink "$script_source")"
  [[ $script_source != /* ]] && script_source="$script_dir/$script_source" 
done
bash_df_dir="$( cd -P "$( dirname "$script_source" )/bash_config" && pwd )"

# Search the .dotfiles/bash/ directory (2 levels deep) for . files to source.
bash_source_files=$(find "${bash_df_dir}" -maxdepth 2 -iname '.*' -a ! -iname '.bash*' | sort)

# Source files returned by the above query and check and source host specific files.
for bash_source_file in $bash_source_files
do
  machine_hostname=$(hostname)
  host_override_file="${bash_source_file}_${machine_hostname}"
  [[ -e "${bash_source_file}" && -r "${bash_source_file}" ]] && . "$bash_source_file"
  [[ -e "${host_override_file}" && -r "${host_override_file}" ]] && . "$host_override_file"
  unset host_override_file
done
unset bash_source_file


