-- init.lua

-- Richard Zhao <richardz@andrew.cmu.edu>

local log = hs.logger.new('init', 'debug')
log.i('initializing')

--------------------------------------------------------------------------------
-- General ---------------------------------------------------------------------

local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

local hotkey = require 'hs.hotkey'

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
  local finder = 'tell application "Finder" to make new Finder window'
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

--------------------------------------------------------------------------------
-- Window management -----------------------------------------------------------

local screen = require 'hs.screen'
local window = require 'hs.window'
local geom   = require 'hs.geometry'

local gap = 15
local margin = {
  left   = 20,
  top    = 40,
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
