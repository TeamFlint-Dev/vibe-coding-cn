# Linked Lists

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/linked-lists-in-verse>
> **爬取时间**: 2025-12-27T00:02:34.208518

---

Linked lists are a common data structure in Computer Science. You can use a linked list to represent a music playlist, or track history of actions, for example.

## Overview

A linked list is a linear data structure where each element stores a reference to the next element in the list. Each element in a linked list is called a **node**. A node is a container that holds some data and a reference to the next node.

Linking different nodes together in a sequence creates a linked list. The first node in the list is called the **head** node, and the last node is called the **tail** node. To traverse through the list, you start at the Head and travel to the next element using the reference in each node.

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/4791c6ce-2c48-4549-8531-61c08a88b58b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4791c6ce-2c48-4549-8531-61c08a88b58b?resizing_type=fit)

### When to use

Linked lists are a good starting point for implementing other data structures such as stacks or queues. Linked lists are a straightforward way of storing data for sequential access, and they support the quick insertion of new elements. Unlike arrays, linked lists are not contiguous (next to each other) in memory. This means that a node could be anywhere in memory, and the reference to the next node tells you the location. To insert or delete nodes from a linked list, all you need to do is change the references to which node comes next.

### When not to use

If your program requires random access to elements (such as picking a random player from a list), linked lists lack this functionality. Linked lists are less efficient than arrays if you need to access a particular node in the middle of the list since you'll have to start from the head and traverse to the particular node you need.

## Verse Implementation

The Verse API does not have a built-in implementation of linked lists, but you can create one yourself.

Linked lists are comprised of nodes, and you'll need to define a class to represent them. An example of a generic type of node is below:

```verse
# A container node that contains data and a reference
# to the next node in the list.
list_node := class<unique>:
    var Next:?list_node = false
    Data:any = {}
```

Here the option variable `Next` stores a reference to the next node in the list, which is of type `list_node`. Note that `Next` has to be an `option` variable, because a node might not always have a next node to point to (such as the tail node of a linked list). If you want to change the linking of your list dynamically, `Next` needs to be a `var`. The node also contains some value, which is stored in `Data`. Since this is a generic type of node, `Data` is of type `any`, and the node could contain any data type. It could be a common type, a container, or even another linked list!

```verse
Node1 := list_node{ Next := false, Data := 1 } # An int
Node2 := list_node{ Next := false, Data := "String" } # A string
Node3 := list_node{ Next := false, Data := []int} # An array
Node4 := list_node{ Next := false, Data := list_node } # list_node class
Node5 := list_node{ Next := false, Data := Node1 } # The first node
```

The `<unique>` specifier lets `list_node` be [comparable](https://dev.epicgames.com/documentation/en-us/fortnite/comparable-in-verse). This lets you check if a node is equal to some other node, such as checking if your node is the head or tail of a list.

If you need a more specific implementation, such as a node that only handles numbers or strings, make sure to change the type of `Data` to match. If `Data` is of type `comparable`, you can compare the value in `Data` to another value to find a specific node.

```verse
# A container node that contains integer data and a reference
# to the next node in the list.
list_node_int := class(list_node):
    # Reference to the next node in the list.
    var Next<override>:?list_node = false
    Data<override>:int

# A container node that contains string data and a reference
# to the next node in the list.
list_node_string := class(list_node):
    # Reference to the next node in the list.
    var Next<override>:?list_node = false
    Data<override>:string

# A container node that contains float data and a reference
# to the next node in the list.
list_node_float := class(list_node):
    # Reference to the next node in the list.
    var Next<override>:?list_node = false
    Data<override>:float
```

### Singly Linked Lists

The most basic type of linked list is a **singly linked list**, where each node contains a reference to the next node (a single link). To turn your nodes into a list, link them together using the `Next` references in each node.

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/7d189be5-d91c-4658-b796-b4053c96279b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d189be5-d91c-4658-b796-b4053c96279b?resizing_type=fit)

```verse
# Link each Node to the next Node in the list
set Node1.Next = option{Node2}
set Node2.Next = option{Node3}
set Node3.Next = option{Node4}
set Node4.Next = option{Node5}
```

Although your nodes are linked, you'll want to define your linked list in a class. This will make it easy to perform functions using your list, rather than referencing your first node each time.

```verse
# A data structure that links multiple list_node structures together to create a chain. 
# Uses singly linked nodes which contain a reference to the next node in the chain.linked_list := class:
    var Head:list_node
```

A basic `linked_list` class only contains a reference to the head node. To create an instance of your `linked_list` class, link your nodes together, then instantiate your list using the head node.

```verse
# Create a Linked List with node1 as the head.
BasicList:linked_list = linked_list{Head := Node1}
```

To traverse the list, you start at the head node and iterate through the list, stopping at the tail. You can do this either in an external function or in a class function inside your `linked_list` class. An example function that traverses the entire list from head to tail is provided below:

```verse
# A data structure that links multiple list_node structures together to create a chain. 
# Uses singly linked nodes which contain a reference to the next node in the chain.linked_list := class:
    var Head:list_node

    TraverseList():void=
        var CurrentNode:?list_node := option{Head} # The node you're currently on
        var NodeNumber:int = 1 # The number of the current node
        Print("Starting at the Head Node...")
        # If the current node has a next node, set the current node to
        # the next node in the list
        loop:
            if(NextNode := CurrentNode?.Next?):
                set CurrentNode = option{NextNode}
                set NodeNumber += 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No next node, this is the Tail node!")
                break
```

Here the `TraverseList()` function checks if `CurrentNode` contains a `Next` reference, and stores it in `NextNode`. If so, it sets `CurrentNode` to `NextNode` repeatedly until reaching the tail node. The tail node does not have a `Next` reference so the loop stops here.

### Doubly Linked Lists

Unlike singly linked lists, nodes in a **doubly linked list** also contain a reference to the node that came before it called the **previous** node.

```verse
# A container node that contains data and a reference to both
# the next and previous nodes in the list.
doubly_linked_node := class<unique>:
    var Next:?doubly_linked_node = false
    var Previous:?doubly_linked_node = false
    Data:any = {}
```

As with singly linked nodes, if you need a more specific implementation that only handles certain data types, make sure to change the type of `Data` to match.

```verse
# A container node that contains integer data and a reference to both
# the next and previous nodes in the list.
doubly_linked_int_node := class(doubly_linked_node):
    Data<override>:int

# A container node that contains string data and a reference to both
# the next and previous nodes in the list.
doubly_linked_string_node := class(doubly_linked_node):
    Data<override>:string
```

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/d912268f-b702-48b6-bbc5-712776c1bdfa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d912268f-b702-48b6-bbc5-712776c1bdfa?resizing_type=fit)

This means that you can traverse nodes in a doubly linked list both forward and backward. This can be done either in an external function or in a class function. An example function that traverses the list from head to tail and back is provided below:

```verse
# A data structure that links multiple list_node structures together to create a chain. 
# Uses doubly linked nodes which contain references to both the next and previous nodes.
doubly_linked_list := class():
    var Head:doubly_linked_node

    # Traverse a LinkedList, but both backward and forward!
    TraverseDoublyLinkedList():void=
        var CurrentNode:?doubly_linked_node := option{Head}
        var NodeNumber:int = 1
        Print("Starting at the Head Node, and going forward...")
        loop:
            if(NextNode := CurrentNode?.Next?):
                set CurrentNode = option{NextNode}
                set NodeNumber += 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No next node, this is the Tail node!")
                break
        Print("Now let's go backward to the Head node...")
        loop:
            if(PreviousNode := CurrentNode?.Previous?):
                set CurrentNode = option{PreviousNode}
                set NodeNumber -= 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No previous Node, we're back at the Head node!")
                break
```

### Circular Linked Lists

In a **circular linked list**, the head node is linked to the tail node. This means you can traverse the entire list past the tail node and arrive back at the head. Circular linked list can be either singly or doubly linked, the only requirement is that the head node links to the tail, or vice versa.

## Iterators

An iterator is an object that allows you to iterate over a container and perform operations along the way. You can think of it like a train car full of passengers. The train travels down a track, stopping at each station along the way. At each station, the train does a task, such as boarding or disembarking passengers. With regard to linked lists, each station is a node in the list. The train (iterator) travels down the list to each node and can perform operations where it stops.

Iterators are useful for linked lists because they allow you to perform operations at specific places, rather than just at the head or tail node.

```verse
# Iterates over a linked_list and can add nodes or remove nodes as it iterates.
linked_list_iterator := class:
    List:linked_list
    var CurrentNode:list_node

    # If there is a NextNode for the iterator to travel to, travel to that node
    Next()<transacts><decides>:list_node=
        set CurrentNode = CurrentNode.Next?
```

Here the iterator contains a reference to the list that it iterates over and a `CurrentNode` where the iterator is currently stopped. The `Next()` function checks if the `CurrentNode` has a node after it, and then jumps to that node. Note that `Next()` here includes the `<transacts>` and `<decides>` specifiers. The function must be `<transacts>` since it updates the `CurrentNode` `var`, and you want to include `<decides>` since making `Next()` failable lets you know whether you iterated to the next node or not.

Although it might seem like an iterator should start at the head of a list, it actually needs to start **before** the head. This is so that the iterator can perform operations on the head node, such as inserting nodes before the head or deleting the head entirely.

To initialize the iterator before the head, you can initialize `CurrentNode` to a dummy node with the head of the list as the next node. In Verse, you can't access the `List` when initializing `CurrentNode`, because class members variable can't be accessed from the same scope, only different scopes such as within a function.

```verse
linked_list_iterator := class:
    List:linked_list
    # The below line will fail because you can't access List from this scope
    var CurrentNode:list_node := list_node{Next := option{List.Head}}
```

Instead, to instantiate an iterator you can use a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse) function. A constructor is a composite type that creates an instance of the class it's associated with. The constructor sets initial values for an object and allows you to access the value of List and assign `CurrentNode` to its head.

```verse
# Construct an Iterator with CurrentNode as a dummy node before the head of the given list.
MakeIterator<constructor>(List:linked_list) := linked_list_iterator:
    List := List
    # You can access List from this scope in a constructor function
    CurrentNode:= list_node{Next := option{List.Head}}

# Iterates over a linked_list and can add nodes or remove nodes as it iterates.
linked_list_iterator := class:
    List:linked_list
    var CurrentNode:list_node
```

Initializing an iterator for a doubly linked list looks very similar, except that you initialize it using doubly linked nodes.

```verse
# Construct an Iterator with CurrentNode as a dummy node before the head of the given list.
MakeDoublyLinkedIterator<constructor>(List:doubly_linked_list) := doubly_linked_list_iterator:
    List := List
    # You can access List from this scope in a constructor function
    CurrentNode:= doubly_linked_node{Next := option{List.Head}}

# Iterates over a doubly_linked_list and can add nodes or remove nodes as it iterates.
doubly_linked_list_iterator := class:
    List:doubly_linked_list
    var CurrentNode:doubly_linked_node
```

### Iterating Between Nodes

You can move the iterator forwards or backward depending on the linking of your list. Iterators in a singly linked list can only travel forward, while iterators in a doubly linked list can travel in either direction. This functionality is defined in two functions, `Next()` and `Previous()`. Remember that singly linked lists will not have a `Previous()` function. Circularly linked lists may have either function depending on whether they are singly or doubly linked.

```verse
# If there is a NextNode for the iterator to travel to, travel to that node
Next()<transacts><decides>:doubly_linked_node=
    set CurrentNode = CurrentNode.Next?

# If there is a PreviousNode for the iterator to travel to, travel to that node
Previous()<transacts><decides>:doubly_linked_node=
    set CurrentNode = CurrentNode.Previous?
```

### Adding Nodes

You can use iterators to add nodes to specific places in the linked list. When adding a node, choosing where to add the node is important. You could add the node before or after the current node, but this depends on the structure of your list. In a singly linked list, you can only add nodes after other nodes, because you don't have a `Previous` node reference to refer to. In a doubly linked list, you can add nodes before or after other nodes.

```verse
# Adds a new node after CurrentNode.
AddNextNode(NewNode:list_node):void=
    if(NextNode := CurrentNode.Next?):
        set NewNode.Next = option{NextNode}
        set CurrentNode.Next = option{NewNode}
        Print("Successfully added a new node!")
    else:
        set CurrentNode.Next = option{NewNode}
        Print("Successfully added a new node to the tail of the list!")
```

Here the `AddNode` function adds a node between `CurrentNode` and the node after it. It does this by:

- Setting the `Next` reference of the `CurrentNode` to `NewNode`.
- Setting the `Next` reference of `NewNode` to the `NextNode`. If there is no `NextNode` (such as at the tail of a list), the function only sets `NewNode` as the next node.

In a doubly linked list, you have the option of adding nodes before or after `CurrentNode`. You can split this functionality into two functions, `AddNodeAfter()` and `AddNodeBefore()`. The implementation is very similar to the one in the singly linked list, except that you have to remember to set the `Previous` reference for each node as well.

```verse
# Adds a new node after CurrentNode.
AddNodeAfter(NewNode:doubly_linked_node):void=
    if(NextNode := CurrentNode.Next?):
        set NewNode.Next = option{NextNode}
        set NewNode.Previous = option{CurrentNode}
        set CurrentNode.Next = option{NewNode}
        set NextNode.Previous = option{NewNode}
        Print("Successfully added a new node!")
    else:
        set CurrentNode.Next = option{NewNode}
        Print("Successfully added a new node to the tail of the list!")

# Adds a new node before CurrentNode.
AddNodeBefore(NewNode:doubly_linked_node):void=
    if(PreviousNode := CurrentNode.Previous?):
        set NewNode.Next = option{CurrentNode}
        set NewNode.Previous = option{PreviousNode}
        set CurrentNode.Previous = option{NewNode}
        set PreviousNode.Next = option{NewNode}
        Print("Successfully added a new node!")
    else:
        set NewNode.Next = option{CurrentNode}
        set CurrentNode.Previous = option{NewNode}
        Print("Successfully added a new node to the tail of the list!")
```

### Removing Nodes

To remove nodes, you need to delete any references to that node while preserving the order of the list. To do so, if the node you want to remove has any nodes after it, you need to link any nodes before the removed node to the nodes after it. In a singly linked list, because you don't have a `Previous` reference, you can only remove nodes after the `CurrentNode`.

```verse
# Remove the next node after CurrentNode. If the next node
# has a Next reference, set that node to the next node of CurrentNode.
RemoveNextNode():void=
    if(RemovedNode := CurrentNode.Next?):
        if(NodeAfter := RemovedNode.Next?, set RemovedNode.Next = false):
            set CurrentNode.Next = option{NodeAfter}
            Print("Removed the node between CurrentNode and the node after it")
            # If the removed node is the Head node, set the next node as the new Head.
            if(RemovedNode = List.Head):
                Print("Removed node was the head node, setting the node after as the new head")
                set List.Head = NodeAfter
        else:
            set CurrentNode.Next = false
            Print("Removed the node before CurrentNode")
    else:
        Print("Couldn't remove the node")
```

Note that you need a special case when removing from the head node. In this situation, you need to set the node after the head node to the new head, or else your linked list won't have a place to start from.

As with adding nodes, removing nodes in a doubly linked list can be split into removing the node before or after the current node.

```verse
# Remove the node after CurrentNode
RemoveNodeAfter():void=
    if(RemovedNode := CurrentNode.Next?):
        if:
            NodeAfter := RemovedNode.Next?
            set RemovedNode.Next = false
            set RemovedNode.Previous = false
            set NodeAfter.Previous = option{CurrentNode}
            set CurrentNode.Next = option{NodeAfter}
        then:
            Print("Removed the node between CurrentNode and the node after it")
            # If the removed node is the Head node, set the next node as the new Head
            if(RemovedNode = List.Head):
                Print("Removed node was the head node, setting the node after as the new head")
                set List.Head = NodeAfter
                # You don't want to be able to traverse back to the dummy node
                # so set the new head's Previous to false
                set NodeAfter.Previous = false       
        else:
            set CurrentNode.Next = false
            Print("Removed the node after CurrentNode")
    else:
        Print("Couldn't remove the node")   

# Remove the node before CurrentNode.
RemoveNodeBefore():void=
    if(RemovedNode := CurrentNode.Previous?):
        if:
            NodeBefore := RemovedNode.Previous?
            set RemovedNode.Previous = false
            set CurrentNode.Previous = option{NodeBefore}
            set NodeBefore.Next = option{CurrentNode}
        then:
            Print("Removed the node between CurrentNode and the node before it")
            # If the removed node is the Head node, set the next node as the new Head
        else:
            set CurrentNode.Previous = false
            if(RemovedNode = List.Head):
                Print("Removed node was the head node, setting the node after as the new head")
                set List.Head = CurrentNode
            Print("Removed the node after CurrentNode")
    else:
        Print("Couldn't remove the node")
```

## Complete Code

The following is the complete code for each of the classes in this example.

### list\_node

```verse
# A container node that contains data and a reference
# to the next node in the list.
list_node := class<unique>:
    # Reference to the next node in the list.
    var Next:?list_node = false
    Data:any = {}

# A container node that contains integer data and a reference
# to the next node in the list.
list_node_int := class(list_node):
    Data<override>:int

# A container node that contains string data and a reference
# to the next node in the list.
list_node_string := class(list_node):
    Data<override>:string

# A container node that contains data and a reference to both
# the next and previous nodes in the list.
doubly_linked_node := class<unique>:
    # Reference to the next node in the list.
    var Next:?doubly_linked_node = false
    # Reference to the previous node in the list.
    var Previous:?doubly_linked_node = false
    Data:any = {}

# A container node that contains integer data and a reference to both
# the next and previous nodes in the list.
doubly_linked_int_node := class(doubly_linked_node):
    Data<override>:int

# A container node that contains string data and a reference to both
# the next and previous nodes in the list.
doubly_linked_string_node := class(doubly_linked_node):
    Data<override>:string
```

### linked\_list

```verse
# A data structure that links multiple list_node structures together to create a chain. 
# Uses singly linked nodes which contain a reference to the next node in the chain.
linked_list := class:
    # The first node in the list.
    var Head:list_node
 
    # Traverses the linked list forward starting from the CurrentNode.
    TraverseList():void=
        var CurrentNode:?list_node := option{Head} # The node you're currently on
        var NodeNumber:int = 1 # The number of the current node.
        Print("Starting at the Head Node...")
        # If the current node has a next node, set the current node to
        # the next node in the list.
        loop:
            if(NextNode := CurrentNode?.Next?):
                set CurrentNode = option{NextNode}
                set NodeNumber += 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No next node, this is the Tail node!")
                break

# A data structure that links multiple list_node structures together to create a chain. 
# Uses doubly linked nodes which contain references to both the next and previous nodes.
doubly_linked_list := class():
    var Head:doubly_linked_node
 
    # Traverse a LinkedList, but both backward and forward!
    TraverseDoublyLinkedList():void=
        var CurrentNode:?doubly_linked_node := option{Head}
        var NodeNumber:int = 1
        Print("Starting at the Head Node, and going forward...")
        loop:
            if(NextNode := CurrentNode?.Next?):
                set CurrentNode = option{NextNode}
                set NodeNumber += 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No next node, this is the Tail node!")
                break
        Print("Now let's go backward to the Head node...")
        loop:
            if(PreviousNode := CurrentNode?.Previous?):
                set CurrentNode = option{PreviousNode}
                set NodeNumber -= 1
                Print("Traveling to Node {NodeNumber}!")
            else:
                Print("No previous Node, we're back at the Head node!")
                break
```

### linked\_list\_iterator

```verse
# Iterates over a linked_list and can add nodes or remove nodes as it iterates.
linked_list_iterator := class:
    List:linked_list
    var CurrentNode:list_node

    # If there is a NextNode for the iterator to travel to, travel to that node.
    Next()<transacts><decides>:list_node=
        NextNode := CurrentNode.Next?
        set CurrentNode = NextNode

    # Adds a new node after CurrentNode.
    AddNextNode(NewNode:list_node):void=
        if(NextNode := CurrentNode.Next?):
            set NewNode.Next = option{NextNode}
            set CurrentNode.Next = option{NewNode}
            Print("Successfully added a new node!")
        else:
            set CurrentNode.Next = option{NewNode}
            Print("Successfully added a new node to the tail of the list!")

    # Remove the next node after CurrentNode. If the next node
    # has a Next reference, set that node to the next node of CurrentNode.
    RemoveNextNode():void=
        if(RemovedNode := CurrentNode.Next?):
            if(NodeAfter := RemovedNode.Next?, set RemovedNode.Next = false):
                set CurrentNode.Next = option{NodeAfter}
                Print("Removed the node between CurrentNode and the node after it")
                # If the removed node is the Head node, set the next node as the new Head.
                if(RemovedNode = List.Head):
                    Print("Removed node was the head node, setting the node after as the new head")
                    set List.Head = NodeAfter
            else:
                set CurrentNode.Next = false
                Print("Removed the node before CurrentNode")
        else:
            Print("Couldn't remove the node")

# Construct an Iterator with CurrentNode as a dummy node before the head of the given list.
MakeIterator<constructor>(List:linked_list) := linked_list_iterator:
    List := List
    # You can access List from this scope in a constructor function
    CurrentNode:= list_node{Next := option{List.Head}}

# Construct an Iterator with CurrentNode as a dummy node before the head of the given list.
MakeDoublyLinkedIterator<constructor>(List:doubly_linked_list) := doubly_linked_list_iterator:
    List := List
    # You can access List from this scope in a constructor function
    CurrentNode:= doubly_linked_node{Next := option{List.Head}}

# Iterates over a doubly_linked_list and can add nodes or remove nodes as it iterates.
doubly_linked_list_iterator := class:
    List:doubly_linked_list
    var CurrentNode:doubly_linked_node

    # If there is a NextNode for the iterator to travel to, travel to that node
    Next()<transacts><decides>:doubly_linked_node=
        NextNode := CurrentNode.Next?
        set CurrentNode = NextNode

    # If there is a PreviousNode for the iterator to travel to, travel to that node
    Previous()<transacts><decides>:doubly_linked_node=
        PreviousNode := CurrentNode.Previous?
        set CurrentNode = PreviousNode

    # Adds a new node after CurrentNode
    AddNodeAfter(NewNode:doubly_linked_node):void=
        if(NextNode := CurrentNode.Next?):
            set NewNode.Next = option{NextNode}
            set NewNode.Previous = option{CurrentNode}
            set CurrentNode.Next = option{NewNode}
            set NextNode.Previous = option{NewNode}
            Print("Successfully added a new node!")
        else:
            set CurrentNode.Next = option{NewNode}
            Print("Successfully added a new node to the tail of the list!")

    # Adds a new node before CurrentNode
    AddNodeBefore(NewNode:doubly_linked_node):void=
        if(PreviousNode := CurrentNode.Previous?):
            set NewNode.Next = option{CurrentNode}
            set NewNode.Previous = option{PreviousNode}
            set CurrentNode.Previous = option{NewNode}
            set PreviousNode.Next = option{NewNode}
            Print("Successfully added a new node!")
        else:
            set NewNode.Next = option{CurrentNode}
            set CurrentNode.Previous = option{NewNode}
            Print("Successfully added a new node to the tail of the list!")

    # Remove the node after CurrentNode
    RemoveNodeAfter():void=
        if(RemovedNode := CurrentNode.Next?):
            if:
                NodeAfter := RemovedNode.Next?
                set RemovedNode.Next = false
                set RemovedNode.Previous = false
                set NodeAfter.Previous = option{CurrentNode}
                set CurrentNode.Next = option{NodeAfter}
            then:
                Print("Removed the node between CurrentNode and the node after it")
                # If the removed node is the Head node, set the next node as the new Head
                if(RemovedNode = List.Head):
                    Print("Removed node was the head node, setting the node after as the new head")
                    set List.Head = NodeAfter
                    # You don't want to be able to traverse back to the dummy node
                    # so set the new head's Previous to false
                    set NodeAfter.Previous = false
            else:
                set CurrentNode.Next = false
                Print("Removed the node after CurrentNode")
        else:
            Print("Couldn't remove the node")

    # Remove the node before CurrentNode.
    RemoveNodeBefore():void=
        if(RemovedNode := CurrentNode.Previous?):
            if:
                NodeBefore := RemovedNode.Previous?
                set RemovedNode.Previous = false
                set CurrentNode.Previous = option{NodeBefore}
                set NodeBefore.Next = option{CurrentNode}
            then:
                Print("Removed the node between CurrentNode and the node before it")
                # If the removed node is the Head node, set the next node as the new Head
            else:
                set CurrentNode.Previous = false
                if(RemovedNode = List.Head):
                    Print("Removed node was the head node, setting the node after as the new head")
                    set List.Head = CurrentNode
                Print("Removed the node after CurrentNode")
        else:
            Print("Couldn't remove the node")
```

## On your own

There are multiple ways to enhance linked lists, and you should explore different ways of adding functionality. The following are a couple of ways you could enhance your linked lists:

- What if each List also stored a reference to the tail node?
- Can you implement a `ToString()` method to print out the contents of your nodes?
- What about reversing a list? Can you implement a `Length()` functionality?
- Can you add more methods to the iterator to do new operations?
