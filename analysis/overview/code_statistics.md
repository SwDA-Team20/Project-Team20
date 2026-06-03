# Codebase Statistics Analysis

I analyzed the size and composition of the Jolt Physics codebase to better understand its overall complexity and structure. Understanding these metrics helps me estimate the scale of the system and provides context for the project overview.

---

## Methodology

I performed this analysis using cloc v2.08 to measure the size and composition of the repository. I ran the following command from the root directory of the JoltPhysics repository:

```bash
cloc .
```

Run from the root directory of the JoltPhysics repository.

---

## Results

| Metric                      | Value   |
|-----------------------------|-------  |
| Total files                 | 1,195   |
| Source lines of code (SLOC) | 138,100 |
| Blank lines                 | 32,768  |
| Comment lines               | 28,511  |

### Language Breakdown

| Language     | Files     | Blank      | Comment    | Code        |
|--------------|-----------|------------|------------|-------------|
| C++          | 441       | 17,802     | 12,442     | 85,603      |
| C/C++ Header | 619       | 13,287     | 15,288     | 43,717      |
| CMake        | 11        | 212        | 257        | 2,012       |
| Objective-C++| 16        | 273        | 104        | 1,045       |
| HLSL         | 28        | 198        | 179        | 804         |
| GLSL         | 11        | 63         | 25         | 202         |
| Metal        | 4         | 59         | 27         | 223         |
| Markdown     | 10        | 644        | 0          | 1,686       |
| Bourne Shell | 10        | 53         | 118        | 192         |
| DOS Batch    | 21        | 21         | 2          | 178         |
| Python       | 1         | 19         | 24         | 100         |
| Other        | 23        | 136        | 45         | 338         |
| **Total**    | **1,195** | **32,768** | **28,511** | **138,100** |

---

## Observations

- I found that most of the code is written in C++, accounting for approximately 62% of the total source lines of code. According to the project documentation, deterministic execution and low-level control are important design goals, which aligns with the choice of C++ as the primary implementation language.
- I also noticed that a large portion of the code is contained in header files (over 43,000 lines), suggesting a modular structure with a clear separation between interfaces and implementations.
- I also found HLSL, GLSL, and Metal files within the repository, indicating the presence of platform specific shader and graphics-related components.
- The use of Objective C++ indicates support for Apple platforms such as macOS and iOS.
- Build and scripting files (CMake, shell scripts, batch files, etc.) suggest that the project is designed to work across multiple platforms.

---

## Interpretation

Based on the results, I consider Jolt Physics to be a moderately large and complex system. With more than 138,000 source lines of code distributed across 1,195 files, the project is large enough to provide meaningful architectural insights while still being manageable for detailed analysis.

I also observed that C++ and C/C++ header files together account for the vast majority of the codebase. This aligns with the project's focus on performance, deterministic execution, and low-level control. The presence of platform specific files, shader code, and build scripts further suggests that the engine is designed to support a wide range of platforms and deployment environments.

