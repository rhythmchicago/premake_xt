--[[
  (C) Copyright 2022 Automated Design Corp. All Rights Reserved.
  File Created: Friday, 4th March 2022 3:33:11 pm
  Author: Thomas C. Bitsky Jr. (support@automateddesign.com)
]]--


local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end



if _ACTION == 'archive' then

    -- first get all directories
    -- for windows, use dir
    -- Note: To get list of files, only use /b instead of /b /ad
    -- for linux, use ls


    -- build a list of file names and directory names will will ignored
    -- use upper-case because that's the case we'll be comparing to.

    print("Arching on OS " .. _OS)

    ignore_files = {}

    index = 1
    for f in io.popen("dir \"" .. _WORKING_DIR .. "\\archive*.zip\" /b"):lines() do         

        if string.upper(f) ~= "FILE NOT FOUND" then
            ignore_files[index] = f
            index = index + 1
        end
        
    end

    for i,item in ipairs(ignore_files) do
        print("\tIGNORING " .. item)
    end

    ignore_directories = {"BUILD", "RELEASE", "DEBUG", "BIN", ".VS", ".VSCODE"}


    file_list = {} 
    index = 1

    has_toml = false

    for dir in io.popen("dir \"" .. _WORKING_DIR .. "\" /b /ad"):lines() do 

        if not has_value(ignore_directories, dir) then
            file_list[index] = dir
            index = index + 1
        end

    end




    -- then get the files of the local directory
    for f in io.popen("dir \"" .. _WORKING_DIR .. "\" /b"):lines() do         

        if not has_value(ignore_files, f) then
            file_list[index] = f
            index = index + 1
        end

    end


    file_args = ""

    for i,item in ipairs(file_list) do

        if i > 1 then
            file_args = file_args .. "," .. item
        else
            file_args = item
        end

    end


    -- Target file processing
    -- if the package.toml file does not exist, then create a standard archive name

    target_file = ""
    
    if not has_toml then
        date_code = os.date("%Y%m%dT%H%M%S")
        target_file = _WORKING_DIR .. "/" .. "archive" .. date_code .. ".zip"
    end


    cmd = "powershell Compress-Archive " .. file_args .. " " .. target_file .. " -CompressionLevel Optimal -Force"
    print (cmd)

    io.popen(cmd)




end