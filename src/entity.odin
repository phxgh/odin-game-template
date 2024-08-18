package game

Entity :: struct {
    animation: Animation,
    pos, vel: Vec2,
    entity_type: Entity_Type,
}

entity_init :: proc(animation: Animation, x, y: f32) -> Entity {
    return Entity{
        animation = animation,
        pos = { x, y },
    }
}

entity_deinit :: proc(e: Entity) {
    animation_deinit(e.animation)
}

entity_draw :: proc(e: Entity) {
    animation_draw(e.animation, e.pos)
}

entity_update :: proc(e: ^Entity) {
    switch _ in e.entity_type {
        case Player:
            // Update player
    }
    animation_update(&e.animation)
}

/* NOTE: you can essentially use this as an enum that can hold
data specialized to each entity. You can also use an empty struct
and just name it if you don't need specialized data for the entity*/
Entity_Type :: union {
    Player,
}

Player :: struct {

}
