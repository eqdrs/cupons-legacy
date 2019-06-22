# Cupons

O sistema de Cupons é utilizado pelo time de MKT para criar promoções
que são oferecidas tanto em meios digitais (campanhas online etc) como em mídias
impressas (eventos, revistas etc).

## Funcionalidades Principais

### Gerenciamento de Promoções

Cadastro e manutenção de promoções, incluindo prazo de validade, produtos da
promoção, descontos e regra para criação de cupons

### Aprovação de Promoção

Após criada, uma promoção deve ser aprovada por outro usuário antes de ser
emitidos os cupons.

### Emissão de Cupons

Os cupons devem ser emitidos a partir de uma promoção já criada. Os cupons devem
respeitar as regras da promoção. Todos cupons devem ser gerados no momento da
emissão de cupons.

De acordo com a quantidade X definida na promoção, devem ser gerados X cupons
cada um com um código único, composto pelo prefixo da promoção + um número
sequencial com 4 casas.

Exemplo: uma promoção com 20 cupons, com prefixo PROMO, deve gerar 20 cupons
únicos com códigos PROMO0001, PROMO0002, PROMO0003 ... PROMO0020

### Consumo de Cupons via sistema

Deve ser possível queimar cupons via sistema, para controle interno
ou possível invalidação de alguns cupons. Ao queimar um cupom via sistema deve
ser registrado a data e hora, o usuário responsável e o motivo.

### Consulta de Cupons via API

Deve ser possível consultar se um cupom é valido ou não e o desconto que o cupom
vai oferecer.

### Consumo de Cupons via API

Deve ser oferecido um endpoint para consumo de um CUPOM. Ao ser consumido devem
ser registrados dados como: a aplicação que consumiu o cupom, o número do
pedido, data e hora do consumo.

## Relatório

Criar relatórios que extraiam as seguintes informações:

- Promocões com mais cupons consumidos durante um período;
- Dado uma promoção, trazer uma relação de cupons consumidos e cupons
  disponíveis;
- Produtos com mais cupons consumidos dado um período;


## Dados Armazenados

Promoções devem conter:

  - Descrição/Nome
  - Desconto em %
  - Nome
  - Validade em dias
  - Prefixo dos cupons da promoção 
  - Quantidade
  - Usuário responsável pela criação
  - Usuário responsável pela aprovação

Cupons devem refletir dados vindos da promoção e adicionar:

  - Usuário responsável pela emissão 
  - Código único gerado a partir do prefixo 
  - Data e hora de criação

Cupons já consumidos devem registrar:
  - Nome de aplicação que consumiu o cupom 
  - Número do pedido
  - Data e hora do consumo


## Controle de Acesso

O acesso a aplicação poderá ser feito por usuários previamente cadastrados. O
acesso será garantido através do uso de um email de identificação e de uma
senha.

## Interfaces

O sistema terá toda sua interface regida pelas regras descritas na documentação
do Locaweb Style (LocaStyle).

