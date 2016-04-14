/* 
 * Script to create triggers.
 *
 * 2009-2016
 *
 */

---- Trigger 1 ----
/*
  Trigger used to update the table Res each time the user insert, remove or update the 
  table Participa.  
*/
CREATE TRIGGER resultJogos
AFTER INSERT OR DELETE OR UPDATE OF golsPro, golsContra
ON Participa
REFERENCING OLD AS antigo NEW AS novo
FOR EACH ROW
DECLARE
  clubeMand Res.cnpjClubeMandante%Type;
  clubeVisi Res.cnpjClubeVisitante%Type;
  cnpjClube Res.cnpjClubeVisitante%Type;
  nomeEq Res.nomeEqVisitante%Type;
  eqMand Res.nomeEqMandante%Type;
  eqVisi Res.nomeEqVisitante%Type;
  dataHoraP Res.dataHoraPartida%Type;
  nroPart Res.nroPartida%Type;
  idCamp Res.idCamp%Type;
  nroPartida Res.nroPartida%Type;
  nomeEst Res.nomeEst%Type;
  golsM Res.golsMandante%Type;
  golsV Res.golsVisitante%Type;
  timeVenc Res.timeVencedor%Type; 
  timePerd Res.timePerdedor%Type;
  flag NUMBER;                    
  atualizar NUMBER;            
  
BEGIN
  flag := 0; 
  atualizar := 1;
  
  /*
    Verifica se essa partida j� est� cadastrada em Res pegando informa��es �teis.
  */
  IF (inserting OR updating) THEN
    SELECT R.idCamp, R.nroPartida, R.cnpjClubeMandante, R.nomeEqMandante, R.cnpjClubeVisitante, R.nomeEqVisitante, R.golsMandante, R.golsVisitante
    INTO idCamp, nroPartida, clubeMand, eqVisi, clubeVisi, eqMand, golsM, golsV
    FROM Res R
    WHERE R.idCamp = :novo.idCamp AND
          R.nroPartida = :novo.nroPartida;
          
    cnpjClube := :novo.cnpjClube;
    nomeEq := :novo.nomeEq;
    flag := 1;
  ELSE
    SELECT R.idCamp, R.nroPartida, R.cnpjClubeMandante, R.nomeEqMandante, R.cnpjClubeVisitante, R.nomeEqVisitante, R.golsMandante, R.golsVisitante
    INTO idCamp, nroPartida, clubeMand, eqVisi, clubeVisi, eqMand, golsM, golsV
    FROM Res R
    WHERE R.idCamp = :antigo.idCamp AND
          R.nroPartida = :antigo.nroPartida; 
    
    cnpjClube := :antigo.cnpjClube;
    nomeEq := :antigo.nomeEq;
    flag := 1;
  END IF; 
  /* 
    Se a partida j� est� cadastrada em Res continua o processo.
  */
  IF flag = 1 THEN
    /*
      Se o clube modificado em Participa for o mandante da partida 
      ele recebe os gols pr�s do respectivo jogador cadastrado. E o 
      clube visitante recebe os poss�veis gols contra.
      Os gols s�o adicionados ou subtra�dos dependendo do caso.
    */
    IF (cnpjClube = clubeMand) AND (nomeEq = eqMand) THEN
      IF updating THEN
        golsM := (golsM - :antigo.golsPro) + :novo.golsPro;
        golsV := (golsV - :antigo.golsContra) + :novo.golsContra;
      ELSIF deleting THEN
        golsM := golsM - :antigo.golsPro;
        golsV := golsV - :antigo.golsContra;
      ELSE
        golsM := golsM + :novo.golsPro;
        golsV := golsV + :novo.golsContra;
      END IF;
    /*
      Se o clube modificado em Participa for o visitante da partida 
      ele recebe os gols pr�s do respectivo jogador cadastrado. E o 
      clube mandante recebe os poss�veis gols contra.
      Os gols s�o adicionados ou subtra�dos dependendo do caso.
    */
    ELSIF (cnpjClube = clubeVisi) AND (nomeEq = eqVisi) THEN
      IF updating THEN
        golsV := (golsV - :antigo.golsPro) + :novo.golsPro;
        golsM := (golsM - :antigo.golsContra) + :novo.golsContra;
      ELSIF deleting THEN
        golsV := golsV - :antigo.golsPro;
        golsM := golsM - :antigo.golsContra;
      ELSE
        golsV := golsV + :novo.golsPro;
        golsM := golsM + :novo.golsContra;
      END IF;
    ELSE
       /*
        Como a modelagem do banco permite que um usu�rio cadastre em participa��o um time que n�o tenha jogado a referida partida 
        (assumindo que o qu� est� em Partida � verdadeiro), essa verifica��o se faz necess�ria para que o resultado do jogo n�o fique
        corrompido.
       */
       dbms_output.put_line('O clube ' || cnpjClube || ' n�o jogou na partida ' || nroPartida || ' do campeonato ' || idCamp || '.');   
    END IF;
    
    /* 
      Se o n�mero de gols for inv�lido n�o atualiza.
    */
    IF ((golsM < 0) OR (golsV < 0)) THEN 
       atualizar := 0;
    END IF;
    
    IF atualizar = 1 THEN
      /*
        Verifica��o do time vencedor e perdedor ou empate (-1).
      */
      IF golsM = golsV THEN
         timeVenc := -1;
         timePerd := -1;
      ELSIF golsM > golsV THEN
         timeVenc := clubeMand;
         timePerd := clubeVisi;
      ELSE
         timeVenc := clubeVisi;
         timePerd := clubeMand;
      END IF;           
      
      IF (inserting OR updating) THEN    
        UPDATE Res R 
        SET R.golsMandante = golsM,
            R.golsVisitante = golsV,
            R.timeVencedor = timeVenc,
            R.timePerdedor = timePerd
        WHERE R.idCamp = :novo.idCamp AND
              R.nroPartida = :novo.nroPartida;
          
      ELSE
        UPDATE Res R 
        SET R.golsMandante = golsM,
            R.golsVisitante = golsV,
            R.timeVencedor = timeVenc,
            R.timePerdedor = timePerd
        WHERE R.idCamp = :antigo.idCamp AND
              R.nroPartida = :antigo.nroPartida;
      END IF;
    END IF;
  END IF;
  
  EXCEPTION
  /*
    Caso a partida n�o tenha sido cadastrada em Res, obtemos as informa��es
    referentes a ela em Partida
  */
  WHEN NO_DATA_FOUND THEN
    BEGIN
      flag := 0; -- Nesse escopo, flag recebe 1 se o clube em quest�o n�o jogou na partida informada
      
      /*
        Seleciona as informa��es da partida informada.
      */
      SELECT P.idCamp, P.nroPartida, P.cnpjClubeMandante, P.nomeEqMandante,
             P.cnpjClubeVisitante, P.nomeEqVisitante, P.dataHoraPartida, 
             P.nomeEst
      INTO idCamp, nroPartida, clubeMand, eqMand, clubeVisi, eqVisi, dataHoraP,
           nomeEst
      FROM Partida P
      WHERE P.idCamp = :novo.idCamp AND
            P.nroPartida = :novo.nroPartida; 
      /*
        Verifica��o do time vencedor, perdedor ou empate (-1).
        Nesse caso s� � preciso ver se o clube em quest�o � o mandande ou 
        visitante e assim verificar, pelo total de gols pr�s e contra, quem �
        o time vencedor.
      */
      IF (:novo.cnpjClube = clubeMand) AND (:novo.nomeEq = eqMand) THEN
        IF :novo.golsPro = :novo.golsContra THEN
          timeVenc := -1;
          timePerd := -1;
        ELSIF :novo.golsPro > :novo.golsContra THEN
          timeVenc := clubeMand;
          timePerd := clubeVisi;
        ELSE
          timeVenc := clubeVisi;
          timePerd := clubeMand;
        END IF;
        INSERT INTO Res VALUES (idCamp, nroPartida, clubeMand, eqMand, clubeVisi, eqVisi, dataHoraP, 
                                nomeEst, :novo.golsPro, :novo.golsContra, timeVenc, timePerd);
                                
      ELSIF (:novo.cnpjClube = clubeVisi) AND (:novo.nomeEq = eqVisi) THEN 
        IF :novo.golsPro = :novo.golsContra THEN
          timeVenc := -1;
          timePerd := -1;
        ELSIF :novo.golsPro > :novo.golsContra THEN
          timeVenc := clubeVisi;
          timePerd := clubeMand;
        ELSE
          timeVenc := clubeMand;
          timePerd := clubeVisi;
        END IF;
        INSERT INTO Res VALUES (idCamp, nroPartida, clubeMand, eqMand, clubeVisi, eqVisi, dataHoraP, 
                                nomeEst, :novo.golsContra, :novo.golsPro, timeVenc, timePerd);
      ELSE
        flag := 1;
      END IF;
      /*
        Se o clube n�o � o mandante, nem o visitante, ele n�o participou dessa partida.
      */
      IF (flag = 1) THEN
         dbms_output.put_line('O clube ' || :novo.cnpjClube || ' n�o jogou na partida ' || nroPartida || ' do campeonato ' || idCamp || '.');   
      END IF;
      dbms_output.put_line('Dados da partida ' || nroPartida || ' inseridos em Resultados.');
      
      EXCEPTION 
        WHEN NO_DATA_FOUND THEN
          dbms_output.put_line('Partida ' || nroPartida || ' n�o cadastrada.');
    END;    
  WHEN OTHERS THEN
     dbms_output.put_line('Erro!'); 
END;
/
---- Trigger 2 ----

/*
  Descri��o: Esta Trigger Conta o n�mero de jogadores de cada Clube na tabela Jogador, ao serem 
  realizadas inser��es ou remo��es na mesma, e em seguida atualiza o campo nroJogadoresEq
  da tabela Equipe.
*/
CREATE OR REPLACE TRIGGER nroJogadoresEquipe
  AFTER INSERT OR DELETE ON Jogador
DECLARE
  -- Este Cursor conta o n�mero de Jogadores de cada Clube 
  CURSOR resultados IS
    SELECT J.cnpjClube AS cnpjClube, COUNT(J.cpfJogador) AS nroJogadores
    FROM Jogador J
    GROUP BY J.cnpjClube;
    
  vRes          resultados%RowType;
  nroJogadores Equipe.nroJogadoresEq%Type;
BEGIN

  OPEN resultados;
    LOOP
      FETCH resultados INTO vRes;
        EXIT WHEN resultados%NOTFOUND;
      BEGIN
        UPDATE Equipe SET equipe.nroJogadoresEq = vRes.nroJogadores
          WHERE Equipe.cnpjClube =  vRes.cnpjClube;
      END;
    END LOOP;
    CLOSE resultados;
END;
/
---- Insercao de dados na tabela Participa (comentar essa parte se o script for rodado mais de uma vez)
INSERT INTO participa VALUES (491234567, 77777777777777, 'Oficial', TO_DATE('18/07/2007', 'DD/MM/YYYY'), 0001, 01, 00, 04, 'zagueiro', 01, 00, 00, 00);
INSERT INTO participa VALUES (351234567, 22222222222222, 'Oficial', TO_DATE('04/07/2000', 'DD/MM/YYYY'), 0001, 01, 00, 01, 'goleiro',  00, 00, 00, 00);
INSERT INTO participa VALUES (301234567, 11111111111111, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), 0001, 02, 02, 10, 'atacante', 01, 00, 02, 00);
INSERT INTO participa VALUES (391234567, 44444444444444, 'Oficial', TO_DATE('08/07/2006', 'DD/MM/YYYY'), 0001, 02, 00, 04, 'zagueiro', 01, 00, 00, 00);
INSERT INTO participa VALUES (341234567, 22222222222222, 'Oficial', TO_DATE('14/08/2006', 'DD/MM/YYYY'), 0001, 05, 02, 02, 'zagueiro', 03, 00, 02, 00);
INSERT INTO participa VALUES (421234567, 55555555555555, 'Oficial', TO_DATE('30/07/2001', 'DD/MM/YYYY'), 0001, 05, 02, 08, 'lateral', 01, 00, 00, 00);
INSERT INTO participa VALUES (311234567, 11111111111111, 'Oficial', TO_DATE('10/07/2001', 'DD/MM/YYYY'), 0001, 06, 03, 09, 'atacante', 01, 00, 03, 00);
INSERT INTO participa VALUES (451234567, 66666666666666, 'Oficial', TO_DATE('08/07/2007', 'DD/MM/YYYY'), 0001, 06, 00, 01, 'goleiro',  00, 00, 00, 00);
INSERT INTO participa VALUES (461234567, 66666666666666, 'Oficial', TO_DATE('08/07/2004', 'DD/MM/YYYY'), 0001, 08, 01, 02, 'zagueiro', 00, 00, 00, 00);
INSERT INTO participa VALUES (381234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), 0001, 08, 02, 06, 'meio-campista', 00, 00, 02, 00);
INSERT INTO participa VALUES (321234567, 11111111111111, 'Oficial', TO_DATE('20/06/2002', 'DD/MM/YYYY'), 0001, 09, 01, 01, 'goleiro',  01, 00, 01, 00);
INSERT INTO participa VALUES (331234567, 22222222222222, 'Oficial', TO_DATE('20/03/2004', 'DD/MM/YYYY'), 0001, 09, 01, 10, 'atacante', 02, 00, 01, 00);
INSERT INTO participa VALUES (411234567, 44444444444444, 'Oficial', TO_DATE('15/05/2002', 'DD/MM/YYYY'), 0001, 11, 03, 01, 'goleiro',  02, 00, 03, 00);
INSERT INTO participa VALUES (491234567, 77777777777777, 'Oficial', TO_DATE('18/07/2007', 'DD/MM/YYYY'), 0001, 11, 00, 04, 'zagueiro', 01, 00, 00, 00);
INSERT INTO participa VALUES (351234567, 22222222222222, 'Oficial', TO_DATE('04/07/2000', 'DD/MM/YYYY'), 0001, 12, 00, 01, 'goleiro',  01, 00, 00, 00);
INSERT INTO participa VALUES (361234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), 0001, 12, 01, 04, 'zagueiro', 00, 00, 01, 00);
INSERT INTO participa VALUES (371234567, 33333333333333, 'Oficial', TO_DATE('08/07/2000', 'DD/MM/YYYY'), 0001, 13, 01, 07, 'lateral', 00, 00, 01, 00);
INSERT INTO participa VALUES (401234567, 44444444444444, 'Oficial', TO_DATE('09/06/2004', 'DD/MM/YYYY'), 0001, 13, 00, 05, 'zagueiro', 01, 00, 00, 00);
INSERT INTO participa VALUES (441234567, 55555555555555, 'Oficial', TO_DATE('08/07/2003', 'DD/MM/YYYY'), 0001, 15, 01, 02, 'zagueiro', 03, 00, 01, 00);
INSERT INTO participa VALUES (471234567, 66666666666666, 'Oficial', TO_DATE('07/11/2003', 'DD/MM/YYYY'), 0001, 15, 02, 10, 'atacante', 03, 00, 01, 00);
INSERT INTO participa VALUES (331234567, 22222222222222, 'Oficial', TO_DATE('20/03/2004', 'DD/MM/YYYY'), 0002, 01, 01, 10, 'atacante', 01, 00, 02, 00);
INSERT INTO participa VALUES (471234567, 66666666666666, 'Oficial', TO_DATE('07/11/2003', 'DD/MM/YYYY'), 0002, 01, 02, 10, 'atacante', 00, 01, 02, 00);
