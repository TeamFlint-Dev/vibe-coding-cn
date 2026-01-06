# Stacks and Queues

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/stacks-and-queues-in-verse
> **爬取时间**: 2025-12-27T00:03:15.204300

---

## Overview

**Stacks** and **queues** are common data structures in computer science that specify the order in which you can add and remove elements. You can use them to control the order in which you interact with data:

- Stack: a container where you insert and remove elements in a first-in, last-out (FILO) order, such as picking a book off the top of a stack of books to read.
- Queue: a container where you insert and remove elements in a first-in, first-out (FIFO) order, such as processing a line of customers waiting for a meal.

Although the underlying code for stacks and queues are similar, they each have key differences and strengths you can leverage to make your experience fast, efficient, and intuitive.

## Stacks

You can think of a stack as a stack of pancakes. Suppose you’re at a breakfast restaurant, and your waiter gives you an endless stack of pancakes. Because you want to be polite, you’re only going to take one pancake at a time, and only from the top of the stack. You can ask your waiter to **push** a new pancake to the top of your stack, and when you’re hungry you can **pop** a pancake off the top of the stack and onto your plate to eat it. If you want to eat a specific pancake in the middle of the stack, you’ll have to keep eating pancakes from the top till you get to the one you want. The first pancake added is going to be the last one you remove. This makes a stack a **FILO**, or first-in, last-out data structure.

### When to Use

Stacks are useful when you need backtracking, or the ability to remember what order you did events in. This could be an undo function, a chain of events, or a series of choices. For instance, maybe you have a robot that needs to solve a maze with branching paths. When the robot hits a split in the maze, it chooses a path and pushes that choice onto the stack. When it hits a dead end, it backtracks through the stack, popping choices off until it finds a new path it can take.

## Verse Implementation

The Verse API does not have a built-in implementation of stacks, but you can create one yourself.

You can represent the elements in a stack using any ordered data structure, such as an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) or a [linked list](https://dev.epicgames.com/documentation/en-us/fortnite/linked-lists-in-verse). In this example, you’ll use an array since it gives you easy access to the top of the stack.

```verse
stack<public>(t:type) := class:
    Elements<internal>:[]t = array{}
```

The `Elements` array stores the objects in the stack, which are of type `t`. This means you can initialize a stack with any type of element, such as `int`, `float`, `stack`, etc. Using `type` as an argument to the stack class is an example of a parametric type](parametric-types-in-verse).

Let’s define a few helper functions first. You need to know where the top of the stack is so you can `Push()` and `Pop()` elements from it. For this, you’ll need three functions, `Size()`, `IsEmpty()`, and `Peek()`.

```verse
# Returns the size of the stack.
    Size<public>()<transacts>:int=
        Elements.Length

    # Succeeds if the stack is empty.
    IsEmpty<public>()<decides><transacts>:void=
        Size() = 0

    # Returns the top element of the stack.
    Peek<public>()<decides><transacts>:t=
        Elements[Elements.Length - 1]
```

The `Size()` function simply returns the `Length` of the `Elements` array. The `IsEmpty()` function calls the `Size()` function, and has the `<transacts>` specifier, meaning it will fail if `Size()` is not equal to 0.

The `Peek()` function returns the element at the top (Length - 1) index of the elements array. This function has the `<decides><transacts>` specifiers since the array access can fail if the array is empty.

To instantiate a stack you can use a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse) function. A constructor is a special function that creates an instance of the class it’s associated with. The constructor sets initial values for an object and allows you to access the value of `Elements` and assign it to an initial array of elements.

```verse
# Creates and returns a stack from an initial array of elements InitialElements.
CreateStack<public><constructor>(InitialElements:[]t where t:type) := stack(t):
    Elements := InitialElements
```

### Push and Pop

To add and remove elements from the stack, you either need to `push` the new element to the top of the stack, or `pop` it off the top.

```verse
# Adds NewElement to the top of the stack by returning a new
# stack with NewElement as the top
Push<public>(NewElement:t):stack(t)=
    stack(t){Elements := Elements + array{NewElement}}

# Removes the element on top of the stack and returns a tuple of both a new
# stack with the top element removed and the removed element.
Pop<public>()<decides><transacts>:tuple(stack(t),t)=
    FirstElement := Peek[]
    (stack(t){Elements := Elements.RemoveElement[Elements.Length - 1]}, FirstElement)
```

The `Push()` function takes the element you want to put on top of the stack and returns a new stack with the element on top. Returning a new stack rather than modifying the current stack is an example of [functional programming](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#functional-programming), and reduces the risk of [side effects](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#side-effect).

To implement the `Pop()` function, you need to first find the element on top of the stack using `Peek()`. You need to then remove the element on top (using the `RemoveElement[]` function), and also return a new stack without the element. You can use a tuple to return both the new stack and the removed element simultaneously. Because of failable expressions for the array access and the call to `Peek()`, `Pop()` must have the `<decides><transacts>` specifiers.

### Complete Code

The complete code for the stack class is provided below.

```verse
stack<public>(t:type) := class:
    Elements<internal>:[]t = array{}

    # Adds NewElement to the top of the stack by returning a new
    # stack with NewElement as the top
    Push<public>(NewElement:t):stack(t)=
        stack(t){Elements := Elements + array{NewElement}}

    # Removes the element on top of the stack and returns a tuple of both a new
    # stack with the top element removed and the removed element.
    Pop<public>()<decides><transacts>:tuple(stack(t),t)=
        FirstElement := Peek[]
        (stack(t){Elements := Elements.RemoveElement[Elements.Length - 1]}, FirstElement)

    # Returns the size of the stack.
    Size<public>()<transacts>:int=
        Elements.Length

    # Succeeds if the stack is empty.
    IsEmpty<public>()<decides><transacts>:void=
        Size() = 0

    # Returns the top element of the stack.
    Peek<public>()<decides><transacts>:t=
        Elements[Elements.Length - 1]
```

## Queues

You can think of a queue as a conveyor belt of sushi. Suppose you’re at a sushi restaurant that sends you plates of sushi one at a time a conveyor belt, and they arrive in the order they were ordered. You can **dequeue** the plate at the front of the line to pick it up and eat it, but you can only pick up one plate at a time. When you want to order a new plate, you ask the chef to **enqueue** a plate to the back of the line. If the queue already has other plates of sushi in it, you’ll have to keep eating plates from the front of the line till you get to the plate at the back. The first plate of sushi added is going to be the first you remove. This makes a queue **FIFO**, or first-in, first-out data structure.

### When to Use

Queues are useful when you need to process data based on when they arrive. This could be serving customers at a drive-thru, lining up calls at a call center, or asking the player a queue of questions in an interview. For example, if you need to create a waiting room for players while they perform a task or go through an experience one at a time, you could use a queue to order the players by when they arrive on a first-come, first-served basis.

## Verse Implementation

The Verse API does not have a built-in implementation of queues, but you can create one yourself.

Like stacks, you can represent the elements in the queue using any ordered data structure, such as an array or a linked list. In this example, you’ll use an array since it gives you easy access to both the front and back of the queue. For a queue implementation using a linked list, check out [this code snippet](https://dev.epicgames.com/community/snippets/rmpp/fortnite-generic-queue-implementation).

```verse
queue<public>(t:type) := class:
    Elements<internal>:[]t = array{}
```

The `Elements` array stores the objects in the queue of type `t`. This means you can initialize a queue with any type of element, such as `int`, `float`, `queue`, etc. Using `type` as an argument to the stack class is an example of a parametric type](parametric-types-in-verse).

As with stacks, queues need a few helper functions. You need to know where the front and back of the queue are so you can perform `Enqueue()` and `Dequeue()`. It’s also helpful to know the size of the queue and if the queue is empty. You’ll define these in four functions, `Size()`, `IsEmpty()`, `Front()`, and `Back()`.

```verse
# Returns the size of the queue
Size<public>()<transacts>:int=
    Elements.Length

# Succeeds if the queue is empty
IsEmpty<public>()<decides><transacts>:void=
    Size() = 0

# Returns the element at the front of the queue.
Front<public>()<decides><transacts>:t=
    Elements[0]

# Returns the element at the back of the queue.
Rear<public>()<decides><transacts>:t=
    Elements[Elements.Length - 1]
```

The `Size()` function returns the `Length` of the `Elements` array. The `IsEmpty()` function calls the `Size()` function, and has the `<transacts>` specifier, meaning it will fail if `Size()` is not equal to 0.

The `Front()` and `Rear()` functions return the element at the front (index 0) and rear (Length - 1) index of the elements array. Both these functions have the `<decides><transacts>` specifiers since the array access can fail if the array is empty.

Like `stack`, the `queue` class also has to use a constructor function to assign the `Elements` array. The constructor function allows you to access the value of `Elements` and assign it to an initial array of elements.

```verse
# Creates and returns a queue from an initial array of elements InitialElements.
CreateQueue<public><constructor>(InitialElements:[]t where t:type) := queue(t):
    Elements := InitialElements
```

### Enqueue and Dequeue

To add and remove elements from the queue, you either need to **enqueue** the new element at the back of the queue, or **dequeue** an element from the front.

```verse
# Adds a new element to the back of the queue by returning a
# new queue with NewElement at the back.
Enqueue<public>(NewElement:t):queue(t)=
    queue(t){Elements := Elements + array{NewElement}}

# Removes the element at the front of the queue and returns a tuple of
# both a new queue with the element removed and the removed element.
Dequeue<public>()<decides><transacts>:tuple(queue(t),t)=
    FirstElement := Front[]
    (queue(t){Elements := Elements.RemoveElement[0]}, FirstElement)
```

The `Enqueue()` function takes the element you want to insert into the queue and returns a new queue with the new element at the back. Returning a new queue rather than modifying the current queue is an example of [functional programming](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#functional-programming), and reduces the risk of [side effects](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#side-effect).

For the `Dequeue()` function, you need to remove and return the element at the front of the queue and also return a new queue with the first element removed (using the `RemoveElement[]` function). Because of failable expressions for the array access and the call to `Front()`, `Dequeue()` must have the `<decides><transacts>` specifiers.

### Complete Code

The complete code for the Queue class is provided below.

```verse
queue<public>(t:type) := class:
    Elements<internal>:[]t = array{}

    # Adds a new element to the back of the queue by returning a
    # new queue with NewElement at the back.
    Enqueue<public>(NewElement:t):queue(t)=
        queue(t){Elements := Elements + array{NewElement}}

    # Removes the element at the front of the queue and returns a tuple of
    # both a new queue with the element removed and the removed element.
    Dequeue<public>()<decides><transacts>:tuple(queue(t),t)=
        FirstElement := Front[]
        (queue(t){Elements := Elements.RemoveElement[0]}, FirstElement)

    # Returns the size of the queue
    Size<public>()<transacts>:int=
        Elements.Length

    # Succeeds if the queue is empty
    IsEmpty<public>()<decides><transacts>:void=
        Size() = 0

    # Returns the element at the front of the queue.
    Front<public>()<decides><transacts>:t=
        Elements[0]

    # Returns the element at the back of the queue.
    Rear<public>()<decides><transacts>:t=
        Elements[Elements.Length - 1]

# Creates and returns a queue from an initial array of elements InitialElements.
CreateQueue<public><constructor>(InitialElements:[]t where t:type) := queue(t):
    Elements := InitialElements
```

## On your own

There are many ways to iterate on and enhance stacks and queues, and you should explore different ways of adding functionality. Here are a few ideas to get you started:

- Can you turn a queue into a circular queue, where the last element is connected to the first element and the queue keeps looping?
- What about a priority queue, where objects are ordered based both on when they enter the queue AND some other value?
- Can you create games using a stack, such as Tower of Hanoi? How about a restaurant game, where customers have to wait in a queue?
