package game

import rl "vendor:raylib"
import "core:log"

Entity :: struct {
    anims: map[string]Animation,
    cur_anim: string,
    pos, vel: Vec2,
    type: Entity_Type,
}

entity_init :: proc(x, y: f32, type: Entity_Type) -> Entity {
    return Entity{
        anims = make(map[string]Animation),
        cur_anim = "",
        pos = { x, y },
        type = type,
    }
}

entity_deinit :: proc(e: ^Entity) {
    for _, a in e.anims {
        animation_deinit(a)
    }
    delete_map(e.anims)
}

entity_update :: proc(e: ^Entity) {
    switch _ in e.type {
        case Player:
            if rl.IsKeyPressed(.SPACE) {
                entity_switch_animation(e, "walk")
            }
    }
    animation_update(&e.anims[e.cur_anim])
    e.pos += e.vel * rl.GetFrameTime()
}

entity_draw :: proc(e: Entity) {
    animation_draw(e.anims[e.cur_anim], e.pos)
}

entity_add_animation :: proc(e: ^Entity, a: Animation) {
    e.anims[a.label] = a
}

entity_switch_animation :: proc(e: ^Entity, label: string) {
    log.info("Attempting to switch to animation", label)

    if e.anims[e.cur_anim].label == label {
        log.info("Animation being switched to & current animation are the same. Did not switch")
        return
    }

    for _, i in e.anims {
        a := e.anims[label]
        if a.label == label {
            e.cur_anim = label
            return
        }
    }

    log.warn("Failed to switch to animation, no animation found with label", label)
}

Entity_Type :: union {
    Player,
}

Player :: struct {

}
