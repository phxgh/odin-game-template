package game

import rl "vendor:raylib"

Entity :: struct {
    current_animation: ^Animation,
    animations: [dynamic]Animation,
    pos, vel: Vec2,
    type: Entity_Type,
}

entity_init :: proc(x, y: f32) -> Entity {
    return Entity{
        current_animation = nil,
        animations = make([dynamic]Animation),
        pos = { x, y },
    }
}

entity_deinit :: proc(e: ^Entity) {
    for a in e.animations {
        animation_deinit(a)
    }
    delete(e.animations)
}

entity_update :: proc(e: ^Entity) {
    switch _ in e.type {
        case Player:
    }
    e.pos += e.vel * rl.GetFrameTime()
}

entity_draw :: proc(e: Entity) {
    
}

entity_add_animation :: proc(e: ^Entity, a: Animation) {
    append(&e.animations, a)
}

entity_switch_animation :: proc(e: ^Entity, al: string) {
    if e.current_animation.label == al {
        return
    }

    for _, i in e.animations {
        a := e.animations[i]
        if a.label == al {
            e.current_animation = &a
        }
    }
}

Entity_Type :: union {
    Player,
}

Player :: struct {

}
