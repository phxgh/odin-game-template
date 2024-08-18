package game

import rl "vendor:raylib"
import "core:log"

Animation :: struct {
    texture: Texture,
    frames: []i32,
    speed: i32,
    cur_index, cur_frame: i32,
    total_frames: i32,
    counter: f32,
}

animation_init :: proc(texture: Texture, frames: []i32, speed: i32, total_frames: i32) -> Animation {
    a := Animation{
        texture = texture,
        cur_index = -1,
        total_frames = total_frames,
    }
    animation_switch(&a, frames, speed)
    return a
}

animation_deinit :: proc(a: Animation) {
    delete(a.frames)
    texture_deinit(a.texture)
}

animation_update :: proc(a: ^Animation) {
    if a.speed <= 0 {
        a.cur_frame = a.frames[0]
        return
    }

    a.counter += 1
    if a.counter >= f32(rl.GetFPS()) / f32(a.speed) {
        a.cur_index += 1
        if a.cur_index >= i32(len(a.frames)) {
            a.cur_index = 0
        }
        a.cur_frame = a.frames[a.cur_index]
    }
}

animation_draw :: proc(a: Animation, pos: Vec2) {
    texture_draw_rect(a.texture, animation_rect(a), pos)
}

animation_switch :: proc(a: ^Animation, frames: []i32, speed: i32) {
    if a.frames != nil {
        delete(a.frames)
    }
    a.frames = make([]i32, len(frames))
    for _, i in a.frames {
        a.frames[i] = frames[i]
    }

    a.counter = 0
    a.speed = speed
    a.cur_index = -1
}

animation_rect :: proc(a: Animation) -> Rect {
    if a.total_frames == 0 {
        log.error("Animation given 0 frames")
        return RECT_EMPTY
    }

    size := texture_raw_size(a.texture)
    width := (size.x / f32(a.total_frames))
    return Rect{
        x = f32(a.cur_frame) * width,
        y = 0,
        width = width,
        height = size.y,
    }
}
