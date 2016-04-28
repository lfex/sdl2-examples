# sdl2-examples

[![][sdl-logo]][sdl-logo-large]

*SDL2 Examples in LFE*


##### Contents

* [Introduction](#introduction-)
* [Dependencies](#dependencies-)
* [Installation](#installation-)
* [Usage](#usage-)
* [License](#license-)


## Introduction [&#x219F;](#contents)

Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D. It is used by video playback software, emulators, and popular games including Valve's award winning catalog and many Humble Bundle games.

The Erlang/LFE/Elixir ecosystem have access to SDL via the following Erlang libraries:

* [esdl](https://github.com/dgud/esdl)
* [esdl2](https://github.com/ninenines/esdl2)

The example in this repo take advantage of the newer SDL2 library and the Erlang bindings
for it that Loïc has made available with esdl2.


## Dependencies [&#x219F;](#contents)

The following are required to be installed on your system:

* Erlang
* rebar3
* SDL2


## Installation [&#x219F;](#contents)

In your ``rebar.config`` file, update your ``deps`` section to include
``lutil``:

```erlang
{deps, [
  {sdl2ex, {git, "https://github.com/lfex/sdl2-examples.git"}}
]}
```


## Usage [&#x219F;](#contents)

Start up the LFE repl:

```bash
$ make repl
```

Then run the example:

```lisp
> (sdl2ex-hello:run)
```

This will open up a window like you see here:

[![Hello SDL screenshot][sdl-hello-screen-thumb]][sdl-hello-screen]

When you're done admiring the logo, closing the window will cause the LFE application to shutdown.


## License [&#x219F;](#contents)

Original Erlang:

```
Copyright © 2014-2015, Loïc Hoguin
```

LFE port:
```
Copyright © 2016 Duncan McGreggor

Distributed under the Apache License, Version 2.0.
```

<!-- Named page links below: /-->

[sdl-logo]: priv/images/sdl-logo-x250.png
[sdl-logo-large]: priv/images/sdl-logo-x1480.png

[sdl-hello-screen-thumb]: priv/images/screenshot-hello-sdl-thumb.png
[sdl-hello-screen]: priv/images/screenshot-hello-sdl.png
