
CREATE TABLE tb_produtos (
  produto_id INT PRIMARY KEY,
  fornecedor_id INT, 
  categoria VARCHAR(45) NOT NULL,
  nome VARCHAR(250) NOT NULL,
  preco DECIMAL(10, 2) NOT NULL
);
CREATE TABLE descricao (
  produto_id INT,
  fornecedor_id INT,
  descricao VARCHAR(250) NOT NULL,
  PRIMARY KEY (produto_id, fornecedor_id),
  FOREIGN KEY (produto_id) REFERENCES tb_produtos(produto_id),
  FOREIGN KEY (fornecedor_id) REFERENCES tb_fornecedores(fornecedor_id));

CREATE TABLE tb_fornecedores (
  fornecedor_id INT PRIMARY KEY,
  nome VARCHAR(250) NOT NULL,
  endereco VARCHAR(250) NOT NULL,
  telefone VARCHAR(15) NOT NULL
);

CREATE TABLE tb_clientes (
  cliente_id INT PRIMARY KEY,
  nome VARCHAR(250) NOT NULL,
  endereco VARCHAR(250) NOT NULL,
  telefone VARCHAR(15) NOT NULL
);


CREATE TABLE tb_vendas (
  venda_id INT PRIMARY KEY,
  cliente_id INT,
  data_venda DATE NOT NULL,
  total_venda DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES tb_clientes(cliente_id)
);


CREATE TABLE itens (
  venda_id INT,
  produto_id INT,
  quantidade INT NOT NULL,
  PRIMARY KEY (venda_id, produto_id),
  FOREIGN KEY (venda_id) REFERENCES tb_vendas(venda_id),
  FOREIGN KEY (produto_id) REFERENCES tb_produtos(produto_id)
);


CREATE TABLE tb_compras (
  compra_id INT PRIMARY KEY,
  produto_id INT,
  data_compra DATE NOT NULL,
  quantidade_compras INT NOT NULL,
  valor_compra DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (produto_id) REFERENCES tb_produtos(produto_id)
);


INSERT INTO tb_fornecedores (fornecedor_id, nome, endereco, telefone) VALUES
  (1, 'Fornecedor1', 'Rua Fornecedor1, 123', '(12) 0000-0000'),
  (2, 'Fornecedor2', 'Avenida Fornecedor2, 321', '(12) 1111-1111'),
  (3, 'Fornecedor3', 'Rua Fornecedor3, 111', '(12) 2222-2222');

INSERT INTO tb_produtos (produto_id, fornecedor_id, categoria, nome, preco) VALUES
  (1, 1, 'Eletrônicos', 'Smartphone', 599.99),
  (2, 2, 'Roupas', 'Touca', 19.99),
  (3, 3, 'Alimentos', 'Chocolate', 3.99);

INSERT INTO tb_clientes (cliente_id, nome, endereco, telefone) VALUES
  (1, 'Kleber the Kleber', 'Rua Kleber, 123', '(12) 1234-5678'),
  (2, 'Horário da Silva', 'Avenida 12 horas, 1212', '(12) 9876-5432'),
  (3, 'Dinossauro Komodo', 'Rua Dragão, 789', '(12) 1111-2222');

INSERT INTO tb_vendas (venda_id, cliente_id, data_venda, total_venda) VALUES
  (1, 1, '2023-10-19', 299.95),
  (2, 2, '2023-10-19', 59.97),
  (3, 3, '2023-10-20', 10.00);
  
INSERT INTO itens (venda_id, produto_id, quantidade)
VALUES
  (1, 1, 2),  
  (2, 2, 3),  
  (3, 3, 5);  
  
  INSERT INTO tb_compras (compra_id, produto_id, data_compra, quantidade_compras, valor_compra)
VALUES
  (1, 1, '2023-10-18', 5, 500.00),  
  (2, 2, '2023-10-18', 10, 100.00),   
  (3, 3, '2023-10-19', 20, 40.00); 
  
  INSERT INTO descricao (produto_id, fornecedor_id, descricao)
VALUES
  (1, 1, 'Smartphone de última geração com câmera de alta resolução, processador rápido e tela de alta qualidade.'),
  (2, 2, 'Touca de lã com design elegante e confortável para uso em climas frios.'),
  (3, 3, 'Delicioso chocolate ao leite em barra, perfeito para satisfazer seus desejos por doce.');
  
SELECT
    Pr.nome AS "Nome do Produto",
    V.quantidade AS "Quantidade Vendida",
    Pr.preco AS "Valor Unitário",
    (V.quantidade * Pr.preco) AS "Valor Total"
FROM
    tb_produtos AS Pr
JOIN
    itens AS V ON Pr.produto_id = V.produto_id;


SELECT
    v.data_venda AS "Data da Venda",
    c.nome AS "Nome do Cliente"
FROM
    tb_vendas v
JOIN
    tb_clientes c ON v.cliente_id = c.cliente_id;

SELECT
    c.compra_id,
    p.nome AS "Produto Comprado",
    c.data_compra,
    c.quantidade_compras,
    c.valor_compra
FROM
    tb_compras c
JOIN
    tb_produtos p ON c.produto_id = p.produto_id;
    
    
  SELECT
    Pr.produto_id AS "Código",
    Pr.nome AS "Nome do Produto",
    D.descricao AS "Descrição",
    Pr.categoria AS "Categoria",
    F.nome AS "Fornecedor"
FROM
    tb_produtos AS Pr
JOIN
    descricao AS D ON Pr.produto_id = D.produto_id
JOIN
    tb_fornecedores AS F ON Pr.fornecedor_id = F.fornecedor_id;
    
    
    SELECT
    c.compra_id,
    p.nome AS "Produto Comprado",
    c.data_compra,
    c.quantidade_compras,
    c.valor_compra,
    p.fornecedor_id AS "ID do Fornecedor",
    f.nome AS "Nome do Fornecedor"
FROM
    tb_compras c
JOIN
    tb_produtos p ON c.produto_id = p.produto_id
JOIN
    tb_fornecedores f ON p.fornecedor_id = f.fornecedor_id;
    
