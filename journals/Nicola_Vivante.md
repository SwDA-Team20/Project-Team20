# 2026/04/26

I looked at some of the system code looking for examples of design patterns (my task in the project) and I found a few occurrences of the Singleton pattern, the factory method (I believe). In order to help me with the analysis I tried to find a way to generate class diagrams from the c++ source code, but it turns out it's more complicated than I anticipated (still haven't found a way)


# 2026/05/06

I looked at some other portions of the system code and I came across the CompoundShape class, which looks like an use of the Composite pattern. Related to this, there seem to be some ShapeVisitors classes for performing various physics queries such as ray-casting, shape-casting... This could be the Visitor pattern but to be sure I need to investigate further.
I postponed the creation of a class diagram automatically from the c++ code, since it requires a non-trivial setup and the resulting diagram could also be quite unreadable at the end, given the size of the system; maybe I will attempt again at a later time if I find it necessary