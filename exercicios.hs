{-
  ATIVIDADE DE HASKELL
  ---------------------
  Este arquivo contém a resolução de todas as questões da atividade.
  Cada questão está separada por comentários e, no final, existe uma
  função `main` que executa e imprime os resultados de cada exercício
  para facilitar a conferência.

  Para entender o "porquê" de cada resposta, leia o arquivo explicacao.md
  (que acompanha este código).
-}

module Main where

-- =========================================================
-- QUESTÃO 1
-- =========================================================
-- Pergunta teórica sobre tipos de expressões. As respostas estão
-- detalhadas no arquivo explicacao.md, mas deixamos aqui os exemplos
-- que SÃO válidos em Haskell, para você testar no GHCi com o comando :t

-- 1.1 "squid" ++ "clam"          -> tipo: [Char] (ou String)
exemplo1_1 :: String
exemplo1_1 = "squid" ++ "clam"

-- 1.2 [True, False, True, True]  -> tipo: [Bool]
exemplo1_2 :: [Bool]
exemplo1_2 = [True, False, True, True]

-- 1.3 [True, False, 'a']         -> ERRO DE TIPO! Não compila.
--     (lista não pode misturar Bool e Char)
-- exemplo1_3 = [True, False, 'a']   -- <-- descomente para ver o erro

-- 1.4 (True, False, 'a')         -> tipo: (Bool, Bool, Char)
exemplo1_4 :: (Bool, Bool, Char)
exemplo1_4 = (True, False, 'a')


-- =========================================================
-- QUESTÃO 2 - Cubo de um valor Double
-- =========================================================
cube :: Double -> Double
cube x = x * x * x


-- =========================================================
-- QUESTÃO 3 - Soma de três valores Double
-- =========================================================
sumThree :: Double -> Double -> Double -> Double
sumThree x y z = x + y + z


-- =========================================================
-- QUESTÃO 4 - Expressão quadrática: a*x^2 + b*x + c
-- =========================================================
quadratic :: Double -> Double -> Double -> Double -> Double
quadratic a b c x = a * x ^ 2 + b * x + c


-- =========================================================
-- QUESTÃO 5 - Inverter uma lista
-- =========================================================
reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]


-- =========================================================
-- QUESTÃO 6 - Lista infinita "doubles": 10, 20, 40, 80, 160, ...
-- =========================================================
doubles :: [Integer]
doubles = 10 : map (* 2) doubles


-- =========================================================
-- QUESTÃO 7 - Lista infinita "dollars": juros de 5% ao ano
-- =========================================================
dollars :: [Double]
dollars = 100.0 : map (* 1.05) dollars


-- =========================================================
-- QUESTÃO 8 - Tipos de my_const, append e my_map
-- =========================================================
-- O enunciado não define essas funções porque elas são versões
-- "disfarçadas" de funções clássicas do Prelude do Haskell:
--   my_const = const
--   append   = (++)
--   my_map   = map
-- Definimos elas aqui exatamente assim, para podermos checar
-- os tipos com o comando :t no GHCi.

my_const :: a -> b -> a
my_const = const

append :: [a] -> [a] -> [a]
append = (++)

my_map :: (a -> b) -> [a] -> [b]
my_map = map

-- 8.6 append [3] ['a', 'b']  -> ERRO DE TIPO! (descomente para ver o erro)
-- exemplo8_6 = append [3] ['a', 'b']

-- 8.7 append "squid" ['a', 'b'] -> válido, pois String = [Char]
exemplo8_7 :: [Char]
exemplo8_7 = append "squid" ['a', 'b']


-- =========================================================
-- FUNÇÃO PRINCIPAL - executa e mostra os resultados no terminal
-- =========================================================
main :: IO ()
main = do
  putStrLn "=================================================="
  putStrLn "QUESTÃO 1 - Tipos de expressões"
  putStrLn "=================================================="
  putStrLn $ "1.1  \"squid\" ++ \"clam\"        = " ++ show exemplo1_1
  putStrLn $ "1.2  [True, False, True, True] = " ++ show exemplo1_2
  putStrLn   "1.3  [True, False, 'a']        = ERRO DE TIPO (não compila)"
  putStrLn $ "1.4  (True, False, 'a')        = " ++ show exemplo1_4

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 2 - cube :: Double -> Double"
  putStrLn "=================================================="
  putStrLn $ "2.1  cube 3   = " ++ show (cube 3)
  putStrLn $ "2.2  cube 2.5 = " ++ show (cube 2.5)

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 3 - sumThree :: Double -> Double -> Double -> Double"
  putStrLn "=================================================="
  putStrLn $ "3.1  sumThree 1 2 3       = " ++ show (sumThree 1 2 3)
  putStrLn $ "3.2  sumThree 1.5 2.5 3.0 = " ++ show (sumThree 1.5 2.5 3.0)

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 4 - quadratic :: Double -> Double -> Double -> Double -> Double"
  putStrLn "=================================================="
  putStrLn $ "4.1  quadratic 1 2 3 2    (a=1,b=2,c=3,x=2)  = " ++ show (quadratic 1 2 3 2)
  putStrLn $ "4.2  quadratic 2 0 (-1) 5 (a=2,b=0,c=-1,x=5) = " ++ show (quadratic 2 0 (-1) 5)

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 5 - reverseList :: [a] -> [a]"
  putStrLn "=================================================="
  putStrLn $ "5.1  reverseList [1,2,3,4,5] = " ++ show (reverseList [1,2,3,4,5 :: Int])
  putStrLn $ "5.2  reverseList \"haskell\"   = " ++ show (reverseList "haskell")

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 6 - doubles :: [Integer] (lista infinita)"
  putStrLn "=================================================="
  putStrLn $ "6.1  take 8 doubles = " ++ show (take 8 doubles)

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 7 - dollars :: [Double] (lista infinita)"
  putStrLn "=================================================="
  putStrLn $ "7.1  take 5 dollars = " ++ show (take 5 dollars)

  putStrLn ""
  putStrLn "=================================================="
  putStrLn "QUESTÃO 8 - my_const, append, my_map"
  putStrLn "=================================================="
  putStrLn   "8.1  my_const            :: a -> b -> a            (tipo, sem valor para executar)"
  putStrLn $ "8.2  my_const True 99    = " ++ show (my_const True (99 :: Int))
  putStrLn   "8.3  append              :: [a] -> [a] -> [a]      (tipo, sem valor para executar)"
  putStrLn $ "8.4  append [] [1,2,3]   = " ++ show (append [] [1,2,3 :: Int])
  putStrLn $ "8.5  append [True,False] [True] = " ++ show (append [True, False] [True])
  putStrLn   "8.6  append [3] ['a','b'] = ERRO DE TIPO (não compila)"
  putStrLn $ "8.7  append \"squid\" ['a','b'] = " ++ exemplo8_7
  putStrLn   "8.8  my_map              :: (a -> b) -> [a] -> [b] (tipo, sem valor para executar)"
  putStrLn $ "8.9  my_map (my_const True) [1,2,3] = " ++ show (my_map (my_const True) [1,2,3 :: Int])