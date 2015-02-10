local bitwise= require 'bitwise'

local binary= {}

function binary.big_endian(bytes)
    local shiftbits= 8 * (#bytes - 1)
    local read= 0x00000000

    for _, byte in ipairs(bytes) do
        read= bitwise.bor(read, bitwise.lshift(byte, shiftbits))

        shiftbits= shiftbits - 8
    end

    return read
end

function binary.little_endian(bytes)
    local shiftbits= 0
    local read= 0x00000000

    for _, byte in ipairs(bytes) do
        read= bitwise.bor(read, bitwise.lshift(byte, shiftbits))

        shiftbits= shiftbits + 8
    end

    return read
end

function binary.open(filename, endian)
    assert(filename)

    local fh, err= io.open(filename, 'rb')

    if not fh then
        return nil, err
    end

    local object= {
        -- associated file handle
        __file= fh,
        -- endian
        __endian= (endian or binary.big_endian),
    }

    -- `*n' delegate
    -- `*a' delegate
    -- `*l' delegate
    -- `*L' delegate
    -- {number} return {number} bytes as list
    -- `u1' return next 1 byte into single number
    -- `u2' return next 2 bytes into single number
    -- `u4' return next 4 bytes into single number
    function object:read(...)
        local fmt= ({...})[1]

        if fmt == nil then
            return self.__file:read()
        elseif type(fmt) == 'string' and fmt:find('^u%d+$') then
            local _, _, nbytes= fmt:find('^u(%d+)$')

            nbytes= 0 + nbytes

            assert(nbytes == 1 or nbytes == 2 or nbytes == 4, "Only supported `u1', `u2' or `u4', but got `u" .. nbytes .. "'.")

            local s= self.__file:read(nbytes)
            local bytes= {}
            for c in s:gmatch('.') do
                table.insert(bytes, c:byte())
            end

            return self.__endian(bytes)
        elseif type(fmt) == 'number' then
            local s= '' .. self.__file:read(fmt)
            local bytes= {}

            for c in s:gmatch('.') do
                table.insert(bytes, c:byte())
            end

            return bytes
        else
            return self.__file:read(fmt)
        end
    end

    function object:close()
        return self.__file:close()
    end

    function object:seek(whence, offset)
        return self.__file:seek(whence, offset)
    end

    return object
end

return binary
