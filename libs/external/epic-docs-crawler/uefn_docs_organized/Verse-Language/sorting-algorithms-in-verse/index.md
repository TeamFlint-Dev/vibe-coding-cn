# Sorting Algorithms in Verse

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/sorting-algorithms-in-verse
> **爬取时间**: 2025-12-27T00:02:20.248452

---

Sorting is a simple but powerful concept. By taking an unorganized list of items, you can use an algorithm to sort them in a particular order. Although this idea might seem basic, sorting appears all throughout computer science in many different aspects and forms. One of the most important applications is in speeding up search. For example, your computer sorts files by name and size so you can quickly find the one you need. UEFN lets you sort objects in the **Outliner** by **Type** to group things together and organize your project. In Fortnite, players on the in-game scoreboard are sorted by many different stats like eliminations and lap time so everyone knows who's on top.

Applying sorting to Verse code can help you level up your gameplay and enhance aspects of your development. For instance, what about ordering an array of players by their score in a tournament, where the players who scored the least in each round get eliminated? By sorting this array at the end of each round, you can quickly find the lowest scorers and set them to spectators. On the other hand, you can just as quickly get the players with the best score and award them a bonus for the next round. You can even use this sorted list to create persistent local leaderboards, so players know who to watch out for during the game. And if you’ve got a list of people you’d like to shout out in your island, you can sort their names alphabetically for easy display.

Each of these examples uses sorting in different ways, but under the hood, they all use a **sorting algorithm** to accomplish their goal. Sorting algorithms implement the logic that sorts your lists, and there are many different types to choose from based on your needs. Although sorting is a powerful tool, it’s important to understand how it works if you want to integrate it into your projects. This page covers the main ideas behind sorting and how to pick the algorithm that works best for your project. For implementations of specific sorting algorithms, check out the link at the end of this page.

## Merge Sort

Merge sort is a divide-and-conquer sorting algorithm. This means that it breaks up the group of elements that need to be sorted into smaller groups, and sorts the smaller groups. It then combines the smaller groups together with the knowledge that they’re already sorted.

### Implementing Merge Sort

The following implementation calls itself to merge sort the divided arrays, which means it’s a recursive function. When you have a recursive function, you need to specify a base case to prevent infinite recursion. Because this algorithm splits the arrays in half every time, the base case is the array having only one element, so the array is considered sorted to start with one element and can be merged with another single-element array and so on back up to the full array of elements.

The following implementation is generic by using [parametric types](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse) for its parameters. This means you can use whatever type you want for the elements and your own comparison function as arguments. So you can have an integer array that you sort or an array of a more complex type like a class that you can sort. The `Compare` function is another parameter to which you can pass your own custom functions. If you want to sort by smallest to largest, or by certain fields of a class, you can specify that in your custom function, without modifying this generic function implementation.

Follow these steps to implement merge sort in Verse:

1. Let’s start by writing the base case: only one element in the array. If there’s one element or less, return the Array argument that was passed into the function.

   ```verse
        MergeSort<public>(Array:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
            Length:int = Array.Length
            if:
                Length > 1 # Verify there is more than one element in the array, otherwise we've reached the base case.
            else:
                # Return the array passed in because we've reached the base case.
                Array
   ```
2. Then split the array in half.

   ```verse
        MergeSort<public>(Array:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
            Length:int = Array.Length
            if:
                Length > 1 # Verify there is more than one element in the array, otherwise we've reached the base case.
                Mid:int = Floor(Length / 2) # Get the middle index of the array.
                Left:[]t = Array.Slice[0, Mid] # Split the array in half. This keeps elements from the beginning to Mid - 1 index.
                Right:[]t = Array.Slice[Mid] # Split the array in half. This keeps elements from Mid index to the end of the array.
            else:
                # Return the array passed in because we've reached the base case.
                Array
   ```
3. Call `MergeSort` on each half of the initial array, and then `Merge` the two halves together.

   ```verse
        MergeSort<public>(Array:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
            Length:int = Array.Length
            if:
                Length > 1 # Verify there is more than one element in the array, otherwise we've reached the base case.
                Mid:int = Floor(Length / 2) # Get the middle index of the array.
                Left:[]t = Array.Slice[0, Mid] # Split the array in half. This keeps elements from the beginning to Mid - 1 index.
                Right:[]t = Array.Slice[Mid] # Split the array in half. This keeps elements from Mid index to the end of the array.
            then:
                # Call MergeSort on the left half of the array.
                LeftSorted:[]t = MergeSort(Left, Compare)

                # Call MergeSort on the right half of the array.
                RightSorted:[]t = MergeSort(Right, Compare)

                # Combine the two arrays and return the result.
                Merge(LeftSorted, RightSorted, Compare)
            else:
                # Return the array passed in because we've reached the base case.
                Array
   ```
4. When merging the two halves back together, compare elements from each array and add them to the resulting array until all elements from both arrays have been added. To do this, have an index variable to track positions in each array. Every time the `Compare` function succeeds, the left array element should be added and its index variable advanced to the next position in the array, otherwise do the same with the right array element. Once all the elements from one of the arrays have been added, add the remaining elements from the other array since it’s already been sorted.

   ```verse
        # A helper function for MergeSort that combines the divided arrays in an order based on the Compare function.
        Merge(Left:[]t, Right:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
            var LeftIndex:int = 0
            var RightIndex:int = 0
            var MergedArray:[]t = array{}

            # Loop through all the elements in the arrays to add them to the MergedArray variable.
            loop:
                if (LeftElement := Left[LeftIndex], RightElement := Right[RightIndex]):
                    # Check the element in the left half array with the element in the right half array.
                    # Uses the Compare function passed in as an argument
                    if (Compare[LeftElement, RightElement]):
                        set MergedArray += array{LeftElement}
                        set LeftIndex += 1
                    else:
                        set MergedArray += array{RightElement}
                        set RightIndex += 1
                else:
                    # We've added all of the elements from one of the arrays at this point.
                    # Now check which array still has elements to merge in and add all remaining elements.
                    if (LeftIndex >= Left.Length):
                        option{set MergedArray += Right.Slice[RightIndex]}
                    else:
                        option{set MergedArray += Left.Slice[LeftIndex]}
                    # Exit out of the loop because we've finished adding all elements.
                    break

            # Return the merged array.
            MergedArray
   ```

### Complete Script

```verse
    # A divide-and-conquer sorting algorithm that divides an array into two, sorts each divided array, and then merges the arrays together.
    # This is a recursive implementation, where the function calls itself to merge sort the divided arrays.
    # The base case (the condition to stop the recursion) is the array has only one element.
    # This is a generic implementation using parametric types, so you can provide your own type and your own comparison function as arguments.
    MergeSort<public>(Array:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
        Length:int = Array.Length
        if:
            Length > 1 # Verify there is more than one element in the array, otherwise we've reached the base case.
            Mid:int = Floor(Length / 2) # Get the middle index of the array.
            Left:[]t = Array.Slice[0, Mid] # Split the array in half. This keeps elements from the beginning to Mid - 1 index.
            Right:[]t = Array.Slice[Mid] # Split the array in half. This keeps elements from Mid index to the end of the array.
        then:
            # Call MergeSort on the left half of the array.
            LeftSorted:[]t = MergeSort(Left, Compare)

            # Call MergeSort on the right half of the array.
            RightSorted:[]t = MergeSort(Right, Compare)

            # Combine the two arrays and return the result.
            Merge(LeftSorted, RightSorted, Compare)
        else:

            # Return the array passed in because we've reached the base case.
            Array

    # A helper function for MergeSort that combines the divided arrays in an order based on the Compare function.
    Merge(Left:[]t, Right:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:type)<transacts>:[]t=
        var LeftIndex:int = 0
        var RightIndex:int = 0
        var MergedArray:[]t = array{}

        # Loop through all the elements in the arrays to add them to the MergedArray variable.
        loop:
            if (LeftElement := Left[LeftIndex], RightElement := Right[RightIndex]):
                # Check the element in the left half array with the element in the right half array.
                # Uses the Compare function passed in as an argument
                if (Compare[LeftElement, RightElement]):
                    set MergedArray += array{LeftElement}
                    set LeftIndex += 1
                else:
                    set MergedArray += array{RightElement}
                    set RightIndex += 1
            else:
                # We've added all of the elements from one of the arrays at this point.
                # Now check which array still has elements to merge in and add all remaining elements.
                if (LeftIndex >= Left.Length):
                    option{set MergedArray += Right.Slice[RightIndex]}
                else:
                    option{set MergedArray += Left.Slice[LeftIndex]}
                # Exit out of the loop because we've finished adding all elements.
                break

        # Return the merged array.
        MergedArray
```

## Choosing an Algorithm

Although many sorting algorithms follow similar ideas, a few things set each of them apart that can have a big impact on how the algorithm performs.

### Time Complexity

Algorithms take time, and the more things they have to do, the longer it will take. A number of factors influence the complexity of the problem the algorithm is trying to solve, and the amount of time it takes to handle it is called the **time complexity**.

Since calculating an exact amount of time it will take for an algorithm to finish is almost impossible due to various things like your computer hardware, other running code, or the type of data you’re working with, time complexity is instead measured in [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference#operators), or the number of actions an algorithm has to perform to finish. Because each algorithm is different, the amount of time it takes to process a dataset is represented using **big O** notation. Big O notation doesn’t describe the exact number of operations required but instead describes how that number changes as the size of the list you input into the algorithm increases.

For example, say you write an algorithm to find the smallest number in a list. You don’t know if the list is ordered, so your algorithm has to check every number to know if it’s the smallest one. If there are three items in the list, your algorithm does three checks, and If there are ten items, your algorithm does ten. Since the number of operations increases linearly with the input size of your list, the time complexity is linear, or **O(n)**, where n is the number of items in your list. If your algorithm had to do two operations per item, such as copying each item into a different list after each check, the time complexity would be **O(2n)** since the number of operations is 2 \* NumberOfItems.

What if your algorithm just wanted to check if there were any items in the list? Since your algorithm only does one operation regardless of input size, the time complexity would be constant, or **O(1)**. There are many other examples such as quadratic time (**O(n^2)**) or factorial time (**O(n!)**), but what matters is that each of them describes how the number of operations performed grows with the input size.

### Complexity in Sorting

Measuring time complexity for sorting algorithms gets a lot more complicated due to the different states a list could be in before sorting. What if it’s already sorted? What if it’s sorted in reverse? The performance of a sorting algorithm could vary dramatically depending on these factors, so sorting algorithms are typically measured by their best, worst, and average case time complexities.

For example, let’s look at the [bubble sort algorithm](https://dev.epicgames.com/community/snippets/zbLB/fortnite-bubble-sort). In the best case, given an already sorted list, bubble sort just needs to check every pair of elements, but won’t need to make any swaps! This means the best-case time complexity will be **O(n)**, which is great! However what about the opposite scenario, where the list is sorted backwards? In this situation, bubble sort will have to do *n \_number of checks, and swap every element in the list \_n* times, meaning the worst-case time complexity will be n \* n or **O(n^2)**. This is considered slow compared to other sorting algorithms and can get out of hand very fast, as the algorithm would take at least a hundred operations to process a list of ten elements. Can you imagine how many operations a hundred elements would take? What about a thousand?

Instead of best and worst case, sorting algorithms will usually perform closer to their average case. For instance, the average case complexity of merge sort is **O(nlogn)**. This is considered a good benchmark, as many other common sorting algorithms have best, worst, and average case complexities at or very close to this level. Bubble sort from before has an average case complexity of **O(n^2)**, so even in the average case, it’s still relatively slow.

Knowing the time complexity is important when picking out an algorithm since you want your code to run fast and perform similarly no matter the type of input. For some examples of common efficient sorting algorithms, check out [Merge Sort](https://dev.epicgames.com/community/snippets/LNY1/fortnite-merge-sort) and [Quicksort](https://dev.epicgames.com/community/snippets/90Da/fortnite-quicksort). Both these algorithms have the same best, worst, and average case complexities of **O(nlogn)**, and are a good starting point for any sorting situation.

### Space Complexity

In addition to time complexity, it’s also important to consider how much stuff your algorithm has to create to finish sorting. This is the **space complexity** or the amount of extra data created when running your algorithm. Like time complexity, space complexity is measured with Big *O \_notation, which varies between algorithms. For example, because merge sort divides a list into \_n* sublists, it has a space complexity of **O(n)**. Algorithms that sort objects in place (as in they only modify existing data, rather than making new ones) have a space complexity of **O(1)**. If you’re working with very large lists, space complexity may be something to watch out for when selecting your algorithm.

Because Verse is a [functional programming language](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functional-programming), data structure API operations return modified versions of the original item passed as input. For example, both the `Insert()` and `RemoveElement()` array functions do not modify the original array, but instead create and return a new array after the function executes. This may lead to higher time and space complexity requirements to account for the creation of these new elements.

### Stability

Often when sorting, your algorithm is going to run into ties. For instance, given two players, each with a score of five, how should the algorithm sort them? In this scenario, a **stable algorithm** will preserve the order that equal elements appear in the list after sorting. So if player one came before player two in the list before sorting, the sorted list will still have player one before player two.

However, an **unstable algorithm** won’t preserve this order, meaning that player two might appear before player one. This is important if your code cares about the first few elements in a list, such as if you wanted to get the top three players by score to display on a leaderboard. In that situation, you would want a stable algorithm to make sure that whoever achieved that score first stayed on the leaderboard.

## Testing and Profiling Your Algorithms

Although it’s good to know how your algorithm is expected to run given time and space complexity, it’s even more important to measure how your algorithm actually performs on real inputs. Developing sorting algorithms can be difficult, and it may be hard to identify if your code works consistently for all inputs. This is where testing comes in. By setting up a test function, you can gauge the accuracy of your code and identify how it behaves as you develop it. You can also see if there’s any regression in performance if you change the implementation of what you’re testing. Follow these steps to set up a testing file for your sorting algorithms and output data about their performance:

1. Create a failable function named `RunArrayTest`.

   ```verse
        # Test function for sorting arrays and profiling the code.
        RunArrayTest()<decides><transacts>:void=
   ```
2. Add the argument for the array you want to run the sort on and the compare function to use.

   ```verse
        # Test function for sorting arrays and profiling the code.
        RunArrayTest(ActualArray:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:subtype(comparable))<decides><transacts>:void=
            # Perform merge sort
            ResultArray := SortingAlgorithms.MergeSort(ActualArray, Compare)
   ```
3. Now you’ll need to compare the sorted array with what’s expected. Add the argument for the expected array to compare with the sorted actual array to verify the result is correct.

   Compare the elements in the `ResultArray` with the elements in the `ExpectedArray`. The function `RunArrayTest` is failable so as soon as an element doesn’t match, then the test function fails.

   ```verse
    # Test function for sorting arrays and profiling the code.
    RunArrayTest(ActualArray:[]t, ExpectedArray:[]t, Compare(L:t, R:t)<decides><transacts>:t where t:subtype(comparable))<decides><transacts>:void=
        # Perform merge sort
        ResultArray := SortingAlgorithms.MergeSort(ActualArray, Compare)

        # Verify the test passed and sorted the array as expected.
        for (Index -> Result : ResultArray, Expected := ExpectedArray[Index]):
            Result = Expected
   ```
4. Add an argument function to print out the arrays at each step so you can compare them if the test fails, and understand how to fix the code you’re testing.

   ```verse
        # Test function for sorting arrays and profiling the code.
        RunArrayTest(ActualArray:[]t, ExpectedArray:[]t, Compare(L:t, R:t)<decides><transacts>:t, ArrayToString(:[]t)<transacts>:string where t:subtype(comparable))<decides><transacts>:void=
            # Perform merge sort
            ResultArray := SortingAlgorithms.MergeSort(ActualArray, Compare)

            # Print out the Actual, Expected, and Result arrays for troubleshooting.
            ProjectLog("Actual: {ArrayToString(ActualArray)}")
            ProjectLog("Expected: {ArrayToString(ExpectedArray)}")
            ProjectLog("Result: {ArrayToString(ResultArray)}")

            # Verify the test passed and sorted the array as expected.
            for (Index -> Result : ResultArray, Expected := ExpectedArray[Index]):
                Result = Expected
   ```
5. Your test function checks for the accuracy of the result, but you can also get more information from your test. Using the [profile expression](https://dev.epicgames.com/documentation/en-us/fortnite/profile-in-verse), you can measure the performance of your algorithms by logging the time it takes the algorithm to complete.

   This is useful if you want to compare the performance of different sorting algorithms or test how your algorithms run given different inputs. Individual algorithms may perform very differently given best and worst-case inputs, and profiling lets you find and test those cases to know what to look out for. Over multiple tests, you can gauge your algorithm's average performance, and estimate how it will perform on inputs of any given size.
6. Add a string argument named `Description` that explains what the test is focused on. You can add this to the `profile` expression to log the description with the timed value.

   ```verse
       # Test function for sorting arrays and profiling the code.
        RunArrayTest(Description:string, ActualArray:[]t, ExpectedArray:[]t, Compare(L:t, R:t)<decides><transacts>:t, ArrayToString(:[]t)<transacts>:string where t:subtype(comparable))<decides><transacts>:void=

            # Perform merge sort and profile the code.
            ResultArray := profile(Description):
                SortingAlgorithms.MergeSort(ActualArray, Compare)

            # Print out the Actual, Expected, and Result arrays for troubleshooting.
            ProjectLog("Actual: {ArrayToString(ActualArray)}")
            ProjectLog("Expected: {ArrayToString(ExpectedArray)}")
            ProjectLog("Result: {ArrayToString(ResultArray)}")

            # Verify the test passed and sorted the array as expected.
            for (Index -> Result : ResultArray, Expected := ExpectedArray[Index]):
                Result = Expected
   ```

### Writing Test Cases

Start simple. Isolate what you’re testing. Test an integer array to sort from smallest to largest value.

1. Create a comparison function for integers.

   ```verse
        # Comparison function to use as argument for sorting integers from smallest to largest number.
        IsIntSmallerThan(Left:int, Right:int)<decides><transacts>:int=
            Left < Right
   ```
2. Create a helper function to convert an integer array to a string.

   ```verse
        # Helper function to convert an integer array to a string.
        IntArrayToString(Array:[]int)<transacts>:string=
            var ConvertedToString:string = "["
            for (Index -> Element : Array):
                set ConvertedToString += "{Element}"
                if (Index < Array.Length - 1):
                    set ConvertedToString += ", "
            set ConvertedToString += "]"
   ```
3. Create a Verse device to run the test.

   ```verse
        # This file contains tests for verifying the sorting algorithm behaves as expected.
        # The tests also include profiling the code to see the performance of the algorithm.

        using { /Fortnite.com/Devices }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /Verse.org/Simulation }
        using { /Verse.org/Random }

        my_log_channel<public> := class(log_channel):

        # A project-wide "Logger" to print messages from functions that are not in a class with a log.
        # The non-Logger Print is <no_rollback>, so it can't be used in a <transacts> function.
        ProjectLog<public>(Message:[]char, ?Level:log_level = log_level.Normal)<transacts>:void=
            Logger := log{Channel := my_log_channel}
            Logger.Print(Message, ?Level := Level)

        # A Verse-authored creative device that can be placed in a level.
        # Place in the level to run tests and profile code.
        test_sorting := class(creative_device):

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                # Example arrays to use for the test.
                Test1ExpectedIntArray:[]int = array{}
                Test1ActualIntArray:[]int = array{}

                # Run the tests and report if they failed or succeeded.
                if:
                    RunArrayTest["Integer array in order from smallest to largest", Test1ActualIntArray, Test1ExpectedIntArray, IsIntSmallerThan, IntArrayToString]
                then:
                    ProjectLog("All tests passed.")
                else:
                    ProjectLog("One or more tests failed.")
   ```
4. Now populate the test arrays with values.

   ```verse
        var ArrayLength:int = GetRandomInt(10, 100)
                Test1ExpectedIntArray:[]int =
                    for (Count := 0..ArrayLength):
                    	Count
                Test1ActualIntArray:[]int = Shuffle(Test1ExpectedIntArray)
   ```
5. Run the test by dragging the Verse device in to your level

The following are more ideas for tests you can run:

\* Sort an integer array from largest to smallest.

```verse
        # Comparison function to use as argument for sorting integers from largest to smallest number.
        IsIntGreaterThan(Left:int, Right:int)<decides><transacts>:int=
            Left > Right
```

\* Sort an integer array that has repeating values.

```verse
        Test3ExpectedIntArray:[]int = array{0, 1, 1, 2, 3, 3}
        Test3ActualIntArray:[]int = Shuffle(Test3ExpectedIntArray)
```

\* Sort a class by one of its fields.

```verse
        # An example class for testing sorting.
        player_stats := class<unique>:
            Wins:int = 0
            RoundsPlayed:int = 0

        # Comparison function to use as argument for sorting wins from smallest to largest.
        IsWinsSmallerThan(Left:player_stats, Right:player_stats)<decides><transacts>:player_stats=
            Left.Wins < Right.Wins
            Left

        # Helper function to convert the player stats comparison values to a string.
        PlayerStatsWinsArrayToString(Array:[]player_stats)<transacts>:string=
            var ConvertedToString:string = "["

            for (Index -> Element : Array):
                set ConvertedToString += "{Element.Wins}"
                if (Index < Array.Length - 1):
                    set ConvertedToString += ", "
            set ConvertedToString += "]"
```

### Complete Script

```verse
    # This file contains tests for verifying the sorting algorithm behaves as expected.
    # The tests also include profiling the code to see the performance of the algorithm.

    using { /Fortnite.com/Devices }
    using { /UnrealEngine.com/Temporary/Diagnostics }
    using { /Verse.org/Simulation }
    using { /Verse.org/Random }

    my_log_channel<public> := class(log_channel):

    # A project-wide "Logger" to print messages from functions that are not in a class with a log.
    # The non-Logger Print is <no_rollback>, so it can't be used in a <transacts> function.
    ProjectLog<public>(Message:[]char, ?Level:log_level = log_level.Normal)<transacts>:void=
        Logger := log{Channel := my_log_channel}
        Logger.Print(Message, ?Level := Level)

    # A Verse-authored creative device that can be placed in a level.
    # Place in the level to run tests and profile code.
    test_sorting := class(creative_device):

        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=

            # Example arrays to use for the test.
            var ArrayLength:int = GetRandomInt(10, 100)

            Test1ExpectedIntArray:[]int =
                for (Count := 0..ArrayLength):
                        Count

            Test1ActualIntArray:[]int = Shuffle(Test1ExpectedIntArray)

            set ArrayLength = GetRandomInt(10, 100)

            Test2ExpectedIntArray:[]int = for (Count := 0..ArrayLength):
                ArrayLength - Count

            Test2ActualIntArray:[]int = Shuffle(Test2ExpectedIntArray)

            Test3ExpectedIntArray:[]int = array{0, 1, 1, 2, 3, 3}

            Test3ActualIntArray:[]int = Shuffle(Test3ExpectedIntArray)

            set ArrayLength = GetRandomInt(10, 100)
            Test4ExpectedPlayerStats:[]player_stats = for (Count := 0..ArrayLength):
                player_stats:
                    Wins := ArrayLength - Count
                    RoundsPlayed := GetRandomInt(Count, Count * 30)

            Test4ActualPlayerStats:[]player_stats = Shuffle(Test4ExpectedPlayerStats)

            # Run the tests and report if they failed or succeeded.
            if:
                RunArrayTest["Integer array in order from smallest to largest", Test1ActualIntArray, Test1ExpectedIntArray, IsIntSmallerThan, IntArrayToString]
                RunArrayTest["Integer array in order from largest to smallest", Test2ActualIntArray, Test2ExpectedIntArray, IsIntGreaterThan, IntArrayToString]
                RunArrayTest["Integer array in order from smallest to largest with repeats", Test3ActualIntArray, Test3ExpectedIntArray, IsIntSmallerThan, IntArrayToString]
                RunArrayTest["Player stats array in order from largest # wins to smallest", Test4ActualPlayerStats, Test4ExpectedPlayerStats, IsWinsGreaterThan, PlayerStatsWinsArrayToString]
            then:
                ProjectLog("All tests passed.")
            else:
                ProjectLog("One or more tests failed.")

    # Test function for sorting arrays and profiling the code.
    RunArrayTest(Description:string, ActualArray:[]t, ExpectedArray:[]t, Compare(L:t, R:t)<decides><transacts>:t, ArrayToString(:[]t)<transacts>:string where t:subtype(comparable))<decides><transacts>:void=

        # Perform merge sort and profile the code.
        ResultArray := profile(Description):
            SortingAlgorithms.MergeSort(ActualArray, Compare)

        # Print out the Actual, Expected, and Result arrays for troubleshooting.
        ProjectLog("Actual: {ArrayToString(ActualArray)}")
        ProjectLog("Expected: {ArrayToString(ExpectedArray)}")
        ProjectLog("Result: {ArrayToString(ResultArray)}")

        # Verify the test passed and sorted the array as expected.
        for (Index -> Result : ResultArray, Expected := ExpectedArray[Index]):
            Result = Expected

    # Helper function to convert an integer array to a string.
    IntArrayToString(Array:[]int)<transacts>:string=
        var ConvertedToString:string = "["
        for (Index -> Element : Array):
            set ConvertedToString += "{Element}"
            if (Index < Array.Length - 1):
                set ConvertedToString += ", "
        set ConvertedToString += "]"

    # Helper function to convert the player stats comparison values to a string.
    PlayerStatsWinsArrayToString(Array:[]player_stats)<transacts>:string=
        var ConvertedToString:string = "["
        for (Index -> Element : Array):
            set ConvertedToString += "{Element.Wins}"
            if (Index < Array.Length - 1):
                set ConvertedToString += ", "
        set ConvertedToString += "]"

    # Comparison function to use as argument for sorting integers from smallest to largest number.
    IsIntSmallerThan(Left:int, Right:int)<decides><transacts>:int=
        Left < Right

    # Comparison function to use as argument for sorting integers from largest to smallest number.
    IsIntGreaterThan(Left:int, Right:int)<decides><transacts>:int=
        Left > Right

    # An example class for testing sorting.
    player_stats := class<unique>:
        Wins:int = 0
        RoundsPlayed:int = 0

    # Comparison function to use as argument for sorting wins from smallest to largest.
    IsWinsSmallerThan(Left:player_stats, Right:player_stats)<decides><transacts>:player_stats=
        Left.Wins < Right.Wins
        Left

    # Comparison function to use as argument for sorting wins from largest to smallest.
    IsWinsGreaterThan(Left:player_stats, Right:player_stats)<decides><transacts>:player_stats=
        Left.Wins > Right.Wins
        Left
```

## On Your Own

- Implement a different sorting algorithm. You can find the following other algorithm implementations:

  - [Quick Sort](https://dev.epicgames.com/community/snippets/zbLB/fortnite-bubble-sort)
  - [Bubble Sort](https://dev.epicgames.com/community/snippets/90Da/fortnite-quicksort)
- Add more test cases to increase coverage of the tester. Can you think of edge cases the tester doesn’t currently cover? Or what about more complex data types?
