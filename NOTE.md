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

## Frequently useful Tcl commands

### Variables and expressions

```tcl
set value 10
incr value 2
set doubled [expr {$value * 2}]
```

- `set name value` assigns a value; `set name` reads it.
- `incr` is the clearest way to update an integer variable.
- Put arithmetic and boolean expressions inside braces.
- `expr {$a eq $b}` compares strings; `expr {$a == $b}` compares numerically.

### Lists

```tcl
set values [list alpha "two words" gamma]
lappend values delta
set first [lindex $values 0]
set middle [lrange $values 1 end-1]
set values [lsort -dictionary $values]
```

- `list` safely quotes dynamic elements.
- `lassign` destructures a list into variables.
- `lmap` transforms each element and returns a new list.
- `lsearch -exact` avoids accidental glob matching.
- `lset` mutates a list variable by name; `lreplace` returns a new value.

### Dictionaries

```tcl
set record [dict create name core0 status ready]
dict set record status running
dict incr record retries
set status [dict get $record status]
```

- Use `dict exists` before reading optional keys.
- `dict getdef` in Tcl 9 is useful for defaults.
- `dict update` exposes selected fields as variables and writes changes back.
- `dict for` is the natural way to iterate over key/value pairs.

### Strings and Unicode

```tcl
set lower [string tolower $text]
set prefix [string range $text 0 4]
set reversed [join [lreverse [split $text ""]] ""]
```

- `string length` and `string range` follow Tcl's character model.
- Use Tcl 9 for exercises involving supplementary Unicode characters.
- `scan`, `format`, and `binary` are for explicit representation conversion;
  do not use them when normal string commands already express the intent.

### Pattern matching

```tcl
if {[regexp {^([A-Z]+)\[(.*)\]$} $token -> key value]} {
    dict lappend properties $key $value
}
regsub -all {\s+} $text " " normalized
```

- Anchor validation patterns with `^` and `$`.
- Use `regexp -all -inline` when every match is needed.
- Prefer `string match` for simple glob patterns.
- Escape backslashes carefully; braced regex patterns are usually easiest.

### Procedures and caller variables

```tcl
proc takeNext {itemsVar} {
    upvar 1 $itemsVar items
    set next [lindex $items 0]
    set items [lrange $items 1 end]
    return $next
}
```

- Tcl passes values, not variable aliases, unless an API accepts a variable
  name and uses `upvar`.
- Use `tailcall` when one procedure should directly return another command's
  result without growing the call stack.
- Use `{name default}` in a procedure argument list for optional arguments.
- Use `args` only when a genuinely variable-length API is useful.

### Errors and cleanup

```tcl
try {
    set channel [open $path r]
    set data [read $channel]
} on error {message options} {
    return -options $options "cannot read $path: $message"
} finally {
    if {[info exists channel]} {
        close $channel
    }
}
```

- `try/finally` is safer than duplicating cleanup around every return path.
- `return -code error -errorcode {...}` creates machine-readable failures.
- `dict get $options -errorinfo` contains the stack trace inside a handler.
- Never hide tool failures in EDA automation; propagate a non-zero status.

### Files, channels, and platform details

```tcl
set channel [open $path r]
chan configure $channel -encoding utf-8 -translation auto
while {[gets $channel line] >= 0} {
    # Process one line without loading the whole report.
}
close $channel
```

- `glob -nocomplain` safely handles an empty match set.
- `file join`, `file normalize`, and `file dirname` are portable path tools.
- Channel translation affects newline byte counts. The `paasio` exercise
  explicitly normalizes file output to LF for cross-platform consistency.
- Socket channels intentionally use network CRLF semantics.

### Objects and namespaces

- TclOO is appropriate when state and behavior belong together, as in
  `clock`, `bowling`, `react`, and `zipper`.
- Declare object variables with `variable`; avoid globals shared by instances.
- Namespaces group related procedures without requiring object state.
- `namespace export` and `namespace ensemble create` build clean command APIs.

### Concurrency

- `thread::create` creates an interpreter in another OS thread.
- `thread::send` evaluates a script in that interpreter.
- `tpool::post`, `tpool::wait`, and `tpool::get` manage worker-pool jobs.
- A result posted to a thread pool must be waited for before calling
  `tpool::get`.
- Parallelism helps only when work is large enough to exceed setup and
  communication overhead.

## Advanced Tcl Features & Tricks

### Coroutines and Generators
Tcl 8.6+ has powerful support for coroutines, allowing you to pause (`yield`) and resume execution. This is extremely useful for generators, state machines, and lazy evaluation:
```tcl
proc generator {} {
    yield [info coroutine]
    yield 1
    yield 2
    return 3
}
coroutine nextNum generator
set a [nextNum] ;# 1
set b [nextNum] ;# 2
```

### Math as Commands
You can avoid `expr` by using math operators directly as commands via the `::tcl::mathop::` namespace. This is great for functional programming styles (like folding/reducing a list):
```tcl
set sum [::tcl::mathop::+ 1 2 3 4]
set product [::tcl::mathop::* {*}[list 2 3 4]]
```

### Searching Complex Lists
`lsearch` is incredibly powerful for nested lists (list of lists or list of dicts). You can search by specific index and extract results inline:
```tcl
set records {{John 25} {Alice 30} {Bob 25}}
# Find all records where age (index 1) is 25
set young [lsearch -all -inline -index 1 -exact $records 25]
```

### Variable Tracing
Tcl allows you to execute callbacks automatically whenever a variable is read, written, or unset using the `trace` command. This is heavily used in Tk for reactive UIs but is also great for debugging or data validation:
```tcl
proc watchVar {name1 name2 op} {
    puts "Variable $name1 was modified!"
}
set myVar 10
trace add variable myVar write watchVar
set myVar 20 ;# Triggers the callback
```

### Safe Interpreters (Sandboxing)
Tcl was designed with embeddability in mind. You can create isolated, restricted sandboxes (`safe interpreters`) to execute untrusted code without allowing access to the file system or network:
```tcl
set sandbox [interp create -safe]
$sandbox eval {
    # This works
    set x [expr {1 + 1}]
    # This will throw an error (command not found)
    open "/etc/passwd" r
}
```

## Common mistakes caught by the exercises

- Forgetting `RUN_ALL=1` and accidentally running only the first progressive
  Exercism case.
- Building lists with string concatenation instead of `list`/`lappend`.
- Comparing numeric values with `eq` or strings with `==`.
- Mutating a collection while iterating over assumptions tied to old indices.
- Using greedy logic where dynamic programming is required.
- Recomputing a sorted canonical form inside a loop.
- Forgetting to reject the original word in an anagram check.
- Treating bytes as Unicode characters.
- Calling `tpool::get` before `tpool::wait`.
- Depending on platform newline translation in byte-counting code.
- Omitting exercise support files such as `zipper/tree.tcl` or
  `zebra-puzzle/lib/permutations.tcl`.

## Testing commands worth remembering

Run one complete suite and print every passing case:

```powershell
$env:RUN_ALL = "1"
tclsh90 exercise.test.tcl -verbose p
```

Useful `tcltest` verbosity flags include:

- `p`: passing tests;
- `b`: test bodies;
- `e`: errors;
- `s`: skipped tests;
- `u`: timing information.

The repository CI uses `-verbose p`, while failures automatically include
their body, actual result, expected result, and stack trace.
