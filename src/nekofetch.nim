import os, osproc, strutils, terminal

const ascii = staticRead("./asciiart.txt").splitLines

proc getOsName(): string =
  if defined(windows):
    return "windows"
  elif defined(macosx):
    return "macos"
  elif defined(bsd):
    return "bsd"
  elif defined(linux):
    return execCmdEx("cat /etc/os-release | grep ^ID=").output.split("=")[1].replace("\"", "").toLower().strip()
  else:
    return ""

proc getKernelVersion(): string =
  if defined(windows):
    return execCmdEx("ver").output.toLower().strip()
  else: 
    return execCmdEx("uname -r").output.strip()

proc getWmName(): string =
  echo execCmdEx("wmctrl -m | grep Name").output.split(":")[1].strip()

proc getHostname(): string =
  echo execCmdEx("hostnamectl hostname").output.strip()
  
stdout.styledWriteLine(ascii[0], fgGreen, "os ", fgWhite, getOsName())
stdout.styledWriteLine(ascii[1], fgBlue, "kr ", fgWhite, getKernelVersion())
stdout.styledWrite(ascii[2], fgMagenta, "wm ", fgWhite, getWmName())
stdout.styledWriteLine(ascii[3], fgCyan, "hn ", fgWhite, getHostname())
quit 0