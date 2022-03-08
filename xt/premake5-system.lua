require "archive"
require "project_file"

if _ACTION == 'clean' then
	print("Working dir: ", _WORKING_DIR)
	print("Script dir: ", _MAIN_SCRIPT_DIR)
	print("Premake dir: ", _PREMAKE_DIR)
end


