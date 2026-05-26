# Module Structure

I explored the internal structure of the `Jolt/` directory by running PowerShell file count commands and reading through folder names, class names, and documentation comments inside the repository. I also read `Docs/Architecture.md`, where the author explains some of the
main design decisions behind the engine.

The core library (`Jolt/`) contains 11 top-level modules with a total of 513 files. Most of the files are concentrated inside the
`Physics/` module — it alone contains 265 files (96 `.cpp` and 169 `.h` files), which is more than half of the entire core library.

The other modules are much smaller:

- `Core/` — 68 files
- `Compute/` — 46 files
- `Geometry/` — 27 files
- `Math/` — 25 files
- `ObjectStream/` — 23 files
- `Renderer/`, `Skeleton/`, `AABBTree/`, and `TriangleSplitter/` contain fewer than 10 files each

While exploring the `Physics/` module, I noticed that the largest submodule is `Collision/`, which contains collision detection logic and shape handling. It is further divided into folders such as `BroadPhase/` and `Shape/`, where different collision algorithms and shape types are implemented.

One thing I noticed is that the project clearly separates low-level utility modules (`Math`, `Core`, `Geometry`) from higher-level simulation modules (`Physics`, `Collision`, `Constraints`). This makes the overall structure easier to understand and maintain.

I also noticed a very high header-to-source ratio in the project: 362 `.h` files compared to 151 `.cpp` files in the core library. This suggests heavy use of templates and inline functions for performance optimization.

Overall, the repository feels well organized and modular. The smaller utility modules provide the foundation, while the larger `Physics` module contains most of the main simulation logic built on top of them.