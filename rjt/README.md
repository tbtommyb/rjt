# rjt

## Deployment notes

Server runs FreeBSD. GHC 8.4.3 doesn't work with FreeBSD, so had to revert to GHC 8.2.2 using LTS 11.23.

Make sure old version of Cabal is present:

```
$ stack install --resolver lts-9.21 cabal-install
$ cabal -V
# version 1.24
```

Pull latest from Github, remove any existing `stack.yaml` file. Then generate `stack.yaml` file:

```
$ stack init --resolver lts-11.22 --solver
```


Can set global resolver version:

```
$ stack config set resolver lts-11.22
```

Should now be able to build:

```
$ stack build rjt
```


Note that code currently expects `${pwd}/src` to be present. `-c` flag in init file (see below) means it's run at `/` so made a hacky symlink:

```
$ ln -s /usr/local/www/rjt/src/ /src
```

Should really pass in cwd as arg.

In `/usr/local/etc/rc.d/rjt` (in jail):

```
#!/bin/sh

# PROVIDE: rjt

. /etc/rc.subr

name="rjt"

rcvar=${name}_enable
pidfile="/var/run/${name}.pid"
command="/usr/local/www/rjt/rjt"
start_cmd="RJT_PASSWORD= /usr/sbin/daemon -c -P ${pidfile} ${command}"
load_rc_config $name
run_rc_command "$1"
```
