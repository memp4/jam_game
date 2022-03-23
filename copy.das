def swap(var p_checker: Player_Checker?; var check_arr: array<Checker?>)
        if p_checker.direction == "up"
            for i in check_arr
                if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 1)
                    i.tab_pos.y += 1
                    p_checker.tab_pos.y -= 1
                    break

        elif p_checker.direction == "right"
            for i in check_arr
                if i.tab_pos == int2(p_checker.tab_pos.x + 1, p_checker.tab_pos.y)
                    i.tab_pos.x -= 1
                    p_checker.tab_pos.x += 1
                    break

        elif p_checker.direction == "down"
            for i in check_arr
                if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 1)
                    i.tab_pos.y -= 1
                    p_checker.tab_pos.y += 1
                    break

        elif p_checker.direction == "left"
            for i in check_arr
                if i.tab_pos == int2(p_checker.tab_pos.x - 1, p_checker.tab_pos.y)
                    i.tab_pos.x += 1
                    p_checker.tab_pos.x -= 1
                    break
        return

def jump(var p_checker: Player_Checker?; var check_arr: array<Checker?>; grid: Grid?)
    if p_checker.direction == "up"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 2)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 1) && i.color != p_checker.color && is_jump && i.tab_pos.y != 0
                p_checker.tab_pos.y -= 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "right"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x + 2, p_checker.tab_pos.y)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x + 1, p_checker.tab_pos.y) && i.color != p_checker.color && is_jump && i.tab_pos.x != grid.columns - 1
                p_checker.tab_pos.x += 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "down"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 2)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 1) && i.color != p_checker.color && is_jump && i.tab_pos.y != grid.rows - 1
                p_checker.tab_pos.y += 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "left"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x - 2, p_checker.tab_pos.y)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x - 1, p_checker.tab_pos.y) && i.color != p_checker.color && is_jump && i.tab_pos.x != 0
                p_checker.tab_pos.x -= 2
                i.color = p_checker.color
                break
    return