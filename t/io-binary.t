package.path= package.path .. ';lib/?.lua'

require 'Test.More'

plan('no_plan')

subtest('big endian bytes', function()
    local binary= require 'io.binary'

    local file, err= binary.open('t/resources/test.jar')

    ok(file)

    is(file:read('u1'), 0x50)
    is(file:read('u2'), 0x4b03)
    is(file:read('u4'), 0x04140008)
    eq_array(file:read(4), {0x00, 0x08, 0x00, 0x2b})

    file:close()
end)

subtest('little endian bytes', function()
    local binary= require 'io.binary'

    local file, err= binary.open('t/resources/test.jar', binary.little_endian)

    ok(file)

    is(file:read('u1'), 0x50)
    is(file:read('u2'), 0x034b)
    is(file:read('u4'), 0x08001404)
    eq_array(file:read(4), {0x00, 0x08, 0x00, 0x2b})

    file:close()
end)

done_testing()
-- vim:ft=lua
