# N2---Desenvolvimento-Mobile
Trabalho Feito Para N2 da materia de desenvolvimento Mobile, Desenvolvido em flutter e usando Firebase como banco de dados

Descrição da Arquitetura do Sistema - Arquitetura de camadas
O aplicativo segue uma arquitetura em camadas, com uma divisão clara entre a camada de apresentação, onde estão as telas de registro, visualização e edição, e a camada de dados, que gerencia 
a configuração do Firebase e o acesso ao banco de dados.Essa separação facilita a manutenção e organiza o código, mantendo o acesso aos dados independente das telas que o usuário acessa.

A Forma como ficou organizado :

![image](https://github.com/user-attachments/assets/265380a6-3587-4780-8de4-632d1e2304b2)




-------------------------------------------------------------------------------------------------------------------------------------------------------------
Paleta de cores:
Para a paleta de cores queria algo que tivesse cores relacionadas a musculação (principalmente o vermelho), e uma cor para indicar os exercicios concluidos ( como o verde por exemplo). 
Com base nisso a paleta de cores que escolhi foi a do seguinte a seguinte:

![image](https://github.com/user-attachments/assets/d69c7c27-75f6-4f53-b17e-d07288e1149c)

podendo ser acessada no seguinte Link:
https://paletadecores.com/paleta/ccf390/e0e05a/f7c41f/fc930a/ff003d/

usei 3 cores dessa paleta, sendo elas:

#ff003d como a cor do APPBAR

#ccf390 para indicar exercicios concluidos

#e0e05a para indicar os exercicios que ainda devem ser concluidos


-------------------------------------------------------------------------------------------------------------------------------------------------------------

Explicação Do Código

Criação de dados no Firebase:

A Criação de dados no Firebase é feito através da tela "add_exercise_screen", onde após preencher os campos com os dados solicitados e clicar 
em "Adicionar Exercício", um mapa "(Map<String, dynamic>)" é criado, onde os valores de sequência e repetições são convertidos para inteiros.
E em seguida O método "adicionarExercicio" da classe "DatabaseMethods" é chamado para enviar esses dados para o Firestore.


Visualização de dados no firebase:

A visualização dos exercícios pode ser feita através da tela "view_exercises_screen", O corpo da tela é construído com um "StreamBuilder", 
que se conecta à coleção de exercícios no Firestore através do método "lerExercicio"s da classe "DatabaseMethods". Esse "StreamBuilder" 
permite que a interface seja atualizada em tempo real sempre que os dados forem alterados.
Para cada documento recuperado, os dados são convertidos em um "Map<String, dynamic>", e uma verificação é realizada para determinar se o 
exercício está concluído (baseado no campo "concluido").


Edição de dados no Firebase:

A edição dos dados do Firebase podeM ser feita através de duas telas, "view_exercises_screen" e "edit_exercise_screen", na tela 
"view_exercises_screen" apenas é possível alterar o estado do exercício (concluído ou não), através de um ícone que fica ao lado do 
exercicio ao pressiona-lo, o valor do campo "concluído" é alternado, e a função "atualizarExercicio" é chamada para atualizar o estado do
exercício correspondente no Firestore. 
Através do "edit_exercise_screen" é possível editar os exercícios já existentes no Firebase, ela utiliza um "StreamBuilder" para
se conectar à coleção de exercícios no Firestore através do método "lerExercicios" da classe "DatabaseMethods". Ao Selecionar um exercicio
para editar,a classe "EditExerciseDetailScreen" é chamada passando o ID do documento e os dados atuais do exercício selecionado.


Exclusão de dados no Firebase:

A exclusão de dados é feita somente através da tela "edit_exercise_screen", e após selecionar um exercicioe chamar a classe 
"EditExerciseDetailScreen", onde há um icone no canto superior direito, e ao clicar nele, surge uma mensagem de confirmação de exclusão, caso 
confirmada a exclusão, ele executa "databaseMethods.deletarExercicio(widget.docId)", que chama o método "deletarExercicio", passando assim o
"docId" do exercicio que será excluido, esse método fica implantado na classe "DatabaseMethods", assim como todas as outras interações com o 
banco de dados

 
O formato que os dados ficam no firebase pode ser visualizado da seguinte forma:


![image](https://github.com/user-attachments/assets/4ad1d330-421c-4081-99e3-ed171281be3a)


-------------------------------------------------------------------------------------------------------------------------------------------------------------
Regras de Negócio Implementadas 

Foi implementada a funcionalidade de criar registros de exercicios a serem feitos a partir de um formulário que envia os dados para o Firebase. 

Foi implementada a funcionalidade de visualizar os exercicios que foram registrados, podendo mostrar uma tela vazia, caso não tenha nenhum exercicio registrado. 

Foi implementada a funcionalidade de alterar o status de conclusão  (se o exercicio foi feito ou não) na própria lista. 

Foi implementada a funcionalidade de editar o registro de um exercicio a partir de um formulário que envia os dados atualizados para o Firebase. 

Foi implementada a funcionalidade de deletar o registro de um exercicio a partir de uma mensagem de confirmação. 

A funcionalidade de editar o registro só pode editar um registro que já tenha sido criado. 

A funcionalidade de deletar um registro só pode deletar um registro que já tenha sido criado. 
