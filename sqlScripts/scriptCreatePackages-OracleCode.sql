/* 
  Dupla:
  Allan da Silva Pinto         NUSP:5967791
  Jeferson William Teixeira    NUSP:5890312
  
  Laboratorio de Bases de Dados - Turma B1
  
  Trabalho Pratico 5 - Scrip Pacotes
  
  11/12/2009
*/

/* Pacote */
CREATE OR REPLACE PACKAGE futebolApp IS
  PROCEDURE atualizaCamp;
  PROCEDURE relatorioCamp (in_idCamp IN NUMBER, v_anoCamp OUT VARCHAR2, v_divisaoCamp OUT NUMBER, v_totGolsP OUT NUMBER,
                           v_totGolsC OUT NUMBER, v_avgGP OUT NUMBER, v_totCartAm OUT NUMBER, v_totCartVer OUT NUMBER, 
                           v_nomeClube OUT VARCHAR2, v_nomeEqVence OUT VARCHAR2, v_pontosVitoria OUT NUMBER, v_nomeTreinador OUT VARCHAR2);
END futebolApp;
/
CREATE OR REPLACE PACKAGE BODY futebolApp IS

  ---- PROCEDURE 1 ----
  /*
    Descri��o: Esta procedure atualiza as informa��es da tabela Campeonato.
    Primeiramente, os clubes cadastrados em EqInscreveCamp s�o inseridos na tabela Classifica��o e em seguida
    a tabela Res (com os resultados dos jogos) � consultada  de forma a contabilizar os pontos ganhos por
    cada time nos jogos, atualizando as informa��es da tabela Classifica��o.
    Por fim, utilizando os dados de Classifica��o, podemos atualizar a tabela Campeonato.
  */
  PROCEDURE atualizaCamp IS
    -- Cursor referente aos times que participam de algum campeonato
    CURSOR times IS
        SELECT DISTINCT Eq.cnpjClube AS cnpjClube, Eq.nomeEq AS nomeEq, Eq.idCamp AS idCamp
        FROM EqInscreveCamp Eq
        ORDER BY idCamp, cnpjClube;
        
    -- Cursor referente aos resultados obtidos nos jogos
    CURSOR resultados IS
      SELECT res.idCamp AS idCamp, res.nroPartida AS nroPartida, res.cnpjClubeMandante AS cnpjClubeMandante,
             res.nomeEqMandante AS nomeEqMandante, res.cnpjClubeVisitante AS cnpjClubeVisitante, res.nomeEqVisitante AS nomeEqVisitante,
             res.golsMandante AS golsMandante, res.golsVisitante AS golsVisitante, res.timeVencedor AS timeVencedor, res.timePerdedor AS timePerdedor
      FROM res
      ORDER BY res.idCamp ASC, res.nroPartida ASC;
      
    -- Cursor referente a classifica��o dos times
    CURSOR tmpC IS
        SELECT classificacao.idcamp AS idCamp, classificacao.cnpjclube AS cnpjclube, classificacao.pontosEmpate AS pontosEmpate, classificacao.pontosVitoria AS pontosVitoria,
                classificacao.nomeEq AS nomeEq, classificacao.pontosGanhos AS pontosGanhos
        FROM classificacao
        ORDER BY classificacao.idCamp ASC, classificacao.pontosGanhos DESC;
        
    -- Cursor que informa o time que possui o maior n�mero de pontos ganhos por campeonato  
    CURSOR maxC IS
        SELECT classificacao.idcamp, MAX(classificacao.pontosganhos) AS maxPontos
        FROM classificacao
        GROUP BY (classificacao.idcamp);
        
    /* Vari�vel de controle */
    flagLoop NUMBER;
    
    /* Vari�veis de cursor */
    vTimes times%RowType;
    vRes resultados%RowType;
    vTmp tmpC%RowType;
    vMax maxC%RowType;
  
  BEGIN
    /* 
      Esta parte do c�digo insere na tabela Classifica��o o id do campeonato, 
      o cnpj e o nome de todos os times que participam de algum campeonato.
      Se ocorrer algum erro, este ser� tratado pela devida Exce��o n�o interrompendo o 
      fluxo do programa.
    */
    --DELETE FROM classificacao;
    
    OPEN times;
    LOOP
      FETCH times INTO vTimes;
      EXIT WHEN times%NOTFOUND;
      BEGIN
        INSERT INTO classificacao VALUES (vTimes.idCamp, vTimes.cnpjClube, vTimes.nomeEq, 0, 0, 0, 0, 0);
        EXCEPTION
          WHEN Dup_Val_On_Index THEN 
            UPDATE classificacao Cl 
            SET   Cl.pontosVitoria = 0, Cl.pontosEmpate = 0, Cl.pontosDerrota = 0, Cl.pontosGanhos = 0, Cl.saldoGols = 0
            WHERE Cl.idCamp = vTimes.idCamp AND
                  Cl.nomeEq = vTimes.nomeEq AND
                  Cl.cnpjClube = vTimes.cnpjClube; 
          WHEN OTHERS
            THEN dbms_output.put_line('Erro ao inserir na tabela classificação!');
      END;
    END LOOP;
    CLOSE times;
    /*
      Esta parte do c�digo pesquisa no cursor "resultados" o resultado dos
      jogos. Com isso s�o calculados os pontos ganhos nos jogos por cada time e os campos
      pontosVitoria, pontosGanhos, pontosDerrota e pontos empate da tabela Classifica��o 
      s�o atualizados.
    */ 
    OPEN resultados;
    LOOP
      FETCH resultados INTO vRes;
      EXIT WHEN resultados%NOTFOUND;
      
        IF(vRes.timeVencedor = -1)THEN
          UPDATE classificacao SET classificacao.pontosEmpate = classificacao.pontosEmpate + 1, classificacao.pontosGanhos = classificacao.pontosGanhos + 1, 
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsMandante  
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeMandante AND
                  classificacao.nomeEq = vRes.nomeEqMandante;
          UPDATE classificacao SET classificacao.pontosEmpate = classificacao.pontosEmpate + 1, classificacao.pontosGanhos = classificacao.pontosGanhos + 1,
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsVisitante  
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeVisitante AND
                  classificacao.nomeEq = vRes.nomeEqVisitante;
                  
        ELSIF(vRes.timeVencedor = vRes.cnpjClubeMandante) THEN
          UPDATE classificacao SET classificacao.pontosVitoria = classificacao.pontosVitoria + 1, classificacao.pontosGanhos = classificacao.pontosGanhos + 3,
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsMandante  
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeMandante AND
                  classificacao.nomeEq = vRes.nomeEqMandante;
          UPDATE classificacao SET classificacao.pontosDerrota = classificacao.pontosDerrota + 1,
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsVisitante  
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeVisitante AND
                  classificacao.nomeEq = vRes.nomeEqVisitante;
                  
        ELSE
          UPDATE classificacao SET classificacao.pontosVitoria = classificacao.pontosVitoria + 1, classificacao.pontosGanhos = classificacao.pontosGanhos + 3,
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsVisitante
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeVisitante AND
                  classificacao.nomeEq = vRes.nomeEqVisitante;
          UPDATE classificacao SET classificacao.pontosDerrota = classificacao.pontosDerrota + 1,
                 classificacao.saldoGols = classificacao.saldoGols + vRes.golsMandante  
            WHERE classificacao.idcamp = vRes.idCamp AND
                  classificacao.cnpjclube = vRes.cnpjClubeMandante AND
                  classificacao.nomeEq = vRes.nomeEqMandante;
        END IF;
    END LOOP;
    CLOSE resultados;    
    /*
      Esta parte do programa atualiza a tabela campeonato com seu respectivo clube vencedor. 
      Se j� houver um clube vencedor cadastrado em um dado campeonato, n�o ser� feita a atualiza��o. 
      Por default, a tabela campeonato inicializa o campo cnpjClubeVence com -1.
    */
    OPEN tmpC;
    LOOP
      FETCH tmpC INTO vTmp;
      EXIT WHEN tmpC%NOTFOUND;
      OPEN maxC;
      flagLoop := 0;
      LOOP
        FETCH maxC INTO vMax;
        EXIT WHEN maxC%NOTFOUND OR flagLoop = 1;
        IF((vTmp.pontosGanhos = vMax.maxPontos)AND(vTmp.idCamp = vMax.idCamp))THEN
           UPDATE Campeonato Camp
            SET Camp.cnpjClubeVence = vTmp.cnpjClube,
                 Camp.nomeEqVence = vTmp.nomeEq,
                 Camp.pontosVitoria = vTmp.pontosVitoria,
                 Camp.pontosEmpate = vTmp.pontosEmpate
            WHERE Camp.idCamp = vTmp.idCamp AND
                  Camp.cnpjClubeVence <= 0;    
            flagLoop := 1;
        END IF;
      END LOOP;
      CLOSE maxC;
    END LOOP;
    CLOSE tmpC;  
  END atualizaCamp;  
  
  ---- PROCEDURE 2 ----
  /*
    Descri��o: Este procedimento recebe como par�metro um id de campeonato e gera
    um relat�rio sobre o campeonato desejado com as seguintes informa��es:
    total de gols pr�s, contras, m�dia de gols por partida, total de cart�es amarelos,
    vermelhos, al�m do clube vencedor, seu t�cnico e os pontos de vit�ria.
  */
  PROCEDURE relatorioCamp (in_idCamp IN NUMBER, v_anoCamp OUT VARCHAR2, v_divisaoCamp OUT NUMBER, v_totGolsP OUT NUMBER,
                           v_totGolsC OUT NUMBER, v_avgGP OUT NUMBER, v_totCartAm OUT NUMBER, v_totCartVer OUT NUMBER, 
                           v_nomeClube OUT VARCHAR2, v_nomeEqVence OUT VARCHAR2, v_pontosVitoria OUT NUMBER, v_nomeTreinador OUT VARCHAR2) IS
    v_idCamp Campeonato.idCamp%Type;
    v_nomeCamp Campeonato.nomeCamp%Type; 
  BEGIN
    SELECT Camp.idCamp, Camp.nomeCamp, Camp.divisaoCamp, Camp.anoCamp, Cl.nomeClube,
           Camp.nomeEqVence, Camp.pontosVitoria, M.nomeMembro
    INTO v_idCamp, v_nomeCamp, v_divisaoCamp, v_anoCamp, v_nomeClube,
         v_nomeEqVence, v_pontosVitoria, v_nomeTreinador
    FROM Campeonato Camp JOIN 
         (Equipe E JOIN Clube Cl ON E.cnpjClube = Cl.cnpjClube 
          JOIN (Treinador T JOIN Membro M ON T.cpfTreinador = M.cpfMembro)
          ON T.cnpjClube = E.cnpjClube AND T.nomeEq = E.nomeEq) 
         ON Camp.cnpjClubeVence = E.cnpjClube AND
            Camp.nomeEqvence = E.nomeEq
    WHERE Camp.idCamp = in_idCamp AND Camp.cnpjClubeVence > -1;
    
    SELECT P.idCamp, SUM(P.cartaoAmarelo), SUM(P.cartaoVermelho),
           SUM (P.golsPro), SUM (P.golsContra), AVG (P.golsPro)
    INTO v_idCamp, v_totCartAm, v_totCartVer, v_totGolsP, v_totGolsC, v_avgGP
    FROM Participa P
    WHERE P.idCamp = in_idCamp
    GROUP BY (P.idCamp);

    EXCEPTION 
     WHEN NO_DATA_FOUND THEN
        dbms_output.put_line ('N�o foram encontrados dados sobre o campeonato identificado por ' || in_idCamp || '.' || 
                              'Talvez ele n�o tenha sido cadastrado ou ent�o n�o h� um clube vencedor inserido.');
     WHEN OTHERS THEN
        dbms_output.put_line ('ERRO AO EXECUTAR ESSA OPERA��O!');
  END relatorioCamp;  
END;
/
SHOW ERROS;
/

