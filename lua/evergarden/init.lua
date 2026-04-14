--- *evergarden*
--- cozy evergarden theme for neovim
---
--- for configuration see |evergarden.config|

local config = require('evergarden.config')
local evergarden = {}

--- Set global configuration
--- @param cfg? table
function evergarden.setup(cfg)
  config.set(cfg or {})
end

--- Main load function
--- @param cfg? table
function evergarden.load(cfg)
  -- Clear existing highlights if a theme is already active
  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  -- Resolve configuration (prioritize local override)
  local active_cfg = cfg and config.override(cfg) or config.get()
  
  vim.g.colors_name = 'evergarden'
  vim.go.background = active_cfg.theme.variant == 'summer' and 'light' or 'dark'

  -- Handle ANSI colors fallback
  active_cfg.theme.ansi = vim.F.if_nil(active_cfg.theme.ansi, not vim.o.termguicolors)

  -- Cache Management logic
  local use_cache = active_cfg.cache or false
  if use_cache then
    local cache_mod = require('evergarden.cache')
    if not cache_mod.needs_compile(active_cfg) then
      return cache_mod.load()
    end
    cache_mod.clear()
  end

  -- Generate and apply highlights
  local theme = require('evergarden.theme').setup(active_cfg)
  local hlgroups = require('evergarden.hl').setup(theme, active_cfg)
  require('evergarden.utils').set_highlights(hlgroups)

  -- Save to cache if enabled
  if use_cache then
    require('evergarden.cache').write(active_cfg)
  end
end

--- Get color palette
--- @return table
function evergarden.colors()
  return require('evergarden.colors').get()
end

return evergarden
