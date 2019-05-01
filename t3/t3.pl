%Author: Eduardo Rivas Vedooto

/*1- Defina um predicado odd(N) que seja verdadeiro se 
N for um número ímpar. Exemplo de uso:*/
odd(N) :-
 1 is mod(N,2).
%---------------------------------------------------------%

/*2- Defina um predicado recursivo hasN(L,N) que 
seja verdadeiro se L for uma lista de N elementos.*/
hasN([],_).
hasN(L,N) :-
 L = [H|T],
 H == N,
 hasN(T,N).
%---------------------------------------------------------%

/*3- Defina um predicado recursivo inc99(L1,L2),de 
forma que L2 seja uma lista com todos os elementos
de L1 acrescidos da constante 99.*/
inc99([],[]).
inc99(L1,L2) :-
 L1 = [H1|T1], %Head and Tail List 1
 L2 = [H2|T2], %Head and Tail List 2
 H2 is H1 + 99,
 inc99(T1,T2).
%---------------------------------------------------------%

/*4- Defina um predicado recursivo incN(L1,L2,N), de 
forma que L2 seja uma lista com todos os elementos de L1 
acrescidos da constante N.*/
incN([],[],_).
incN(L1,L2,N) :-
 L1 = [H1|T1],
 L2 = [H2|T2],
 H2 is H1 + N,
 incN(T1,T2,N).
%---------------------------------------------------------%

/*5- Defina um predicado recursivo comment(L1,L2), de 
forma que L1 seja uma lista de strings e L2 tenha todos 
os elementos de L1 concatenados com o prefixo "%%". 
Dica: consulte predicados Prolog para manipulação de 
strings.*/
comment([],[]).
comment(L1,L2) :-
 L1 = [H1|T1],
 L2 = [H2|T2],
 string_concat('%%',H1,H2),
 comment(T1,T2).
%---------------------------------------------------------%

/*6- Defina um predicado recursivo onlyEven(L1,L2), de 
forma que L2 seja uma lista só com os elementos pares de
L1, conforme o exemplo abaixo:

 ?- onlyEven2([1,2,3,4,5,6,7],L).
 L = [2, 4, 6].*/
onlyEven([],[]).
onlyEven(L1,L2) :-
 L1 = [H1|T1],
 L2 = [H2|T2],
 H1 mod 2 =:= 0,
 H2 is H1,
 onlyEven(T1,T2),!.

onlyEven(L1,L2) :-
 L1 = [_|T],
 onlyEven(T,L2).
%---------------------------------------------------------%

/*7- Defina um predicado recursivo countdown(N,L), de forma 
que L seja uma lista com os números [N, N-1, N-2, .., 1],
sendo N um número positivo. Exemplo:

 ?- countdown(7,L).
 L = [7, 6, 5, 4, 3, 2, 1].*/
countdown(0,[]).
countdown(N,L) :-
 L = [H|T],
 H is N,
 N2 is N - 1,
 countdown(N2,T),!.
%---------------------------------------------------------%

/*8- Defina um predicado recursivo nRandoms(N,L), de 
forma que L seja uma lista com N números gerados 
aleatoriamente, conforme os exemplos abaixo:

 ?- nRandoms(3,L).
 L = [60, 92, 28].

 ?- nRandoms(6,L).
 L = [12, 81, 46, 19, 81, 21].

 ?- nRandoms(0,L).
 L = [].*/
nRandoms(0,[]).
nRandoms(N,L) :-
 L = [H|T],
 random(0,100,H),
 N1 is N - 1,
 nRandoms(N1,T),!.
%---------------------------------------------------------%

/*9- Defina um predicado recursivo potN0(N,L), de forma que
L seja uma lista de potências de 2, com expoentes de N a 0.
 Exemplo de uso:

 ?- potN0(7,L).
 L = [128, 64, 32, 16, 8, 4, 2, 1]*/
potN0(0,[1]).
potN0(N,L) :-
 L = [H|T],
 pow(2,N,H),
 N1 is N - 1,
 potN0(N1,T),!.
%---------------------------------------------------------%

/*10- Defina um predicado recursivo zipmult(L1,L2,L3), de 
forma que cada elemento da lista L3 seja o produto dos 
elementos de L1 e L2 na mesma posição do elemento de L3. 
Exemplo:

 ?- zipmult([1,2,3],[2,2,2],L). 
 L = [2, 4, 6].*/
zipmult([],[],[]).
zipmult(L1,L2,L3) :-
 L1 = [H1|T1],
 L2 = [H2|T2],
 L3 = [H3|T3],
 H3 is H1*H2,
 zipmult(T1,T2,T3),!.
%---------------------------------------------------------%

/*11- Defina um predicado recursivo potencias(N,L), de 
forma que L seja uma lista com as N primeiras potências de 
2, sendo a primeira 2^0 e assim por diante, conforme o 
exemplo abaixo:

?- potencias(5,L). 
L = [1, 2, 4, 8, 16]
?- potencias(0,L).
L = []
Dica: defina um predicado auxiliar.*/
potencias(0,[]).
potencias(N,L) :- potencias(0,N,L).
potencias(X,N,[]) :- X>N.
potencias(X,N,L) :-
 L = [H|T],
 pow(2,X,H),
 X1 is X + 1,
 potencias(X1,N,T),!.
%---------------------------------------------------------%

/*12- Defina um predicao recursivo cedulas(V,L1,L2), que
receba um valor V e uma lista L1 de cédulas com valores em
Reais (R$), em ordem decrescente, e obtenha a lista L2
decompondo o valor V em 0 ou mais cédulas de cada tipo.
Exemplo:

 ?- cedulas(423,[100,50,20,10,5,2,1],L).
 L = [4, 0, 1, 0, 0, 1, 1].

Obs.: O resultado acima significa 4 cédulas de 100, 0 de 50, 
1 de 20, e assim por diante.*/
cedulas(0,_,[]).
cedulas(V,L1,L2) :-
 L1 = [H1|T1],
 L2 = [H2|T2],
 X is div(V,H1),
 H2 = X,
 V2 is mod(V,H1),
 cedulas(V2,T1,T2),!.