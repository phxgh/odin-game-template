package game

import rl "vendor:raylib"

GAME_BG_DRAW_COLOR :: rl.Color{183, 184, 196, 255}

Game :: struct {
    entities: [dynamic]Entity,
}

game_init :: proc(title: cstring, width, height: i32) -> Game {
game_init_window(title, width, height)

    g := Game{
        entities = make([dynamic]Entity),
    }
    // initialize game entity list here

    return g
}

game_init_window :: proc(title: cstring, width, height: i32) {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(width, height, title)
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
