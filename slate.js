/*
 * .slate.js
 */


// Dimensions
// ==============================================================================
var screenRect   = function () { return slate.screen().rect(); };
var screenLeft   = function () { return screenRect().x; };
var screenTop    = function () { return screenRect().y; };
var screenWidth  = function () { return screenRect().width; };
var screenHeight = function () { return screenRect().height; };


// Constants
// ==============================================================================

// Boundary between edge of screen and windows
var padding = {
  top: 0,
  bottom: 0,
  left: 0,
  right: 0
};

// Midpoint boundary between adjacent windows
var gap = 5;


// Globals
// ==============================================================================

slate.configAll({
  defaultToCurrentScreen: true,
  resizePercentOf: 'screenSize',
  windowHintsFontName: 'Menlo',
  windowHintsFontSize: '18',
  windowHintsIgnoreHiddenWindows: false,
  windowHintsSpread: true,
  windowHintsWidth: '30',
  windowHintsHeight: '30',
  windowHintsRoundedCornerSize: '1',
});


// Keystrokes
// ==============================================================================
var hyper = 'ctrl;shift';


// Operations
// ==============================================================================
var full = slate.operation('move', {
  x:      screenLeft() + padding.left,
  y:      screenTop()  + padding.top,
  width:  screenWidth()  - padding.left - padding.right,
  height: screenHeight() - padding.top  - padding.bottom,
});

var leftHalf = slate.operation('move', {
  x:      screenLeft() + padding.left,
  y:      screenTop() + padding.top,
  width:  screenWidth() / 2 - padding.left - gap,
  height: screenHeight() - padding.top - padding.bottom,
});

var rightHalf = slate.operation('move', {
  x:      screenLeft() + gap + screenWidth() / 2,
  y:      screenTop() + padding.top,
  width:  screenWidth() / 2 - padding.left - gap,
  height: screenHeight() - padding.top - padding.bottom,
});

var center = slate.operation('move', {
  x:      screenLeft() + screenWidth()  / 6,
  y:      screenTop()  + screenHeight() / 6,
  width:  screenWidth()  * 2 / 3,
  height: screenHeight() * 2 / 3,
});

var topLeft = slate.operation('move', {
  x:      screenLeft() + padding.left,
  y:      screenTop() + padding.top,
  width:  screenWidth() / 2 - padding.left - gap,
  height: screenHeight() / 2 - padding.top - gap,
});

var topRight = slate.operation('move', {
  x:      screenLeft() + screenWidth() / 2 + gap,
  y:      screenTop() + padding.top,
  width:  screenWidth() / 2 - gap - padding.right,
  height: screenHeight() / 2 - padding.top - gap,
});

var bottomLeft = slate.operation('move', {
  x:      screenLeft() + padding.left,
  y:      screenTop() + screenHeight() / 2 + gap,
  width:  screenWidth() / 2 - padding.left - gap,
  height: screenHeight() / 2 - gap - padding.bottom,
});

var bottomRight = slate.operation('move', {
  x:      screenLeft() + screenWidth() / 2 + gap,
  y:      screenTop() + screenHeight() / 2 + gap,
  width:  screenWidth() / 2 - padding.left - gap,
  height: screenHeight() / 2 - gap - padding.bottom,
});

var focusLeft = slate.operation('focus', {
  direction: 'left',
});

var focusRight = slate.operation('focus', {
  direction: 'right',
});

var focusUp = slate.operation('focus', {
  direction: 'up',
});

var focusDown = slate.operation('focus', {
  direction: 'down',
});

var resizeLeft = slate.operation('resize', {
  width: '-10%',
  height: '+0%',
});

var resizeRight = slate.operation('resize', {
  width: '+10%',
  height: '+0%',
});

var resizeUp = slate.operation('resize', {
  width: '+0%',
  height: '-10%',
});

var resizeDown = slate.operation('resize', {
  width: '+0%',
  height: '+10%',
});

var hint = slate.operation('hint', {
  characters: 'asdfghjklqwertyuiopcvbn',
});

var relaunch = slate.operation('relaunch');


// keybinds
// ==============================================================================

// General
slate.bind(`a:${hyper}`, hint);
slate.bind(`r:${hyper}`, relaunch);
slate.bind(`t:${hyper}`, function(win) {
  slate.shell('/usr/bin/osascript /Users/Richard/bin/iterm.scpt' , true);
});

// Layouts
slate.bind(`f:${hyper}`, full);
slate.bind(`left:${hyper}`, leftHalf);
slate.bind(`right:${hyper}`, rightHalf);
slate.bind(`c:${hyper}`, center);

// Quarters
slate.bind(`-:${hyper}`, topLeft);
slate.bind(`=:${hyper}`, topRight);
slate.bind(`[:${hyper}`, bottomLeft);
slate.bind(`]:${hyper}`, bottomRight);

// Focus
slate.bind(`h:${hyper}`, focusLeft);
slate.bind(`j:${hyper}`, focusDown);
slate.bind(`k:${hyper}`, focusUp);
slate.bind(`l:${hyper}`, focusRight);

// Resize
slate.bind('left:alt',  resizeLeft);
slate.bind('right:alt', resizeRight);
slate.bind('up:alt',    resizeUp);
slate.bind('down:alt',  resizeDown);
