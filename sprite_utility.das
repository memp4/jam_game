require daslib/media

// Creates grid from spritesheet
def sprite_grid(spritesheet: ImageHandle; sprite_size: float2): table<int; array<float4>>
    let spritesheet_height = spritesheet.height / int(sprite_size.y)
    let spritesheet_width = spritesheet.width / int(sprite_size.x)
    var tab: table<int; array<float4>>
    for i in range(spritesheet_height)
        var arr: array<float4>
        for j in range(spritesheet_width)
            var sprite = float4(sprite_size.x * float(j), sprite_size.y * float(i),
                sprite_size.x, sprite_size.y)
            push(arr, sprite)
        tab[i] <- arr
    
    return <- tab