require daslib/media

class Message
    position: float2
    size: float2
    img: ImageHandle

    text: string
    isVisible: bool

    def Message(Position: float2; Size: float2; Img: string; Text: string)
        Message`set(self, Position, Size, Img, Text)
        return
    
    def set(Position: float2; Size: float2; Img: string; Text: string)
        position = Position
        size = Size
        img <- create_managed_image(Img)
        text = Text
        return

    def stick(char_pos: float2; char_size: float2)
        self.position.x = char_pos.x - self.size.x / 2.
        self.position.y = char_pos.y - self.size.y - char_size.y / 2.
        return

    def draw()
        if self.isVisible
            draw_image(img, position.x, position.y, 0xffffff, size)
            text_out(position.x + 15., position.y + 10., self.text, 0xffffff)
        return
    
    def draw_window(Text: string)
        draw_image(img, position.x, position.y, 0xffffff, size)
        text_out(position.x + 80., position.y + 100., Text, 0xffffff)
        return
