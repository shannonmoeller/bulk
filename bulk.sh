#!/usr/bin/env bash
# bulk: Do the same thing in multiple places.
# Author: Shannon Moeller <me@shannonmoeller.com>
# vim: set filetype=sh:

# aliases
shopt -s expand_aliases && [[ -f ~/.bashrc ]] && . ~/.bashrc

# split
bulksplit() {
	# split arguments
	echo "$@" | tr -s "\n," "\n" | sed "s/\/$//" | sort -u
}

# variables
IFS=$'\n'
dir=$(bulksplit "$(ls -1)")
eol="\n"
sub=""
exc=""
inc=""

# get options
while getopts "1d:e:i:" opt; do
	case "$opt" in
		1) eol=" -> ";;
		d) sub="$OPTARG";;
		e) exc="$OPTARG";;
		i) inc="$OPTARG";;
	esac
done

# make argv useful again
shift $(( $OPTIND - 1 ))

# filter excludes
if [[ -n $exc ]]; then
	dir=$(comm -23 <(printf "%s\n" ${dir[@]}) <(bulksplit "$exc"))
fi

# filter includes
if [[ -n $inc ]]; then
	dir=$(comm -12 <(printf "%s\n" ${dir[@]}) <(bulksplit "$inc"))
fi

# command
com=$(printf " %q" "$@")

# execute
[[ -n $com ]] && printf "%q\n" ${dir[@]} | while read d; do
	d="$d/$sub"

	if [[ -d $d ]]; then
		printf "\e[0;1;34;40m./%q >\e[0;1;33m%s%b\e[0m" ${d%%/} $com $eol
		printf "%s\n" "$(cd $d && eval $com)"
	fi
done
