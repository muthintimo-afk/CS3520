# Exercise 3: Count Evens in an Array

## Program Description
This program traverses an array of 32-bit integers stored in the `.data` section to count how many elements are even numbers. It utilizes a loop to index through the array elements, a bitwise AND operations (`andi`) to check the least significant bit of each integer, and a conditional branch to increment a counter when an even number is found.

## Register Allocation Map
- `t0`: Base address pointer of the array
- `t1`: Current memory address pointer during iteration (array indexing)
- `t2`: Number of elements in the array (array length)
- `s0`: Loop counter `i` (index tracker)
- `s1`: Current array element value loaded from memory `array[i]`
- `s2`: Bitwise test result from `andi`
- `s3`: Running count of even numbers found

## Challenges Faced
The main challenge was handling array indexing by memory byte offsets instead of elements; since each integer is 4 bytes long (`.word`), the pointer or offset had to be incremented by 4 each loop iteration. Additionally, using `andi` with an immediate of `1` returns `0` for even numbers and `1` for odd numbers, meaning the conditional branch instruction logic felt reversed (`beqz` skips odd, or branches on even depending on preference).
