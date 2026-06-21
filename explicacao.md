# Explicação da Atividade de Haskell

Este documento explica **o porquê** de cada resposta do arquivo `exercicios.hs`. A ideia é que você entenda o raciocínio por trás de cada questão para conseguir apresentar com segurança.

---

## Questão 1 — Tipos de expressões

| Expressão | Tipo | Por quê |
|---|---|---|
| `"squid" ++ "clam"` | `[Char]` (= `String`) | O operador `++` concatena duas listas do mesmo tipo. Como `String` é apenas um apelido (`type`) para `[Char]`, o resultado continua sendo uma lista de caracteres. |
| `[True, False, True, True]` | `[Bool]` | Todos os elementos da lista são do tipo `Bool`, então o tipo da lista é uma lista homogênea de `Bool`. |
| `[True, False, 'a']` | **ERRO DE TIPO** | Em Haskell, **toda lista precisa ser homogênea** (todos os elementos do mesmo tipo). Aqui temos `Bool` misturado com `Char`, o que o compilador rejeita com um erro do tipo `Couldn't match expected type 'Bool' with actual type 'Char'`. |
| `(True, False, 'a')` | `(Bool, Bool, Char)` | Diferente de listas, **tuplas podem misturar tipos diferentes**. O tipo de uma tupla é definido pela tipagem de cada posição individualmente. |

**Conceito-chave:** listas (`[a]`) exigem elementos do mesmo tipo; tuplas `(a, b, c, ...)` não.

---

## Questão 2 — `cube`

```haskell
cube :: Double -> Double
cube x = x * x * x
```

- **Tipo:** `Double -> Double` — a função recebe um número de ponto flutuante e devolve outro.
- **Resultado de `cube 3`:** `27.0`
- **Resultado de `cube 2.5`:** `15.625`

Como restringimos explicitamente o tipo na assinatura (`Double -> Double`), o Haskell não generaliza para `Num a => a -> a`; ele força que tanto a entrada quanto a saída sejam `Double`.

---

## Questão 3 — `sumThree`

```haskell
sumThree :: Double -> Double -> Double -> Double
sumThree x y z = x + y + z
```

- **Tipo:** `Double -> Double -> Double -> Double`. Em Haskell, toda função de "vários argumentos" é, tecnicamente, uma sequência de funções de um argumento (isso se chama **currying**). Por isso o tipo é escrito com várias setas: cada seta representa "espera mais um argumento".
- **Resultado de `sumThree 1.5 2.5 3.0`:** `7.0`

---

## Questão 4 — `quadratic`

```haskell
quadratic :: Double -> Double -> Double -> Double -> Double
quadratic a b c x = a * x ^ 2 + b * x + c
```

- **Tipo:** recebe 4 valores `Double` (`a`, `b`, `c`, `x`, nessa ordem) e devolve um `Double`.
- **Resultado de `quadratic 1 2 3 2`** (ou seja, `1x² + 2x + 3` com `x=2`): `1*4 + 2*2 + 3 = 11.0`
- **Resultado de `quadratic 2 0 (-1) 5`** (`2x² - 1` com `x=5`): `2*25 - 1 = 49.0`

Observação: usamos `^` (não `**`), pois o expoente `2` é um número inteiro fixo (literal). O operador `^` é usado quando a base é `Num` e o expoente é `Integral`.

---

## Questão 5 — `reverseList`

```haskell
reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]
```

- **Tipo:** `[a] -> [a]` — repare no `a` minúsculo: isso indica que a função é **polimórfica**, ou seja, funciona para lista de qualquer tipo (`[Int]`, `[Char]`, `[Bool]` etc.), não apenas `Double`.
- **Como funciona (recursão):**
  - Caso base: lista vazia `[]` revertida é `[]`.
  - Caso recursivo: pega o primeiro elemento `x`, reverte o resto da lista (`xs`) recursivamente, e coloca `x` no final (`++ [x]`).
- **Exemplo:** `reverseList [1,2,3,4,5]` → `[5,4,3,2,1]`
- **Exemplo:** `reverseList "haskell"` → `"lleksah"`

---

## Questão 6 — Lista infinita `doubles`

```haskell
doubles :: [Integer]
doubles = 10 : map (* 2) doubles
```

- **Tipo:** `[Integer]` — lista infinita de números inteiros.
- **Como funciona:** essa é uma definição **recursiva e preguiçosa (lazy)**, um dos recursos mais poderosos do Haskell:
  - O primeiro elemento é `10`.
  - O resto da lista é construído aplicando `(* 2)` a cada elemento de `doubles` — usando a própria lista que está sendo definida!
  - Isso só funciona porque Haskell é **lazy**: ele só calcula um elemento quando você realmente pede por ele (por exemplo, com `take`).
- **`take 8 doubles`** → `[10,20,40,80,160,320,640,1280]`

---

## Questão 7 — Lista infinita `dollars`

```haskell
dollars :: [Double]
dollars = 100.0 : map (* 1.05) dollars
```

- **Tipo:** `[Double]`
- **Lógica:** mesmo princípio da questão 6 — começa com `100.0` e cada próximo valor é `1.05` vezes o anterior (juros compostos de 5% ao ano).
- **`take 5 dollars`** → `[100.0, 105.0, 110.25, 115.7625, 121.550625]`

---

## Questão 8 — Tipos de `my_const`, `append` e `my_map`

> **Importante:** o enunciado não definiu essas funções de propósito. Elas são versões "disfarçadas" de três funções clássicas do **Prelude** (a biblioteca padrão do Haskell, carregada automaticamente):
>
> - `my_const` é `const`
> - `append` é `(++)`
> - `my_map` é `map`
>
> Definimos no código: `my_const = const`, `append = (++)`, `my_map = map`. Isso é uma prática comum em exercícios de Haskell: pedir para o aluno reconhecer o comportamento de funções fundamentais da linguagem usando nomes diferentes.

### 8.1 `my_const`
**Tipo:** `a -> b -> a`
Recebe dois argumentos de tipos quaisquer (`a` e `b`, podendo ser diferentes) e **sempre devolve o primeiro**, ignorando o segundo.

### 8.2 `my_const True`
**Tipo:** `b -> Bool`
Ao aplicar `True` ao primeiro argumento de `my_const`, o tipo `a` fica fixado como `Bool`. Sobra uma função que aceita qualquer coisa (`b`) e sempre devolve `True`. Exemplo: `my_const True 99` → `True`.

### 8.3 `append`
**Tipo:** `[a] -> [a] -> [a]`
Recebe duas listas do **mesmo tipo** de elemento e devolve a concatenação delas.

### 8.4 `append []`
**Tipo:** `[a] -> [a]`
Aplicamos apenas o primeiro argumento (lista vazia). O tipo `a` continua genérico, porque uma lista vazia não revela qual é o tipo dos elementos. Resultado: uma função que recebe uma lista e a devolve "concatenada com nada" (ou seja, ela mesma).

### 8.5 `append [True, False]`
**Tipo:** `[Bool] -> [Bool]`
Aqui o tipo `a` é fixado como `Bool`, porque a lista `[True, False]` já tem elementos concretos do tipo `Bool`.

### 8.6 `append [3] ['a', 'b']`
**ERRO DE TIPO.**
`[3]` é inferido como `[Num a => a]` (um número, por padrão `Integer`), e `['a','b']` é `[Char]`. Como `append` exige que **as duas listas tenham o mesmo tipo de elemento**, e `Integer ≠ Char`, o compilador recusa com algo como `Couldn't match expected type 'Char' with actual type 'Integer'`.

### 8.7 `append "squid" ['a', 'b']`
**Tipo:** `[Char]` (válido!)
Diferente do item anterior, aqui não há erro: `"squid"` é `String`, que é só um apelido para `[Char]`. Como `['a', 'b']` também é `[Char]`, os tipos batem perfeitamente. Resultado: `"squidab"`.

### 8.8 `my_map`
**Tipo:** `(a -> b) -> [a] -> [b]`
Recebe uma função que transforma um `a` em um `b`, e uma lista de `a`, devolvendo uma lista de `b`. Repare que os tipos de entrada e saída da função interna **podem ser diferentes** (`a` e `b` não precisam ser iguais).

### 8.9 `my_map (my_const True)`
**Tipo:** `[b] -> [Bool]`
Primeiro, `my_const True` tem tipo `b -> Bool` (vimos no item 8.2). Ao passar isso como o primeiro argumento de `my_map :: (a -> b) -> [a] -> [b]`, o Haskell unifica o `a` interno de `my_map` com o `b` de `my_const True`, e o `b` interno de `my_map` com `Bool`. Resultado: uma função que recebe **qualquer lista** e devolve uma lista de `True`'s do mesmo tamanho.
Exemplo: `my_map (my_const True) [1,2,3]` → `[True, True, True]`

---
