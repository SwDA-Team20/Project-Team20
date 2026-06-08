# Module Structure

The internal structure of the `Jolt/` directory was examined using PowerShell file count commands. Folder names, class names, and documentation comments were reviewed throughout the repository. Docs/Architecture.md was also consulted to better understand the overall organization of the engine.

The core library (`Jolt/`) contains 11 top-level modules with a total of 513 files. Most of these files are concentrated within the `Physics/` module, which alone contains 265 files (96 .cpp and 169 .h files). This represents more than half of the entire core library.

| Module             | Files | Role                         |
|--------------------|------:|------------------------------|
| Physics/           | 265   | Main simulation pipeline     |
| Core/              | 68    | Memory, threading, utilities |
| Compute/           | 46    | GPU compute workloads        |
| Geometry/          | 27    | Geometric primitives         |
| Math/              | 25    | Math types and operations    |
| ObjectStream/      | 23    | Serialization                |
| Renderer/          | 8     | Debug visualization          |
| Skeleton/          | 8     | Skeletal animation support   |
| AABBTree/          | 5     | Bounding volume hierarchy    |
| TriangleSplitter/  | 6     | Mesh processing              |
| Other              | 19    | Platform and miscellaneous   |
| **Total**          | **513** |                            |

Within the `Physics/` module, the largest submodule is `Collision/`, which contains collision detection logic and shape handling functionality. This submodule is further divided into directories such as `BroadPhase/` and `Shape/`, where different collision algorithms and shape implementations are maintained.

A clear separation exists between low-level utility modules (`Math`, `Core`, and `Geometry`) and higher-level simulation modules (`Physics`, `Collision`, and `Constraints`). This structure reflects the engine's goal of keeping foundational utilities independent from the main simulation logic. The `Compute/` module handles GPU-accelerated workloads and remains separate from the CPU-based physics pipeline.

Another notable observation is the header-to-source ratio within the core library. A total of 362 header files were identified compared to 151 source files. This suggests extensive use of C++ templates and inline functions, which are commonly used in performance-critical libraries where the compiler benefits from having access to full implementations during compilation.

Overall, the repository appears well organized and modular. Smaller utility modules provide the foundation of the engine, while the larger Physics module contains most of the simulation functionality built on top of those lower-level components.