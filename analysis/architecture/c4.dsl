workspace "Jolt Physics - C4 Architecture" {

    model {
        dev = person "Game Developer" "Integrates Jolt Physics into a game engine, VR application etc." External

        gameApp = softwareSystem "Game/Simulation Application" "External host application or engine that embeds Jolt Physics and drives the simulation." External
        toolchain = softwareSystem "C++ Build Toolchain" "CMake, compiler, linker, and platform used to build and link Jolt." External
        platform = softwareSystem "Operating System/Hardware Platform" "Provides CPU execution, memory, threading and optional platform APIs." External

        jolt = softwareSystem "Jolt Physics" "C++17 rigid-body physics and collision-detection library." {
            joltLib = container "Jolt Physics Library" "Provides rigid-body simulation, collision detection, constraints, character and vehicle support, serialization, math, memory, and job-system infrastructure." "C++17 static/shared library"
        }

        dev -> jolt "Uses public C++ API and documentation"
        dev -> gameApp "Develops and configures"
        gameApp -> jolt "Embeds and uses physics functionality" "C++ API/in-process calls"

        toolchain -> jolt "Builds and links" "CMake/C++17"
        jolt -> platform "Uses runtime services" "Threads, memory etc."

        dev -> joltLib "Uses public headers and API"
        gameApp -> joltLib "Links against and invokes physics functionality" "C++ API/in-process calls"
        toolchain -> joltLib "Compiles and links" "CMake/C++17"
        joltLib -> platform "Uses runtime services" "Threads, memory etc."
    }

    views {
        systemContext jolt "SystemContext" {
            title "Jolt Physics - C4 Level 1: System Context"
            include dev
            include gameApp
            include toolchain
            include platform
            include jolt
            autolayout lr
        }

        container jolt "Container" {
            title "Jolt Physics - C4 Level 2: Container Diagram"
            include dev
            include gameApp
            include toolchain
            include platform
            include joltLib
            autolayout lr
        }

        theme default

        styles {
            element "External" {
                background "#999999"
                color "#ffffff"
            }
        }
    }
}