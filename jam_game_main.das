require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/grid
require minigame/checker
require minigame/player_checker
require minigame/minigame
require character
require col_object
require message

//Core game
var map <- create_managed_image("sprites/map.png")
var gamestate: string = "start"
var minigame_choice: string
var screen_width = float(get_screen_width())
var screen_height = float(get_screen_height())

//Objects
var message <- create_managed_image("sprites/message.png")
var genes_amount: int = 4
var tex1: string
var mess1 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex1)

var tex2 = "\t\tGene here!\n\t\tPress E"
var mess2 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex2)

var mess_window = new Message(float2(0., 0.), float2(screen_width, screen_height), "sprites/message_window2.png", "")

var start_text = "              Mission: Colombo Circle

Big brother: Greetings Pi718, your mission on this planet will be collect genetic code of the living beings who once lived here.
    We haven't explore this area of galactic yet, so you are first one here newbie. Our metal friends will come here soon, in one or two hundred years.
    Life on this planet was destroyed by some accident.
    Try find everything that you can and we will try to restore the appearance of the local creatures.
    But before sending you have to clear genetic materials, you will understand when you will see it.

Pi718:  ...Kshhshst. Bip-bip, Okey. I will try my best. Kirk out (:_:).

        Press SPACE or E to continue."

var rock_text = "Big brother: Hmm... this one are pretty complex genes. Here is about 48 chromosomes.
        Intersting, but our archives have information about this creature. It says he was called 'Monkey'. 
        It had 2 hands and 2 legs, so he could walk.
        Probably he is an ancestor of the upright species on this planet.
        I mean he was.

Pi718: I bet they had the potential to be a sentient species. Seems like they missed some spark (<_<).

        Press E to continue."

var pit_text = "Big brother: I just got your results from this pit. This creature is some sort of reptile.
    From this model I can say that it had very strong hind legs and ah... it ate insects I guess.
    Not sure that it was a dominant species.

Pi718: The reptiles that I've met were very noble, I believe that their ancestors too.

        Press E to continue."

var bush_text = "Big brother: Wow, this beast hadn't arms and legs or any limb to hold something.
    Also it hadn't a noramal brain. But the regeneration skills are amazing. I could say that he was technically immortal.
    But something killed them all too. Funny creature he looked like energy umbrella on our spaceships.

Pi718: But I wonder how they survived without legs on this desert planet (0.0).

        Press E to continue."

var bonfire_text = "Big brother: Looks like this creature was a predator. Gene decoder says that he was very aggressive.
    But strange that he had wings and feathers and he couldn't fly.
    Also they grew up in eggs like an reptiles.

Pi718: Despite our species researches and tchnologies, we still haven't figured out which came first, the reptile or the egg.
    It seems that this phrase was originally different, A-ha (^_^).

        Press E to continue."

var final_text = "              Secret Mission: Three of Life

Big brother: You found secret gene code of 'Human' that opened our oldest archives and information. This planet was called Earth and
    and there lived our creators. They left a message to us. Listen:

        'We are sending this self-evolving AI into space in the hope that one day it will fly back and restore humanity.
        We lost 3rd Jedi War with human clones. Replicants gonna kill all original humans. But they can't reproduce naturally.
        The Planet is depleted, we made a lot mistakes in last 3 decades. 2049 year probably gonna be last year for the humanity.'

    So your new mission will be to start restoring ecosystem of this planet. You can start from the genes that you have found yet.

Pi718:  It's so unexpected, we found our main mission. Let's restore the humanity 0_0 .

        Press SPACE or E to continue."

var credits = "
                            Thanks for playing >:)

        Game design: Sultan                         Creative director: Sultan
        Q&A: Sultan                                 Text written by Sultan
        Script: Sultan                              Credits written by Sultan
        Engine programmer: Sultan                   
        Level design: Sultan

        Press ESC to quit
"

var instructions = "
    Your goal in this game to make all checks in one color
    Press Q to swap checks
    Press SPACE to jump over the check and change it color. You can't jump over the colored checks.
    Press E to back to exploring"

var text_table <- {{
    "rock" => rock_text;
    "pit" => pit_text;
    "bush" => bush_text;
    "bonfire" => bonfire_text
}}
var text_choice: string

var
    tree = new Col_object(float2(19. * 32., 11. * 32.), float2(7. * 32., 5. * 32.))
    bonfire = new Col_object(float2(32. * 32., 19. * 32.), float2(4. * 32., 4. * 32.))
    rock = new Col_object(float2(5. * 32., 13. * 32.), float2(7. * 32., 7. * 32.))
    pit = new Col_object(float2(2. * 32., 3. * 32.), float2(3. * 32., 3. * 32.))
    bush = new Col_object(float2(35. * 32., 2. * 32.), float2(6. * 32., 4. * 32.))

//Minigames
//First game
var m1_grid = new Grid(5, 2, 100)
var m1_p_checker = new Player_Checker(int2(1, 0), 0xd48837)
var 
    m1_checker1 = new Checker(int2(1, 1), m1_p_checker.color)
    m1_checker2 = new Checker(int2(2, 0), 0xffffff)
    m1_checker3 = new Checker(int2(2, 1), 0xffffff)

var m1_check_arr <- [{auto m1_checker1; m1_checker2; m1_checker3}]
var m1_minigame = new Minigame(m1_p_checker, m1_check_arr, m1_grid)

//Second game
var m2_grid = new Grid(4, 4, 100)
var m2_p_checker = new Player_Checker(int2(1, 1), 0x2b84f0)
var 
    m2_checker1 = new Checker(int2(0, 0), 0xffffff)
    m2_checker2 = new Checker(int2(1, 2), 0xffffff)
    m2_checker3 = new Checker(int2(2, 1), 0xffffff)
    m2_checker4 = new Checker(int2(0, 2), 0xffffff)

var m2_check_arr <- [{auto m2_checker1; m2_checker2; m2_checker3; m2_checker4}]
var m2_minigame = new Minigame(m2_p_checker, m2_check_arr, m2_grid)

//Third game
var m3_grid = new Grid(5, 5, 100)
var m3_p_checker = new Player_Checker(int2(2, 2), 0x18134c)
var 
    m3_checker1 = new Checker(int2(2, 1), 0xffffff)
    m3_checker2 = new Checker(int2(3, 1), 0xffffff)
    m3_checker3 = new Checker(int2(1, 2), 0xffffff)
    m3_checker4 = new Checker(int2(2, 3), 0xffffff)
    m3_checker5 = new Checker(int2(3, 3), 0xffffff)
    m3_checker6 = new Checker(int2(2, 4), m3_p_checker.color)
    m3_checker7 = new Checker(int2(3, 4), 0xffffff)

var m3_check_arr <- [{auto m3_checker1; m3_checker2; m3_checker3; m3_checker4;
    m3_checker5; m3_checker6; m3_checker7}]

var m3_minigame = new Minigame(m3_p_checker, m3_check_arr, m3_grid)

//Fourth game
var m4_grid = new Grid(7, 2, 100)
var m4_p_checker = new Player_Checker(int2(0, 0), 0x53423b)
var 
    m4_checker1 = new Checker(int2(1, 0), 0xffffff)
    m4_checker2 = new Checker(int2(3, 0), 0xffffff)
    m4_checker3 = new Checker(int2(5, 0), 0xffffff)
    m4_checker4 = new Checker(int2(1, 1), 0xffffff)
    m4_checker5 = new Checker(int2(2, 1), m4_p_checker.color)
    m4_checker6 = new Checker(int2(3, 1), 0xffffff)
    m4_checker7 = new Checker(int2(5, 1), 0xffffff)
    m4_checker8 = new Checker(int2(6, 1), m4_p_checker.color)

var m4_check_arr <- [{auto m4_checker1; m4_checker2; m4_checker3; m4_checker4;
    m4_checker5; m4_checker6; m4_checker7; m4_checker8}]
var m4_minigame = new Minigame(m4_p_checker, m4_check_arr, m4_grid)

//Fivth game
var m5_grid = new Grid(5, 5, 100)
var m5_p_checker = new Player_Checker(int2(0, 0), 0x53423b)
var 
    m5_checker1 = new Checker(int2(1, 0), 0xffffff)
    m5_checker2 = new Checker(int2(3, 0), 0xffffff)
    m5_checker3 = new Checker(int2(4, 1), 0xffffff)
    m5_checker4 = new Checker(int2(4, 3), 0xffffff)
    m5_checker5 = new Checker(int2(3, 4), 0xffffff)
    m5_checker6 = new Checker(int2(1, 4), 0xffffff)
    m5_checker7 = new Checker(int2(0, 3), 0xffffff)
    m5_checker8 = new Checker(int2(1, 2), 0xffffff)
    m5_checker9 = new Checker(int2(2, 3), 0xffffff)

var m5_check_arr <- [{auto m5_checker1; m5_checker2; m5_checker3; m5_checker4;
    m5_checker5; m5_checker6; m5_checker7; m5_checker8; m5_checker9}]
var m5_minigame = new Minigame(m5_p_checker, m5_check_arr, m5_grid)

var minitable <- {{
    "minigame 1" => m1_minigame;
    "minigame 2" => m2_minigame;
    "minigame 3" => m3_minigame;
    "minigame 4" => m4_minigame;
    "minigame 5" => m5_minigame
    }}

[export]
def initialize()
    set_window_title("Jam Game")    
    return

[export]
def act(dt: float)

    if gamestate == "start"
        if get_key_up(VK_SPACE) || get_key_up(VK_E)
            gamestate = "play"
    elif gamestate == "play"
        set_font_name("fonts/Robot Crush.ttf")
        character_act(dt)
        objects_act()
    elif gamestate == "minigame"
        minigame_act(minigame_choice)
        if m5_minigame.isFinished
            gamestate = "final"
    elif gamestate == "final"
        if get_key_up(VK_SPACE) || get_key_up(VK_E)
            gamestate = "credits"        
    
    if get_key(VK_ESCAPE)
        schedule_quit_game()
        
    return

[export]
def draw()
    if gamestate == "start"
        set_font_name("fonts/SilomBol.ttf")
        mess_window -> draw_window(start_text)
    elif gamestate == "play"
        draw_image(map, 0, 0)
        objects_draw()
        character_draw()
    elif gamestate == "minigame"
        setup_2d_camera(float2(get_screen_width() / 2, get_screen_height() / 2), 1.0)
        minigame_draw(minigame_choice, text_choice)
    elif gamestate == "final"
        set_font_name("fonts/SilomBol.ttf")
        mess_window -> draw_window(final_text)
    elif gamestate == "credits"
        set_font_name("fonts/Carnevalee Freakshow.ttf")
        set_font_size(35)
        text_out(150, 20, credits, 0xffffff)
    return

//Objects function
def objects_act()
    mess1.isVisible = false
    mess2.isVisible = false
    if robot -> collision(tree.position, tree.size)
        mess1.isVisible = true
        if genes_amount == 0
            mess1.text = "\t\tGene here!\n\t\tPress E"
            if get_key_up(VK_E)
                minigame_choice = "minigame 5"
                gamestate = "minigame"
        else
            mess1.text = "\t\tFind 4 genes\n\t\t{genes_amount}/4"
    elif robot -> collision(bonfire.position, bonfire.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 3"
            text_choice = "bonfire"
    elif robot -> collision(rock.position, rock.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 1"
            text_choice = "rock"
    elif robot -> collision(pit.position, pit.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 2"
            text_choice = "pit"
    elif robot -> collision(bush.position, bush.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 4"
            text_choice = "bush"

    genes_amount = minigames_check()
    mess1 -> stick(robot.position, robot.size)
    mess2 -> stick(robot.position, robot.size)
    return


def objects_draw()
    mess1 -> draw()
    mess2 -> draw()
    return

//Minigame functions
def minigame_act(minigame_choice: string)
    if minitable[minigame_choice].isFinished == false
        minitable[minigame_choice] -> update()

    if get_key_up(VK_E)
        gamestate = "play"
    return

def minigame_draw(minigame_choice: string; text_choice)
    fill_rect(0, 0, get_screen_width(), get_screen_height(), 0x064e51)
    if minitable[minigame_choice].isFinished == true
        set_font_name("fonts/SilomBol.ttf")
        mess_window -> draw_window(text_table[text_choice])
    else
        minitable[minigame_choice] -> draw()
        set_font_name("fonts/SilomBol.ttf")
        text_out(50, int(screen_height) - 200, instructions, 0xffffff)
    return

def minigames_check(): int
    var amount = 0
    for i in range(1, 5)
        if minitable["minigame {i}"].isFinished != true
            amount++
    return amount