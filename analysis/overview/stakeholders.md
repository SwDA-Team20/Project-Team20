# Stakeholder Analysis

The main stakeholders were identified by reviewing `README.md`, `Docs/ProjectsUsingJolt.md`, and `Docs/Architecture.md`.

The most prominent commercial users are Guerrilla Games, which used Jolt in Horizon Forbidden West, and Kojima Productions, which used it in Death Stranding 2. Beyond AAA studios, a large number of open-source game engines have also adopted Jolt, including Godot (since v4.4), Wicked Engine, and ezEngine, with roughly 20 projects listed in `ProjectsUsingJolt.md`. One reason for this broad adoption is likely the project's MIT license, which allows both commercial and open-source projects to use the engine without restrictive licensing requirements.

Based on the identified users, three broad stakeholder groups emerge, each with different requirements:

* **AAA and professional game studios** require deterministic, high-performance simulation. For these teams, correctness and raw throughput are primary concerns.
* **Engine teams and open-source integrators** require long-term API stability and clean integration boundaries, since frequent interface changes can create significant maintenance overhead across larger codebases.
* **Independent developers and smaller teams** require accessible documentation and a straightforward integration process.

A notable observation is the inclusion of multiplayer games such as War Thunder (Dagor Engine) and X4 Foundations in the project's user list. In multiplayer physics, simulations must produce identical results across different machines and runs to keep the game state synchronized across clients. This requirement cannot easily be introduced later in development and must be considered from the beginning, helping explain why determinism is treated as a core design goal of the project.
