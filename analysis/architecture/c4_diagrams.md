# Architecture

The architecture diagrams are specified using text-based modelling, in particular Structurizr DSL (see c4.dsl file). 

Jolt Physics is a reusable C++ physics engine library; the system boundary is therefore placed around the Jolt Physics library itself, not around the whole GitHub repository. This distinction is important in this analysis because the repository also contains examples, tests, performance benchmarks, documentation, build scripts, etc. . These elements mainly support development, validation and demonstration, they're not the primary software system delivered to users.

 In the following analysis, optional repository tools such as samples, viewers, and unit tests are deliberately excluded from the context diagram because they are not external systems that the deployed library depends on during normal use as explained above.

## Context level
At the context level, Jolt Physics is modeled as a software system used by game, simulation, or VR developers. These developers interact with Jolt mainly through its public C++ API, documentation, examples, and build configuration. The final users of applications using Jolt, such as players, are not represented as direct actors in this diagram because they do not interact with Jolt Physics directly. They interact with a game/simulator/engine that internally embeds the library. For this reason, the direct external software system is represented as a Game Application, which links against Jolt and invokes its physics functionality through in-process C++ calls.

The context diagram also includes the C++ build toolchain and the operating system/hardware platform. The build toolchain is relevant because Jolt is a compiled C++ library and must be built and linked using tools such as CMake, a compiler, linker, etc. . The operating system and hardware platform are relevant because a physics engine depends on runtime services such as memory allocation, multithreading, CPU execution etc. . 


![ C4 - Level 1: System Context ](./images/systemContext_diagram.svg)

## Container level
At the container level, the system is intentionally modeled as a single deployable container: the Jolt Physics Library. In the C4 model, a container is a separately deployable or executable unit; applying this definition to Jolt Physics leads to a simple container view: the core system is distributed as a C++ library, which can be built and linked into external host applications.

The internal folders under `Jolt/` aren't represented as containers; they are important architectural areas, but they're not independently deployable runtime units. They are compiled together into the same library and cooperate through C++ headers, classes, functions, templates, and shared internal abstractions.

The repository-level folders outside the core library, such as `Samples/`, `UnitTests/`, `PerformanceTest/`, and viewer-related tools, are also not modeled as containers of the Jolt Physics system. Some of them may be compiled as separate executables, but they are support artifacts around the library rather than part of the system boundary chosen for this architecture analysis. They help test or visualize Jolt, but they are not required as runtime containers for an application that embeds the physics engine.

This makes the container diagram simple, it shows an important architectural property of the system: Jolt Physics is not a multi-container service-based system, but a monolithic native library designed to be embedded inside other applications. The main architectural complexity is therefore not at the container level, but inside the library container itself.

![ C4 - Level 2: Container Diagram ](./images/container_diagram.svg)

### Relationship with the Clean Architecture blueprint
At container level, Jolt Physics shows little direct correspondence with the Clean Architecture blueprint. Clean Architecture is mainly useful when a system can be decomposed into application layers with clear dependency rules, such as domain logic, use cases, interface adapters and external frameworks. JoltPhysics, instead, is a performance-oriented C++ engine library delivered as a single static or shared library.

A limited separation of concerns is still visible. Physics functionalities are mainly grouped under `Jolt/Physics`, infrastructure facilities under `Jolt/Core`, serialization under `Jolt/ObjectStream`, and compute backends under `Jolt/Compute`. However, this is a modular organization inside one native library, not a Clean Architecture layering. The dominant architectural drivers are performance, data locality, memory control, and efficient integration into host applications.

Therefore, the relationship with Clean Architecture is only partial and conceptual. The architecture is better described as a modular, performance-oriented library architecture rather than a Clean Architecture implementation.

## Component Diagram
![ C4 - Level 3: Component Diagram ](./images/ComponentDiagram.png)

### Explanations:
 JoltPhysics is divided into two layers. The top layer holds reusable utility components (Core, Math, Geometry, AABBTree, TriangleSplitter, ObjectStream, Skeleton, Renderer, Shaders, Compute). The bottom layer is the PhysicsSystem subsystem containing the main simulation components (Body, Collision, Character, RagDoll, Shapes, Constraints, Vehicle, SoftBody, Hair).

### SOLID Violations:

Single Responsibility Principle

| # | Class | File | Issue |
|---|---|---|---|
| 1 | `PhysicsSystem` | `PhysicsSystem.h` | 6 responsibilities: simulation, body access, collision, serialization, listeners, internal systems |
| 2 | `DebugRenderer` | `DebugRenderer.h` | Primitive drawing + GPU batch creation + LOD management |
| 3 | `Shape` | `Shape/Shape.h` | Collision + geometry + mass + debug + serialization + sub-shape |
| 4 | `CharacterVirtual` | `CharacterVirtual.h` | Movement + contacts + penetration + ground detection + predictive contact |
| 5 | `RagdollSettings` | `Ragdoll.h` | Config + skeleton mapping + serialization + stabilization |


---

Open/Closed Principle

| # | Class | File | Issue |
|---|---|---|---|
| 1 | `CollisionDispatch` | `CollisionDispatch.h` | For new shape type manual registration is required |
| 2 | `EShapeSubType` | `Shape.h` | For new shape we have to enum modify so full recompile |
| 3 | `PhysicsSystem` | `PhysicsSystem.h` | `BroadPhaseQuadTree` concrete member, not swappable |

---

Liskov Substitution Principle

| # | Class | File | Issue |
|---|---|---|---|
| 1 | `CharacterVirtual` | `CharacterVirtual.h` | `GetBodyID()` always returns invalid, no body exists |
| 2 | `PlaneShape` | `PlaneShape.h` | Infinite bounds + zero mass, parent contract broken |
| 3 | `EmptyShape` | `EmptyShape.h` | All collision methods no-op, caller gets nothing |
| 4 | `StaticCompoundShape` | `StaticCompoundShape.h` | `AddShape()` throws assert, parent promises it works |


---

Interface Segregation Principle

| # | Class | File | Issue |
|---|---|---|---|
| 1 | `Shape` | `Shape.h` | 6 concern groups in one interface |
| 2 | `BodyInterface` | `BodyInterface.h` | 7 concern groups: creation, transform, velocity, forces, activation, query, material |
| 3 | `CharacterBase` | `CharacterBase.h` | `GetBodyID()` forced on `CharacterVirtual` which has no body |
| 4 | `BroadPhase` | `BroadPhase.h` | Body management + queries + optimization + layer collision |


---

Dependency Inversion Principle

| # | Class | File | Issue |
|---|---|---|---|
| 1 | `RagdollSettings` | `Ragdoll.h` | Concrete `Skeleton*`,no `ISkeleton` interface |
| 2 | `PhysicsSystem` | `PhysicsSystem.h` | `BroadPhaseQuadTree` hardcoded member, not injectable |
| 3 | `Hair` | `Hair/` internals | Concrete `SoftBodySharedSettings`,  no abstraction |
| 4 | `ObjectStreamIn` | `ObjectStream.cpp` | `Factory::sInstance` global singleton, not injectable |
| 5 | `DebugRenderer` | `DebugRenderer.h` | `sInstance` global singleton, unit testing impossible |
| 6 | `ContactConstraintManager` | `ContactConstraintManager.h` | Concrete `Body&`,  no `IBody` abstraction |

## Architectural level
*Architectural characteristics: comment on important architectural characteristics/qualities of the system and how they are supported by the architecture. \
You might also use components coupling and cohesion metrics to support your reasoning.*