(defmodule sdl2ex-hello
  (export (run 0)))

(defun run ()
  (spawn_opt #'init/0 '(#(scheduler 0))))

(defun init ()
  (logjam:start)
  (logjam:debug "Start: ~p" `(,(sdl:start)))
  (logjam:debug "Stop on exit: ~p" `(,(sdl:stop_on_exit)))
  (let* ((`#(ok ,window) (sdl_window:create "Hello, SDL!" 10 10 500 500 '()))
         (`#(ok ,renderer) (sdl_renderer:create window
                             -1 '(accelerated present_vsync)))
         ('ok (sdl_renderer:set_draw_color renderer 255 255 255 255))
         (`#(ok ,texture) (sdl_texture:create_from_file
                            renderer "priv/images/lfe.png")))
    (loop (map 'window window 'renderer renderer 'texture texture))))

(defun loop (state)
  (events-loop)
  (render state)
  (loop state))

(defun events-loop ()
  (case (sdl_events:poll)
    ('false 'ok)
    (`#m(type quit) (terminate))
    (_ (events-loop))))

(defun render
  ((`#m(renderer ,renderer texture ,texture))
    (sdl_renderer:clear renderer)
    (sdl_renderer:copy renderer texture 'undefined #m(x 100 y 100  w 300 h 300))
    (sdl_renderer:present renderer)))

(defun terminate ()
  (init:stop)
  (exit 'normal))
