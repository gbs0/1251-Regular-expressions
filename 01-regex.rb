# Regex (Expressões Regulares) são comumente utilizadas quando
# Precisamos validar um certo tipo de dado, seja pelo seu formato (emails, telefones, cep, cpf, etc..)
# Ou quando precisamos extrair dados.

# --------------- COMO FUNCIONA? ---------------
# Imagine que precisamos validar um número de telefone do Brasil,
# No qual é iniciado com o seguinte código internacional "+55", um Código de Área (DDD)
# Em seguida, os últimos 9 dígitos do número.

# Então, para validar este telefone, vamos fazer uma simples Regex:
# /  \s* \+55  \s*  \d{2}  \s*  \d{9}  /
# /     -> Iniciar delimitador (para iniciar o regex)
# \s    -> Deve conter espaços
# * 	-> OU NÃO
# \+55 	-> O código internacional que queremos validar
# \s 	-> Deve conter espaços
# * 	-> OU NÃO
# \d{2} -> Deve conter apenas 2 dígitos (para o código de área)
# \s 	-> Deve conter espaços
# * 	-> OU NÃO
# \d{9} -> Finalmente, deve conter apenas 9 dígitos
# / 	-> Último delimitador

# --------------- O BÁSICO ---------------
# /a/           # a
# Quando digitamos "a" no regex, todas as letras "a" serão correspondidas pelo Regex.
# /ab/          # a directly followed by b
# Quando digitamos "ab" em uma regex, todos os "a" seguidos de "b" serão correspondidos pela Regex.

# --------------- QUANTIFICADORES ---------------
# /?/ Quantificador:
# Ex: /oie?/
# O quantificador '?' é utilizado quando precisamos recuperar a palavra "oi", OPCIONALMENTE seguido por 1 "e"/.
/oie?/.match?("oi") # => true
/oie?/.match?("oie") # => true
/oie?/.match?("oieeeee") # => true

# /*/ Quantificador:
# Ex: /oie*/
# O quantificador '*' é usado quando precisamos recuperar a palavra "oi", OPCIONALMENTE seguido por N (muitos) caracteres "e".
/oie*/.match?("oi") # => true
/oie*/.match?("oie") # => true
/oie*/.match?("oieeeeee") # => true

# /+/ Quantificador:
# Ex: /oie+/
# O quantificador '+' é usado quando precisamos recuperar a palavra "oi" e OBRiGATORIAMENTE, pelo menos 1 ou muitos caracteres "e".
/oie+/.match?("oi") # => false
/oie+/.match?("oie") # => true
/oie+/.match?("oieeeeee") # => true

# /{i}/ Quantificador:
# Ex: /oie{3}/ # O operador deve receber um número do tipo INTEGER
# O quantificador '{i}' é usado quando precisamos recuperar "oi" e obrigatoriamente 3 caracteres "e"
# Podemos utilzar também a virgula '{3,}', p/ permitir 3 ou mais caracteres.
/oie{3}/.match?("oi") # => false
/oie{3}/.match?("oie") # => false
/oie{3}/.match?("oieeeeee") # => true


# --------------- AGRUPAMENTO ---------------
# Opcionalmente, podemos dividir nossa regex em grupos,
# Assim podemos dividir nossa seleção em vários diferentes grupos, e utilizá-los posteriormente.

# /()/ Agrupamento:
# Ex: /(oie)/
# O agrupamento '()' é usado quando precisamos recuperar todos os caracteres "oie", UM POR UM.
/(oie)/.match?("oi") # => false
/(oie)/.match("oieoieoieoieoieoie") # => O objeto MatchData irá conter 6 grupos com o seguinte conjunto de caracteres "oie".

# /()+/ Agrupamento:
# Ex: /(oie)+/
# O agrupamento '()+' é usado quando precisamos recuperar todos os caracteres "oie", TODOS DE UMA VEZ.
/(oie)/.match?("oi") # => false
/(oie)/.match("oieoieoieoieoieoie") # => O objeto MatchData irá conter 1 grupo com somente o conjunto de caracteres "oie".

# /(|)/ Agrupamento:
# Ex: /o(i|e)/
# O agrupamento '(|)' é usado para recuperar uma letra opcional "i" OU "e", após a letra "o"
/(o(i|e))/.match?("oi") # => true
/(o(i|e))/.match?("ola") # => false

# --------------- INTERVALOS ---------------
# São comumente usados quando precisamos recuperar
# Apenas um conjunto personalizado de caracteres

# /./ Intervalo:
# Ex: /./
# O '.' significa qualquer caractere UNICODE.
/./.match?("ABCDEFGHIJKLMNOPQRSTUVXZabcdefghijklmnopqrstuvxz1234567890\/@#$%^&*.?!-+_") # => true

# /[]/ Intervalo:
# Ex: /[a&*@]/
# O '[]' é muito parecido com o '(|)' (operador OR), mas podemos especificar quantos caracteres quisermos.
/[a&*@]/.match?("ABCDEFGHIJKLMNOPQRSTUVXZabcdefghijklmnopqrstuvxz1234567890\/@#$%^&*.?!-+_") # => true
/[a&*@]/.match("ABCDEFGHIJKLMNOPQRSTUVXZabcdefghijklmnopqrstuvxz1234567890\/@#$%^&*.?!-+_") # => The match data is equal to 1 group of "a" character.

# /[0-9]/ Intervalo:
# Ex: /\s*\+55[0-9]{11}/
# O intervalo '[0-9]' é usado para especificar apenas dígitos numéricos.
/[0-9]/.match?("abcdefghijklmnopqrstuvxz") # => false
/[0-9]/.match?("0123456789") # => true

# /[a-zA-Z]/ Intervalo:
# Ex: /[a-zA-Z]/
# O '[a-zA-Z]' está especificando apenas caracteres alfabéticos.
/[a-zA-Z]/.match?("abcdefghijklmnopqrstuvxz") # => true
/[a-zA-Z]/.match?("ABCDEFGHIJKLMNOPQRSTUVXZ") # => true
/[a-zA-Z]/.match?("0123456789") # => false

# /[^]/ Intervalo:
# Ex: /[^a-z]/
# O '[^]' significa que NÃO queremos certos caracteres.
/[^a-z]/.match?("0123456789") # => true
/[^a-z]/.match?("abcdefghijklmnopqrstuvxz") # => false

# /\d/ Intervalo:
# Ex: /\d{10}/
# O '\d' é um ATALHO p/ o intervalo de operadores '[0-9]'.
/\d{10}/.match?("abcdefghijklmnopqrstuvxz") # => false
/\d{10}/.match?("0123456789") # => true

# /\w/ Intervalo:
# Ex: /\w[^z]/
# O '\w' é um ATALHO para o intervalo de operadores '[a-zA-Z0-9_]'.
/\w/.match?("abcdefghijklmnopqrstuvxz") # => true
/\w/.match?("ABCDEFGHIJKLMNOPQRSTUVXZ") # => true
/\w/.match?("0123456789") # => false

# /\W/ Intervalo:
# Ex: /\W/
# O '\W' é o OPOSTO de '\w', então é semelhante ao operador '/[^a-zA-Z0-9_]/'
/\w/.match?("abcdefghijklmnopqrstuvxz") # => false
/\w/.match?("ABCDEFGHIJKLMNOPQRSTUVXZ") # => false
/\w/.match?("0123456789") # => true

# /\s/ Intervalo:
# Ex: /\s*\+55/
# O '\s' significa espaço em branco, espaço, tabulação, quebra de linha e outros.
/\s/.match?("OláMundo") # => false
/\s/.match?("Olá Mundo") # => true

# --------------- ÂNCORAS ---------------
# /^/ Âncora:
# Ex: /^abc/
# A âncora '^' é usada quando queremos definir certos caracteres para o começo de nossas strings.
/^abc/.match?("abc") # => true
/^abc/.match?("zbc") # => false
/^abc/.match?(" abc") # => false

# /$/ Âncora:
# Ex: /abc$/
# A âncora '$' é usada quando queremos definir certos caracteres para o FINAL de nossas strings.
/el$/.match?("Gabriela") # => false
/el$/.match?("Gabriel") # => true
/el$/.match?("Raphael") # => true

# /^$/ Âncora:
# Ex: /^abc$/
# A âncora '^$' é usada quando queremos apenas um conjunto de caracteres definidos.
/^abc$/.match?("ab") # => false
/^abc$/.match?("abc") # => true
/^abc$/.match?("abcd") # => false

# /\b/ Âncora:
# Ex: /\bis/
# A âncora '\b' é usada quando queremos apenas a palavra com limite de palavra no COMEÇO OU NO FINAL da palavra.
"Let's play tic tac toe".scan(/t../) # => ["t's", "tic", "tac", "toe"]
"Let's play tic tac toe".scan(/\bt../) # => ["tic", "tac", "toe"]

# --------------- Modificadores ---------------
# /i Modificador:
# Ex: /hello/i
# O modificador 'i' é usado quando queremos tornar nossa regex insensível a maiúsculas e minúsculas.
/hello/i.match?("HELLO") # => true
/hello/i.match?("Hello") # => true
# And will match hello, Hello, HeLlO, HELLO, ...

# /m Modificador:
# Ex: /hello.world/m
# O modificador 'm' é usado para strings de correspondência que opcionalmente contém caracteres de linha de quebra (\n).
/hello.world/m.match?("hello world") # => true
/hello.world/m.match?("hello\nworld") # => true