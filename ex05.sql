--1
SELECT 'O identificador da ' || ds_funcao || ' é o id ' || id_funcao AS "Descrição das funções"
FROM tb_funcao;

--2
SELECT 'circunferência ' || (22/7) * (6000 * 6000) AS "Área" FROM dual;

--3
SELECT nm_departamento FROM tb_departamento
WHERE nm_departamento LIKE '%ing';

--4
SELECT ds_funcao, base_salario, teto_salario - base_salario
FROM tb_funcao
WHERE ds_funcao = 'Presidente' OR ds_funcao = 'Gerente'
ORDER BY (teto_salario - base_salario) DESC;

--5
DEFINE &var = 0.5
SELECT id_empregado, nome, salario, salario*12, &var AS "aliquota", &var * (salario*12) AS "aliquote anual"
FROM tb_empregado;