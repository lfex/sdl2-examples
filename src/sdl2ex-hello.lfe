(defmodule sdl2ex-hello
  (export (run 0)))

(defun run ()
  (logjam:start)
  (spawn_opt #'init/0 '(#(scheduler 0))))

(defun init ()
  (logjam:info "Starting 'hello' LFE SDL Example ...")
  (sdl2ex:setup)
  (let* ((window (sdl2ex:get-window "Hello, SDL!" 10 10 500 500))
         (renderer (sdl2ex:get-renderer window))
         (texture (sdl2ex:get-texture renderer "priv/images/lfe.png")))
    (sdl2ex:set-bgcolor renderer 255 255 255 255)
    (loop (map 'window window
               'renderer renderer
               'texture texture))))

(defun loop (state)
  (sdl2ex:sdl-event-loop)
  (render state)
  (loop state))

(defun render
  ((`#m(renderer ,renderer texture ,texture))
    (sdl_renderer:clear renderer)
    (sdl_renderer:copy renderer texture 'undefined #m(x 100 y 100  w 300 h 300))
    (sdl_renderer:present renderer)))
