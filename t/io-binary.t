package.path= 'lib/?.lua;' .. package.path

require 'Test.More'

plan('no_plan')

subtest('big endian bytes', function()
    local binary= require 'io.binary'

    local file, err= binary.open('t/resources/test.jar')

    ok(file)

    is(file:seek(), 0)

    is(file:read('u1'), 0x50)
    is(file:seek(), 1)

    is(file:read('u2'), 0x4b03)
    is(file:seek(), 3)

    is(file:read('u4'), 0x04140008)
    is(file:seek(), 7)

    eq_array(file:read(4), {0x00, 0x08, 0x00, 0x2b})
    is(file:seek(), 11)

    file:close()
end)

subtest('little endian bytes', function()
    local binary= require 'io.binary'

    local file, err= binary.open('t/resources/test.jar', binary.little_endian)

    ok(file)

    is(file:seek(), 0)

    is(file:read('u1'), 0x50)
    is(file:seek(), 1)

    is(file:read('u2'), 0x034b)
    is(file:seek(), 3)

    is(file:read('u4'), 0x08001404)
    is(file:seek(), 7)

    eq_array(file:read(4), {0x00, 0x08, 0x00, 0x2b})
    is(file:seek(), 11)

    file:close()
end)

done_testing()
-- vim:ft=lua
