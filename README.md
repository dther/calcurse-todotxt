# calcurse-todotxt

## Overview

Two POSIX shell scripts for converting todo.txt files to
calcurse todo files, and vice versa.

## Rationale

todo.txt is an excellent standard for plaintext todo lists,
which balances machine and human readability.
It's portable and plaintext, making it virtually future proof.

calcurse is an excellent ncurses personal planner,
which implements a calendar planner and todo list.
It *also* stores data as plaintext, making it just as portable-
but it stores it with its own data structure that prioritises
easy UNIX philosophy file management over everything else.

The problem with todo.txt is, well, it's just a text file,
unless you have an app to view it.

The problem with calcurses is, well, you can only easily read
and edit your todo list with calcurse.

However, being both portable, machine readable plaintext formats,
it's fairly trivial to convert between the two.

So *here we go.*

## Usage

You can use this however you like, but my usecase is such:

> When loading files, calcurse will convert a todo.txt file into its format.
> Any differences in the calcurse files are discarded,
> and the todo.txt file is assumed to be the most recent and correct.
> When saving files, it will convert its todo list back into the todo.txt.

In this way, calcurses becomes a user friendly todo.txt terminal app.
See the pre-load and post-save shell scripts for an example of how this works!

## Caveats

 * todo.txt tasks can only be on one line. Multi-line notes are not preserved during conversion,
   *and will be lost permanently.*
 * Priorities lower than "I" get *lost*. Haven't figured out how to deal with them.
 * Probably a lot more. Please don't use this on particularly valuable todo lists.
