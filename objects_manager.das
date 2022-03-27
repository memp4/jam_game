require daslib/media
require col_object
require message
require character

var message <- create_managed_image("sprites/message.png")
var tex1 = "\t\tFind 4 gens\n\t\t4/4"
var mess1 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex1)

var tex2 = "\t\tGene here!\n\t\tPress E"
var mess2 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex2)

var
    tree = new Col_object(float2(19. * 32., 11. * 32.), float2(7. * 32., 5. * 32.))
    bonfire = new Col_object(float2(32. * 32., 19. * 32.), float2(4. * 32., 4. * 32.))
    rock = new Col_object(float2(5. * 32., 13. * 32.), float2(7. * 32., 7. * 32.))
    pit = new Col_object(float2(2. * 32., 3. * 32.), float2(3. * 32., 3. * 32.))
    bush = new Col_object(float2(35. * 32., 2. * 32.), float2(6. * 32., 4. * 32.))


def objects_init()
    return

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

def objects_draw()
    mess1 -> draw()
    mess2 -> draw()
    return