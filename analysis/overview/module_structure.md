# Module Structure

I explored the internal structure of the `Jolt/` directory by running PowerShell file count commands and reading through folder names, class names, and documentation comments inside the repository. I also read `Docs/Architecture.md`, where the author explains some of the
main design decisions behind the engine.

The core library (`Jolt/`) contains 11 top-level modules with a total of 513 files. Most of the files are concentrated inside the
`Physics/` module — it alone contains 265 files (96 `.cpp` and 169 `.h` files), which is more than half of the entire core library.

| Module           | Number of Files |
|------------------|-----------------|
| Physics          | 265             |
| Core             | 68              |
| Compute          | 46              |
| Geometry         | 27              |
| Math             | 25              |
| ObjectStream     | 23              |
| Renderer         | ~10             |
| Skeleton         | ~10             |
| AABBTree         | ~10             |
| TriangleSplitter | ~10             |
| Other            | ~19             |
| **Total**        | **513**         |

While exploring the `Physics/` module, I noticed that the largest submodule is `Collision/`, which contains collision detection logic and shape handling. It is further divided into folders such as `BroadPhase/` and `Shape/`, where different collision algorithms and shape types are implemented.

One thing I noticed is that the project clearly separates low-level utility modules (`Math`, `Core`, `Geometry`) from higher-level simulation modules (`Physics`, `Collision`, `Constraints`). This structure reflects the engine's design goal of keeping foundational utilities independent from the main simulation logic. The `Compute/` module handles GPU accelerated workloads and is separate from the CPU based physics pipeline. This makes the overall structure easier to understand and maintain.

One thing I found interesting is the header-to-source ratio: within the core library, I counted 362 .h files compared to 151 .cpp files. This is a strong indicator that the project makes heavy use of C++ templates and inline functions, a common pattern in performance critical libraries where the compiler needs to see the full implementation at the call site to generate optimised code.

Overall, the repository feels well organized and modular. The smaller utility modules provide the foundation, while the larger `Physics` module contains most of the main simulation logic built on top of them.