package game

import rl "vendor:raylib"
import "core:log"

Texture :: struct {
    texture: rl.Texture2D,
    scale, rotation: f32,
    tint: rl.Color,
    flipped: bool,
}

texture_init :: proc(path: cstring, scale: f32 = 1, rotation: f32 = 0, tint: rl.Color = rl.WHITE) -> Texture {
    t := Texture{
        texture = rl.LoadTexture(path),
        scale = scale,
        rotation = rotation,
        tint = tint,
    }
    if t.texture.id == 0 {
        log.warn("Failed to load texture at path", path)
    }
    return t
}

texture_deinit :: proc(t: Texture) {
    rl.UnloadTexture(t.texture)
}

texture_draw :: proc(t: Texture, pos: Vec2) {
    size := texture_size(t)
    draw_pos := pos - (size / 2)
    rl.DrawTextureEx(t.texture, draw_pos, t.rotation, t.scale, t.tint)
}

texture_draw_rect :: proc(t: Texture, rect: Rect, pos: Vec2, frame_offset: i32 = 1) {
    size := texture_size(t)
    dest := Rect{
        x = pos.x - (size.x / 2),
        y = pos.y - (size.y / 2),
        width = size.x,
        height = size.y * f32(frame_offset),
    }
    rl.DrawTexturePro(t.texture, rect_flip(rect) if t.flipped else rect, dest, VEC2_ZERO, t.rotation, t.tint)
}

texture_size :: proc(t: Texture) -> Vec2 {
    return texture_raw_size(t) * t.scale
}

texture_raw_size :: proc(t: Texture) -> Vec2 {
    return Vec2{
        f32(t.texture.width),
        f32(t.texture.height),
    }
}
