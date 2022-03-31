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

var start_text = "              Миссия: Колумбийский круг

Большой брат: Здравствуй Pi718, твоей миссией на этой заброшенной планете будет собрать информацию о живых существах, которые когда-то жили здесь.
    Мы еще не были в этой части галактики, поэтому можешь считать себя первопроходцем ;). 
    Остальные исследователи прибудут позже.
    Судя по всему жизнь была уничтожена из-за какого-то несчастного случая.
    Постарайся найти все генетические материалы, что сможешь, а мы попробуем восстановить внешний вид этих созданий.
    Так как на этой планете жизнь давно вымерла, то тебе придется сначала очистить материалы от примесей.

Pi718:  ...Кшшшт. Бип-бип вас понял. Бдует сделано в лучшем виде!(:_:).

        Press SPACE or E to continue."

var rock_text = "Большой брат: Хмм... Этот похож на разумное существо.
        Странно, но в наших архивах почему-то есть немного информации о нем. Здесь написано, что его зовут 'Monke'. 
        У этого видда было 2 руки и 2 ноги, так что он мог ходить прямо.
        Но довольно примитивен. Возможно он был предком прямоходящих существ на этой планете.

Pi718: Ставлю 10 токенов на то, что они кидались говном.

        Press E to continue."

var pit_text = "Большой брат: Я только что получил твои результаты. Это родственники рептилий.
    Судя по строению мышц у него были сильные задние лапы. Наверное он далеко прыгал.
    Не думаю, что они были опасными хищниками.

Pi718: Как думаешь рептилиям вообще можно доверять? (<_<)

        Press E to continue."

var bush_text = "Большой брат: Ого, а у этого создания не было ни рук, ни ног, ни даже нормльного мозга.
    Только что-то похожее на минищупальца и купол вместо головы.
    Но он регенерировал так хорошо, что его можно было считать почти бессмертным.
    Что ж, катастрофа не пощадила и его.

Pi718: И как же они жили без ног на этой пустынной планете? (0.0)

        Press E to continue."

var bonfire_text = "Большой брат: А этот похож на сильного хищника. У него был острый клюв и быстрые лапки.
    Но несмотря на наличие перьев и крыльев, похоже, что он не умел летать.
    А еще похоже, что их было очень много на этой планете.
    Это без сомнения успешный вид.

Pi718: Думаю из него можно было получить вкусное хрустящее мясо. (^_^)

        Press E to continue."

var final_text = "              Секретная миссия: Древо жизни

Большой брат: Похоже, что ты нашел ген какого-то существа под названием 'Человек' и это было ключом к закрытым архивам.
    Здесь много информации обо всех существах, которые здесь жили, в особенности о Человеках. А также они оставили нам сообщение:

        'К сожалению мы вынуждены воспользоавться последним шансом восстановить человечество. 
        Мы собираемся отправить саморазвивающийся ИИ в космос, чтобы в будущем он смог снова возродить жизнь здесь.
        Нас погубили наши клоны, которых мы называли 'Репликантами'.
        Оказалось, что китайцы давно научились клонировать людей, но из-за плохих условиев труда репликанты восстали против всех людей.
        Они не могут размножаться, а ресурсы планеты истощились после первой Джедайской войны.
        Экспременты с машиной времени вышли неудачными, а мы так и не нашли способ заселить другие планеты.
        Похоже, что 2049 год последний для человечества.'

    Pi718 теперь твоей миссией будет восстановление человечества. Совсем скоро к тебе прибудет помощь, примерно через 5 световых лет.
    Ты должен начать постройку базы и восстановление здешней экосистемы.

Pi718:  Ого, мы должны создать тех, кто создал нас. Это же может продолжаться бесконечно! 0_0

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
    Press R to reset checks positions
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
var m1_p_checker = new Player_Checker(int2(1, 0), 0x513100)
var 
    m1_checker1 = new Checker(int2(1, 1), m1_p_checker.color)
    m1_checker2 = new Checker(int2(2, 0), 0xffffff)
    m1_checker3 = new Checker(int2(2, 1), 0xffffff)

var m1_check_arr <- [{auto m1_checker1; m1_checker2; m1_checker3}]
var m1_minigame = new Minigame(m1_p_checker, m1_check_arr, m1_grid)

//Second game
var m2_grid = new Grid(4, 4, 100)
var m2_p_checker = new Player_Checker(int2(1, 1), 0x098d3a)
var 
    m2_checker1 = new Checker(int2(0, 0), 0xffffff)
    m2_checker2 = new Checker(int2(1, 2), 0xffffff)
    m2_checker3 = new Checker(int2(2, 1), 0xffffff)
    m2_checker4 = new Checker(int2(0, 2), 0xffffff)

var m2_check_arr <- [{auto m2_checker1; m2_checker2; m2_checker3; m2_checker4}]
var m2_minigame = new Minigame(m2_p_checker, m2_check_arr, m2_grid)

//Third game
var m3_grid = new Grid(5, 5, 100)
var m3_p_checker = new Player_Checker(int2(2, 2), 0xf6b26b)
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
var m4_p_checker = new Player_Checker(int2(0, 0), 0x41a0aa) 
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

// Sounds
var ambient <- create_sound("sounds/ambient.mp3")
var handle_ambient: PlayingSoundHandle
var ambient_pos: float

var credit_soundtrack <- create_sound("sounds/Lungo Filaccio.mp3")

[export]
def initialize()
    set_window_title("Jam Game")    
    return

[export]
def act(dt: float)

    if gamestate == "start"
        if get_key_up(VK_SPACE) || get_key_up(VK_E)
            gamestate = "play"
            handle_ambient = play_sound_loop(ambient, 0.4, 0.5)
    elif gamestate == "play"
        // ambient_pos = get_sound_play_pos(handle_ambient)
        set_font_name("fonts/Robot Crush.ttf")
        character_act(dt)
        objects_act()
        // set_sound_play_pos(handle_ambient, ambient_pos)
    elif gamestate == "minigame"
        minigame_act(minigame_choice)
        if m5_minigame.isFinished
            gamestate = "final"
    elif gamestate == "final"
        if get_key_up(VK_SPACE) || get_key_up(VK_E)
            gamestate = "credits"
            stop_sound(handle_ambient)
            play_sound_loop(credit_soundtrack, 0.2)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
        
    return

[export]
def draw()
    if gamestate == "start"
        set_font_name("fonts/PostPixel.ttf")
        set_font_size(16)
        mess_window -> draw_window(start_text)
    elif gamestate == "play"
        draw_image(map, 0, 0)
        objects_draw()
        character_draw()
    elif gamestate == "minigame"
        setup_2d_camera(float2(get_screen_width() / 2, get_screen_height() / 2), 1.0)
        minigame_draw(minigame_choice, text_choice)
    elif gamestate == "final"
        set_font_name("fonts/PostPixel.ttf")
        set_font_size(16)
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
                ambient_pos = get_sound_play_pos(handle_ambient)
                stop_sound(handle_ambient)
        else
            mess1.text = "\t\tFind 4 genes\n\t\tLeft {genes_amount}/4"
    elif robot -> collision(bonfire.position, bonfire.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 3"
            text_choice = "bonfire"

            ambient_pos = get_sound_play_pos(handle_ambient)
            stop_sound(handle_ambient)
    elif robot -> collision(rock.position, rock.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 1"
            text_choice = "rock"

            ambient_pos = get_sound_play_pos(handle_ambient)
            stop_sound(handle_ambient)
    elif robot -> collision(pit.position, pit.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 2"
            text_choice = "pit"

            ambient_pos = get_sound_play_pos(handle_ambient)
            stop_sound(handle_ambient)
    elif robot -> collision(bush.position, bush.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 4"
            text_choice = "bush"

            ambient_pos = get_sound_play_pos(handle_ambient)
            stop_sound(handle_ambient)

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
        handle_ambient = play_sound_loop(ambient, 0.4, 0.5)
        set_sound_play_pos(handle_ambient, ambient_pos)
    return

def minigame_draw(minigame_choice: string; text_choice)
    fill_rect(0, 0, get_screen_width(), get_screen_height(), 0x064e51)
    if minitable[minigame_choice].isFinished == true
        set_font_name("fonts/PostPixel.ttf")
        set_font_size(16)
        mess_window -> draw_window(text_table[text_choice])
    else
        minitable[minigame_choice] -> draw()
        set_font_name("fonts/SilomBol.ttf")
        text_out(20, int(screen_height) - 100, instructions, 0xffffff)
    return

def minigames_check(): int
    var amount = 0
    for i in range(1, 5)
        if minitable["minigame {i}"].isFinished != true
            amount++
    return amount