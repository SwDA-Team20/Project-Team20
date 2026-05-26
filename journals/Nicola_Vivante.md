# 2026/04/26

I looked at some of the system code looking for examples of design patterns (my task in the project) and I found a few occurrences of the Singleton pattern, the factory method (I believe). In order to help me with the analysis I tried to find a way to generate class diagrams from the c++ source code, but it turns out it's more complicated than I anticipated (still haven't found a way)


# 2026/05/06

I looked at some other portions of the system code and I came across the CompoundShape class, which looks like an use of the Composite pattern. Related to this, there seem to be some ShapeVisitors classes for performing various physics queries such as ray-casting, shape-casting... This could be the Visitor pattern but to be sure I need to investigate further.
I postponed the creation of a class diagram automatically from the c++ code, since it requires a non-trivial setup and the resulting diagram could also be quite unreadable at the end, given the size of the system; maybe I will attempt again at a later time if I find it necessary


# 2026/05/09

I looked at the uses of the visitor pattern inside the system code: it is actually used in multiple different sections of the code, such as compoundShape but also for the physics queries on the AABB QuadTree structure. Unfortunately there is not an explicit interface because most of the code is marked as forced_inlined for performance reasons, so different visitors actually must match the necessary interface at compile time. Also for this reason each different visitor is created inside the QuadTree method that needs to perform the specific operation. 


# 2026/05/11

Notes for the visitor pattern analysis half-way done (missing diagram, word count checking still to be performed)


# 2026/05/23

Split analysis of different pattern in separate files. Singleton analysis completed.