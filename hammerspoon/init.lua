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
-- Keybinds --------------------------------------------------------------------


local eventtap = require 'hs.eventtap'

hotkey.bind(hyper, 'return', function ()
  eventtap.keyStroke({}, 'escape')
end)


--------------------------------------------------------------------------------
-- Scripts ---------------------------------------------------------------------


-- Open a new iTerm window
hotkey.bind(hyper, 't', function ()
  local iterm = [[ tell application "iTerm"
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
  hs.application.launchOrFocus('/Applications/iTerm.app')
end)


--------------------------------------------------------------------------------
-- Window management -----------------------------------------------------------

local screen = require 'hs.screen'
local window = require 'hs.window'
local geom   = require 'hs.geometry'

window.animationDuration = 0.0

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
  local mode = screen.mainScreen():currentMode()
  return mode
end

function fWin ()
  return window.focusedWindow()
end

function resizer.full ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = margin.left
  local t = margin.top
  local w = b.w - margin.left - margin.right
  local h = b.h - margin.top - margin.bottom

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.center ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = b.w / 6
  local t = b.h / 6
  local w = b.w * 2 / 3
  local h = b.h * 2 / 3

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.reading ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = b.w / 6
  local t = margin.top
  local w = b.w * 2 / 3
  local h = b.h - margin.top - margin.bottom

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.left ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = margin.left
  local t = margin.top
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h - margin.top - margin.bottom

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.right ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = b.w / 2 + gap / 2
  local t = margin.top
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h - margin.top - margin.bottom

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.northEast ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = margin.left
  local t = margin.top
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h / 2 - margin.top - gap / 2

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.southEast ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = margin.left
  local t = b.h / 2 + gap / 2
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h / 2 - margin.bottom - gap / 2

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.northWest ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = b.w / 2 + gap / 2
  local t = margin.top
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h / 2 - margin.top - gap / 2

  win:setFrame(screen:localToAbsolute(l, t, w, h))
end

function resizer.southWest ()
  local win = fWin()
  local screen = win:screen()
  local b = screen:frame()
  local l = b.w / 2 + gap / 2
  local t = b.h / 2 + gap / 2
  local w = b.w / 2 - margin.left - gap / 2
  local h = b.h / 2 - margin.bottom - gap / 2

  win:setFrame(screen:localToAbsolute(l, t, w, h))
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
hotkey.bind(hyper, '-', resizer.northEast)
hotkey.bind(hyper, '=', resizer.northWest)
hotkey.bind(hyper, '[', resizer.southEast)
hotkey.bind(hyper, ']', resizer.southWest)

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

local hints = {
  -- font = 'Lato Light',
  font = 'Lato Light',
  size = 24,
  width = 200,
  duration = 2,
  fadeIn = 0.3,
  fadeOut = 0.3,
}

local colors = {
  orange = { red = 214 / 255, green = 93 / 255, blue = 14 / 255, alpha = 0.9 },
  green  = { red = 152 / 255, green = 151 / 255, blue = 26 / 255, alpha = 0.9 },
  blue = { red = 69 / 255, green = 133 / 255, blue = 136 / 255, alpha = 0.9 },
  grey = { red = 0, green = 0, blue = 0, alpha = 0.4 }
}

-- Create a circle centered at (x, y) with radius r.
function hints.circle (x, y, r, color)
  local c = drawing.circle(geom(x - r, y - r, 2 * r, 2 * r))
  c:setStroke(false)
  c:setFillColor(color)
  return c
end

function hints.background ()
  local b = box ()
  local rect = drawing.rectangle(geom(0, 0, b.w, b.h))
                 :setStroke(false)
                 :setFillColor(colors.grey)
  return {
    show = function ()
      rect:show(hints.fadeIn)
    end,
    hide = function ()
      rect:hide(hints.fadeOut)
    end
  }
end

function hints.hint (x, y, key, msg, color)
  local radius = hints.size
  local circle = hints.circle(x + radius, y + radius, radius, color)
  local keyBox = hs.drawing.getTextDrawingSize(key, {
    font = hints.font, size = hints.size, alignment = 'center',
  })
  keyBox.w = keyBox.w + 3 -- known fudge factor (see getTextDrawingSize docs)

  local left = x + radius - keyBox.w / 2
  local top  = y + radius - keyBox.h / 2 - 5 -- lower case keys

  local keyText = hs.drawing.text(geom(left, top, keyBox.w, keyBox.h), key)
                   :setTextFont(hints.font)
                   :setTextSize(hints.size)

  local msgBox = hs.drawing.getTextDrawingSize(msg, {
    font = hints.font, size = hints.size, alignment = 'left',
  })
  msgBox.w = msgBox.w + hints.size
  if msgBox.w > hints.width then
    log.i('width ' .. msgBox.w .. ' of hint ' .. msg .. ' too large')
  end

  local msgText = hs.drawing.text(geom(left + hints.size * 2, top, hints.width, msgBox.h), msg)
                    :setTextFont(hints.font)
                    :setTextSize(hints.size)

  return {
    show = function ()
      circle:show(hints.fadeIn)
      keyText:show(hints.fadeIn)
      msgText:show(hints.fadeIn)
    end,
    hide = function ()
      circle:hide(hints.fadeOut)
      keyText:hide(hints.fadeOut)
      msgText:hide(hints.fadeOut)
    end
  }
end


--------------------------------------------------------------------------------
-- Hydra -----------------------------------------------------------------------

local hydraExitKey = 'space'

function hydraBatteryStatusTrigger ()
  local minutes = hs.battery.timeRemaining ()
  local hours = minutes // 60
  local msg

  if minutes == -2 then
    msg = 'Power source: power adapter'
  else
    minutes = minutes % 60
    msg = string.format('%d:%02d remaining', hours, minutes)
  end
  hs.alert.show(msg)
end

function hydraBrightnessIncrease ()
  local current = hs.brightness.get()
  local target  = math.min(current + 10, 100)
  hs.brightness.set(target)
end

function hydraBrightnessDecrease ()
  local current = hs.brightness.get()
  local target  = math.max(current - 10, 0)
  hs.brightness.set(target)
end

local hydraDefinitions = {
  {
    mods  = hyper,
    key   = 'space',
    hint  = 'head',
    master = true,
    actions = {},
    hydras = {
      -- window
      {
        mods  = '',
        key   = 'w',
        hint  = 'window',
        actions = {
          { mod = '', key = 'c', hint = 'center', target = function() resizer.center() end, exit = false },
          { mod = '', key = 'f', hint = 'full', target = function() resizer.full() end, exit = false },
          { mod = '', key = 'r', hint = 'reading', target = function() resizer.reading() end, exit = false },
        },
        hydras = {}
      },

      -- launcher
      {
        mods  = '',
        key   = 'l',
        hint  = 'launch',
        actions = {
          { mod = '', key = 'c', hint = 'Calendar', target = function() hs.application.launchOrFocus('Calendar') end, exit = true },
          { mod = '', key = 'e', hint = 'Emacs', target = function() hs.application.launchOrFocus('Emacs') end, exit = true },
          { mod = '', key = 's', hint = 'Safari', target = function() hs.application.launchOrFocus('Safari') end, exit = true },
          { mod = '', key = 't', hint = 'iTerm', target = function() hs.application.launchOrFocus('iTerm') end, exit = true },
          { mod = '', key = 'p', hint = 'Spotify', target = function() hs.application.launchOrFocus('Spotify') end, exit = true }
        },
        hydras = {}
      },

      -- info
      {
        mods  = '',
        key   = 'i',
        hint  = 'info',
        actions = {
          { mod = '', key = 'b', hint = 'Battery', target = function() hydraBatteryStatusTrigger() end }
        },
        hydras = {}
      },

      -- system
      {
        mods  = '',
        key   = 's',
        hint  = 'system',
        actions = {
          { mod = '', key = 's', hint = 'Screen saver', target = function() hs.caffeinate.startScreensaver() end, exit = true }
        },
        hydras = {
          {
            mods  = '',
            key   = 'b',
            hint  = 'brightness',
            actions = {
              { mod = '', key = 'j', hint = '-', target = hydraBrightnessDecrease },
              { mod = '', key = 'k', hint = '+', target = hydraBrightnessIncrease },
            },
            hydras = {}
          }
        }
      }
    }
  }
}

function tableLen(T)
  local count = 0
  for k, v in pairs(T) do
    count = count + 1
  end
  return count
end

function hydraGenerateHints (hydra)
  local b = box ()
  local hintTable = {}

  local numHints = tableLen(hydra.hydras) + tableLen(hydra.actions)
  local height = hints.size * 2 + hints.size / 2
  local totalHeight = numHints * height

  local left = b.w / 2 - hints.width / 2
  local top  = b.h / 2 - totalHeight / 2

  local y = top

  -- generate child hydras first
  for _, child in pairs(hydra.hydras) do
    local hint = hints.hint(left, y, child.key, child.hint, colors.blue)
    table.insert(hintTable, hint)
    y = y + height
  end

  -- and then actions
  for _, child in pairs(hydra.actions) do
    local hint
    if child.exit then
      hint = hints.hint(left, y, child.key, child.hint, colors.orange)
    else
      hint = hints.hint(left, y, child.key, child.hint, colors.green)
    end
    table.insert(hintTable, hint)
    y = y + height
  end

  return {
    show = function ()
      for _, hint in pairs(hintTable) do
        hint.show()
      end
    end,
    hide = function ()
      for _, hint in pairs(hintTable) do
        hint.hide()
      end
    end
  }
end

function hydraExitAllAndHideHints ()
  recurse = function (hydras)
    for _, hydra in pairs(hydras) do
      if hydra.master ~= nil and hydra.master == true then
        hydra.background.hide()
      end
      hydra.modal:exit()
      hydra.hints.hide()
      if next(hydra.hydras) ~= nil then
        recurse(hydra.hydras)
      end
    end
  end
  recurse(hydraDefinitions)
end

function hydraInit (parentHydra, hydras)
  if next(hydras) == nil then return end

  -- add modals to each body and bind all actions
  for _, hydra in pairs(hydras) do
    -- generate a new modal and put it under its parent
    hydra.modal = hotkey.modal.new()
    hydra.modal:bind('', hydraExitKey, function() hydraExitAllAndHideHints () end)

    -- global bind of master
    if hydra.master ~= nil and hydra.master == true then
      hydra.background = hints.background ()
      hotkey.bind(hydra.mods, hydra.key, function ()
        hydra.background.show()
        hydra.modal:enter()
      end)
    else
      parentHydra.modal:bind(hydra.mods, hydra.key, function()
        parentHydra.modal:exit()
        hydra.modal:enter()
      end)
    end

    -- add the hint drawing objects
    hydra.hints = hydraGenerateHints(hydra)

    -- for debugging
    function hydra.modal:entered()
      hydra.hints.show()
      log.i("hydra [" .. hydra.hint .. "] entered")
    end
    function hydra.modal:exited()
      hydra.hints.hide()
      log.i("hydra [" .. hydra.hint .. "] exited")
    end

    -- add actions
    for _, action in ipairs(hydra.actions) do
      hydra.modal:bind(action.mod, action.key, function ()
        action.target ()
        if action.exit then hydraExitAllAndHideHints () end
      end)
      log.i("hydra [" .. hydra.hint .. "] binding action " .. action.hint)
    end

    -- recurse on children
    hydraInit (hydra, hydra.hydras)
  end
end

-- Create all hydras under the head
hydraInit (nil, hydraDefinitions)

