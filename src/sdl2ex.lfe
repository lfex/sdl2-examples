(defmodule sdl2ex
  (doc "Various utility and wrapper functions for the examples.")
  (export all))

(defun setup ()
  (logjam:debug "Start SDL: ~p" `(,(sdl:start '(video))))
  (logjam:debug "Stop on exit: ~p" `(,(sdl:stop_on_exit))))

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

(defun set-bg-color (renderer r g b a)
  (let ((response (sdl_renderer:set_draw_color renderer r g b a)))
    (logjam:debug "Set draw color: ~p" `(,response))))

(defun set-size (renderer w h)
  (let ((response (sdl_renderer:set_logical_size renderer w h)))
    (logjam:debug "Set size: ~p" `(,response))))

(defun sdl-event-loop ()
  (case (sdl_events:poll)
    ('false 'ok)
    (`#m(type window event close) (terminate))
    (`#m(type quit) (terminate))
    (_ (sdl-event-loop))))

(defun terminate ()
  (logjam:debug "Stopping ... ~p" `(,(init:stop)))
  (exit 'normal))
