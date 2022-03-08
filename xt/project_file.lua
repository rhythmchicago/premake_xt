--[[
--(C) Copyright 2022 Automated Design Corp. All Rights Reserved.
--File Created: Saturday, 5th March 2022 6:37:35 am
--Author: Thomas C. Bitsky Jr. (support@automateddesign.com)
--]]


local XT = {
	-- denotes the current supported package file version
	version = 0.1
}


function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

XT.loadDefaultProject = function()

    TOML = require "toml"

    file_name = _WORKING_DIR .. "/package.toml"

    content = readAll(fileName)

    TOML.parse(string)

end


return XT