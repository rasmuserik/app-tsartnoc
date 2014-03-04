# {{{1 Boilerplate
# predicates that can be optimised away by uglifyjs
if typeof isNodeJs == "undefined" or typeof runTest == "undefined" then do ->
  root = if typeof global == "undefined" then window else global
  root.isNodeJs = (typeof window == "undefined") if typeof isNodeJs == "undefined"
  root.runTest = true if typeof runTest == "undefined"
# use - require/window.global with non-require name to avoid being processed in firefox plugins
use = if isNodeJs then ((module) -> require module) else ((module) -> window[module]) 
# execute main
onReady = (fn) ->
  if isNodeJs
    process.nextTick fn
  else
    if document.readystate != "complete" then fn() else setTimeout (-> onReady fn), 17 
# {{{1 Actual code

onReady ->
  frame = document.getElementById("ifr")
  scale = Math.min window.innerWidth / 800, window.innerHeight / 480
  frame.style.msTransform = frame.style.webkitTransform = frame.style.transform = "scale(#{scale})"
  frame.focus()
