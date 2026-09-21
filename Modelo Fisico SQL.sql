-- Banco de Dados db_supermercadoalves
create database db_supermercadoalves;

use db_supermercadoalves;

-- Cadastro de Clientes
-- Armazena todos os dados do cliente
create table tb_cliente(
   id_cliente int auto_increment primary key,
   nome varchar(100),
   cpf varchar(18) not null unique,
   data_cadastro datetime,
   telefone varchar(20) not null,
   endereco varchar(250) not null,
   email varchar(100) not null,
   id_cliente int
);

-- Número Cliente
-- Onde armazena os telefone dos clientes
create table tb_telefone( 
   id_telefone int not null auto_increment primary key,
   numero varchar(15),
   id_cliente int
   );
   
   -- Criação de tabela endereço
   -- Endereço detalhado do cliente
   create table tb_endereco(
      id_endereco int not null auto_increment primary key,
      logradouro varchar(45) not null,
      bairro varchar(45) not null,
      cep varchar(45) not null,
      cidade varchar(45) not null,
      estado varchar(45) not null,
      pais varchar(45) not null,
      id_cliente int,
   
     CONSTRAINT FK_endereco_cliente
     FOREIGN KEY (id_cliente)
     REFERENCES tb_cliente(id)
   );
   
   -- Criação de tabela email cliente
   -- Armazena os email dos clientes
   create table tb_email_cliente(
      id_email_cliente int auto_increment primary key,
      email varchar(255) not null,
      id_cliente int,
      
	 CONSTRAINT FK_email_cliente
     FOREIGN KEY (id_cliente)
     REFERENCES tb_cliente(id_cliente)
);   

 -- Criação de tabela colaborador
 -- Onde vai armazenar todos os dados necessários 'obrigatório'
 create table tb_colaborador( 
    id_colaborador int auto_increment primary key,
    nome varchar(100) not null,
    cpf varchar(18) not null,
    cargo varchar(60) not null,
    salario decimal(10,2) not null,
    data_admissao date not null,
    email varchar(255) not null,
    telefone varchar(20) not null,
    id_colaborador int
 );
 
 -- Criação de tabela endereço do colaborador
 -- Endereço detalhado do colaborador
 create table tb_endereco_colaborador(
    id_endereco_colaborador int not null auto_increment primary key,
    logradouro varchar(45) not null,
    cep varchar(45) not null,
    bairro varchar(45) not null,
    pais varchar(45) not null,
    cidade varchar(45) not null,
    estado varchar(45) not null,
    
    CONSTRAINT FK_endereco_colaborador
    FOREIGN KEY (id_colaborador)
    REFERENCES tb_colaborador (id_colaborador) -- dando erro!
 );
 
-- Criação de tabela email colaborador
-- Armazena os email dos colaborador
   create table tb_email_colaborador(
      id_email_colaborador int auto_increment primary key,
      email varchar(255) not null,
      id_colaborador int,
      
	 CONSTRAINT FK_email_colaborador
     FOREIGN KEY (id_colaborador)
     REFERENCES tb_colaborador(id_colaborador)
);

show tables;
 -- Criação de tabela produtos
 -- Armazena todos os produtos do supermercado
 create table tb_produtos(
   id_produto int auto_increment primary key,
   nome varchar(150) not null,
   categoria varchar(100) not null,
   descricao varchar(300) not null,
   codigo_barras varchar(20) not null,
   estoque int not null,
   preco_custo decimal(10,2) not null,
   preco_venda decimal(10,2) not null
 );
 
 -- Criação de tabela vendas
 -- Armazena todos os registros de vendas caixa mercado
 create table tb_vendas(
   id_vendas int auto_increment primary key,
   data_venda datetime,
   valor_total decimal(10,2) not null,
   forma_pagamento enum( 'dinheiro', 'cartao_credito', 'cartao_debito',
   'pix', 'vale_alimentacao', 'vale_refeicao'), 
   id_cliente int
 );
 
 
-- Criação de tabela itens_vendas
-- Itens produtos dentro de cada venda
 create table tb_itens_vendas(
   id_itens_vendas int auto_increment primary key,
   id_venda INT NOT NULL, -- Nome definido aqui: id_venda
   id_produto INT NOT NULL,
   quantidade DECIMAL(10,3) NOT NULL,
   preco_unitario DECIMAL(10,2) NOT NULL, 
   subtotal DECIMAL(10,2) NOT NULL,

   CONSTRAINT fk_item
   FOREIGN KEY (id_venda) REFERENCES tb_vendas(id_vendas),
   
   CONSTRAINT fk_item_produto
   FOREIGN KEY (id_produto) REFERENCES tb_produtos(id_produto)
 );
 
 -- Dados de exemplos — INSERT
-- Clientes
INSERT INTO tb_cliente (nome, cpf, email, telefone, endereco) VALUES
('João Silva', '99988877766', 'joao@email.com', '11987654321','rua A, 001'),
('Maria Oliveira', '33344455566', 'maria@email.com', '11912345678', 'av B, 123');

-- Endereços de clientes
INSERT INTO tb_endereco (logradouro, bairro,cep, cidade, estado, pais, id_cliente) VALUES
('Rua das Flores, 100', 'Centro',       '01000-000', 'São Paulo', 'SP','Brasil', 1),
('Av. Paulista, 500',   'Bela Vista',   '01310-100', 'São Paulo', 'SP', 'Brasil', 2);

-- Colaboradores
INSERT INTO tb_colaborador (nome, cpf, cargo, salario, email, telefone, data_admissao) VALUES
('Carlos Souza', '11122233344', 'Operador de Caixa', 1800.00, 'carlos@gmail.com', '11987654321', '2022-03-01'),
('Ana Lima', '55566677788', 'Gerente', 4500.00, 'analima@gmail.com', '11912345678', '2020-01-15');

-- Produtos
INSERT INTO tb_produtos (nome, categoria,descricao, codigo_barras, estoque, preco_custo, preco_venda) VALUES
('Banana Prata', 'Hortifruti',  'fruta', '7891234560001', 100,  2.50,  5.99),
('Leite Integral 1L', 'Laticínios', 'bebida', '7891234560002', 200,  3.20,  5.49),
('Refrigerante Cola 2L', 'Bebidas','Refrigerante', '7891234560003', 150,  6.00, 10.99),
('Arroz Branco 5kg', 'Mercearia','comid','7891234560004',  80, 18.00, 28.90);

-- Venda de exemplo
INSERT INTO tb_vendas (data_venda,valor_total,forma_pagamento,id_cliente) VALUES
(NOW(), 78.99,'PIX', 1);

-- Itens da venda (triggers atualizam estoque e valor_total automaticamente)
INSERT INTO tb_itens_vendas (quantidade, preco_unitario, id_venda, id_produto, subtotal) VALUES
(2.000, 5.99,  1, 1, 11.98),  -- 2 kg de Banana
(1.000, 5.49,  1, 2, 5.99),   -- 1 Leite
(1.000, 28.90, 1, 4, 28.90);  -- 1 Arroz

show tables;

-- Select

select * from tb_cliente;
select * from tb_telefone;
select * from tb_email_cliente;
select * from tb_colaborador;
select * from tb_email_colaborador;
select * from tb_endereco;
select * from tb_vendas;
select * from tb_itens_vendas;
select * from tb_produtos;