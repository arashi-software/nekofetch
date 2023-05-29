# Package

version       = "0.1.1"
author        = "Luke"
description   = "A new awesome nimble package"
license       = "GPL-3.0-only"
srcDir        = "src"
binDir        = "bin"
bin           = @["nekofetch"]


# Dependencies

requires "nim >= 1.4.8", "xcb >= 0.2.0"
