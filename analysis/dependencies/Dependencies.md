## 1. Dependencies Analysis

### 1.1 Methodology

To evaluate the dependencies among the software modules within the core Jolt Physics library, we employed this approach:

1. **Code Dependencies (Static Analysis):** We utilized **Doxygen** in conjunction with **Graphviz (Dot)** to parse the source code and extract structural dependencies. We configured Doxygen to recursively scan the directory and generate inclusion and inverse-inclusion graphs (with a maximum graph depth of 3). This allowed us to map afferent (incoming) and efferent (outgoing) coupling visually.
2. **Knowledge Dependencies (Behavioral Analysis):** To assess co-change frequencies, we analyzed the repository's Git history. We extracted the commit logs on the main branch using custom `git log` commands to identify sets of files that are frequently modified together within the same commit, indicating a logical or architectural coupling.

### 1.2 Code Dependencies Results 

#### Files with the Most Dependencies
The files exhibiting the highest number of outgoing dependencies are central implementation files (`.cpp`) that act as orchestrators or manage complex geometry and simulation logic:

* **`MeshShape.cpp` (36 dependencies):** This file handles complex mesh-based collision detection. Its high dependency count is justified by the need to interact with bounding volume hierarchies (BVH), triangle intersection algorithms, and various collision interfaces.
![MeshShape.cpp Dependency Graph](./images/mesh_shape_graph.svg)

* **`PhysicsSystem.cpp` (31 dependencies):** This is the core orchestrator of the JoltPhysics engine. It coordinates bodies, constraints, shapes, and the simulation steps. Its high coupling is a natural consequence of its role as the central "hub" or Facade of the engine.
![PhysicsSystem.cpp Dependency Graph](./images/physics_system_graph.svg)

* **`HeightFieldShape.cpp` (30 dependencies):** Similar to the mesh shape, this file manages terrain-like collision structures, requiring integration with multiple specialized math and collision utilities.
![HeightFieldShape.cpp Dependency Graph](./images/height_field_shape_graph.svg)

#### Files with the Least Dependencies
Conversely, a large number of header files (`.h`) exhibit zero outgoing dependencies. We can categorize them into two main architectural groups:

* **Foundational Math & Utilities:** Files such as `Vector.h`, `Plane.h`, `Math.h`, `Color.h`, and `Memory.h`. 
* **Enums and Configuration:** Files such as `BodyType.h`, `MotionType.h`, and `PhysicsSettings.h`.

These files represent the lowest layer of the engine's architecture. They are designed with extreme cohesion and zero coupling to provide reusable building blocks. If a core utility like `Vector.h` were to include higher-level physics concepts, it would create circular dependencies, significantly damaging the modularity and maintainability of the engine.

### 1.3 Knowledge Dependencies
### 1.4 Consistency Evaluation