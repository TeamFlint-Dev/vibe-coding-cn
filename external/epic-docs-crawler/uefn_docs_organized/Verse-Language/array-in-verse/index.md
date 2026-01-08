# Array

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse>
> **爬取时间**: 2025-12-26T23:51:09.230960

---

When you have [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of the same [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type), you can collect them into an array. An array is a [container type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#container-type) where you specify the type of the elements with `[]type`, such as `[]float`. An array is useful because it scales to however many elements you store in it without changing your code for accessing the elements.

For example, if you have multiple players in your game, you can create an array and [initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) it with all the players.

```verse
Players : []player = array{Player1, Player2}
```

[![An array containing 2 players](https://dev.epicgames.com/community/api/documentation/image/aadba63f-f121-47dd-a7a0-dc90fd176b3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aadba63f-f121-47dd-a7a0-dc90fd176b3b?resizing_type=fit)

Verse has the pattern where definition mirrors use. Defining an array and using it follows that pattern.

## Array Length

You can get the number of elements in an array by accessing the [member](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#member) `Length` on the array. For example, `array{10, 20, 30}.Length` returns 3.

## Accessing Elements in an Array

Elements in an array are ordered in the same position in the array as you inserted them, and you can access the element at that position, called its [index](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#index), in the array. For example, to get the first player, you’d access the Players array with `Players[0]`.

The first element in an array has an index of 0 and each subsequent element’s index increases in number. For example, `array{10, 20, 30}[0]` is 10 and `array{10, 20, 30}[1]` is 20.

|  |  |  |  |
| --- | --- | --- | --- |
| **Index** | 0 | 1 | 2 |
| **Element** | 10 | 20 | 30 |

The last index in an array is one less than the length of the array. For example, `array{10, 20, 30}.Length` is 3 and the index for 30 in `array{10, 20, 30}` is 2.

Accessing an element in an array is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) and can only be used in a failure context, such as an `if` expression. For example:

```verse
ExampleArray : []int = array{10, 20, 30, 40, 50}
for (Index := 0..ExampleArray.Length - 1):
    if (Element := ExampleArray[Index]):
        Print("{Element} in ExampleArray at index {Index}")
```

This code will print:

```verse
10 in ExampleArray at index 0
    20 in ExampleArray at index 1
    30 in ExampleArray at index 2
    40 in ExampleArray at index 3
    50 in ExampleArray at index 4
```

## Changing an Array and its Elements

Arrays, like all other [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) in Verse, are [immutable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#immutable). If you define an array variable, that allows you to assign a new array to the variable, or mutate individual elements.

For example:

```verse
# Array1 is an array of integers
Array1 : []int = array{10, 11, 12}

# Array2 is an array variable of integers
var Array2 : []int = array{20, 21, 22}

# we concatenate Array1, Array2, and a new array of integers
# and assign that to the Array2 variable
set Array2 = Array1 + Array2 + array{30, 31}

# we assign the integer 77 to index 1 of Array2
if (set Array2[1] = 77) {}

for (Index := 0..Array2.Length - 1):
    if (Element := Array2[Index]):
        Print("{Element} at index {Index}")
```

This code will print:

```verse
10 at index 0
    77 at index 1
    12 at index 2
    20 at index 3
    21 at index 4
    22 at index 5
    30 at index 6
    31 at index 7
```

## Multi-Dimensional Arrays

The arrays in the previous examples were all one-dimensional, but you can also create multi-dimensional arrays. Multi-dimensional arrays have another array, or arrays, stored at each index, similar to columns and rows in a table.

For example, the following code produces a two-dimensional (2D) array, visualized in the following table:

```verse
var Counter : int = 0
Example : [][]int =
    for (Row := 0..3):
        for(Column := 0..2):
            set Counter += 1
```

|  | Column 0 | Column 1 | Column 2 |
| --- | --- | --- | --- |
| **Row 0** | 1 | 2 | 3 |
| **Row 1** | 4 | 5 | 6 |
| **Row 2** | 7 | 8 | 9 |
| **Row 3** | 10 | 11 | 12 |

To access elements in a 2D array, you must use two indices. For example, `Example[0][0]` is 1, `Example[0][1]` is 2, and `Example[1][0]` is 4.

The following code shows how to use a `for` expression to iterate through the `Example` 2D array.

```verse
if (NumberOfColumns : int = Example[0].Length):
    for(Row := 0..Example.Length-1, Column := 0..NumberOfColumns):
         if (Element := Example[Row][Column]):
             Print("{Element} at index [{Row}][{Column}]")
```

This code will print:

```verse
1 at index [0][0]
    2 at index [0][1]
    3 at index [0][2]
    4 at index [1][0]
    5 at index [1][1]
    6 at index [1][2]
    7 at index [2][0]
    8 at index [2][1]
    9 at index [2][2]
    10 at index [3][0]
    11 at index [3][1]
    12 at index [3][2]
```

The number of columns in each row is not required to be constant.

For example, the following code produces a two-dimensional (2D) array, visualized in the following table, where the number of columns in each row is greater than the previous row:

```verse
Example : [][]int =
    for (Row := 0..3):
        for(Column := 0..Row):
            Row * Column
```

|  | Column 0 | Column 1 | Column 2 | Column 3 |
| --- | --- | --- | --- | --- |
| **Row 0** | 0 |  |  |  |
| **Row 1** | 0 | 1 |  |  |
| **Row 2** | 0 | 2 | 4 |  |
| **Row 3** | 0 | 3 | 6 | 9 |

## Persistable Type

An array is persistable if the type of elements in the array are persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
