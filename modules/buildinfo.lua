-- Copyright © 2017 Embedded Artistry LLC.
-- License: MIT. See LICENSE file for details.

local git_ = require "modules/buildinfo/git"
local info_ = require "modules/buildinfo/info"

local m = {}

function m.set_root(root)
	git_.set_root_dir(root)
end

function m.defines()
	return " -DBUILD_COMMIT=\\\"" .. git_.commit() .. "\\\"" ..
      " -DBUILD_VERSION=\\\"" .. git_.tag() .. "\\\"" ..
      " -DBUILD_INFO=\\\"" .. git_.tag() .. "-" .. git_.commits_past() .. git_.dirty() .. "\\\"" ..
      " -DBUILD_MACHINE=\\\"" .. info_.machine() .. "\\\"" ..
      " -DBUILD_DATE=\\\"" .. info_.date() .. "\\\""
end

return m
