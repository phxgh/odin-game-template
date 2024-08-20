package game

import "core:log"

Signal_Proc :: proc()

Signal :: struct {
    procs: [dynamic]Signal_Proc,
}

signal_init :: proc() -> Signal {
    return Signal{}
}

signal_deinit :: proc(s: ^Signal) {
    delete(s.procs)
}

signal_connect :: proc(s: ^Signal, p: Signal_Proc) {
    append(&s.procs, p)
}

signal_emit :: proc(s: ^Signal) {
    for p in s.procs {
        p()
    }
}
