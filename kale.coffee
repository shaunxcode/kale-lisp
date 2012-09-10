edn = require "edn"
k = exports

k.read = (str) ->
	console.log edn.parse str

k.eval = (form) ->
	console.log form

k.print = ->
	console.log "print"

k.toJS = (form) ->

k.interp = (str) -> k.print k.eval k.read str 

k.compile = (str) -> k.toJS k.read str