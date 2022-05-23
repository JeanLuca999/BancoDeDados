--1)
SELECT e.nome, f.ds_funcao, e.data_admissao
FROM tb_empregado e 
INNER JOIN tb_funcao f
USING(id_funcao)
WHERE e.data_admissao BETWEEN '20-FEB-1987' AND '01-MAY-1989'
ORDER BY e.data_admissao;

--2)
SELECT UPPER(e.nome) AS "nome", LENGTH(e.sobrenome) AS "tamanho nome", d.nm_departamento AS "nome departamento", p.nm_pais AS "nome pais"
FROM tb_empregado e
INNER JOIN tb_departamento d
USING(id_departamento)
INNER JOIN tb_localizacao l
USING (id_localizacao)
INNER JOIN tb_pais p
USING (id_pais)
WHERE LOWER(e.nome) LIKE 'e%' OR LOWER(e.nome) LIKE 'l%' OR LOWER(e.nome) LIKE 'a%';

--3)
SELECT e.nome, d.nm_departamento, l.cidade, l.estado
FROM tb_empregado e
INNER JOIN tb_departamento d
USING (id_departamento)
INNER JOIN tb_localizacao l
USING (id_localizacao)
WHERE e.percentual_comissao > 0;

--4)
SELECT e.nome || ' trabalha para ' || NVL(g.nome, 'os acionistas')
FROM tb_empregado e
LEFT JOIN tb_empregado g
ON(e.id_gerente = g.id_gerente)
ORDER BY g.nome DESC;

--5)
CREATE OR REPLACE PROCEDURE sp_get_emp(
p_id INTEGER
)
AS
v_emp NUMBER;
v_output VARCHAR2(455);
BEGIN
SELECT COUNT(id_empregado) INTO v_emp FROM tb_empregado WHERE id_empregado = p_id;
IF(v_emp > 0) THEN
  SELECT 'Nome: ' || ' ' || e.nome || ' ' || e.sobrenome || ' Função: ' || f.ds_funcao INTO v_output
  FROM tb_empregado e INNER JOIN tb_funcao f
  ON(e.id_funcao = f.id_funcao)
  WHERE e.id_empregado = p_id;
  DBMS_OUTPUT.PUT_LINE(v_output);
ELSE
  DBMS_OUTPUT.PUT_LINE('Empregado ' || p_id || ' não localizado!!');
END IF;
END sp_get_emp;

BEGIN
  sp_get_emp(100);
END;