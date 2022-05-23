--1)
SELECT e.nome, e.sobrenome
FROM tb_empregado e
WHERE LOWER(e.nome) LIKE '%li%';

--2)
SELECT 
CASE
WHEN LENGTH(e.nome||e.sobrenome) >= 10
THEN SUBSTR(e.nome, 1, 1) || ' ' || SUBSTR(e.sobrenome, 1, 10)
ELSE
e.nome || ' ' || e.sobrenome
END
AS "nome formal"
FROM tb_empregado e;

--3)
SELECT h.data_termino, COUNT(e.id_empregado), h.id_funcao
FROM tb_empregado e
INNER JOIN tb_historico_funcao h
ON(e.id_funcao = h.id_funcao)
GROUP BY h.id_funcao, h.data_termino;

--4)
SELECT COUNT(TO_CHAR(e.data_admissao, 'D')) AS "contador", e.data_admissao, CASE
WHEN TO_CHAR(e.data_admissao, 'D') = 1
THEN 'domingo'
WHEN TO_CHAR(e.data_admissao, 'D') = 2
THEN 'segunda'
WHEN TO_CHAR(e.data_admissao, 'D') = 3
THEN 'terça'
WHEN TO_CHAR(e.data_admissao, 'D') = 4
THEN 'quarta'
WHEN TO_CHAR(e.data_admissao, 'D') = 5
THEN 'quinta'
WHEN TO_CHAR(e.data_admissao, 'D') = 6
THEN 'sexta'
WHEN TO_CHAR(e.data_admissao, 'D') = 7
THEN 'sabado'
END AS "Dia da semana"
FROM tb_empregado e
GROUP BY e.data_admissao
ORDER BY COUNT(TO_CHAR(e.data_admissao, 'D')) DESC;

--5)
CREATE OR REPLACE PROCEDURE sp_questao_05(
 p_id_departamento IN tb_departamento.id_departamento%TYPE
)
AS
v_id_departamento     NUMBER;
v_output              VARCHAR2(455);
v_nome VARCHAR2(255);
BEGIN
  SELECT COUNT(*) INTO v_id_departamento
  FROM tb_departamento
  WHERE id_departamento = p_id_departamento;
  SELECT nm_departamento INTO v_nome FROM tb_departamento WHERE id_departamento = p_id_departamento;
   
  IF(v_id_departamento = 1) THEN
    IF(SUBSTR(LOWER(v_nome), 1, 1) IN ('a', 'e', 'i', 'o', 'u')) THEN
      UPDATE tb_departamento
      SET nm_departamento = UPPER(nm_departamento)
      WHERE id_departamento = p_id_departamento;
    ELSE
      UPDATE tb_departamento
      SET nm_departamento = LOWER(nm_departamento)
      WHERE id_departamento = p_id_departamento;
    END IF;

  ELSE
    DBMS_OUTPUT.PUT_LINE('Departamento não localizado');
  END IF;
END sp_questao_05;

BEGIN
  sp_questao_05(70);
END;