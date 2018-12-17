# Tic-tac-tic-tac-toe

An advanced tic-tac-toe game for your terminal.

## How to use the program

```bash
$> make
$> ./tic-tac-toe
Start a new game? Y or N
n
Goodbye!
```

## Game rules

Two players on a 3x3 cells board

```bash
- - -
- - -
- - -
```

Each player fills a cell, player one with **0** and player two with **X**

```bash
X - -
0 0 0
- - X

0 wins!

X - -
X 0 0
X 0 0

X wins!
```

This is the simple tic-tac-toe, but this one is a *tic-tac-tic-tac-toe*!  
It is a bit more complicated, each cell is a board itself, meaning that a game is actually a set of **nine tic-tac-toe** games.  

Players pick a cell one after another, using simple format like **(row) (column)**. No line discipline at all is expected.  
Both players try to win the game by winning the main board by winning the nested grids. If a nested grid ends up in a draw, the winner is the one who puts the last (and ninth) symbol into the grid.  

eg.
```bash
Start a new game? Y or N
y
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
Os turn to play.
5 5
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - O - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
Xs turn to play.
2354 534
Incorrect format.
5 5
Illegal move.
1 4
- - - | X - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - O - | - - -
- - - | - - - | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
Os turn to play.
...
5 4
O wins grid 5!

- - - | X X - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
---------------------
O - - | / - \ | - - -
X - - | | O | | - - -
- - - | \ - / | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
Xs turn to play.
1 6
X wins grid 2!

- - - | \   / | - - -
- - - |   X   | - - -
- - - | /   \ | - - -
---------------------
O - - | / - \ | - - -
X - - | | O | | - - -
- - - | \ - / | - - -
---------------------
- - - | - - - | - - -
- - - | - - - | - - -
- - - | - - - | - - -
O's turn to play.
...
```

## Conclusion

This project was a nice algorithmic introduction to more advanced topics using *Ocaml* functionnal programming language.  
The use of modals, interfaces, pattern matching, user defined types and recursion allows to create a really elegant and concise code.  
