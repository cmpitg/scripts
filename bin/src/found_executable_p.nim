import os, strutils

proc showHelp =
  var
    (_, thisApp) = getAppFilename().splitPath()
  echo """Usage: $1 <file>

Returns exit code 0 if the file is an executable and found in the PATH
environment variable and returns exit code 1 otherwise.""".format(thisApp)


if isMainModule:
  if paramCount() == 1 and paramStr(1) == "--help":
    showHelp()
    quit(0)
  elif paramCount() == 0:
    showHelp()
    quit(2)
  elif paramCount() != 1:
    echo "Invalid arguments."
    showHelp()
    quit(3)
  else:
    quit(if findExe(paramStr(1)) == "": 1 else: 0)
