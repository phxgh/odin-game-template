package game

import rl "vendor:raylib"

Game :: struct {
    entities: [dynamic]Entity,
}

game_init :: proc() -> Game {
    game_init_window()

    g := Game{
        entities = make([dynamic]Entity),
    }
    // initialize game entity list here

    return g
}

game_init_window :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(1280, 720, "")
}

game_deinit :: proc(g: ^Game) {
    game_deinit_window()

    delete(g.entities)
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
        rl.ClearBackground(rl.WHITE)
        for e in g.entities {
            entity_draw(e)
        }
    rl.EndDrawing()
}
