package = "io-binary"
version = "0.0.0-1"
source = {
   url = "git://github.com/kamichidu/lua-io-binary",
   tag = "v0.0.0",
}
description = {
   summary = "Binary IO library in pure lua implementation.",
   detailed = "Binary IO library in pure lua implementation.",
   homepage = "https//github.com/kamichidu/lua-io-binary",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.3",
   "bitwise"
}
build = {
   type = "builtin",
   modules = {
      ['io.binary'] = "lib/io/binary.lua"
   }
}
