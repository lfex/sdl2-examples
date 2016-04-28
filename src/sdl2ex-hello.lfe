(defmodule sdl2ex-hello
  (export (run 0)))

(defun run ()
  (logjam:start)
  (spawn_opt #'init/0 '(#(scheduler 0))))

(defun init ()
  (logjam:debug "Start: ~p" `(,(sdl:start)))
  (logjam:debug "Stop on exit: ~p" `(,(sdl:stop_on_exit)))
  (let* ((window (get-window "Hello, SDL!" 10 10 500 500))
         (renderer (get-renderer window))
         (texture (get-texture renderer "priv/images/lfe.png")))
    (logjam:debug "Set draw color: ~p"
                  `(,(sdl_renderer:set_draw_color renderer 255 255 255 255)))
    (loop (map 'window window
               'renderer renderer
               'texture texture))))

(defun get-window (title x y w h)
  (case (sdl_window:create title x y w h '())
    (`#(ok ,window) window)
    (err (logjam:error "~p" `(,err)))))

(defun get-renderer (window)
  (let ((index -1)
        (flags '(accelerated present_vsync)))
    (case (sdl_renderer:create window index flags)
      (`#(ok ,renderer) renderer)
      (err (logjam:error "~p" `(,err))))))

(defun get-texture (renderer image-file)
  (case (sdl_texture:create_from_file renderer image-file)
    (`#(ok ,texture) texture)
    (err (logjam:error "~p" `(,err)))))

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
  (logjam:debug "Stopping ... ~p" `(,(init:stop)))
  (exit 'normal))
