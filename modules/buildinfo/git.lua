-- Copyright © 2017 Embedded Artistry LLC.
-- License: MIT. See LICENSE file for details.


local m = {}

-- We need to get our current git build description
local handle = io.popen("git describe --long --dirty --tags")
local description = handle:read("*a")
handle:close()

-- remove newline
description = string.gsub(description, "\n", "")

-- Parse values
tag, c_past, hash, dirty = string.match(description, '([^-]+)-([^-]+)-([^-]+)-([^-]+)')

-- Commit hash
function m.commit()
  return "$(shell git log -1 --format=\"%h\")"
end

-- Count of commits past
function m.commits_past()
  return "$(strip $(word 2, $(subst -, ,$(shell git describe --long --dirty --tags))))"
end

-- Dirty or not
function m.dirty()
  return "$(strip $(word 4, $(subst dirty,+, $(subst -, ,$(shell git describe --long --dirty --tags)))))"
end

function m.tag()
	return "$(strip $(word 1, $(subst -, ,$(shell git describe --long --dirty --tags))))"
end

return m
