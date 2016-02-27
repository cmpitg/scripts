import os, strutils, lists

type ExeProg = tuple[exe: string, prog: string]


proc showHelp =
  let (_, thisApp) = getAppFilename().splitPath()
  echo """Usage: $1 <file>

Reports missing software by checking if their corresponding executables exist.
If all executables are found, exit with status 0; otherwise, exit with status
1.

E.g.

  $1 aria2c Aria2 wget Wget
    # aria2c and wget not found
    # Make sure you have Aria2 and Wget installed

  $1 aria2c Aria2 wget Wget curl cURL
    # aria2c, curl, and wget not found
    # Make sure you have Aria2, Wget, and cURL installed

  $1 aria2c Aria2 wget
    # Invalid arguments.  Number of arguments must be even.
""".format(thisApp)


#
# Determines if an executable is found in your `PATH` environment variable.
#
proc foundExe(exe: string): bool =
  findExe(exe).len() != 0


#
# Gets missing executables from command line arguments.  The command line
# arguments is a list of strings of the following format: `<exe> <prog> ...`.
# This function returns the list of `(exe, prog)` tuples where `exe`
# executable is not found.
#
proc getMissingExes(): SinglyLinkedList[ExeProg] =
  result = initSinglyLinkedList[ExeProg]()

  for i in countup(1, paramCount(), 2):
    let
      exe  = paramStr(i)
      prog = paramStr(i + 1)

    if not foundExe(exe):
      result.prepend((exe, prog))

  return result


#
# Determines if a SinglyLinkedList is empty.
#
proc isEmpty[T](list: SinglyLinkedList[T]): bool =
  return list.head == nil


#
# Determines the length of a SinglyLinkedList.
#
proc length[T](list: SinglyLinkedList[T]): int =
  var count = 0
  for item in list:
    inc(count)
  return count


#
# Returns the first element of a SinglyLinkedList.
#
proc first[T](list: SinglyLinkedList[T]): T =
  return list.head.value


#
# Reports missing executables, returning true if there is at least one missing
# and false otherwise.
#
# This function takes list of `(string, string)` tuples, representing
# `(executable, programName)`.
#
proc reportMissingExes(missing: SinglyLinkedList[ExeProg]): bool =
  if isEmpty(missing):
    return false

  else:
    let length = length(missing)
    
    proc printMissingList(preMessage: string,
                          purposeMessage: string,
                          missing: SinglyLinkedList[ExeProg],
                          extractor: proc) =
      var count = 0
      stderr.write preMessage
      
      for exeProg in missing:
        var
          formatStr: string
          withNewLine: bool

        if count == length - 1:
          formatStr = "and $1 $2".format("$1", purposeMessage)
          withNewLine = true
        elif length > 2:
          formatStr = "$1, "
          withNewLine = false
        else:
          formatStr = "$1 "
          withNewLine = false

        stderr.write formatStr.format(extractor(exeProg))
        if withNewLine:
          stderr.writeLine ""

        inc(count)
      

    if length == 1:
      stderr.writeLine "$1 not found".format(first(missing).exe)
      stderr.writeLine "Make sure you have $1 installed".format(first(missing).prog)
    else:
      printMissingList(preMessage = "",
                       purposeMessage = "not found",
                       missing = missing,
                       extractor = proc(e: ExeProg): string = return e.exe)
      printMissingList(preMessage = "Make sure you have ",
                       purposeMessage = "installed",
                       missing = missing,
                       extractor = proc(e: ExeProg): string = return e.prog)

    return true


#
# Reverses a SinglyLinkedList.
#
proc reverse[T](list: SinglyLinkedList[T]): SinglyLinkedList[T] =
  result = initSinglyLinkedList[T]()
  for item in list:
    result.prepend(item)
  return result


if isMainModule:
  if paramCount() == 1 and paramStr(1) == "--help":
    showHelp()
    quit(0)
  elif paramCount() == 0:
    showHelp()
    quit(2)
  elif paramCount() div 2 == 0:
    echo "Invalid arguments.  Number of arguments must be even."
    showHelp()
    quit(3)
  else:
    quit(if getMissingExes().reverse().reportMissingExes(): 1 else: 0)
