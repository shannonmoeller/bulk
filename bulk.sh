#!/usr/bin/env bash
# bulk: Do the same thing in multiple places.
# Author: Shannon Moeller <me@shannonmoeller.com>

# aliases
shopt -s expand_aliases && [[ -f ~/.bashrc ]] && . ~/.bashrc

# split
bulksplit() {
	# split arguments
	echo "$@" | tr -s '\n,' '\n' | sed 's/\/$//' | sort -u
}

# variables
IFS=$'\n'
dir=$(bulksplit "$(ls -1)")
off=0
eol='\n'
sub=''
exc=''
inc=''

# get options
while getopts '1d:e:i:' opt; do case $opt in
	1) eol=' -> ';    (( off += 1 ));;
	d) sub="$OPTARG"; (( off += 2 ));;
	e) exc="$OPTARG"; (( off += 2 ));;
	i) inc="$OPTARG"; (( off += 2 ));;
	*) break;;
esac; done; OPTIND=1

# remove option arguments
(( $off > 0 )) && shift $off

# filter excludes
[[ -n $exc ]] && dir=$(comm -23 <(printf '%s\n' ${dir[@]}) <(bulksplit "$exc"))

# filter includes
[[ -n $inc ]] && dir=$(comm -12 <(printf '%s\n' ${dir[@]}) <(bulksplit "$inc"))

# command
com=$(printf ' %q' "$@")

# execute
[[ -n $com ]] && printf '%q\n' ${dir[@]} | while read d; do
	d="$d/$sub"
	if [[ -d $d ]]; then
		printf '\e[0;1;34m./%q\e[32m]\e[33m$%s%b\e[0m' $d $com $eol
		printf '%s\n' "$(cd $d && eval $com)"
	fi
done
