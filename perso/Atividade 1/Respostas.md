### Quais os nomes de classes definidas nos arquivos DesktopLauncher.java e Drop.java?

 * DesktopLauncher.java: tem a classe DesktopLauncher
 * Drop.java: tem a classe Drop que é herdada da classe ApplicationAdapter

### Explique como o conceito de herança se aplica a ambas as classes.

 Na classe Drop.java, a classe é herdada da super classe ApplicationAdapter, e durante a implementação da classe, são usados métodos métodos e atributos da classe "mãe".
 Já a classe DesktopLauncher não herda de nenhuma outra classe, apenas cria um novo objeto da classe LwjglApplicationConfiguration.

### Em qual classe estão os atributos que representam as gotas que "caem" no balde?

 Os atributos das gotas estão na classe Drop.

### Quais são os atributos do jogo que representam a imagem e a posição das gotas?

 Os atributos são: 
 
 * dropImage                -- Imagem das gotas
 * raindrop.x e raindrop.y  -- Posição das gotas

### O que significam as anotações @Override em Drop.java?

 Essa anotação permite que um método seja sobreescrito, ou seja, na função "mãe" já possuia este método, e ele fazia algo, porém, com essa anotação, conseguimos modificar o corpo do método para ele fazer outra função.

### Em Drop.java, no método spawnRaindrop():
### É possível deduzir qual a visibilidade (public, private, protected) do atributo raindrop.x?
 A visibilidade do atributo é *public visto que ele pode ser alterado sem ser chamado um método, apenas passando um valor para ele.

### Ainda no método spawnRaindrop(), MathUtils é um nome de classe ou uma referência para um objeto?
 MathUtils, como pode ser visto na parte superior do código, é uma classe importada.

### raindrop é um nome de classe ou uma referência para um objeto?
 Referência para um objeto, o qual foi criado na linha 63 da classe Drop.java.

### Em spawnRaindrop(), por que lastDropTime pode ser usado sem estar declarado dentro deste método?
 Ele pode ser usado dentro do método, pois foi declarado dentro da classe Drop.java, ou seja, qualquer método criado dentro desta classe, tem acesso a estes atributos.