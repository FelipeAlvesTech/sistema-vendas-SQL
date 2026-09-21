-- RESET DO BANCO

DROP DATABASE IF EXISTS db_supermercadoalves;
CREATE DATABASE db_supermercadoalves;
USE db_supermercadoalves;

 -- Cadastro de Clientes
 -- Armazena todos os dados do cliente
CREATE TABLE tb_cliente (
   id_cliente INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100),
   cpf VARCHAR(18) NOT NULL UNIQUE,
   data_cadastro DATETIME,
   telefone VARCHAR(20) NOT NULL,
   endereco VARCHAR(250) NOT NULL,
   email VARCHAR(255) NOT NULL
);

 -- Número Cliente
 -- Onde armazena os telefone dos clientes
CREATE TABLE tb_telefone ( 
   id_telefone INT AUTO_INCREMENT PRIMARY KEY,
   numero VARCHAR(15),
   id_cliente INT,
  
   FOREIGN KEY (id_cliente) 
   REFERENCES tb_cliente(id_cliente)
);

   -- Criação de tabela endereço
   -- Endereço detalhado do cliente
CREATE TABLE tb_endereco (
   id_endereco INT AUTO_INCREMENT PRIMARY KEY,
   logradouro VARCHAR(45) NOT NULL,
   bairro VARCHAR(45) NOT NULL,
   cep VARCHAR(45) NOT NULL,
   cidade VARCHAR(45) NOT NULL,
   estado VARCHAR(45) NOT NULL,
   pais VARCHAR(45) NOT NULL,
   id_cliente INT,
   
   FOREIGN KEY (id_cliente) 
   REFERENCES tb_cliente(id_cliente)
);

   -- Criação de tabela email cliente
   -- Armazena os email dos clientes
CREATE TABLE tb_email_cliente (
   id_email_cliente INT AUTO_INCREMENT PRIMARY KEY,
   email VARCHAR(255) NOT NULL,
   id_cliente INT,
  
   FOREIGN KEY (id_cliente) 
   REFERENCES tb_cliente(id_cliente)
);

  -- Criação de tabela colaborador
  -- Onde vai armazenar todos os dados necessários 'obrigatório'
CREATE TABLE tb_colaborador ( 
   id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   cpf VARCHAR(18) NOT NULL,
   cargo VARCHAR(60) NOT NULL,
   salario DECIMAL(10,2) NOT NULL,
   data_admissao DATE NOT NULL
);

 -- Criação de tabela endereço do colaborador
 -- Endereço detalhado do colaborador
CREATE TABLE tb_endereco_colaborador (
   id_endereco_colaborador INT AUTO_INCREMENT PRIMARY KEY,
   logradouro VARCHAR(45) NOT NULL,
   cep VARCHAR(45) NOT NULL,
   bairro VARCHAR(45) NOT NULL,
   pais VARCHAR(45) NOT NULL,
   cidade VARCHAR(45) NOT NULL,
   estado VARCHAR(45) NOT NULL,
   id_colaborador INT,
   
   FOREIGN KEY (id_colaborador) 
   REFERENCES tb_colaborador(id_colaborador)
);

 -- Criação de tabela email colaborador
 -- Armazena os email dos colaborador
CREATE TABLE tb_email_colaborador (
   id_email_colaborador INT AUTO_INCREMENT PRIMARY KEY,
   email VARCHAR(255) NOT NULL,
   id_colaborador INT,
   
   FOREIGN KEY (id_colaborador) 
   REFERENCES tb_colaborador(id_colaborador)
);

  -- Criação de tabela produtos
  -- Armazena todos os produtos do supermercado
CREATE TABLE tb_produtos (
   id_produto INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(150) NOT NULL,
   categoria VARCHAR(100) NOT NULL,
   descricao VARCHAR(300) NOT NULL,
   codigo_barras VARCHAR(20) NOT NULL,
   estoque INT NOT NULL,
   preco_custo DECIMAL(10,2) NOT NULL,
   preco_venda DECIMAL(10,2) NOT NULL
);

show tables;

  -- Criação de tabela vendas
  -- Armazena todos os registros de vendas caixa mercado
CREATE TABLE tb_vendas (
   id_vendas INT AUTO_INCREMENT PRIMARY KEY,
   data_venda DATETIME,
   valor_total DECIMAL(10,2) NOT NULL,
   forma_pagamento ENUM('dinheiro','cartao_credito','cartao_debito','pix','vale_alimentacao','vale_refeicao'),
   id_cliente INT,
   id_colaborador INT,
  
   FOREIGN KEY (id_cliente) 
   REFERENCES tb_cliente(id_cliente),
   
   FOREIGN KEY (id_colaborador) 
   REFERENCES tb_colaborador(id_colaborador)
);

 -- Criação de tabela itens_vendas
 -- Itens produtos dentro de cada venda
CREATE TABLE tb_itens_vendas (
   id_itens_vendas INT AUTO_INCREMENT PRIMARY KEY,
   id_venda INT NOT NULL,
   id_produto INT NOT NULL,
   quantidade DECIMAL(10,3) NOT NULL,
   preco_unitario DECIMAL(10,2) NOT NULL,
   subtotal DECIMAL(10,2) NOT NULL,
  
   FOREIGN KEY (id_venda) 
   REFERENCES tb_vendas(id_vendas),
   
   FOREIGN KEY (id_produto) 
   REFERENCES tb_produtos(id_produto)
);

 -- Dados de exemplos — INSERT
 -- Clientes

 -- Clientes
INSERT INTO tb_cliente (nome, cpf, email, telefone, endereco) VALUES
('João Silva', '99988877766', 'joao@email.com', '11987654321','rua A, 001'),
('Maria Oliveira', '33344455566', 'maria@email.com', '11912345678', 'av B, 123');

 -- Endereços clientes
INSERT INTO tb_endereco (logradouro, bairro, cep, cidade, estado, pais, id_cliente) VALUES
('Rua das Flores, 100', 'Centro', '01000-000', 'São Paulo', 'SP','Brasil', 1),
('Av. Paulista, 500', 'Bela Vista', '01310-100', 'São Paulo', 'SP','Brasil', 2);

 -- Colaboradores
INSERT INTO tb_colaborador (nome, cpf, cargo, salario, data_admissao) VALUES
('Carlos Souza', '11122233344', 'Operador de Caixa', 1800.00, '2022-03-01'),
('Ana Lima', '55566677788', 'Gerente', 4500.00, '2020-01-15');

 -- Email colaborador
INSERT INTO tb_email_colaborador (email, id_colaborador) VALUES
('carlos@gmail.com', 1),
('ana@gmail.com', 2);

 -- Produtos
INSERT INTO tb_produtos (nome, categoria, descricao, codigo_barras, estoque, preco_custo, preco_venda) VALUES
('Banana Prata', 'Hortifruti', 'fruta', '7891234560001', 100, 2.50, 5.99),
('Leite Integral 1L', 'Laticínios', 'bebida', '7891234560002', 200, 3.20, 5.49),
('Refrigerante Cola 2L', 'Bebidas','refrigerante', '7891234560003', 150, 6.00, 10.99),
('Arroz Branco 5kg', 'Mercearia','comida','7891234560004', 80, 18.00, 28.90);

 -- Venda
INSERT INTO tb_vendas (data_venda, valor_total, forma_pagamento, id_cliente, id_colaborador) VALUES
(NOW(), 78.99, 'pix', 1, 1);

 -- Itens
INSERT INTO tb_itens_vendas (quantidade, preco_unitario, id_venda, id_produto, subtotal) VALUES
(2.000, 5.99, 1, 1, 11.98),
(1.000, 5.49, 1, 2, 5.49),
(1.000, 28.90, 1, 4, 28.90);

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