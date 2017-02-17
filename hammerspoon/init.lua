-- init.lua

-- Richard Zhao <richardz@andrew.cmu.edu>

local log = hs.logger.new('init', 'debug')
log.i('initializing')

--------------------------------------------------------------------------------
-- General ---------------------------------------------------------------------

local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

local hotkey = require 'hs.hotkey'

-- local alertStyle = {
--    radius = 0,
--    strokeWidth = 0,
--    fillColor = { white = 0.1, alpha = 0.8 },
-- }

hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.textSize = 22
hs.alert.defaultStyle.textFont = 'Menlo'
hs.alert.defaultStyle.textColor = { white = 1, alpha = 0.95 }
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }
hs.alert.defaultStyle.fillColor = { white = 0.2, alpha = 0.9 }

-- Configuration reload
hotkey.bind(hyper, 'r', function ()
  hs.reload()
end)
hs.alert.show('Config loaded')

--------------------------------------------------------------------------------
-- Scripts ---------------------------------------------------------------------


-- Open a new iTerm window
hotkey.bind(hyper, 't', function ()
  local iterm = [[ tell application "iTerm2"
  create window with default profile
end tell
]]
  hs.osascript.applescript(iterm)
end)

-- Open a new Finder window
hotkey.bind(hyper, 'n', function ()
  local finder = [[ tell application "Finder"
    make new Finder window
end tell
do shell script "open -a \"Finder\""
]]
  hs.osascript.applescript(finder)
end)


--------------------------------------------------------------------------------
-- Focus -----------------------------------------------------------------------

hotkey.bind(hyper, 'h', function ()
  hs.window.focusWindowWest()
end)

hotkey.bind(hyper, 'j', function ()
  hs.window.focusWindowSouth()
end)

hotkey.bind(hyper, 'k', function ()
  hs.window.focusWindowNorth()
end)

hotkey.bind(hyper, 'l', function ()
  hs.window.focusWindowEast()
end)

hotkey.bind(hyper, 'e', function ()
  hs.application.launchOrFocus('/usr/local/Cellar/emacs/25.1/Emacs.app')
end)

hotkey.bind(hyper, 'i', function ()
  hs.application.launchOrFocus('/Applications/iTerm2.app')
end)


--------------------------------------------------------------------------------
-- Window management -----------------------------------------------------------

local screen = require 'hs.screen'
local window = require 'hs.window'
local geom   = require 'hs.geometry'

local gap = 15
local margin = {
  left   = 20,
  top    = 20,
  right  = 20,
  bottom = 20
}

local delta = 50                -- For resizing and moving

local resizer = {}
local mover   = {}

function box ()
  return screen.mainScreen():currentMode()
end

function fWin ()
  return window.focusedWindow()
end

function resizer.full ()
  local win = fWin ()
  local b = box ()
  local w = b.w - margin.left - margin.right
  local h = b.h - margin.top - margin.bottom

  win:move(geom(margin.left, margin.top, w, h), nil, nil, 0)
end

function resizer.center ()
  local win = fWin ()
  local b = box ()
  local l = b.w / 6
  local t = b.h / 6
  local w = b.w * 2 / 3
  local h = b.h * 2 / 3

  win:move(geom(l, t, w, h), nil, nil, 0)
end

function resizer.left ()
  local win = fWin ()
  local b = box ()
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h - margin.top - margin.bottom

  win:move(geom(margin.left, margin.top, w, h), nil, nil, 0)
end

function resizer.right ()
  local win = fWin ()
  local b = box ()
  local l = b.w / 2 + gap / 2
  local t = margin.top
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h - margin.top - margin.bottom

  win:move(geom(l, t, w, h), nil, nil, 0)
end

function resizer.shrinkLeft ()
  local win = fWin ()
  local s = win:size()
  local w = s.w - delta

  win:setSize(geom({w = w, h = s.h}))
end

function resizer.shrinkUp ()
  local win = fWin ()
  local s = win:size()
  local h = s.h - delta

  win:setSize(geom({w = s.w, h = h}))
end

function resizer.expandRight ()
  local win = fWin ()
  local s = win:size()
  local w = s.w + delta

  win:setSize(geom({w = w, h = s.h}))
end

function resizer.expandDown ()
  local win = fWin ()
  local s = win:size()
  local h = s.h + delta

  win:setSize(geom({w = s.w, h = h}))
end

function mover.left ()
  local win = fWin ()

  win:move(geom(-delta, 0), nil, true)
end

function mover.right ()
  local win = fWin ()

  win:move(geom(delta, 0), nil, true)
end

function mover.up ()
  local win = fWin ()

  win:move(geom(0, -delta), nil, true)
end

function mover.down ()
  local win = fWin ()

  win:move(geom(0, delta), nil, true)
end


hotkey.bind(hyper, 'f',     resizer.full)
hotkey.bind(hyper, 'c',     resizer.center)
hotkey.bind(hyper, 'left',  resizer.left)
hotkey.bind(hyper, 'right', resizer.right)

hotkey.bind({ 'alt' }, 'left',  resizer.shrinkLeft, nil, resizer.shrinkLeft)
hotkey.bind({ 'alt' }, 'right', resizer.expandRight, nil, resizer.expandRight)
hotkey.bind({ 'alt' }, 'up',    resizer.shrinkUp, nil, resizer.shrinkUp)
hotkey.bind({ 'alt' }, 'down',  resizer.expandDown, nil, resizer.expandDown)

hotkey.bind({ 'alt', 'shift' }, 'h',  mover.left,  nil, mover.left)
hotkey.bind({ 'alt', 'shift' }, 'j',  mover.down,  nil, mover.down)
hotkey.bind({ 'alt', 'shift' }, 'k',  mover.up,    nil, mover.up)
hotkey.bind({ 'alt', 'shift' }, 'l',  mover.right, nil, mover.right)


--------------------------------------------------------------------------------
-- Drawing ---------------------------------------------------------------------

local drawing = require 'hs.drawing'
local timer   = require 'hs.timer'

function drawHints ()
  local b = box ()
  local w = 100
  local h = 80

  local size = geom (b.w/2 - w/2, b.h/2 - h/2, w, h)

  local text = drawing.text(size, 'hello')

  text:show()

  timer.doAfter(3, function () text:delete() end)

end

-- hotkey.bind(hyper, 'space', drawHints)


--------------------------------------------------------------------------------
-- Hydra -----------------------------------------------------------------------

local hydraExitKey = 'space'

function hydraBatteryStatusTrigger ()
  local minutes = hs.battery.timeRemaining ()
  local hours = minutes // 60

  minutes = minutes % 60
  
  hs.alert.show(string.format('%d:%02d remaining', hours, minutes))
end

local hydraDefinitions = {
  {
    mods  = hyper,
    key   = 'space',
    hint  = 'head',
    actions = {},
    hydras = {
      {
        mods  = '',
        key   = 'i',
        hint  = 'info',
        actions = {
          { mod = '', key = 'h', hint = 'Draw hello', target = function() drawHints() end },
          { mod = '', key = 'b', hint = 'Battery', target = function() hydraBatteryStatusTrigger() end }
        },
        hydras = {}
      }
    }
  }
}

function hydraGenerateHintString (hydra)
  local hintTable = {}

  -- generate child hydras first
  for _, child in pairs(hydra.hydras) do
    local hint = child.key .. ':' .. ' ' .. child.hint
    table.insert(hintTable, hint)
  end

  -- and then actions
  for _, child in pairs(hydra.actions) do
    local hint = child.key .. ':' .. ' ' .. child.hint
    table.insert(hintTable, hint)
  end

  return table.concat(hintTable, ' ')
end

function hydraExitAll ()
  recurse = function (hydras)
    for _, hydra in pairs(hydras) do
      hydra.modal:exit()
      if next(hydra.hydras) ~= nil then
        recurse(hydra.hydras)
      end
    end
  end
  recurse(hydraDefinitions)
  hs.alert.closeAll(0)
end

function hydraInit (parentHydra, hydras)
  if next(hydras) == nil then return end

  -- add modals to each body and bind all actions
  for _, hydra in pairs(hydras) do
    -- generate a new modal and put it under its parent
    hydra.modal = hotkey.modal.new()
    hydra.modal:bind('', hydraExitKey, function() hydraExitAll () end)
    if parentHydra ~= nil then
      parentHydra.modal:bind(hydra.mods, hydra.key, function() hydra.modal:enter() end)
    else -- global bind
      hotkey.bind(hydra.mods, hydra.key, function () hydra.modal:enter() end)
    end

    -- add a hint string
    hydra.hints = hydraGenerateHintString(hydra)
    log.i("hydra [" .. hydra.hint .. "] hints: " .. hydra.hints)

    -- for debugging
    function hydra.modal:entered()
      hs.alert.closeAll(0)
      hs.alert.show(hydra.hints, 60)
      log.i("hydra [" .. hydra.hint .. "] entered")
    end
    function hydra.modal:exited()  log.i("hydra [" .. hydra.hint .. "] exited") end

    -- add actions
    for _, action in ipairs(hydra.actions) do
      hydra.modal:bind(action.mod, action.key, action.target)
      log.i("hydra [" .. hydra.hint .. "] binding action" .. action.hint)
    end

    -- recurse on children
    hydraInit (hydra, hydra.hydras)
  end
end

-- Create all hydras under the head
hydraInit (nil, hydraDefinitions)

