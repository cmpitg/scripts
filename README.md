# `~/bin`

This is a (not full) collection of my scripts residing at `~/bin/`.  I wrote
most but not all of them.

## License

Unless clearly stated, do whatever you want with them.  If you like me, buy me
a coffee :-).

## Description

* `functions` - Collection of some requently used SH functions.

* `i3-exec-command` - Execute an i3 command in
  [i3 window manager](http://i3wm.org/), in SH.

* `i3-switch-window` - Task switcher for
  [i3 window manager](http://i3wm.org/), in Python using `dzen`.

* `i3-move-to-workspace` - Move a window to a workspace in i3 window manager,
  in SH.

* `i3-to-workspace` - Switch to a workspace in i3 window manager, in SH.

* `i3-rename-workspace` - Rename a workspace in i3 window manager, in SH.

* `update-sbcl` - Check and update [SBCL](http://www.sbcl.org/), in Ruby.

* `rename-urt-demos` - Rename Urban Terror 4.1 demo files (upcase, reformat
  for better timestamp and map), in Python.

* `get-monitors` - Get `output mode rate` for all active monitors using
  `xrandr`, in Ruby.

* `github-repo-to-ssh` - Convert `git@` protocol to `git+ssh` which Mercurial
  understands, in Ruby.

* `set-default-monitor-config` - Basic multihead, in Ruby.

* `du-this` - Get disk usage for all files and directories residing in the
  current directory and sort them in descending order, in SH.

* `monitor-off` - Turn off monitor, in SH.

* `show-cpu-temp` - Show my laptap's 2 CPUs temperature, in SH.

* `run-ibus-daemon` - Run/restart iBus daemon, with Xim support, in SH.

* `run-xiki` - Fresh start Xiki (due to a bug at startup, Xiki needs to
  restart after the first run), in SH.

* `run-zsnes` - Run Zsnes emulator, in SH.

* `git-rm-orphaned` - Remove deleted files from Git cache, in SH.

* `firefox-beta` - Run Firefox beta, in SH.

* `firefox-beta-new-instance` - Run new instance of Firefox beta (Firefox is
  called with `no-remote`), in SH.

* `python-print-site-packages-path` - Print Python site packages path, in SH.

* `intel-adjust-brightness` - Adjust brightness with shell script, requires
  `ALL=NOPASSWD: /usr/bin/tee` in your `/etc/sudoers` (edited by `visudo`), in
  SH.

* `virtualenv-symlink` - Symlink Python
  [virtualenv](https://virtualenv.pypa.io/en/latest/), in SH.

* `count-monitors` - Count number of connected monitors, in SH.

* `extract-audio` - Extract from a video file, creating the same file name
  with appropriate extension, in SH with FFmpeg.

* `update-openjdk-8-font-patched` - Update OpenJDK 8 with font rendering patch
  from PPA
  [no1wantdthisname](https://launchpad.net/~no1wantdthisname/+archive/ubuntu/openjdk-fontfix),
  in [Rc shell](http://plan9.bell-labs.com/sys/doc/rc.html).

* `local-port-open-p <port>` - Check if a local port is open, returning 0 if it is
  and 1 otherwise, in SH.

* `sbcl-cmpitg-slime <port> ...` Start a SBCL Slime on a bunch of ports with Tmux;
  if called with no argument, use port 4005, in Rc shell.
