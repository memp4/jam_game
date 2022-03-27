require daslib/media

class Col_object
    position: float2
    size: float2
    
    def Col_object(Position: float2; Size: float2)
        Col_object`set(self, Position, Size)
        return
    
    def set(Position: float2; Size: float2)
        position = Position
        size = Size
        return

    def draw()
        rect(self.position.x, self.position.y, self.size.x, self.size.y, 0xffffff)
        return