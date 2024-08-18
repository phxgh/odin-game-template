package game

import rl "vendor:raylib"
import "core:log"

main :: proc() {
    context.logger = log.create_console_logger()

    game := game_init()
    defer game_deinit(&game)

    for !rl.WindowShouldClose() {
        game_update(&game)
        game_draw(&game)
    }
}
