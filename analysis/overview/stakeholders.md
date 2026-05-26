# Stakeholder Analysis

I identified the main stakeholders by reading `README.md`, `Docs/ProjectsUsingJolt.md`, and `Docs/Architecture.md`.

The most prominent users are AAA game studios Guerrilla Games used Jolt in Horizon Forbidden West and Kojima Productions in Death Stranding 2. What surprised me is how many open-source engines have also adopted it. Godot (since v4.4), Wicked Engine, ezEngine, and about 20 others listed in `ProjectsUsingJolt.md`.

This range of users from large studios to indie developers to engine teams means the project has to satisfy very different requirements at once. Studios need deterministic, high performance simulation. Engine teams need long term API stability. Indie devs
need good documentation and easy integration. The fact that Jolt serves all three suggests it has found a good balance between performance and usability.

One thing I noticed specifically is that multiplayer games like War Thunder (Dagor Engine) and X4 Foundations depend on physics determinism so that the simulation stays synchronized across clients. This is an important requirement for multiplayer games and explains why determinism is treated as a first-class feature in the codebase, not as an afterthought.

Jorrit Rouwé is still the main maintainer and reviewer of the project. Even though the project has many contributors, a large part of the responsibility still depends on a single person.