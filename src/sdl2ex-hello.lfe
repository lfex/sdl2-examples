(defmodule sdl2ex-hello
  (export (run 0)))

(defun run ()
  (logjam:start)
  (spawn_opt #'init/0 '(#(scheduler 0))))

(defun init ()
  (logjam:info "Starting 'hello' LFE SDL Example ...")
  (logjam:debug "Start SDL: ~p" `(,(sdl:start '(video))))
  (logjam:debug "Stop on exit: ~p" `(,(sdl:stop_on_exit)))
  (let* ((window (sdl2ex:get-window "Hello, SDL!" 10 10 500 500))
         (renderer (sdl2ex:get-renderer window))
         (texture (sdl2ex:get-texture renderer "priv/images/lfe.png")))
    (logjam:debug "Set draw color: ~p"
                  `(,(sdl_renderer:set_draw_color renderer 255 255 255 255)))
    (loop (map 'window window
               'renderer renderer
               'texture texture))))

(defun loop (state)
  (events-loop)
  (render state)
  (loop state))

(defun events-loop ()
  (case (sdl_events:poll)
    ('false 'ok)
    (`#m(type window event close) (terminate))
    (`#m(type quit) (terminate))
    (_ (events-loop))))

(defun render
  ((`#m(renderer ,renderer texture ,texture))
    (sdl_renderer:clear renderer)
    (sdl_renderer:copy renderer texture 'undefined #m(x 100 y 100  w 300 h 300))
    (sdl_renderer:present renderer)))

(defun terminate ()
  (logjam:debug "Stopping ... ~p" `(,(init:stop)))
  (exit 'normal))
