package game

import rl "vendor:raylib"
import "core:log"

TITLE :: ""
WIDTH :: 1280
HEIGHT :: 720

main :: proc() {
    context.logger = log.create_console_logger()

    game := game_init(TITLE, WIDTH, HEIGHT)
    defer game_deinit(&game)

    for !rl.WindowShouldClose() {
        game_update(&game)
        game_draw(&game)
    }
}
