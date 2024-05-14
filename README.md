
    error: module Nitro is not loaded and could not be found. This may be happening because the module you are trying to load directly or indirectly depends on the current module
    │
  3 │     import Nitro
    │     ^
    │
    └─ lib/routes.ex:3:5: Sample.Routes (module)

    error: module Nitro is not loaded and could not be found. This may be happening because the module you are trying to load directly or indirectly depends on the current module
    │
  3 │     import Nitro
    │     ^
    │
    └─ lib/chatweb.ex:3:5: ChatWeb.ChatController (module)

mix deps.get
Resolving Hex dependencies...
Resolution completed in 0.02s
Unchanged:
  kvs 10.8.2
  n2o 10.12.3
  nitro 8.2.4
All dependencies are up to date
