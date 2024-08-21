package game

import rl "vendor:raylib"
import "core:log"

GAME_BG_DRAW_COLOR :: rl.BLACK

Game :: struct {
    entities: [dynamic]Entity,
}

game_init :: proc(title: cstring, width, height: i32) -> Game {
    game_init_window(title, width, height)

    g := Game{
        entities = make([dynamic]Entity),
    }

    player_texture := texture_init("assets/player.png")
    player := entity_init(f32(width) / 2, f32(height) / 2, Player{})
    entity_add_animation(&player, animation_init("idle", player_texture, { 0 }, 0, 4))
    entity_add_animation(&player, animation_init("walk", player_texture, { 0, 1 }, 0.175, 4))
    entity_add_animation(&player, animation_init("jump", player_texture, { 2 }, 0, 4))
    entity_add_animation(&player, animation_init("fall", player_texture, { 3 }, 0, 4))
    entity_switch_animation(&player, "idle")
    append(&g.entities, player)

    return g
}

game_init_window :: proc(title: cstring, width, height: i32) {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(width, height, title)
}

game_deinit :: proc(g: ^Game) {
    for _, i in g.entities {
        entity_deinit(&g.entities[i])
    }
    delete(g.entities)

    game_deinit_window()
}

game_deinit_window :: proc() {
    rl.CloseWindow()
}

game_update :: proc(g: ^Game) {
    for _, i in g.entities {
        entity_update(&g.entities[i])
    }
}

game_draw :: proc(g: ^Game) {
    rl.BeginDrawing()
        rl.ClearBackground(GAME_BG_DRAW_COLOR)
        for e in g.entities {
            entity_draw(e)
        }
    rl.EndDrawing()
}
