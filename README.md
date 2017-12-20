# bulk

> Run the same command across several directories.

# Usage

```
usage: bulk [command]
```

# Examples

```sh
$ pwd
/Users/smoeller/example

$ tree -L 1

.
┣━ rainbow/
┣━ cake/
┗━ unicorn/

3 directories, 0 files

$ bulk pwd
cake/ $ pwd
/Users/smoeller/example/cake
rainbow/ $ pwd
/Users/smoeller/example/rainbow
unicorn/ $ pwd
/Users/smoeller/example/unicorn

$ bulk git config -l | grep url
remote.origin.url=git@github.com:smoeller-example/cake.git
remote.origin.url=git@github.com:smoeller-example/rainbow.git
remote.origin.url=git@github.com:smoeller-example/unicorn.git
```
