# Tcl notes from the practice track

These notes summarize reusable techniques found across the 135 active
Exercism exercises. They are not a catalog of solutions.

## Evaluation, quoting, and substitution

Tcl parses a command into words and then performs substitution. Braces delay
substitution; quotes group text while still allowing substitution.

```tcl
set width 8
set mask [expr {(1 << $width) - 1}]
```

Brace expressions whenever possible. This avoids accidental double
substitution and lets Tcl cache the compiled expression. See
[`difference-of-squares`](practices/030-difference-of-squares/) and
[`grains`](practices/046-grains/).

Use `[list ...]` when constructing a list from dynamic values. Do not build Tcl
lists by concatenating strings.

## Lists, dictionaries, arrays, and strings

- A list is an ordered Tcl value manipulated with `lindex`, `lrange`,
  `lappend`, `lset`, `lmap`, and `lsort`.
- A dictionary is a value containing key/value pairs; use `dict get`,
  `dict set`, `dict incr`, and `dict update`.
- An array is a collection of variables tied to one variable name and is often
  useful for mutable lookup tables inside a procedure.
- A string is text. Although Tcl values can change internal representation,
  code should use the command that matches the intended abstraction.

Use lists for sequences, dictionaries for structured records, and arrays when
in-place mutable lookup is useful. See
[`matrix`](practices/067-matrix/),
[`word-count`](practices/135-word-count/), and
[`grade-school`](practices/045-grade-school/).

## Iteration and collection building

`foreach` can iterate over multiple variables or lists. `lmap` is preferable
when each input item maps directly to one output item.

```tcl
set squares [lmap value $values {expr {$value * $value}}]
```

Use `lappend result $value` rather than repeatedly concatenating list strings.
Use `dict incr counts $key` for frequency tables. Examples include
[`etl`](practices/037-etl/) and
[`nucleotide-count`](practices/072-nucleotide-count/).

## Procedures, scope, and controlled mutation

Procedure arguments and local variables are local by default. Use `upvar` when
an API intentionally updates a caller-owned variable, such as a parser index.
Use namespaces or TclOO objects when state has a clear lifetime and owner.

Avoid globals for temporary state. They make test isolation and EDA flow reuse
harder. See [`clock`](practices/022-clock/),
[`react`](practices/094-react/), and
[`sgf-parsing`](practices/115-sgf-parsing/).

## Regular expressions and parsing

Use `regexp` for recognition and extraction, and `regsub` for controlled
replacement. For nested grammars, an index-based parser is usually clearer
than one large regular expression.

```tcl
if {[regexp {^([A-Z]+)\[(.*)\]$} $token -> key value]} {
    dict set properties $key $value
}
```

Always separate validation from transformation. Relevant exercises include
[`phone-number`](practices/080-phone-number/),
[`isbn-verifier`](practices/054-isbn-verifier/), and
[`sgf-parsing`](practices/115-sgf-parsing/).

## Error handling

Use `error` for domain failures and `try`/`catch` when recovery is meaningful.
Preserve useful error information rather than converting every failure to a
generic message.

```tcl
try {
    set data [read $channel]
} finally {
    close $channel
}
```

This is especially important for file, socket, and EDA tool interactions. See
[`error-handling`](practices/036-error-handling/) and
[`paasio`](practices/074-paasio/).

## Recursion, graphs, and backtracking

Recursive code should have a visible base case and make measurable progress.
For graph searches, keep visited state separate from the graph. For
backtracking, undo or isolate each speculative choice.

Examples:

- tree traversal: [`binary-search-tree`](practices/014-binary-search-tree/);
- graph traversal: [`connect`](practices/025-connect/) and
  [`pov`](practices/084-pov/);
- backtracking: [`alphametics`](practices/006-alphametics/);
- tree reconstruction: [`satellite`](practices/109-satellite/).

## Dynamic programming

Use dynamic programming when a problem repeats overlapping subproblems.
Choose a state that captures only information needed by future decisions.

[`book-store`](practices/016-book-store/) and
[`knapsack`](practices/058-knapsack/) demonstrate the trade-off between a
simple greedy rule and a globally correct recurrence.

## Unicode

Do not assume bytes, characters, code points, and grapheme clusters are the
same. Tcl version and build details matter for supplementary Unicode
characters. Test with non-ASCII input instead of extrapolating from ASCII.

See [`micro-blog`](practices/069-micro-blog/),
[`reverse-string`](practices/101-reverse-string/), and
[`anagram`](practices/007-anagram/).

## Performance and readability

- Avoid repeated sorting inside a loop when a canonical form can be computed
  once.
- Avoid repeatedly scanning the same string when one pass is sufficient.
- Prefer `dict incr` and `lappend` to reconstructing whole collections.
- Make algorithmic state explicit rather than hiding it in clever expressions.
- Optimize asymptotic behavior before micro-optimizing syntax.

Shorter code is useful only when intent remains clear. A named intermediate
value is often better than a deeply nested command substitution.

## EDA and DFT transfer

The same habits apply to production automation:

- parse reports line by line instead of loading huge files unnecessarily;
- represent configuration as dictionaries;
- validate tool output and return codes;
- keep tool-specific commands behind small procedures;
- make file paths and run state explicit;
- produce deterministic logs and non-zero failure exits;
- avoid global state that leaks between sourced scripts.

The repository's [`vivado`](vivado/) and [`capstone`](capstone/) directories
extend these practices into tool-oriented workflows.
