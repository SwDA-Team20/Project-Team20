# Stefano Tallone

## April 13 - 19
Me and the other team members met to plan the project and assigned work for each of us. After assigning tasks, I setup the base repository. I created the repo, established the main structure, and initialized both "docs" & "journals" folders.

## April 20 - April 26
I started my assigned task regarding the dependencies analysis. I spent several hours analyzing the static code dependencies of the core engine using Doxygen. I configured it to parse the source code and extract structural dependencies like the #include directives to see how the system is wired together. 

## April 27 - May 3
I used CodeScene to analyze the Git commit history. I examined knowledge dependencies, tracking down files that often co-change with each other. This sounded simple enough, but when I attempted to cross reference the two datasets in order to discover architectural inconsistencies, I ran into a wall. CodeScene reports temporal coupling between .cpp files, but in C++ files only include .h headers, meaning almost every pair was being flagged as an inconsistency. I need a way to do this mappings properly instead of manually.

## May 4 - 10
Instead of relying purely on the default tool exports, I wrote a couple of custom Python scripts. The scripts parse the C++ source code to build a clean dependency matrix and then intersect it with the CodeScene dataset by comparing just the base module names.
It worked: the scripts filtered out the trivial couplings and left 135 dependencies violations (like cross-platform rendering files that evolve together but obviously don't include each other). I revised my notes with both the qualitative examples and the quantitative data I extracted.

## May 11 - 17
I reviewed my dependencies analysis. I did few changes here and there for clarity in the notes.