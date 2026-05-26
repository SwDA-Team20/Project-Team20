workspace "Jolt Physics - C4 Architecture" {

    model {
        dev = person "Game Developer" "Integrates Jolt Physics into a game engine, VR application etc." External

        gameApp = softwareSystem "Game/Simulation Application" "External host application or engine that embeds Jolt Physics and drives the simulation." External
        toolchain = softwareSystem "C++ Build Toolchain" "CMake, compiler, linker, and platform used to build and link Jolt." External
        platform = softwareSystem "Operating System/Hardware Platform" "Provides CPU execution, memory, threading and optional platform APIs." External

        jolt = softwareSystem "Jolt Physics" "C++17 rigid-body physics and collision-detection library." {
            joltLib = container "Jolt Physics Library" "Provides rigid-body simulation, collision detection, constraints, character and vehicle support, serialization, math, memory, and job-system infrastructure." "C++17 static/shared library"
            samplesApp = container "Samples Application" "Stand-alone application that demonstrates and exercises the features provided by the Jolt Physics Library." "C++ executable"
            joltViewer = container "JoltViewer Application" "Stand-alone visualization application used to inspect recorded Jolt simulation output." "C++ executable"
            performanceTest = container "PerformanceTest Application" "Stand-alone benchmark application used to measure the performance of Jolt Physics scenes and generate performance output." "C++ executable"
            unitTests = container "UnitTests Executable" "Test executable used to validate the expected behavior of the Jolt Physics Library." "C++ executable"
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
        
        samplesApp -> joltLib "Uses the physics engine to demonstrate library features" "C++ API/in-process calls"
        joltViewer -> joltLib "Uses Jolt to visualize recorded simulation outputs" "C++ API/in-process calls"
        performanceTest -> joltLib "Uses the physics engine to execute benchmark scenes" "C++ API/in-process calls"
        unitTests -> joltLib "Tests and verifies library behavior" "C++ API/in-process calls"
        
        performanceTest -> joltViewer "Produces simulation outputs that can be visualized" 
        
        toolchain -> samplesApp "Builds executable" "C++17 / CMake"
        toolchain -> joltViewer "Builds executable" "C++17 / CMake"
        toolchain -> performanceTest "Builds executable" "C++17 / CMake"
        toolchain -> unitTests "Builds executable" "C++17 / CMake"
        
        samplesApp -> platform "Uses runtime services" 
        joltViewer -> platform "Uses runtime services" 
        performanceTest -> platform "Uses runtime services" 
        unitTests -> platform "Uses runtime services" 
        
        
        
        
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
            include samplesApp
            include joltViewer
            include performanceTest
            include unitTests
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