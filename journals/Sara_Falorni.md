### 27/04/2026
I read the docs/architecture.md document to study the architecture structure of JoltPhysics, I the looked at the repository organization of files to get a better understanding of it. Lastly I looked at the different options for tools to start working on the C4 context diagram draft.

### 30/04/2026
I choose to use structurizr lite and plantuml to model the diagrams. I worked on the system context diagram using the guide questions from the Visualization.pdf from the lectures. I looked up how physics engine library usually interact with hardware etc. to undestand how to model it. First draft of context diagram is finalized. I started working on the container diagram.I'm finding it difficult how to model it since i can't really identify independently deployable units in the library.

### 05/05/2026
Finalized the container diagram draft and committed changes to the repo.

### 06/05/2026
I've written the first draft of the explanations for the context and container diagrams, and the correlation with the clean architecture. I corrected the diagrams to use the correct colors for external systems and people. 

### 17/05/2026
After a discussion with the team we decided to include the other containers in the container diagram and not consider only the library but the whole repository. So I analysed briefly the document and repository again and adjusted the c4.dsl file, in particular the container level.

### 19/05/2026
I finalized the new version of the container diagram and corrected the diagrams explainations to be coherent with the new diagram.

### 27/05/2026
I reviewd the explanations on the context and container diagrams and fixed some minor mistakes, mostly in wording. Then i throughly reviewed the part about the relationship with the clean architecture running a few more analysis tests to review include dependecies. I finally almost completely rewrote that part to be more precise. 