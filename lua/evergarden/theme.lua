---@module 'evergarden.theme'

---@class evergarden.types.theme
---@field none string -- 'NONE'
---@field colors evergarden.types.colors -- copy of colors
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field red string
---@field orange string
---@field yellow string
---@field lime string
---@field green string
---@field aqua string
---@field skye string
---@field snow string
---@field blue string
---@field purple string
---@field pink string
---@field cherry string
---@field accent string
---@field editor evergarden.types.editor
---@field syntax evergarden.types.syntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: string }
---@field diff { ['add'|'delete'|'change']: string }
---@field git { ['staged'|'unstaged'|'ignored'|'untracked']: string }
---@field cursor string
---@field sign string
---@field comment string

--- colors for different ui elements in the editor
---@class evergarden.types.editor
---@field search string
---@field incsearch string
---@field float string
---@field completion string

--- color definitions for syntax groups
---@class evergarden.types.syntax
---@field keyword string
---@field identifier string
---@field property string
---@field type string
---@field context string
---@field operator string
---@field constant string
---@field func string
---@field string string
---@field macro string
---@field annotation string

--- @module 'evergarden.theme'
local M = {}

--- Setup the theme mapping based on configuration and palette
---@param config? evergarden.types.config
---@param colors? evergarden.types.colors
---@return evergarden.types.theme
function M.setup(config, colors)
  -- Fallback to global config and colors if not provided
  config = config or require('evergarden.config').get()
  colors = colors or require('evergarden.colors').get(config)

  -- Create theme object from color palette
  local theme = vim.deepcopy(colors, true)
  local c = theme -- shorthand for internal mapping

  -- Essential UI definitions
  theme.none    = 'NONE'
  theme.colors  = colors
  theme.accent  = c[config.theme.accent] or c.green
  theme.cursor  = c[config.editor.cursor.color] or theme.accent
  theme.sign    = c[config.editor.sign.color] or theme.none
  theme.comment = c.overlay2

  -- Editor UI components
  theme.editor = {
    search     = c.snow,
    incsearch  = c.orange,
    float      = c[config.editor.float.color] or theme.none,
    completion = c[config.editor.completion.color] or theme.none,
  }

  -- Syntax highlighting mapping
  theme.syntax = {
    keyword    = c.red,
    identifier = c.text,
    property   = c.skye,
    type       = c.yellow,
    context    = c.overlay1,
    operator   = c.subtext0,
    constant   = c.pink,
    func       = c.green,
    string     = c.lime,
    macro      = c.cherry,
    annotation = c.cherry,
  }

  -- Diagnostic state colors
  theme.diagnostic = {
    ok    = c.green,
    error = c.red,
    warn  = c.yellow,
    info  = c.aqua,
    hint  = c.skye,
  }

  -- Diff / Git integration
  theme.diff = {
    add    = c.green,
    delete = c.red,
    change = c.aqua,
  }

  theme.git = {
    staged    = c.green,
    unstaged  = c.skye,
    ignored   = c.overlay0,
    untracked = c.subtext1,
  }

  return theme
end

return M

local M = {}

---@param config? evergarden.types.config
---@param colors? evergarden.types.colors
---@return evergarden.types.theme
function M.setup(config, colors)
  config = config or require('evergarden.config').get()
  colors = colors or require('evergarden.colors').get(config)
  ---@type evergarden.types.theme
  local theme = vim.deepcopy(colors, true)

  theme.none = 'NONE'
  theme.colors = colors

  theme.accent = theme.colors[config.theme.accent] or theme.green
  theme.cursor = theme[config.editor.cursor.color] or theme.accent
  theme.sign = theme.colors[config.editor.sign.color] or theme.none
  theme.comment = theme.overlay2

  theme.editor = {
    search = theme.snow,
    incsearch = theme.orange,
    float = theme.colors[config.editor.float.color] or theme.none,
    completion = theme.colors[config.editor.completion.color] or theme.none,
  }
  theme.syntax = {
    keyword = theme.red,
    identifier = theme.text,
    property = theme.skye,
    type = theme.yellow,
    context = theme.overlay1,
    operator = theme.subtext0,
    constant = theme.pink,
    func = theme.green,
    string = theme.lime,
    macro = theme.cherry,
    annotation = theme.cherry,
  }
  theme.diagnostic = {
    ok = theme.green,
    error = theme.red,
    warn = theme.yellow,
    info = theme.aqua,
    hint = theme.skye,
  }
  theme.diff = {
    add = theme.green,
    delete = theme.red,
    change = theme.aqua,
  }
  theme.git = {
    staged = theme.green,
    unstaged = theme.skye,
    ignored = theme.overlay0,
    untracked = theme.subtext1,
  }
  return theme
end

return M
