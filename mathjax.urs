
type mathjax

val load : unit -> transaction mathjax

val typeset : mathjax -> id -> transaction unit

val typesetcontent : mathjax -> string -> id -> transaction unit
