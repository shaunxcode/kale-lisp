escodegen = require "escodegen"
jsedn = require "jsedn"

prog = (prog) -> "{type Program body [#{prog}]}"

assgn = (name, val) -> "
  {type VariableDeclaration 
   kind var 
   declarations [{type VariableDeclarator 
                  id {type Identifier 
                      name #{name}}
                  init {type Literal 
                        value #{val}}}]}"

apply = (fn, args) -> "
  {type CallExpression
   callee #{fn}
   arguments [#{args}]}"

lit = (lit) -> "
  {type Literal 
   value #{lit}}"

idn = (id) -> "
  {type Identifier
   name #{id}}"

exp = (expr) -> "
  {type ExpressionStatement
   expression #{expr}}"

func = (args, body) -> "
  {type FunctionExpression
   id nil
   params [#{args}]
   defaults []
   body {type BlockStatement
         body [{type ReturnStatement
                argument #{body}}]}}"

toJS = (AST) -> jsedn.toJS jsedn.parse AST

toJSCode = (AST) -> escodegen.generate toJS AST 

module.exports = {prog, assgn, apply, idn, lit, exp, func, toJS, toJSCode}

#example
#()
#toJS prog exp func [idn("a"), idn("b")], apply idn("add"), [idn("a"), idn("b")]

#toJS prog exp apply (func [idn("a"), idn("b")], apply idn("add"), [idn("a"), idn("b")]), [lit(10), lit(20)]

