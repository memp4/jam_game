require daslib/media

class Grid
    columns: int
    rows: int
    size: int
    x_start: int
    y_start: int

    def Grid(Columns, Rows, Size: int)
        Grid`set(self, Columns, Rows, Size)
        return

    def set(Columns, Rows, Size: int)
        columns = Columns
        rows = Rows 
        size = Size
        x_start = get_screen_width()/2 - self.columns*self.size/2
        y_start = get_screen_width()/4 - self.rows*self.size/2
        return
    
    // Returns table with coordinates of center for every cell
    // Table format [row] = array<int2(x_coord, y_coord)>>
    def get_coords(): table<int; array<int2>>
        var half_size = self.size / 2
        var tab: table<int; array<int2>> 
        for column in range(self.rows)
            var arr: array<int2>
            for cell in range(self.columns)
                push(arr, int2(x_start + half_size + cell * self.size,
                    y_start + half_size + column * self.size))
            tab[column] <- arr
        return <- tab

    //Draws grid for minigame dependent on amount of clomuns and rows, and cell sizes
    def draw()
        for row in range(self.rows)
            for cell in range(self.columns)
                rect(x_start + self.size * cell, y_start + self.size * row,
                    self.size, self.size, 0xffffff)
        return