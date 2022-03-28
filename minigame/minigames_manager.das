// require daslib/media
// require grid
// require checker
// require player_checker
// require minigame

// First game
// var m1_grid = new Grid(5, 2, 100)
// var m1_p_checker = new Player_Checker(int2(1, 0), 0xd48837)
// var 
//     m1_checker1 = new Checker(int2(1, 1), m1_p_checker.color)
//     m1_checker2 = new Checker(int2(2, 0), 0xffffff)
//     m1_checker3 = new Checker(int2(2, 1), 0xffffff)

// var m1_check_arr <- [{auto m1_checker1; m1_checker2; m1_checker3}]
// var m1_minigame = new Minigame(m1_p_checker, m1_check_arr, m1_grid)

// //Second game
// var m2_grid = new Grid(4, 4, 100)
// var m2_p_checker = new Player_Checker(int2(1, 1), 0x2b84f0)
// var 
//     m2_checker1 = new Checker(int2(0, 0), 0xffffff)
//     m2_checker2 = new Checker(int2(1, 2), 0xffffff)
//     m2_checker3 = new Checker(int2(2, 1), 0xffffff)
//     m2_checker4 = new Checker(int2(0, 2), 0xffffff)

// var m2_check_arr <- [{auto m2_checker1; m2_checker2; m2_checker3; m2_checker4}]
// var m2_minigame = new Minigame(m2_p_checker, m2_check_arr, m2_grid)

// //Third game
// var m3_grid = new Grid(5, 5, 100)
// var m3_p_checker = new Player_Checker(int2(2, 2), 0x18134c)
// var 
//     m3_checker1 = new Checker(int2(2, 1), 0xffffff)
//     m3_checker2 = new Checker(int2(3, 1), 0xffffff)
//     m3_checker3 = new Checker(int2(1, 2), 0xffffff)
//     m3_checker4 = new Checker(int2(2, 3), 0xffffff)
//     m3_checker5 = new Checker(int2(3, 3), 0xffffff)
//     m3_checker6 = new Checker(int2(2, 4), m3_p_checker.color)
//     m3_checker7 = new Checker(int2(3, 4), 0xffffff)

// var m3_check_arr <- [{auto m3_checker1; m3_checker2; m3_checker3; m3_checker4;
//     m3_checker5; m3_checker6; m3_checker7}]

// var m3_minigame = new Minigame(m3_p_checker, m3_check_arr, m3_grid)

// //Fourth fame
// var m4_grid = new Grid(7, 2, 100)
// var m4_p_checker = new Player_Checker(int2(0, 0), 0x2b84f0)
// var 
//     m4_checker1 = new Checker(int2(1, 0), 0xffffff)
//     m4_checker2 = new Checker(int2(3, 0), 0xffffff)
//     m4_checker3 = new Checker(int2(5, 0), 0xffffff)
//     m4_checker4 = new Checker(int2(1, 1), 0xffffff)
//     m4_checker5 = new Checker(int2(2, 1), m4_p_checker.color)
//     m4_checker6 = new Checker(int2(3, 1), 0xffffff)
//     m4_checker7 = new Checker(int2(5, 1), 0xffffff)
//     m4_checker8 = new Checker(int2(6, 1), m4_p_checker.color)

// var m4_check_arr <- [{auto m4_checker1; m4_checker2; m4_checker3; m4_checker4;
//     m4_checker5; m4_checker6; m4_checker7; m4_checker8}]
// var m4_minigame = new Minigame(m4_p_checker, m4_check_arr, m4_grid)

// var minitable <- {{
//     "minigame 1" => m1_minigame;
//     "minigame 2" => m2_minigame;
//     "minigame 3" => m3_minigame;
//     "minigame 4" => m4_minigame
//     }}

// def minigame_init()
//     return

// def minigame_act(minigame_choice: string; var Gamestate: string)
//     if minitable[minigame_choice].isFinished == true
//         if get_key(VK_E)
//             Gamestate = "play"
//     else
//         minitable[minigame_choice] -> update()
//     return

// def minigame_draw(minigame_choice: string)
//     fill_rect(0, 0, get_screen_width(), get_screen_height(), 0x064e51)
//     if minitable[minigame_choice].isFinished == true
//         text_out(get_screen_width() / 2 - 40, 100, "You Win", 0xffffff)
//     else
//         minitable[minigame_choice] -> draw()
//     return