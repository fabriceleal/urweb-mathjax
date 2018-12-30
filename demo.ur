open Mathjax

(* 
http://docs.mathjax.org/en/latest/advanced/typeset.html#manipulating-individual-math-elements

*)

fun example (text :string) : transaction page =
    did <- fresh;
    return <xml>
      <head></head>
      <body>
	<a link={index ()}>index</a>
	<div id={did}>{[text]}</div>
	<active code={
                      mj <- Mathjax.load ();
		     (* Mathjax.typeset mj did;*)
		      return <xml></xml>}>
      </active>
    </body>
    </xml>

and example_2 () : transaction page =
    example "\\begin{align}
\\dot{x} & = \\sigma(y-x) \\\\
\\dot{y} & = \\rho x - y - xz \\\\
\\dot{z} & = -\\beta z + xy
\\end{align}

\\[
\\left( \\sum_{k=1}^n a_k b_k \\right)^{\\!\\!2} \\leq
 \\left( \\sum_{k=1}^n a_k^2 \\right) \\left( \\sum_{k=1}^n b_k^2 \\right)
\\]"

and example_1 () : transaction page =
    example "\\begin{align}
\\dot{x} & = \\sigma(y-x) \\\\
\\dot{y} & = \\rho x - y - xz \\\\
\\dot{z} & = -\\beta z + xy
\\end{align}

\\[
\\left( \\sum_{k=1}^n a_k b_k \\right)^{\\!\\!2} \\leq
 \\left( \\sum_{k=1}^n a_k^2 \\right) \\left( \\sum_{k=1}^n b_k^2 \\right)
\\]

\\[
  \\mathbf{V}_1 \\times \\mathbf{V}_2 =
   \\begin{vmatrix}
    \\mathbf{i} & \\mathbf{j} & \\mathbf{k} \\\\
    \\frac{\\partial X}{\\partial u} & \\frac{\\partial Y}{\\partial u} & 0 \\\\
    \\frac{\\partial X}{\\partial v} & \\frac{\\partial Y}{\\partial v} & 0 \\\\
   \\end{vmatrix}
\\]

\\[P(E) = {n \\choose k} p^k (1-p)^{ n-k} \\]

\\[
   \\frac{1}{(\\sqrt{\\phi \\sqrt{5}}-\\phi) e^{\\frac25 \\pi}} =
     1+\\frac{e^{-2\\pi}} {1+\\frac{e^{-4\\pi}} {1+\\frac{e^{-6\\pi}}
      {1+\\frac{e^{-8\\pi}} {1+\\ldots} } } }
\\]

\\[
  1 +  \\frac{q^2}{(1-q)}+\\frac{q^6}{(1-q)(1-q^2)}+\\cdots =
    \\prod_{j=0}^{\\infty}\\frac{1}{(1-q^{5j+2})(1-q^{5j+3})},
     \\quad\\quad \\text{for $|q|<1$}.
\\]

\\begin{align}
  \\nabla \\times \\vec{\\mathbf{B}} -\\, \\frac1c\\, \\frac{\\partial\\vec{\\mathbf{E}}}{\\partial t} & = \\frac{4\\pi}{c}\\vec{\\mathbf{j}} \\\\
  \\nabla \\cdot \\vec{\\mathbf{E}} & = 4 \\pi \\rho \\\\
  \\nabla \\times \\vec{\\mathbf{E}}\\, +\\, \\frac1c\\, \\frac{\\partial\\vec{\\mathbf{B}}}{\\partial t} & = \\vec{\\mathbf{0}} \\\\
  \\nabla \\cdot \\vec{\\mathbf{B}} & = 0
\\end{align}

Finally, while display equations look good for a page of samples, the
ability to mix math and text in a paragraph is also important.  This
expression \\(\\sqrt{3x-1}+(1+x)^2\\) is an example of an inline equation.  As
you see, MathJax equations can be used this way as well, without unduly
disturbing the spacing between lines."

and index () : transaction page =
    pid <- fresh;
    inp <- source "";
    return <xml>
      
      <body>
	<a link={example_1 ()}>example 1</a>
	<a link={example_2 ()}>example 2</a>
	<active code={mj <- Mathjax.load ();
		      return
			  <xml>
			    <div id={pid}>
                            </div>
			    <ctextarea source={inp} onchange={t <- get inp; Mathjax.typesetcontent mj t pid; return ()} />
			    <button value="TypeSet" onclick={fn _ => Mathjax.typeset mj pid} />
			  </xml>}>
	</active>

      </body>
    </xml>
