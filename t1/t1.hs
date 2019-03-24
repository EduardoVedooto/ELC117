import Data.Char

{- 1°) Crie uma função isVowel :: Char -> Bool que verifique se um caracter é uma vogal ou não.-}
isVowel :: Char -> Bool
isVowel a = if (a=='a'||a=='e'||a=='i'||a=='o'||a=='u'||a=='A'||a=='E'||a=='I'||a=='O'||a=='U') then True else False

{- 2°) Escreva uma função addComma, que adicione uma vírgula no final de cada string contida numa lista.-}
addComma :: [String] -> [String]
addComma lista = map (++",") lista

{-3°) Crie uma função htmlListItems :: [String] -> [String], que receba uma lista de strings e
retorne outra lista contendo as strings formatadas como itens de lista em HTML.
Resolva este exercício COM e SEM funções anônimas (lambda).-}
htmlListItems :: [String] -> [String]
htmlListItems lista = map (\x -> "<LI>" ++ x ++ "</LI>") lista

{-4°) Defina uma função que receba uma string e produza outra retirando as vogais, conforme os exemplos abaixo.
Resolva este exercício COM e SEM funções anônimas (lambda).-}
semVogais :: String -> String
semVogais xs = [ c | c <- xs, not (elem c "aeiouAEIOU")]

{-5°) Defina uma função que receba uma string, possivelmente contendo espaços, e que retorne outra string substituindo 
os demais caracteres por '-', mas mantendo os espaços. Resolva este exercício COM e SEM funções anônimas (lambda). -}
minus :: Char -> Char
minus x = if x==' ' then ' ' else '-'

addMinus :: String -> String
addMinus [] = []
addMinus (x:xs) = (minus x:addMinus xs)

{-6°) Escreva uma função firstName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu primeiro nome.
Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome.-}
firstName :: String -> String
firstName x = takeWhile (/=' ') x

{-7°) Escreva uma função isInt :: String -> Bool que verifique se uma dada string só contém dígitos de 0 a 9. Exemplos:-}
isInt :: String -> Bool
isInt "" = True
isInt (x:xs) = if x=='0'||x=='1'||x=='2'||x=='3'||x=='4'||x=='5'||x=='6'||x=='7'||x=='8'||x=='9' then isInt xs else False

{-8°) Escreva uma função lastName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu último sobrenome.
Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome.-}
lastName :: String -> String
lastName x = reverse (takeWhile (/=' ') (reverse x))

{-9°) Escreva uma função userName :: String -> String que, dado o nome completo de uma pessoa, crie um nome de usuário (login)
da pessoa, formado por: primeira letra do nome seguida do sobrenome, tudo em minúsculas. Dica: estude as funções pré-definidas
no módulo Data.Char, para manipulação de maiúsculas e minúsculas. Você precisará carregar este módulo usando import Data.Char
no interpretador ou no início do arquivo do programa.-}
toLower' :: String -> String
toLower' [] = []
toLower' (x:xs) = (toLower x:toLower' xs)

userName :: String -> String
userName (x:xs) = (toLower x:toLower' (lastName xs))

{-10°) Escreva uma função encodeName :: String -> String que substitua vogais em uma string, conforme o esquema a seguir: 
a = 4, e = 3, i = 2, o = 1, u = 0.-}
code :: Char -> Char
code x | x == 'a' = '4'
       | x == 'e' = '3'
       | x == 'i' = '2'
       | x == 'o' = '1'
       | x == 'u' = '0'
       | otherwise = x

encodeName :: String -> String
encodeName [] = []
encodeName (x:xs) = (code x:encodeName xs)

{-11°) Escreva uma função betterEncodeName :: String -> String que substitua vogais em uma string, conforme este esquema: 
a = 4, e = 3, i = 1, o = 0, u = 00.-}
bettercode :: Char -> Char
bettercode x | x == 'a' = '4'
             | x == 'e' = '3'
             | x == 'i' = '1'
             | x == 'o' = '0'
             | otherwise = x

betterEncodeName :: String -> String
betterEncodeName [] = []
betterEncodeName ["u"] = "00"
betterEncodeName (x:xs) = (bettercode x:betterEncodeName xs)

{-12°) Dada uma lista de strings, produzir outra lista com strings de 10 caracteres, usando o seguinte esquema:
strings de entrada com mais de 10 caracteres são truncadas, strings com até 10 caracteres são completadas com '.' 
até ficarem com 10 caracteres.-}
addDot :: [String] -> [String]
addDot [] = []
addDot (x:xs) | length x >= 10 = ((take 10 x) : addDot (xs))
              | length x < 10 = ((x ++ (replicate (10-length x) '.')):addDot (xs))