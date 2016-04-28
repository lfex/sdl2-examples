# sdl2-examples

[![][sdl-logo]][sdl-logo-large]

[sdl-logo]: priv/images/sdl-logo-x250.png
[sdl-logo-large]: priv/images/sdl-logo-x1480.png

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

