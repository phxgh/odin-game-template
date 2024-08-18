package game

import rl "vendor:raylib"

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(1280, 720, "")
    rl.SetTargetFPS(240)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
            rl.ClearBackground(rl.WHITE)
        rl.EndDrawing()
    }
}
