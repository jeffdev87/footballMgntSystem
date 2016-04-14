/* 
 * Script to create and insert data into the
 * database.
 *
 * 2009-2016
 *
 */

/* Drop tables and sequences */
DROP TABLE patrocinador CASCADE;
DROP TABLE patrocinio CASCADE;
DROP TABLE clube CASCADE;
DROP TABLE clubePossuiEst CASCADE;
DROP TABLE estadio CASCADE;
DROP TABLE equipe CASCADE;
DROP TABLE partida CASCADE;
DROP TABLE campeonato CASCADE;
DROP TABLE EqInscreveCamp CASCADE;
DROP TABLE arbitro CASCADE;
DROP TABLE arbitra CASCADE;
DROP TABLE membro CASCADE;
DROP TABLE treinador CASCADE;
DROP TABLE jogador CASCADE;
DROP TABLE participa CASCADE;
DROP TABLE res CASCADE;
DROP TABLE classificacao CASCADE;
DROP TABLE admuser CASCADE;
DROP SEQUENCE idCampSeq;

/* Create table and sequence */

CREATE SEQUENCE idCampSeq START 1;

-- Admin user table
CREATE TABLE admuser (
   usermail VARCHAR(50) NOT NULL,
   userpass VARCHAR(50) NOT NULL,
   username VARCHAR(30),
   
   CONSTRAINT PK_ADMUSER
      PRIMARY KEY (usermail)
);

-- Patrocinador table
CREATE TABLE patrocinador (
   cnpjPat     VARCHAR(16) NOT NULL,
   nomePat     VARCHAR(50) NOT NULL,
   apelidoPat  VARCHAR(25),
 
   CONSTRAINT PK_PATROCINADOR 
      PRIMARY KEY (cnpjPat)   
);

-- Clube table
CREATE TABLE clube(
   cnpjClube     VARCHAR(14) NOT NULL,
   nomeClube     VARCHAR(50) NOT NULL,
   apelidoClube  VARCHAR(25),
   logoClube     VARCHAR(100),

   CONSTRAINT PK_CLUBE
      PRIMARY KEY (cnpjClube)
);

-- Estadio table
CREATE TABLE estadio (
   nomeEst          VARCHAR(50) NOT NULL,
   capacidadeEst    VARCHAR(6),
   valorAluguelEst  NUMERIC(10,2),
   
   CONSTRAINT PK_ESTADIO 
      PRIMARY KEY (nomeEst)
);

-- Arbitro table
CREATE TABLE arbitro (
   cpfArb        VARCHAR(11) NOT NULL,
   nomeArb       VARCHAR(50),
   apelidoArb    VARCHAR(25),
   
   CONSTRAINT PK_ARBITRO 
      PRIMARY KEY (cpfArb)
);

-- Membro table
CREATE TABLE membro(
   cpfMembro      VARCHAR(11) NOT NULL,
   nomeMembro     VARCHAR(50) NOT NULL,
   apelidoMembro  VARCHAR(25),
   tipoTecnico    VARCHAR(1) NOT NULL,
   tipoAtleta     VARCHAR(1) NOT NULL,
   
   CONSTRAINT PK_MEMBRO
      PRIMARY KEY (cpfMembro),
   
   CONSTRAINT CK_TIPOTECNICO_MEMBRO
      CHECK (tipoTecnico IN ('0', '1')),      

   CONSTRAINT CK_TIPOATLETA_MEMBRO
      CHECK (tipoAtleta IN ('0', '1'))      
);

-- Patrocinio table
CREATE TABLE patrocinio (
   cnpjPat      VARCHAR(14) NOT NULL, 
   cnpjClube    VARCHAR(14) NOT NULL,
   dataInicPc   DATE NOT NULL, 
   dataFimPc    DATE,
   valorPc      NUMERIC(10,2),
   
   CONSTRAINT PK_PATROCINIO
      PRIMARY KEY (cnpjPat, cnpjClube, dataInicPc),
   
   CONSTRAINT FK_PATROCINADOR_PATROCINIO FOREIGN KEY (cnpjPat)
      REFERENCES patrocinador (cnpjPat) 
         ON DELETE CASCADE,
         
   CONSTRAINT FK_CLUBE_PATROCINIO FOREIGN KEY (cnpjClube)
      REFERENCES clube (cnpjClube) 
         ON DELETE CASCADE,
       
   CONSTRAINT CK_PATROCINIO 
      CHECK (dataInicPc < dataFimPc)
);

-- clubePossuiEst table
CREATE TABLE clubePossuiEst (
   cnpjClube  VARCHAR(14) NOT NULL, 
   nomeEst    VARCHAR(50) NOT NULL,
   
   CONSTRAINT PK_CLUBEPOSSUIEST 
      PRIMARY KEY (cnpjClube, nomeEst),

   CONSTRAINT FK_CLUBE_CLUBEPOSSUIEST FOREIGN KEY (cnpjClube)
      REFERENCES clube (cnpjClube) 
         ON DELETE CASCADE,

   CONSTRAINT FK_ESTADIO_CLUBEPOSSUIEST FOREIGN KEY (nomeEst)
      REFERENCES estadio (nomeEst) 
         ON DELETE CASCADE   
);

-- Equipe table 
CREATE TABLE equipe (
   cnpjClube      VARCHAR(14) NOT NULL,
   nomeEq         VARCHAR(50) NOT NULL,
   nroJogadoresEq VARCHAR(2),
   nroTitulosEq   VARCHAR(3),
   
   CONSTRAINT PK_EQUIPE
      PRIMARY KEY (cnpjClube, nomeEq),
   
   CONSTRAINT FK_CLUBE_EQUIPE FOREIGN KEY (cnpjClube)
      REFERENCES clube(cnpjClube)
         ON DELETE CASCADE
);

-- Campeonato table
CREATE TABLE campeonato (
   idCamp           VARCHAR(4) NOT NULL,
   nomeCamp         VARCHAR(50) NOT NULL,
   anoCamp          VARCHAR(4) NOT NULL,
   divisaoCamp      VARCHAR(1) NOT NULL,
   abrangenciaCamp  VARCHAR(20),
   cnpjClubeVence   VARCHAR(14) DEFAULT '-1',
   nomeEqVence      VARCHAR(50),
   
   pontosVitoria    VARCHAR(3),
   pontosEmpate     VARCHAR(3),
   
   CONSTRAINT PK_CAMPEONATO 
      PRIMARY KEY (idCamp),
   
   CONSTRAINT SK_CAMPEONATO
      UNIQUE (nomeCamp, anoCamp, divisaoCamp),
    
   CONSTRAINT FK_EQUIPE_CAMPEONATO FOREIGN KEY (cnpjClubeVence, nomeEqVence)
      REFERENCES equipe (cnpjClube, nomeEq), 
        
   CONSTRAINT CK_Campeonato
      CHECK (UPPER(abrangenciaCamp) IN (UPPER('regional'), UPPER('municipal'), UPPER('estadual'), UPPER('nacional'), UPPER('internacional')))
);

-- EqInscreveCamp table
CREATE TABLE EqInscreveCamp (
   cnpjClube  VARCHAR(14) NOT NULL,
   nomeEq     VARCHAR(50) NOT NULL,
   idCamp     VARCHAR(4) NOT NULL,   
   pontos     VARCHAR(4),
   saldoGols  VARCHAR(2),
   lucro      NUMERIC(10,2),
   
   CONSTRAINT PK_EQINSCREVECAMP 
      PRIMARY KEY (cnpjClube, nomeEq, idCamp),
   
   CONSTRAINT FK_EQUIPE_EQINSCREVECAMP FOREIGN KEY (cnpjClube, nomeEq)
      REFERENCES equipe(cnpjClube, nomeEq)
         ON DELETE CASCADE,   
       
   CONSTRAINT FK_CAMPEONATO_EQINSCREVECAMP FOREIGN KEY (idCamp)
      REFERENCES campeonato(idCamp)
         ON DELETE CASCADE
);

-- Classificacao table
CREATE TABLE classificacao (
   idCamp         VARCHAR(4) NOT NULL,
   cnpjClube      VARCHAR(14) NOT NULL,
   nomeEq         VARCHAR(50) NOT NULL,
   pontosVitoria  VARCHAR(2) DEFAULT '0',
   pontosEmpate   VARCHAR(2) DEFAULT '0',
   pontosDerrota  VARCHAR(2) DEFAULT '0',
   pontosGanhos   VARCHAR(2) DEFAULT '0',
   saldoGols      VARCHAR(3) DEFAULT '0',
   
   CONSTRAINT PK_CLASSIFICACAO
    PRIMARY KEY (idCamp, cnpjClube, nomeEq),
    
   CONSTRAINT FK_EQ1_INSCREVE_CAMP_CLA FOREIGN KEY (idCamp, cnpjClube, nomeEq)
      REFERENCES eqInscreveCamp (idCamp, cnpjClube, nomeEq)
        ON DELETE CASCADE
);

-- Partida table
CREATE TABLE partida(
   idCamp             VARCHAR(4) NOT NULL, 
   nroPartida         VARCHAR(3) NOT NULL, 
   cnpjClubeMandante  VARCHAR(14),
   nomeEqMandante     VARCHAR(50) NOT NULL,
   cnpjClubeVisitante VARCHAR(14), 
   nomeEqVisitante    VARCHAR(50) NOT NULL, 
   dataHoraPartida    TIMESTAMP, 
   valorIngresso      NUMERIC(10,2), 
   nroTorcedores      VARCHAR(6), 
   nomeEst            VARCHAR(50) NOT NULL,

   CONSTRAINT PK_PARTIDA PRIMARY KEY (idCamp, nroPartida),
   
   CONSTRAINT FK_EQ1_INSCREVE_CAMP_PARTIDA FOREIGN KEY (idCamp, cnpjClubeMandante, nomeEqMandante)
      REFERENCES eqInscreveCamp (idCamp, cnpjClube, nomeEq),

   CONSTRAINT FK_EQUIPE2_PARTICIPA FOREIGN KEY (idCamp, cnpjClubeVisitante, nomeEqVisitante)
      REFERENCES eqInscreveCamp (idCamp, cnpjClube, nomeEq),

   CONSTRAINT FK_ESTADIO_PARTICIPA FOREIGN KEY (nomeEst)
      REFERENCES estadio (nomeEst)
);

-- Res table
CREATE TABLE res (
   idCamp             VARCHAR(4) NOT NULL, 
   nroPartida         VARCHAR(3) NOT NULL, 
   cnpjClubeMandante  VARCHAR(14),
   nomeEqMandante     VARCHAR(50) NOT NULL,
   cnpjClubeVisitante VARCHAR(14), 
   nomeEqVisitante    VARCHAR(50) NOT NULL, 
   dataHoraPartida    TIMESTAMP, 
   nomeEst            VARCHAR(50) NOT NULL,
   golsMandante       VARCHAR(2) DEFAULT '0', 
   golsVisitante      VARCHAR(2) DEFAULT '0',
   timeVencedor       VARCHAR(14),
   timePerdedor       VARCHAR(14),
   
   CONSTRAINT PK_res PRIMARY KEY (idCamp, nroPartida),

   CONSTRAINT FK_Partida_Res FOREIGN KEY (idCamp, nroPartida)
      REFERENCES Partida (idCamp, nroPartida)
         ON DELETE CASCADE
);

-- Arbitra table
CREATE TABLE arbitra (
   cpfArb       VARCHAR(11) NOT NULL,
   idCamp       VARCHAR(4) NOT NULL,
   nroPartida   VARCHAR(3) NOT NULL,
   funcao       VARCHAR(30),
   pagamento    NUMERIC(10,2) NOT NULL,
   
   CONSTRAINT PK_ARBITRA
      PRIMARY KEY (cpfArb, idCamp, nroPartida),    
   
   CONSTRAINT FK_ARBITRO_ARBITRA FOREIGN KEY (cpfArb)  
      REFERENCES arbitro(cpfArb),

   CONSTRAINT FK_PARTIDA_ARBITRA FOREIGN KEY (idCamp, nroPartida)
      REFERENCES partida(idCamp, nroPartida)
         ON DELETE CASCADE,
      
   CONSTRAINT CK_Arbitra
      CHECK (UPPER(funcao) in (UPPER('arbitro'), UPPER('bandeirinha')))   
);

-- Treinador table
CREATE TABLE treinador(
   cpfTreinador   VARCHAR(11) NOT NULL,
   cnpjClube      VARCHAR(14) NOT NULL, 
   nomeEq         VARCHAR(50) NOT NULL, 
   dataInicTreina DATE NOT NULL, 
   dataFimTreina  DATE,
   salarioTreina  NUMERIC(10,2) NOT NULL, 
   funcaoTreina   CHAR(9),

   CONSTRAINT PK_TREINADOR PRIMARY KEY (cpfTreinador, cnpjClube, nomeEq, dataInicTreina),
   
   CONSTRAINT FK_MEMBRO_TREINADOR FOREIGN KEY (cpfTreinador)
      REFERENCES membro (cpfMembro)
         ON DELETE CASCADE,

   CONSTRAINT FK_EQUIPE_TREINADOR FOREIGN KEY (cnpjClube, nomeEq)
      REFERENCES equipe (cnpjClube, nomeEq)
         ON DELETE CASCADE,

   CONSTRAINT CK_FUNCAOTREINA_MEMBRO
      CHECK (UPPER(funcaoTreina) IN (('PRINCIPAL'),('INTERINO')))      
);

-- Jogador table
CREATE TABLE jogador(
   cpfJogador     VARCHAR(11) NOT NULL, 
   cnpjClube      VARCHAR(14) NOT NULL, 
   nomeEq         VARCHAR(50) NOT NULL, 
   dataInicJog    DATE NOT NULL, 
   dataFimJog     DATE, 
   salarioJog     NUMERIC(10,2) NOT NULL,

   CONSTRAINT PK_JOGADOR PRIMARY KEY (cpfJogador, cnpjClube, nomeEq, dataInicJog),

   CONSTRAINT FK_MEMBRO_JOGADOR FOREIGN KEY (cpfJogador)
      REFERENCES membro (cpfMembro)
         ON DELETE CASCADE,

   CONSTRAINT FK_EQUIPE_JOGADOR FOREIGN KEY (cnpjClube, nomeEq)
      REFERENCES equipe (cnpjClube, nomeEq)
         ON DELETE CASCADE
);

-- Participa table
CREATE TABLE participa(
   cpfJogador     VARCHAR(11) NOT NULL, 
   cnpjClube      VARCHAR(14) NOT NULL, 
   nomeEq         VARCHAR(50) NOT NULL, 
   dataInicJog    DATE NOT NULL, 
   idCamp         VARCHAR(4) NOT NULL, 
   nroPartida     VARCHAR(2) NOT NULL,
   nroFaltas      INTEGER, 
   nroCamisa      INTEGER, 
   posicao        VARCHAR(20) NOT NULL, 
   golsPro        INTEGER, 
   golsContra     INTEGER, 
   cartaoAmarelo  INTEGER,
   cartaoVermelho INTEGER,

   CONSTRAINT PK_PARTICIPA
      PRIMARY KEY (cpfJogador, cnpjClube, nomeEq, dataInicJog, idCamp, nroPartida),
   
   CONSTRAINT FK_JOGADOR_PARTICIPA FOREIGN KEY (cpfJogador, cnpjClube, nomeEq, dataInicJog)
      REFERENCES jogador (cpfJogador, cnpjClube, nomeEq, dataInicJog)
        ON DELETE CASCADE,

   CONSTRAINT FK_PARTIDA_PARTICIPA FOREIGN KEY (idCamp, nroPartida)
      REFERENCES partida (idCamp, nroPartida)
         ON DELETE CASCADE,
      
   CONSTRAINT CK_POSICAO_PARTICIPA
      CHECK (UPPER(posicao) IN (UPPER('goleiro'), UPPER('zagueiro'), UPPER('meio-campista'), UPPER('lateral'), UPPER('atacante'))),    
    
   CONSTRAINT CK_INTERVAL_PARTICIPA
      CHECK (nroFaltas >= 0 AND nroCamisa >=0 AND golsPro >= 0 AND golsContra  >= 0 AND cartaoAmarelo >= 0 AND cartaoVermelho  >= 0)
);

/* Populate tables */

-- Insert into admin table
INSERT INTO admuser VALUES ('admin@pw.com', '0c00279d061297cf5d71078eed1a7451', 'Administrador PW');
INSERT INTO admuser VALUES ('gasparsigma@gmail.com', '0c00279d061297cf5d71078eed1a7451', 'Admin Thiago');

-- Insert into patrocinador table
INSERT INTO patrocinador VALUES(16701716000156, 'Fiat Automoveis SA', 'Fiat');
INSERT INTO patrocinador VALUES(54428040000168, 'Semp Toshiba Informatica LTDA' , 'STI'); 
INSERT INTO patrocinador VALUES(00801450000264, 'LG Electronics da Amazonia LTDA', 'LG'); 
INSERT INTO patrocinador VALUES(71476527000135, 'Construtora Tenda SA', 'Tenda'); 
INSERT INTO patrocinador VALUES(92702067000196, 'Banco do Estado do Rio Grande do Sul SA', 'Banrisul'); 
INSERT INTO patrocinador VALUES(08343492000120, 'MRV Engenharia e Participaaaes SA', 'MRV'); 

-- Insert into clube table
INSERT INTO clube VALUES (11111111111111, 'Cruzeiro Esporte Clube', 'Cruzeiro','/');
INSERT INTO clube VALUES (22222222222222, 'Sao Paulo Futebol Clube', 'Sao Paulo','/');
INSERT INTO clube VALUES (33333333333333, 'Palmeiras Futebol Clube', 'Palmeiras','/');
INSERT INTO clube VALUES (44444444444444, 'Santos Futebol Clube', 'Santos','/');
INSERT INTO clube VALUES (55555555555555, 'Clube Atlatico Mineiro', 'Atlatico - MG','/');
INSERT INTO clube VALUES (66666666666666, 'Club de Regatas Vasco da Gama', 'Vasco','/');
INSERT INTO clube VALUES (77777777777777, 'Gramio Foot-ball Porto Alegrense', 'Gramio','/');

-- Insert into estadio table
INSERT INTO estadio VALUES ('Estadio Cacero Pompeu de Toledo', 73501, 2000000.00);
INSERT INTO estadio VALUES ('Palestra Italia', 29876, 1500000.00);
INSERT INTO estadio VALUES ('Vila Belmiro', 20120, 750000.00);
INSERT INTO estadio VALUES ('Estadio Governador Magalhaes Pinto', 76500, 3000000.00);
INSERT INTO estadio VALUES ('Sao Januario', 36000, 750000.00);
INSERT INTO estadio VALUES ('Estadio Olampico Monumental', 45000, 300000.00);

-- Insert into arbitro table
INSERT INTO arbitro VALUES(11111111111, 'Luis Antanio Silva Santos',   'Luis');
INSERT INTO arbitro VALUES(22222222222, 'Ediney Guerreiro Mascarenhas', 'Ediney');
INSERT INTO arbitro VALUES(33333333333, 'Jackson Lourenao Massara dos Santos', 'Jackson');

INSERT INTO arbitro VALUES(44444444444, 'Pericles Bassols Pegado Cortez', 'Pericles');
INSERT INTO arbitro VALUES(55555555555, 'Dibert Pedrosa Moises', 'Dibert');
INSERT INTO arbitro VALUES(66666666666, 'Ricardo Mauricio Ferreira de Almeida', 'Ricardo');

INSERT INTO arbitro VALUES(77777777777, 'Carlos Euganio Simon', 'Carlos');
INSERT INTO arbitro VALUES(88888888888, 'Emerson Augusto de Carvalho', 'Emerson');
INSERT INTO arbitro VALUES(99999999999, 'Carlos Augusto Nogueira Junior', 'Carlos');

INSERT INTO arbitro VALUES(15555555555, 'Giuliano Bozanno', 'Giuliano');
INSERT INTO arbitro VALUES(16666666666, 'Milton Otaviano dos Santos', 'Milton');
INSERT INTO arbitro VALUES(17777777777, 'Cleiton Clay Barreto Rios', 'Cleiton');

INSERT INTO arbitro VALUES(12222222222, 'Evandro Rogario Roman', 'Evandro');
INSERT INTO arbitro VALUES(13333333333, 'Roberto Braatz', 'Roberto');
INSERT INTO arbitro VALUES(14444444444, 'Jesmar Benedito Miranda de Paula', 'Jesmar');

-- Insert into membro table
INSERT INTO membro VALUES (301234567, 'Diego Renan de Lima Ferreira', 'Diego Renan', 0, 1); 
INSERT INTO membro VALUES (311234567, 'Patric Cabral Lalau', 'Patric', 0, 1);
INSERT INTO membro VALUES (321234567, 'Leonardo Fortunato dos Santos', 'Lao Fortunato', 0, 1);

INSERT INTO membro VALUES (331234567, 'Rogario Ceni', 'Rogario Ceni', 0, 1);
INSERT INTO membro VALUES (341234567, 'Joao Bosco de Freitas Chaves', 'Bosco', 0, 1);
INSERT INTO membro VALUES (351234567, 'Rodrigo Costa', 'Rodrigo', 0, 1);

INSERT INTO membro VALUES (361234567, 'Marcos Roberto Silveira Reis', 'Marcos', 0, 1);
INSERT INTO membro VALUES (371234567, 'Jefferson Nascimento', 'Jefferson', 0, 1);
INSERT INTO membro VALUES (381234567, 'Lucas Pierre Santos Oliveira', 'Pierre', 0, 1);

INSERT INTO membro VALUES (391234567, 'Fabio Costa', 'Fabio', 0, 1);
INSERT INTO membro VALUES (401234567, 'Paulo Henrique Rodrigues', 'Paulo', 0, 1);
INSERT INTO membro VALUES (411234567, 'George Lucas', 'George', 0, 1);

INSERT INTO membro VALUES (421234567, 'Bruno de Carlo Fuso', 'Bruno', 0, 1);
INSERT INTO membro VALUES (431234567, 'Dyego Rocha Coelho', 'Coelho', 0, 1);
INSERT INTO membro VALUES (441234567, 'Samuel Elias do Carmo Soares', 'Samuel', 0, 1);

INSERT INTO membro VALUES (451234567, 'Fernando Battenbender Prass ', 'Fernando Prass', 0, 1);
INSERT INTO membro VALUES (461234567, 'Fagner Conserva Lemos', 'Fagner', 0, 1);
INSERT INTO membro VALUES (471234567, 'Erinaldo Santos Rabelo', 'Para', 0, 1);

INSERT INTO membro VALUES (481234567, 'Alessandro Felipe Oltramari', 'Alessandro', 0, 1);
INSERT INTO membro VALUES (491234567, 'Raver Humberto Alves de Araajo', 'Raver', 0, 1);
INSERT INTO membro VALUES (501234567, 'Josa Jadalson dos Santos Silva', 'Jadalson', 0, 1);

INSERT INTO membro VALUES (101234567, 'Adalson Dias Batista', 'Adalson Batista', 1, 0);
INSERT INTO membro VALUES (111234567, 'Muricy Ramalho', 'Muricy', 1, 0);
INSERT INTO membro VALUES (121234567, 'Vanderlei Luxemburgo', 'Luxemburgo', 1, 0);
INSERT INTO membro VALUES (131234567, 'Marcio Fernandes', 'Marcio', 1, 0);
INSERT INTO membro VALUES (141234567, 'Alexandre Tadeu Gallo', 'Alexandre', 1, 0);
INSERT INTO membro VALUES (151234567, 'Romario de Souza Faria', 'Romario', 1, 0);
INSERT INTO membro VALUES (161234567, 'Danilo Rios', 'Danilo', 1, 0);

-- Insert into patrocinio table
INSERT INTO patrocinio VALUES(16701716000156, 33333333333333, TO_DATE('08/12/2006', 'DD/MM/YYYY'), TO_DATE('30/12/2009', 'DD/MM/YYYY'), 42000.00);
INSERT INTO patrocinio VALUES(54428040000168, 44444444444444, TO_DATE('13/02/2005', 'DD/MM/YYYY'), TO_DATE('09/11/2009', 'DD/MM/YYYY'), 38000.00); 
INSERT INTO patrocinio VALUES(00801450000264, 22222222222222, TO_DATE('22/04/2006', 'DD/MM/YYYY'), TO_DATE('06/02/2010', 'DD/MM/YYYY'), 56000.00); 
INSERT INTO patrocinio VALUES(71476527000135, 11111111111111, TO_DATE('05/07/2007', 'DD/MM/YYYY'), TO_DATE('25/04/2009', 'DD/MM/YYYY'), 60000.00); 
INSERT INTO patrocinio VALUES(92702067000196, 77777777777777, TO_DATE('17/11/2006', 'DD/MM/YYYY'), TO_DATE('11/07/2010', 'DD/MM/YYYY'), 16000.00); 
INSERT INTO patrocinio VALUES(08343492000120, 66666666666666, TO_DATE('01/01/2008', 'DD/MM/YYYY'), TO_DATE('21/10/2010', 'DD/MM/YYYY'), 12000.00); 
INSERT INTO patrocinio VALUES(08343492000120, 55555555555555, TO_DATE('21/12/2007', 'DD/MM/YYYY'), TO_DATE('23/05/2010', 'DD/MM/YYYY'), 30000.00); 

-- Insert into clubepossuiEst table
INSERT INTO clubepossuiEst VALUES (11111111111111, 'Estadio Governador Magalhaes Pinto');
INSERT INTO clubepossuiEst VALUES (22222222222222, 'Estadio Cacero Pompeu de Toledo');
INSERT INTO clubepossuiEst VALUES (33333333333333, 'Palestra Italia');
INSERT INTO clubepossuiEst VALUES (44444444444444, 'Vila Belmiro');
INSERT INTO clubepossuiEst VALUES (55555555555555, 'Estadio Governador Magalhaes Pinto');
INSERT INTO clubepossuiEst VALUES (66666666666666, 'Sao Januario');
INSERT INTO clubepossuiEst VALUES (77777777777777, 'Estadio Olampico Monumental');

-- Insert into equipe table
INSERT INTO equipe VALUES (11111111111111, 'Oficial', 3, 70);
INSERT INTO equipe VALUES (22222222222222, 'Oficial', 3, 81);
INSERT INTO equipe VALUES (33333333333333, 'Oficial', 3, 80);
INSERT INTO equipe VALUES (44444444444444, 'Oficial', 3, 75);
INSERT INTO equipe VALUES (55555555555555, 'Oficial', 3, 70);
INSERT INTO equipe VALUES (66666666666666, 'Oficial', 3, 68);
INSERT INTO equipe VALUES (77777777777777, 'Oficial', 3, 76);

-- Insert into campeonato table
INSERT INTO campeonato VALUES (nextval('idCampSeq'), 'Campeonato Brasileiro', 2008, 1, 'nacional', 11111111111111, 'Oficial');
INSERT INTO campeonato VALUES (nextval('idCampSeq'), 'Campeonato Paulista', 2008, 1, 'regional', 22222222222222, 'Oficial');

-- Insert into EqInscreveCamp table
INSERT INTO EqInscreveCamp VALUES (11111111111111, 'Oficial', 0001, 00, 00, 480000.00);
INSERT INTO EqInscreveCamp VALUES (22222222222222, 'Oficial', 0001, 00, 00, 819157.00);
INSERT INTO EqInscreveCamp VALUES (33333333333333, 'Oficial', 0001, 00, 00, 896512.00);
INSERT INTO EqInscreveCamp VALUES (44444444444444, 'Oficial', 0001, 00, 00, 284376.00);
INSERT INTO EqInscreveCamp VALUES (55555555555555, 'Oficial', 0001, 00, 00, 631400.00);
INSERT INTO EqInscreveCamp VALUES (66666666666666, 'Oficial', 0001, 00, 00, 425310.00);
INSERT INTO EqInscreveCamp VALUES (77777777777777, 'Oficial', 0001, 00, 00, 000000.00);
INSERT INTO EqInscreveCamp VALUES (22222222222222, 'Oficial', 0002, 00, 00, 000000.00);
INSERT INTO EqInscreveCamp VALUES (66666666666666, 'Oficial', 0002, 00, 00, 000000.00);

-- Insert into partida table
INSERT INTO partida VALUES(0001, 01, 22222222222222, 'Oficial', 77777777777777, 'Oficial', TO_TIMESTAMP('10/05/2008 18:30', 'DD/MM/YYYY HH24:MI'), 18.00, 7929, 'Estadio Cacero Pompeu de Toledo');
INSERT INTO partida VALUES(0001, 02, 11111111111111, 'Oficial', 44444444444444, 'Oficial', TO_TIMESTAMP('25/05/2008 16:00', 'DD/MM/YYYY HH24:MI'), 20.00, 8000, 'Estadio Governador Magalhaes Pinto');
INSERT INTO partida VALUES(0001, 03, 66666666666666, 'Oficial', 77777777777777, 'Oficial', TO_TIMESTAMP('31/05/2008 18:10', 'DD/MM/YYYY HH24:MI'), 17.00, 4810, 'Sao Januario');
INSERT INTO partida VALUES(0001, 04, 44444444444444, 'Oficial', 22222222222222, 'Oficial', TO_TIMESTAMP('01/06/2008 16:00', 'DD/MM/YYYY HH24:MI'), 16.00, 7298, 'Vila Belmiro');
INSERT INTO partida VALUES(0001, 05, 22222222222222, 'Oficial', 55555555555555, 'Oficial', TO_TIMESTAMP('07/06/2008 18:20', 'DD/MM/YYYY HH24:MI'), 10.00, 7609, 'Estadio Cacero Pompeu de Toledo');
INSERT INTO partida VALUES(0001, 06, 11111111111111, 'Oficial', 66666666666666, 'Oficial', TO_TIMESTAMP('08/06/2008 18:10', 'DD/MM/YYYY HH24:MI'), 20.00, 8000, 'Estadio Governador Magalhaes Pinto');
INSERT INTO partida VALUES(0001, 07, 33333333333333, 'Oficial', 11111111111111, 'Oficial', TO_TIMESTAMP('12/06/2008 20:30', 'DD/MM/YYYY HH24:MI'), 15.00, 6272, 'Palestra Italia');
INSERT INTO partida VALUES(0001, 08, 66666666666666, 'Oficial', 33333333333333, 'Oficial', TO_TIMESTAMP('22/07/2008 16:00', 'DD/MM/YYYY HH24:MI'), 17.00, 4810, 'Sao Januario');
INSERT INTO partida VALUES(0001, 09, 11111111111111, 'Oficial', 22222222222222, 'Oficial', TO_TIMESTAMP('29/06/2008 16:00', 'DD/MM/YYYY HH24:MI'), 20.00, 8000, 'Estadio Governador Magalhaes Pinto');
INSERT INTO partida VALUES(0001, 10, 55555555555555, 'Oficial', 33333333333333, 'Oficial', TO_TIMESTAMP('06/07/2008 16:00', 'DD/MM/YYYY HH24:MI'), 20.00, 31570,'Palestra Italia');
INSERT INTO partida VALUES(0001, 11, 44444444444444, 'Oficial', 77777777777777, 'Oficial', TO_TIMESTAMP('09/07/2008 21:45', 'DD/MM/YYYY HH24:MI'), 07.00, 10138,'Vila Belmiro');
INSERT INTO partida VALUES(0001, 12, 22222222222222, 'Oficial', 33333333333333, 'Oficial', TO_TIMESTAMP('13/07/2008 16:00', 'DD/MM/YYYY HH24:MI'), 27, 22235,'Estadio Cacero Pompeu de Toledo');
INSERT INTO partida VALUES(0001, 13, 33333333333333, 'Oficial', 44444444444444, 'Oficial', TO_TIMESTAMP('24/07/2008 20:30', 'DD/MM/YYYY HH24:MI'), 20.00, 8000, 'Palestra Italia');
INSERT INTO partida VALUES(0001, 14, 44444444444444, 'Oficial', 66666666666666, 'Oficial', TO_TIMESTAMP('26/07/2008 16:00', 'DD/MM/YYYY HH24:MI'), 09.00, 10738,'Vila Belmiro');
INSERT INTO partida VALUES(0001, 15, 66666666666666, 'Oficial', 55555555555555, 'Oficial', TO_TIMESTAMP('31/07/2008 20:30', 'DD/MM/YYYY HH24:MI'), 17.00, 4810, 'Sao Januario');
INSERT INTO partida VALUES(0001, 16, 33333333333333, 'Oficial', 66666666666666, 'Oficial', TO_TIMESTAMP('21/09/2008 18:10', 'DD/MM/YYYY HH24:MI'), 28, 22944,'Palestra Italia');
INSERT INTO partida VALUES(0002, 1, 22222222222222, 'Oficial', 66666666666666, 'Oficial', TO_TIMESTAMP('21/09/2008 18:10', 'DD/MM/YYYY HH24:MI'), 28, 22944,'Palestra Italia');

-- Insert into arbitra table
INSERT INTO arbitra VALUES(11111111111, 0001, 01, 'arbitro', 10000.00);
INSERT INTO arbitra VALUES(22222222222, 0001, 01, 'bandeirinha', 9000.00);
INSERT INTO arbitra VALUES(33333333333, 0001, 01, 'bandeirinha', 9000.00);

INSERT INTO arbitra VALUES(44444444444, 0001, 05, 'arbitro', 10000.00);
INSERT INTO arbitra VALUES(55555555555, 0001, 05, 'bandeirinha', 9000.00);
INSERT INTO arbitra VALUES(66666666666, 0001, 05, 'bandeirinha', 9000.00);

INSERT INTO arbitra VALUES(77777777777, 0001, 11, 'arbitro', 10000.00);
INSERT INTO arbitra VALUES(88888888888, 0001, 11, 'bandeirinha', 9000.00);
INSERT INTO arbitra VALUES(99999999999, 0001, 11, 'bandeirinha', 9000.00);

INSERT INTO arbitra VALUES(15555555555, 0001, 13, 'arbitro', 10000.00);
INSERT INTO arbitra VALUES(16666666666, 0001, 13, 'bandeirinha', 9000.00);
INSERT INTO arbitra VALUES(17777777777, 0001, 13, 'bandeirinha', 9000.00);

INSERT INTO arbitra VALUES(12222222222, 0001, 15, 'arbitro', 10000.00);
INSERT INTO arbitra VALUES(13333333333, 0001, 15, 'bandeirinha', 9000.00);
INSERT INTO arbitra VALUES(14444444444, 0001, 15, 'bandeirinha', 9000.00);

-- Insert into treinador table
INSERT INTO treinador VALUES (101234567, 11111111111111, 'Oficial', TO_DATE('19/03/2007', 'DD/MM/YYYY'), TO_DATE('19/04/2011', 'DD/MM/YYYY'), 50000.00, 'Principal');
INSERT INTO treinador VALUES (111234567, 22222222222222, 'Oficial', TO_DATE('20/06/2007', 'DD/MM/YYYY'), TO_DATE('19/03/2010', 'DD/MM/YYYY'), 10000.00, 'Principal');
INSERT INTO treinador VALUES (121234567, 33333333333333, 'Oficial', TO_DATE('10/05/2007', 'DD/MM/YYYY'), TO_DATE('19/02/2009', 'DD/MM/YYYY'), 11000.00, 'Principal');
INSERT INTO treinador VALUES (131234567, 44444444444444, 'Oficial', TO_DATE('14/06/2006', 'DD/MM/YYYY'), TO_DATE('19/01/2010', 'DD/MM/YYYY'), 10000.00, 'Principal');
INSERT INTO treinador VALUES (141234567, 55555555555555, 'Oficial', TO_DATE('14/11/2005', 'DD/MM/YYYY'), TO_DATE('19/05/2010', 'DD/MM/YYYY'), 11000.00, 'Interino');
INSERT INTO treinador VALUES (151234567, 66666666666666, 'Oficial', TO_DATE('21/12/2007', 'DD/MM/YYYY'), TO_DATE('19/04/2009', 'DD/MM/YYYY'), 19000.00, 'Interino');
INSERT INTO treinador VALUES (161234567, 77777777777777, 'Oficial', TO_DATE('10/10/2007', 'DD/MM/YYYY'), TO_DATE('19/07/2009', 'DD/MM/YYYY'), 12000.00, 'Interino'); 

-- Insert into jogador table
INSERT INTO jogador VALUES (301234567, 11111111111111, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 10000.00);
INSERT INTO jogador VALUES (311234567, 11111111111111, 'Oficial', TO_DATE('10/07/2001', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 300000.00);
INSERT INTO jogador VALUES (321234567, 11111111111111, 'Oficial', TO_DATE('20/06/2002', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 1500000.00);

INSERT INTO jogador VALUES (331234567, 22222222222222, 'Oficial', TO_DATE('20/03/2004', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 10000.00);
INSERT INTO jogador VALUES (341234567, 22222222222222, 'Oficial', TO_DATE('14/08/2006', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 150000.00);
INSERT INTO jogador VALUES (351234567, 22222222222222, 'Oficial', TO_DATE('04/07/2000', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 1000000.00);

INSERT INTO jogador VALUES (361234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), TO_DATE('08/07/2009', 'DD/MM/YYYY'), 10000.00);
INSERT INTO jogador VALUES (371234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), TO_DATE('08/07/2009', 'DD/MM/YYYY'), 100000.00);
INSERT INTO jogador VALUES (381234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), TO_DATE('08/07/2009', 'DD/MM/YYYY'), 1000000.00);

INSERT INTO jogador VALUES (391234567, 44444444444444, 'Oficial', TO_DATE('08/07/2006', 'DD/MM/YYYY'), TO_DATE('30/12/2008', 'DD/MM/YYYY'), 10000.00);
INSERT INTO jogador VALUES (401234567, 44444444444444, 'Oficial', TO_DATE('09/06/2004', 'DD/MM/YYYY'), TO_DATE('30/12/2008', 'DD/MM/YYYY'), 150000.00);
INSERT INTO jogador VALUES (411234567, 44444444444444, 'Oficial', TO_DATE('15/05/2002', 'DD/MM/YYYY'), TO_DATE('12/12/2008', 'DD/MM/YYYY'), 1000000.00);

INSERT INTO jogador VALUES (421234567, 55555555555555, 'Oficial', TO_DATE('30/07/2001', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 10000.00);
INSERT INTO jogador VALUES (431234567, 55555555555555, 'Oficial', TO_DATE('12/12/2002', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 100000.00);
INSERT INTO jogador VALUES (441234567, 55555555555555, 'Oficial', TO_DATE('08/07/2003', 'DD/MM/YYYY'), TO_DATE('08/07/2010', 'DD/MM/YYYY'), 1000000.00);

INSERT INTO jogador VALUES (451234567, 66666666666666, 'Oficial', TO_DATE('08/07/2007', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 50000.00);
INSERT INTO jogador VALUES (461234567, 66666666666666, 'Oficial', TO_DATE('08/07/2004', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 100000.00);
INSERT INTO jogador VALUES (471234567, 66666666666666, 'Oficial', TO_DATE('07/11/2003', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 1000000.00);

INSERT INTO jogador VALUES (481234567, 77777777777777, 'Oficial', TO_DATE('20/07/2001', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 60000.00);
INSERT INTO jogador VALUES (491234567, 77777777777777, 'Oficial', TO_DATE('18/07/2007', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 100000.00);
INSERT INTO jogador VALUES (501234567, 77777777777777, 'Oficial', TO_DATE('19/03/2002', 'DD/MM/YYYY'), TO_DATE('08/07/2011', 'DD/MM/YYYY'), 1000000.00);
