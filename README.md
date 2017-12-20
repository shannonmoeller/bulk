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
  -1    Print results on a single line.
  -d    Subdirectory of each subdirectory in which to run the command.
  -e    Name of subdirectory to exclude.
  -i    Name of subdirectory to include.
```

## Examples

```
/Users/smoeller/example $ tree -L 2
.
├── cake/
│   ├── .git/
│   └── readme.md
├── rainbow/
│   ├── .git/
│   └── readme.md
└── unicorn/
    ├── .git/
    └── readme.md

3 directories, 0 files

/Users/smoeller/example $ bulk pwd
./cake/ > pwd
/Users/smoeller/example/cake
./rainbow/ > pwd
/Users/smoeller/example/rainbow
./unicorn/ > pwd
/Users/smoeller/example/unicorn

/Users/smoeller/example $ bulk git config -l | grep url
remote.origin.url=git@github.com:smoeller-example/cake.git
remote.origin.url=git@github.com:smoeller-example/rainbow.git
remote.origin.url=git@github.com:smoeller-example/unicorn.git

/Users/smoeller/example $ bulk -d .git cat HEAD
./cake/.git > cat HEAD
ref: refs/heads/master
./rainbow/.git > cat HEAD
ref: refs/heads/staging
./unicorn/.git > cat HEAD
ref: refs/heads/develop

/Users/smoeller/example $ bulk -d .git -e rainbow -1 cat HEAD
./cake/.git > cat HEAD -> ref: refs/heads/master
./unicorn/.git > cat HEAD -> ref: refs/heads/develop
```
