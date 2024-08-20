package game

import rl "vendor:raylib"

Vec2 :: rl.Vector2
Vec3 :: rl.Vector3

Rect :: rl.Rectangle
Camera :: rl.Camera2D

VEC2_ZERO :: Vec2{}
VEC3_ZERO :: Vec3{}

RECT_EMPTY :: Rect{}

rect_flip :: proc(r: Rect) -> Rect {
    return Rect{
        r.x, r.y,
        -r.width, r.height
    }
}

array_equals :: proc(a, b: []i32) -> bool {
    res := true
    if len(a) != len(b) {
        res = false
    } else {
        for _, i in a {
            if a[i] != b[i] {
                res = false
            }
        }
    }
    return res
} 
