# Patterns

The 4 design patterns that have been identified inside the Jolt system and are analysed in the following sections are: Singleton, Facade, Composite and Visitor. For each pattern a context is presented, then the list of classes involved in the pattern architecture is listed, followed by the reason(s) the patter is used and some closing considerations about pros and cons. 


## Singleton

### Context:
There are many examples of the Singleton pattern in the system, such as the Factory class, the Profiler class, the DeterminismLog class and DebugRenderer class, all needing to be accessed from a single point across different parts of the codebase.


### Classes involved in c++ source code:
JPH::Factory, JPH::DebugRenderer, JPH::DeterminismLog, JPH::Profiler

// TODO: insert class diagram here (?)

### Why is the pattern applied:
All the classes involved are accessed at multiple different points of the system, without any particular cohesion among those callers; this makes sense since functionalities such as debug drawing, profiling, logging and a way to instantiate objects with a given type id (the case of JPH::Factory) are very likely to be widespread in the codebase. This creates the need to ensure that a single point of access to these functionalities is provided, and the Singleton pattern is a simple and effective enough solution.


### Considerations about pros/cons, possible alternatives:
One possible issue in the use of the Singleton pattern in the codebase is that it is implemented in a way that obstructs any future scalability of the functionalities currently encapsulated with it: let's consider for example the JPH::DebugRenderer class (but the considerations can apply to all Singleton occurrences in the system), where it is refactored to support more instances that run on multiple different threads to improve overall performance.
The problem lies in the static instance being accessed explicitly with the use of a public static variable "sInstance", not even a method "getInstance()" to wrap around it, so all DebugRenderer::sInstance calls need to be refactored (100+ occurrences across more than 20 files). It would be useful to add a layer of indirection with the use of a static method to access the instance, so that in a potential refactoring the method could internally switch from returning one instance to selecting the best among many instances available, essencially transitioning from a Singleton to a Broker without the need of drastic changes in the codebase. It has to be said that the Singleton are currently used to access features that are relatively stable and are likely to remain single instances throughout the system lifetime, so avoiding as little as one function call may be the preferred option in the context of high-performance computation. 

## Facade

### Context:
When using the engine to simulate physics and collisions between bodies, handle callbacks and perform queries against the scene, many different subsystems need to be called to interact with various aspect of the system, so a PhysicsSystem class is used as a Facade to redirect each external call to the appropriate subsystem operation. 


### Classes involved in c++ source code:
JPH::PhysicsSystem (Facade), JPH::BodyManager, JPH::ContactConstraintManager, JPH::ConstraintManager, JPH::BroadPhase, JPH::NarrowPhaseQuery, JPH::BodyInterface, JPH::PhysicsStepListener... (Subsystems)

// TODO: insert class diagram here


### Why is the pattern applied:
The pattern is used because having a single access point to different etherogeneus features can provide very useful in the context of game engines or other applications that need to interact with the physics engine code without having to know much about the underlying architecture, especially considering that this enables less coupling between the business rules and the physics engine implementation, given that the PhysicsSystem provides a stable enough boundary.
The PhysicsSystem facade also serves the purpose of initializing many of the subsystem itself, like BroadPhase, ConstraintManager, BodyInterface and others. it also offers some methods to orchestrate more complex behaviours that involve various subsystems, such as the "Update" method: it is responsible for the physics simulation step and it involves the BroadPhase, BodyManager, Contacts Manager and others.


### Considerations about pros/cons, possible alternatives:
No other patterns are really suitable alternatives of the facade in the context of providing a single interface for multiple subsystem to access their functionality, when these are provided by defined systems that do not change at execution time.


## Composite

### Context:
The physics engine is able to simulate bodies that resemble different objects by using a variety of "shapes", such as Sphere, Box, Capsule, Plane... More complex objects (like humanoid characters, vehicles, or even large scenaries made up of many different parts) however are hardly reprisented by only one of such shapes, so a special shape is defined to handle the conjunction of other child shapes. 

### Classes involved in c++ source code:
JPH::Shape, JPH::CompoundShape, JPH::StaticCompoundShape, JPH::MutableCompoundShape (the last 2 are subclasses of CompoundShape: they are not directly involved in the pattern but are the only 2 concrete classes in the list)

// TODO: insert class diagram here

### Why is the pattern applied:
Since a lot of operations that involve aggregate ("composite" in the pattern name, "compound" in the codebase) shapes can be reconduced to a combination of operations on the shapes in the aggregation, the Composite pattern provides a useful way of hiding this complexity from the caller of those operations. Such operations are then handled transparently by combining the information of sub shapes (with the use of the visitor pattern) and returning the appropriate result.

### Considerations about pros/cons, possible alternatives:
Differently than the standard implementation presented in literature, the CompoundShape doesn't directly provide the method to remove a child (RemoveShape). This is due to the fact that one of its subclasses is the StaticCompoundShape, where the shape is "static" in the sense that it cannot be altered after its creation. The RemoveShape method is in fact provided and implemented in the other subclass, which is MutableCompoundShape.

// TODO: decide if the following is to keep or to be discarded
It can be argued that the use of the composite pattern may have a programmer (which uses the system, not develops it) think that the cost of each composite operation is somewhat the same across various subclasses of CompoundShape, but actually static and mutable compound shapes store the children (more precisely, the children's bounds, which hold the data used in nearly all operations on the shapes) in completely different data structures and the performance of the operations can vary a lot as a consequence. Despite being mentioned in one comment, it is not immediatly obvious.

## Visitor

### Context:
The physics engine is able to simulate bodies that resemble different objects by using a variety of "shapes", such as Sphere, Box, Capsule, Plane... More complex objects (like humanoid characters, vehicles, or even large scenaries made up of many different parts) however are hardly reprisented by only one of such shapes, so a special shape is defined to handle the conjunction of other child shapes. 

### Classes involved in c++ source code:
JPH::QuadTree, JPH::QuadTree::NodeID, JPH:BodyID, JPH:QuadTree:Node
Note: there are other occurrences of the visitor pattern being used along with CompoundShape subclasses, but they were not the ones analysed as the CompoundShape is already of interest in the use of the Composite pattern.


There are no close resemblances to the design patter just by looking at the classes involved (see considerations below), but the closest it would look in a fully-OOP setting is: 

// TODO: insert class diagram here

The (pseudo-)code for this would look something like:

// TODO: convert to image?
// TODO: only keep element implementation?

``` 
interface QuadTreeElement { 
	void accept(visitor: Visitor);
}

interface Visitor {
	void visit(nodes: Nodes); // "visitNodes" in the code
	void visit(body: Body); // "visitBody" in the code
	bool shouldVisit(el: QuadTreeElement);
	bool shouldAbort();
	void OnStackResized() // not related to the pattern
}


class Body implements QuadTreeElement {
	// data...

	void accept(visitor: Visitor) {
		if (visitor.shouldVisit(this)):
			visitor.visit(this);
	}
}


class Nodes implements QuadTreeElement {
	// data (i.e. 4 QuadTreeElement children)...

	void accept(visitor: Visitor) {
		// visit element
		if (visitor.shouldVisit(this)):
			visitor.accept(this);

		if (visitor.shouldAbort()):
			return;

		// visit children elements
		foreach (child in children) {
			child.accept(visitor);

			if (visitor.shouldAbort()):
				break;
		}
	}
}
```


QuadTreeElement is the abstract "Element" with 2 concrete implementations:
- Nodes (a group of 4 TreeElements)
- Body (a leaf of the Tree)

Visitor is the abstract "Visitor" with many concrete implementations:
- CastRayVisitor
- CastAABoxVisitor
- CollideAABoxVisitor
- CollideSphereVisitor
- CollidePointVisitor
- CollideOrientedBoxVisitor

### Why is the pattern applied:
In this case the Element interface only has 2 concrete implementations, however there are multiple operations that need to be performed, with more that may be introduced at any point in the project developement to add functionalities such as new physics queries: it would clutter the tree traversal function to have all those different etherogeneus behaviours inside one method, with the rapid degradation of maintainability. By using the visitor pattern each different query is segregated inside its own visitor, while the tree traversal code stays untouched.

### Considerations about pros/cons, possible alternatives:
In this case, the Element interface is not actually defined because there are only 2 Element types that will ever need to exist and the tree traversal doesn't happen recursively but with a stack-like data structure because of performance reasons. Also the Visitor interface is missing and that is because all the queries are template methods with a custom visitor defined and implemented inside, with compiler directives to make all the method calls inlined, so actually no visitor will exist at all after the compilation step. This makes sense since physics queries are likely to be called hundreds or even thousands of times per seconds, but this comes at the cost of worse understandability and evolvability of this section of the code. 
