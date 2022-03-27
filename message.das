require daslib/media

class Message_win
    position: float2
    size: float2
    img: ImageHandle

    text: string
    isVisible: bool

    def Message_win(Position: float2; Size: float2; Img: string)
        Message_win`set(self, Position, Size, Img)
        return
    
    def set(Position: float2; Size: float2; Img: string)
        position = Position
        size = Size
        img <- create_managed_image(Img)
        return

    def stick(char_pos: float2; char_size: float2)
        self.position.x = char_pos.x - self.size.x / 2.
        self.position.y = char_pos.y - self.size.y - char_size.y / 2.
        return

    def draw()
        if self.isVisible
            draw_image(img, position.x, position.y, 0xffffff, size)
            text_out(position.x + 10., position.y + 10., self.text, 0xffffff)
        return