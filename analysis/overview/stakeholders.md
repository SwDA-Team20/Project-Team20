# Stakeholder Analysis

I identified the main stakeholders by reading `README.md`, `Docs/ProjectsUsingJolt.md`, and `Docs/Architecture.md`.

The most prominent commercial users are Guerrilla Games, which used Jolt in Horizon Forbidden West, and Kojima Productions, which used it in Death Stranding 2. Beyond AAA studios, I found that a large number of open-source game engines have also adopted Jolt, including Godot (since v4.4), Wicked Engine, and ezEngine, with roughly 20 projects listed in `ProjectsUsingJolt.md`. I think one reason for this broad adoption is the project's MIT license, which allows both commercial and open-source projects to use the engine without restrictive licensing requirements

Looking at this range of users, I identified three broad stakeholder groups, each with different requirements:

- **AAA and professional game studios** need deterministic, high performance simulation. For these teams, correctness and raw throughput are the primary concerns.
- **Engine teams and open-source integrators** need long-term API stability and clean integration boundaries, since a physics library that changes its interface frequently creates maintenance overhead across a large codebase.
- **Independent developers and smaller teams** need accessible documentation and a straightforward integration path.

One concrete example that shaped my understanding of why determinism is treated as a first class requirement is the inclusion of multiplayer games like War Thunder (Dagor Engine) and X4 Foundations in the project's user list. In multiplayer physics, the simulation must produce identical results across different machines and runs so that the game state stays synchronised across clients. This is not something that can easily be added later in development. It needs to be considered from the beginning, which helps explain why determinism appears to be such an important goal of the project.

Jorrit Rouwé is still the main maintainer and reviewer of the project. Even though the project has many contributors, a large part of the responsibility still depends on a single person.