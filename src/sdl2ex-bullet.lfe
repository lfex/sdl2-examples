(defmodule sdl2ex-bullet
  (export (run 0)))

(include-lib "clj/include/compose.lfe")

(defun run ()
  (logjam:start)
  (spawn #'init/0))

(defun init ()
  (logjam:info "Starting 'bullet-engine' LFE SDL Example ...")
  (sdl2ex:setup)
  (let* ((window (sdl2ex:get-window "Bullets, SDL!" 10 10 500 600))
         (renderer (sdl2ex:get-renderer window))
         (texture (sdl2ex:get-texture renderer "priv/images/bullet.png")))
    (sdl2ex:set-size renderer (bsl 500 16) (bsl 600 16))
    (loop (map 'window window
               'renderer renderer
               'texture texture
               'scene (init-scene)))))

(defun loop (state)
  (sdl2ex:sdl-event-loop)
  (-> state
      (update-state)
      (render)
      (loop)))

(defun update-state
  (((= `#m(scene ,scene) state))
    (maps:put 'scene (update-scene scene '()) state))
  ((state)
    (logjam:warning "Could not update state")
    state))

(defun update-scene
  (('() acc)
    (lists:flatten acc))
  (((cons (= `#m(x ,x y ,y w ,w h ,h
                 dir ,dir speed ,speed
                 wait ,wait actions ,actions) bullet) tail) acc)
    (let* ((a (/ (* 103993 (- dir 90)) (* 33102 180)))
           (x (+ x (round (* speed (math:cos a)))))
           (y (+ y (round (* speed (math:sin a))))))
      (cond
        ((> wait 0)
          (update-scene
            tail (cons
                   (maps:merge
                     bullet
                     `#m(x ,x y ,y wait ,(- wait 1)))
                   acc)))
        ((andalso (> x (bsl 500 16))
                  (< x (* -1 w))
                  (> y (bsl 600 16))
                  (< y (* -1 h)))
          (update-scene tail acc))
        ('true
          (let ((new (update-bullet
                       (maps:merge bullet `#m(x ,x y ,y))
                       actions
                       '())))
            (update-scene tail (cons new acc))))))))

(defun render
  (((= `#m(scene ()) state))
    (logjam:warning "Empty scene data")
    state)
  (((= `#m(renderer ,renderer texture ,texture scene ,scene) state))
    ;;(logjam:debug "Clearing renderer: ~p" `(,(sdl_renderer:clear renderer)))
    (sdl_renderer:clear renderer)
    (list-comp ((<- bullet scene))
               (copy-bullet renderer texture bullet))
    ;;(logjam:debug
    ;;  "Presenting renderer: ~p" `(,(sdl_renderer:present renderer)))
    (sdl_renderer:present renderer)
    state))

(defun copy-bullet
  ((_ _ `#m(t invisible))
    ;;(logjam:debug "Skipping bullet copy (invisible) ..."))
    'noop)
  ((renderer texture bullet)
    (logjam:debug "Copying bullet ...")
    (sdl_renderer:copy renderer texture 'undefined bullet)))

(defun init-scene ()
  (logjam:debug "Initializing scene ...")
  `(,(new-invisible (init-data))))

(defun init-data ()
  (maps:put 'actions
            (init-action-data)
            (init-position-data)))

(defun init-position-data ()
  `#m(x ,(bsl 250 16)
      y ,(bsl 300 16)
      w 0
      h 0
      actions ()))

(defun init-action-data ()
  `(
    ;; Part 1
    #(var w 31)
    #(var x 0)
    #(loop 30 (
      #(loop 12 (
        #(fire (
          #(set speed ,(bsl 2 16))
          #(set dir x)))
        #(var x '+= 30)))
      #(wait w)
      #(var w '+= -1)))
    ;; Part 2
    #(var y 31)
    #(var z -3)
    #(loop 2 (
      #(loop 21 (
        #(loop 18 (
          #(fire (
            #(set speed ,(bsl 2 16))
            #(set dir x)))
          #(var x '+= y)
          #(wait 1)))
        #(var y '+= z)))
      #(var z '*= -1)))
    ;; Part 3
    #(var i 45)
    #(var n 4)
    #(loop 4 (
      #(wait 60)
      #(fire (
        #(set w ,(bsl 64 16))
        #(set h ,(bsl 64 16))
        #(set dir i)
        #(set speed ,(bsl 2 16))
        #(loop 10 (
          #(fire (
            #(var j 180)
            #(var j '+= i)
            #(set dir j)
            #(set speed ,(bsl 10 16))))
          #(wait 6)))
        #(set speed 0)
        #(var w 60)
        #(var w '*= n)
        #(wait w)
        #(var d 90)
        #(var n '+= -4)
        #(var n '*= -1)
        #(var d '*= n)
        #(var d '*= -255)
        #(set dir d)
        #(set speed ,(bsl 3 16))
        #(loop 120 (
          #(var d '+= 3)
          #(set dir d)
          #(wait 1)))
        #(loop 120 (
          #(fire ())
          #(loop 3 (
            #(var d '+= 3)
            #(set dir d)
            #(wait 1)))))
        #(loop 120 (
          #(fire ())
          #(var d2 180)
          #(var d2 '+= d)
          #(fire (
            #(set dir d2)))
          #(loop 3 (
            #(var d '+= 3)
            #(set dir d)
            #(wait 1)))))
        #(loop 120 (
          #(fire ())
          #(var d2 180)
          #(var d2 '+= d)
          #(fire (
            #(set dir d2)))
          #(loop 2 (
            #(var d '+= 3)
            #(set dir d)
            #(wait 1)))))
        #(loop 120 (
          #(fire ())
          #(var d2 180)
          #(var d2 '+= d)
          #(fire (
            #(set dir d2)))
          #(var d '+= 3)
          #(set dir d)
          #(wait 1)))
        #(wait 240)))
      #(var i '+= 90)
      #(var n '+= -1)))
    #(wait 2640)
    init_stop))


(defun new-invisible (parent)
  (maps:merge parent #m(t invisible
                        w 0
                        h 0
                        dir 0
                        speed 0
                        wait 0
                        vars #m())))

(defun new-bullet
  (((= `#m(x ,x y ,y w ,w h ,h) parent) actions)
    (maps:merge parent ))

(defun update-bullet
  ((bullet '() acc)
    bullet)
  ((bullet _ _)
    bullet))
