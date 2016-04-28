(defmodule sdl2ex
  (doc "Various utility and wrapper functions for the examples.")
  (export all))

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
