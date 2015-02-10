io-binary [![Build Status](https://travis-ci.org/kamichidu/lua-io-binary.svg?branch=master)](https://travis-ci.org/kamichidu/lua-io-binary)
========================================================================================================================
This is a lua module provides binary file operation.


Installation
------------------------------------------------------------------------------------------------------------------------
You can install this module using luarocks.

1. Install dependencies

    `luarocks --local install https://raw.githubusercontent.com/kamichidu/lua-bitwise/master/bitwise-v0.0.0-1.rockspec`

1. Install io-binary

    `luarocks --local install https://raw.githubusercontent.com/kamichidu/lua-io-binary/master/io-binary-0.0.0-1.rockspec`


Usage
------------------------------------------------------------------------------------------------------------------------
```lua
local binary= require 'io.binary'

-- for big endian
local file= binary.open('path/to/file')
-- for little endian
-- binary.open('path/to/file', binary.little_endian)

local unsigned_8bit_integer= file:read('u1')
local unsigned_16bit_integer= file:read('u2')
local unsigned_32bit_integer= file:read('u4')

local array_of_bytes= file:read(8)

file:close()
```
