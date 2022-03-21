require daslib/media
require grid
require checker

var grid1 = new Grid(5, 5, 100)
var checker = new Checker()

def minigame_init()
    var tab <- grid1 -> get_coords()
    checker.position = tab[0][0]
    checker.color = 0xffffff
    checker -> info()
    return

def minigame_act(dt: float)
    return

def minigame_draw()
    grid1 -> draw()
    checker -> draw()
    return