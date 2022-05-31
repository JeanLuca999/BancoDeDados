--1)
SELECT e.nome, NVL(CAST(e.percentual_comissao AS VARCHAR2(255)), 'Nenhuma Comissão') AS "Comissão"
FROM tb_empregado e;

--2)
SELECT MAX(e.salario) AS "Máximo", MIN(e.salario) AS "Mínimo", ROUND(AVG(e.salario),0) AS "Média", SUM(e.salario) AS "Somatório"
FROM tb_empregado e;

--3)
SELECT e.id_gerente, e.salario
FROM tb_empregado e LEFT JOIN tb_empregado g ON(e.id_gerente = g.id_empregado)
WHERE e.salario = (SELECT MIN(salario) FROM tb_empregado WHERE id_gerente = g.id_empregado) AND e.salario > 1000 AND e.id_gerente IS NOT NULL
ORDER BY e.salario DESC;

--4)
SELECT
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e) AS "Total",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1990') AS "1990",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1991') AS "1991",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1992') AS "1992",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1993') AS "1993"
FROM dual;

--5)
SELECT * FROM tb_empregado;
SELECT id_departamento || ',' || nome || ',' || sobrenome || ',' || email || ',' || telefone || ',' || data_admissao || ',' || id_funcao || ',' || salario || ',' || percentual_comissao || ',' || id_gerente || ',' || id_departamento AS "Saída"
FROM tb_empregado;

--7)
SELECT e.nome, (SYSDATE - e.data_admissao) AS "Meses Trabalhados"
FROM tb_empregado e
ORDER BY (SYSDATE - e.data_admissao);

--8)
SELECT e.nome, d.nm_departamento, l.cidade, l.estado
FROM tb_empregado e INNER JOIN tb_departamento d USING(id_departamento)
INNER JOIN tb_localizacao l USING(id_localizacao)
WHERE e.percentual_comissao IS NOT NULL;

--10)
SELECT
  CASE
    WHEN UPPER(f.ds_funcao) LIKE '%SH%'
    THEN 'SHIPPING'
    ELSE f.ds_funcao
  END
FROM tb_empregado e INNER JOIN tb_funcao f USING(id_funcao);