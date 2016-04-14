/* 
 * Script to create views.
 *
 * 2009-2016
 *
 */
CREATE OR REPLACE VIEW view_partidas AS
SELECT p.idCamp, p.nroPartida, p.dataHoraPartida, cl1.apelidoClube AS apelidoClubeM, cl2.apelidoClube AS apelidoClubeV, p.nomeest
FROM ((partida p JOIN clube cl1 ON p.cnpjclubemandante = cl1.cnpjclube) join clube cl2 on p.cnpjclubevisitante = cl2.cnpjclube);

CREATE OR REPLACE VIEW view_classificacao AS
SELECT Cla.idCamp, Cl.apelidoClube, Cla.nomeEq, Cla.pontosVitoria,
       Cla.pontosEmpate, Cla.pontosDerrota, Cla.pontosGanhos, Cla.saldoGols
FROM Classificacao Cla JOIN Clube Cl ON Cla.cnpjClube = Cl.cnpjClube;

CREATE OR REPLACE VIEW view_golsJogCamp AS
select DISTINCT p.idcamp, cl.apelidoclube, m.apelidomembro, sum(p.golspro) as somaGols
from ((participa p join clube cl on p.cnpjclube = cl.cnpjclube) join membro m on m.cpfmembro = p.cpfjogador) 
GROUP BY p.idcamp, cl.apelidoclube, m.apelidomembro;
