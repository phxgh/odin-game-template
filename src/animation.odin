package game

import rl "vendor:raylib"
import "core:log"

Animation :: struct {
    label: string,
    texture: Texture,
    frames: []i32,
    cur_index, cur_frame: i32,
    total_frames: i32,
    frame_length, frame_timer: f32,
}

animation_init :: proc(label: string, texture: Texture, frames: []i32, frame_length: f32, total_frames: i32) -> Animation {
    a := Animation{
        label = label,
        texture = texture,
        cur_index = 0,
        total_frames = total_frames,
        frame_length = frame_length,
        frame_timer = frame_length
    }
    
    a.frames = make([]i32, len(frames))
    for _, i in a.frames {
        a.frames[i] = frames[i]
    }

    return a
}

animation_deinit :: proc(a: Animation) {
    delete(a.frames)
    texture_deinit(a.texture)
}

animation_update :: proc(a: ^Animation) {
    if len(a.frames) == 0 {
        log.error("Animation given 0 frames")
        return
    }
    
    if a.frame_length == 0 {
        a.cur_frame = a.frames[0]
        return
    }

    a.frame_timer -= rl.GetFrameTime()
    if a.frame_timer <= 0 {
        a.frame_timer = a.frame_length

        a.cur_index += 1
        if a.cur_index >= i32(len(a.frames)) {
            a.cur_index = 0
        }
        a.cur_frame = a.frames[a.cur_index]
    }
}

animation_draw :: proc(a: Animation, pos: Vec2) {
    texture_draw_rect(a.texture, animation_rect(a), pos, a.total_frames)
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
