import std/[nativesockets, strutils, terminal]
import pkg/xcb/xcb
when defined(posix):
  import std/posix
else:
  import std/osproc

const ascii = staticRead("./asciiart.txt").splitLines

proc c_free(p: pointer) {.importc: "free", header: "<stdlib.h>".}

proc getOsName(): string =
  when defined(windows): return "windows"
  elif defined(macosx): return "macos"
  elif defined(bsd): return "bsd"
  elif defined(linux):
    for line in "/etc/os-release".lines:
      if line.startsWith "ID=":
        if line[3] == '"':
          return line[4..^2]
        else:
          return line[3..^1]
  else: return ""

proc getKernelVersion(): string =
  when defined(windows):
    return execCmdEx("ver").output.toLower.strip
  elif defined(posix):
    var utsname: Utsname
    discard uname(utsname)
    return $cast[cstring](addr utsname.release)
  else:
    return execCmdEx("uname -r").output.toLower.strip

proc getAtom(conn: ptr XcbConnection, atomName: string): XcbAtom =
  let reply = conn.reply(conn.internAtom(true, atomName.len.uint16, atomName.cstring), nil)
  result = reply.atom
  c_free reply

proc getProperty(conn: ptr XcbConnection, window: XcbWindow, atom, kind: XcbAtom, resultType: typedesc): resultType =
  let reply = conn.reply(conn.getProperty(0, window, atom, kind, 0, 128), nil)
  result = cast[resultType](reply.value)

proc getWmName(): string =
  when defined(windows):
    return "dwm"
  else:
    let
      conn = xcbConnect(nil, nil)
      screen = conn.getSetup.rootsIterator.data[0].addr
      supportingWindowAtom = conn.getAtom "_NET_SUPPORTING_WM_CHECK"
      supportingWindow = conn.getProperty(screen.root, supportingWindowAtom, xcbAtomWindow.XcbAtom, ptr XcbWindow)[]
      utf8Atom = conn.getAtom "UTF8_STRING"
      wmNameAtom = conn.getAtom "_NET_WM_NAME"
      wmName = conn.getProperty(supportingWindow, wmNameAtom, utf8Atom, cstring)
    result = $wmName

stdout.styledWriteLine(ascii[0], fgGreen, "os ", fgWhite, getOsName())
stdout.styledWriteLine(ascii[1], fgBlue, "kr ", fgWhite, getKernelVersion())
stdout.styledWriteLine(ascii[2], fgMagenta, "wm ", fgWhite, getWmName())
stdout.styledWriteLine(ascii[3], fgCyan, "hn ", fgWhite, getHostname())
