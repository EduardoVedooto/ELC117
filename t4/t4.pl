/*
Trabalaho 4 de Paradigmas de programação
Autor: Eduardo Rivas Vedooto

Este programa ajuda o inspetor Hercule Poirot a encontrar 
o assassino de um terrível caso envolvendo 9 pessoas.
*/

vitima(anita).

/*  
Lista de Suspeitos:
    - Bia
    - Caren
    - Alice
    - Maria
    - Bernardo
    - Pedro
    - Henrique
    - Adriano
*/

%   Localização dos suspeitos durante a semana.
localizacao(alice,seg,ap).
localizacao(alice,ter,poa).
localizacao(alice,qua,poa).
localizacao(alice,qui,ap).
localizacao(alice,sex,ap).

localizacao(bia,seg,ap).
localizacao(bia,ter,poa).
localizacao(bia,qua,poa).
localizacao(bia,qui,sm).
localizacao(bia,sex,ap).

localizacao(caren,seg,poa).
localizacao(caren,ter,poa).
localizacao(caren,qua,poa).
localizacao(caren,qui,sm).
localizacao(caren,sex,ap).

localizacao(maria,seg,ap).
localizacao(maria,ter,sm).
localizacao(maria,qua,sm).
localizacao(maria,qui,sm).
localizacao(maria,sex,ap).

localizacao(adriano,seg,ap).
localizacao(adriano,ter,ap).
localizacao(adriano,qua,sm).
localizacao(adriano,qui,ap).
localizacao(adriano,sex,ap).

localizacao(bernardo,seg,sm).
localizacao(bernardo,ter,sm).
localizacao(bernardo,qua,poa).
localizacao(bernardo,qui,sm).
localizacao(bernardo,sex,ap).

localizacao(henrique,seg,ap).
localizacao(henrique,ter,poa).
localizacao(henrique,qua,ap).
localizacao(henrique,qui,ap).
localizacao(henrique,sex,ap).

localizacao(pedro,seg,sm).
localizacao(pedro,ter,sm).
localizacao(pedro,qua,poa).
localizacao(pedro,qui,sm).
localizacao(pedro,sex,ap).

%pobres
pobre(bia).
pobre(pedro).
pobre(maria).
pobre(bernardo).

%ricos
rico(alice).
rico(henrique).
rico(adriano).
rico(caren).

%relacionamentos
relacionamento(alice, henrique).
relacionamento(alice, pedro).

relacionamento(anita, bernardo).
relacionamento(anita, pedro).

relacionamento(caren, adriano).
relacionamento(caren, bernardo).

relacionamento(maria, adriano).
relacionamento(maria, henrique).



crime(X) :- localizacao(X,sex,ap); localizacao(X,qui,ap).     % Localização onde o crime foi executado
chave(X) :- localizacao(X,qua,sm); localizacao(X,ter,poa).    % Localização onde a chave foi roubada
arma(X) :- baseball(X); martelo(X).                           % Arma usada durante o assassinato
  baseball(X) :- localizacao(X,qui,poa); localizacao(X,qua,sm).
  martelo(X) :- localizacao(X,qua,ap); localizacao(X,qui,ap).

%Possíveis motivos que levaram ao assassinato
ciumes(X,Y) :- relacionamento(X,Z), relacionamento(Z,Y).      
dinheiro(X) :- pobre(X).                                      
insano(adriano).                                              
insano(maria).

acesso(X) :- arma(X), chave(X), crime(X).                     % O assassino então possui a chave do apartamento e tinha a arma. 
motivo(X) :- ciumes(anita,X); dinheiro(X);insano(X).          % O motivo foi: ciúmes, falta de dinheiro ou a pessoa era louca.

assassino(X) :- motivo(X), acesso(X),!.                         % Quem será o assassino? O_O