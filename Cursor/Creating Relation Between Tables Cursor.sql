-- Função: Inserir no banco de dados o relacionamento entre os motivos de encerramento de conta e as categorias de conta.
-- Goal: Insert the relationship between client contract cancelation and account categories.

begin tran
declare @codCategoriaConta int -- variável

-- declaração e abertura do cursor
DECLARE cursor1 CURSOR FOR select id_area_conta from AreaConta a(nolock);
OPEN cursor1
 
-- lendo linha
FETCH NEXT FROM cursor1 INTO @codCategoriaConta
 
WHILE @@FETCH_STATUS = 0 -- enquanto existerem dados
BEGIN
 
-- Inserindo as linhas relacionando os motivos de encerramento e as áreas de conta.
insert into MotivoEncerramentoConta_CategoriaConta (ID_MOTIVO_ENCERRAMENTO_CONTA, ID_CATEGORIA_CONTA, ATIVO)
select ID_MOTIVO_ENCERRAMENTO_CONTA, @codCategoriaConta, 1 from MotivoEncerramentoConta m(nolock)
where 1=1
and m.ATIVO = 1
and m.ID_MOTIVO_ENCERRAMENTO_CONTA not in 
	-- Retirar áreas já relacionada para evitar erro na execução.
	(select ID_MOTIVO_ENCERRAMENTO_CONTA from MotivoEncerramentoConta_CategoriaConta ma(nolock)where ma.ID_CATEGORIA_CONTA = @codCategoriaConta)
 

print 'Categoria conta ' + cast(@codCategoriaConta as varchar(1000)) + ' relacionada.' -- conferência básica
-------------------------------------------------------------------------------------------------------------

-- lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codCategoriaConta
END
 
-- Fechando cursor 
CLOSE cursor1 
DEALLOCATE cursor1

----!!!-----------------
--rollback
--commit

-----------------------------------------------------------
-- Conferência
select * from MotivoEncerramentoConta_CategoriaConta
order by ID_MOTIVO_ENCERRAMENTO_CONTA;

select * from CategoriaConta;