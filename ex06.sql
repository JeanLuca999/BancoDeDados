--1
CREATE TABLE homem(
id_homem NUMBER,
nome_homem VARCHAR2(100),
id_mulher NUMBER,
CONSTRAINT pk_homem_id_homem PRIMARY KEY (id_homem)
);

CREATE TABLE mulher(
id_mulher NUMBER,
nome_mulher VARCHAR2(100),
id_homem NUMBER,
CONSTRAINT pk_mulher_id_mulher PRIMARY KEY (id_mulher)
);

--chave estrangeira para o casamento entre um homem e uma mulher
ALTER TABLE homem ADD(
  CONSTRAINT fk_mulher_id_mulher FOREIGN KEY (id_mulher) REFERENCES mulher(id_mulher));


--2
INSERT INTO mulher VALUES (1, 'Edna', 20);
INSERT INTO mulher VALUES (2, 'Stefany', 30);
INSERT INTO mulher VALUES (3, 'Cássia', NULL);
INSERT INTO homem VALUES (10, 'Anderson', NULL);
INSERT INTO homem VALUES (20, 'Jander', 1);
INSERT INTO homem VALUES (30, 'Rogério', 2);


--3
--a selecionando todos os casamentos
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casados"
FROM homem h INNER JOIN mulher m ON (h.id_mulher = m.id_mulher);

--b selecionando casamentos utilizando natural join
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casados"
FROM homem h NATURAL JOIN mulher m;

--c selecionando casamentos utilizando inner join e using
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casados"
FROM homem h INNER JOIN mulher m USING (id_mulher);

--d selecionado casamentos utilizando inner join e on
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casados"
FROM homem h INNER JOIN mulher m ON (h.id_mulher = m.id_mulher);

--e selecionando todos os casamentos possíveis através do produto  cartesiano
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos possíveis"
FROM homem h CROSS JOIN mulher m
ORDER BY h.nome_homem;

SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS "Casamentos possíveis"
FROM homem h, mulher m
ORDER BY h.nome_homem;

--4
--a selecionando todos os homens casados e não casados
SELECT h.nome_homem || NVL2(h.id_mulher, ' é casado com ', ' não é casado.') || NVL2(m.nome_mulher, m.nome_mulher, '')
AS "Casados e não casados"
FROM homem h LEFT JOIN mulher m ON (h.id_mulher = m.id_mulher);

--b selecionando todas as mulheres casadas e não casadas
SELECT m.nome_mulher || NVL2(m.id_homem, ' é casado com ', ' não é casada') || NVL2(h.nome_homem, h.nome_homem, '')
AS "Casadas e não casadas"
FROM mulher m LEFT JOIN homem h ON (m.id_homem = h.id_homem);
--c
SELECT h.nome_homem || NVL2(h.id_mulher, ' é casado com ', ' não é casado.') || NVL2(m.nome_mulher, m.nome_mulher, '')
AS "Casados e não casados"
FROM homem h JOIN mulher m ON (h.id_mulher = m.id_mulher);