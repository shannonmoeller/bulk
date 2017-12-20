# bulk

> Run the same command across several directories.

## Installation

```sh
export PATH="$PATH:~/bin"
curl https://raw.githubusercontent.com/shannonmoeller/bulk/master/bulk.sh > ~/bin/bulk
chmod +x ~/bin/bulk
```

## Usage

```
usage: bulk [options] [command]

options:
  -d    Subdirectory of each subdirectory in which to run the command.
  -e    Name of subdirectory to exclude.
  -i    Name of subdirectory to include.
```

## Examples

```
$ pwd
/Users/smoeller/example

$ tree -L 2

.
├── rainbow/
│   ├── .git/
│   └── readme.md
├── cake/
│   ├── .git/
│   └── readme.md
└── unicorn/
│   ├── .git/
│   └── readme.md

3 directories, 0 files

$ bulk pwd
./cake/ > pwd
/Users/smoeller/example/cake
./rainbow/ > pwd
/Users/smoeller/example/rainbow
./unicorn/ > pwd
/Users/smoeller/example/unicorn

$ bulk git config -l | grep url
remote.origin.url=git@github.com:smoeller-example/cake.git
remote.origin.url=git@github.com:smoeller-example/rainbow.git
remote.origin.url=git@github.com:smoeller-example/unicorn.git

$ bulk -d .git cat HEAD
./cake/.git > cat HEAD
ref: refs/heads/master
./rainbow/.git > cat HEAD
ref: refs/heads/staging
./unicorn/.git > cat HEAD
ref: refs/heads/develop

$ bulk -d .git -e rainbow cat HEAD
./cake/.git > cat HEAD
ref: refs/heads/master
./unicorn/.git > cat HEAD
ref: refs/heads/develop
```
