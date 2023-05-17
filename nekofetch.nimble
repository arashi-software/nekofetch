import distros
# Package

version       = "0.1.0"
author        = "Luke"
description   = "A new awesome nimble package"
license       = "GPL-3.0-only"
srcDir        = "src"
binDir        = "bin"
bin           = @["nekofetch"]


# Dependencies

requires "nim >= 1.4.8"
foreignDep "wmctrl"
