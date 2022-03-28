// require daslib/media
// require col_object
// require message
// require character

// def objects_init()
//     return

// def objects_act(var minigame_choice, gamestate: string)
//     mess1.isVisible = false
//     mess2.isVisible = false
//     if robot -> collision(tree.position, tree.size)
//         mess1.isVisible = true
//     elif robot -> collision(bonfire.position, bonfire.size)
//         mess2.isVisible = true
//     elif robot -> collision(rock.position, rock.size)
//         mess2.isVisible = true
//         if get_key_up(VK_E)
//             gamestate = "minigame"
//             minigame_choice = "minigame 1"
//     elif robot -> collision(pit.position, pit.size)
//         mess2.isVisible = truea
//     elif robot -> collision(bush.position, bush.size)
//         mess2.isVisible = true

//     mess1 -> stick(robot.position, robot.size)
//     mess2 -> stick(robot.position, robot.size)
//     return

// def objects_draw()
//     mess1 -> draw()
//     mess2 -> draw()
//     return