# Stefano Tallone

## April 13 - 19
We had a meeting with the rest of the team to plan the project and divide the workload among the members. Once the tasks were assigned, I took care of the initial repository setup. I created the repository, defined the main structure, and set up both the "docs" and "journals" directories so everyone has a proper place to log their updates and documentation.

## April 20 - April 26
I started my assigned task regarding the dependencies analysis. I spent several hours analyzing the static code dependencies of the core engine using Doxygen. I configured it to parse the source code and extract structural dependencies like the #include directives to see how the system is wired together. Next, I will need to look into the behavioral side of things to see how the code actually evolves.

## April 27 - May 3
I moved on to the behavioral analysis (knowledge dependencies) using CodeScene to analyze the Git commit history and find files that frequently co-change. It seemed straightforward at first, but when I tried to cross-reference the two datasets (the static one from Doxygen and the temporal one from CodeScene) to find architectural inconsistencies, I hit a roadblock. CodeScene reports temporal coupling between .cpp files, but in C++ files only include .h headers, meaning almost every pair was being flagged as an inconsistency. I need to find a way to properly map and compare these relationships without doing it manually.

## May 4 - 10
I figured out a way to solve the file extension issue. Instead of relying purely on the default tool exports, I wrote a couple of custom Python scripts. The scripts parse the C++ source code to build a clean dependency matrix and then intersect it with the CodeScene dataset by comparing just the base module names.
It worked perfectly: the scripts automatically filtered out the trivial couplings and successfully isolated 135 actual architectural inconsistencies (like cross-platform rendering files that evolve together but obviously don't include each other). I updated the final report with both the qualitative examples and the quantitative data I extracted.