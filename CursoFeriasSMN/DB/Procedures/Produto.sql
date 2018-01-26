IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelProdutos]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelProdutos]

GO

CREATE PROCEDURE [dbo].[SP_SelProdutos]

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Seleciona produtos já cadastrados.

		Exemplo....... EXEC [dbo].[SP_SelProdutos]

	*/

	BEGIN

		SELECT CodigoProduto,
			   Nome,
			   Preco,
			   Estoque
			FROM [dbo].[Produtos]

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelDadosProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelDadosProduto]

GO

CREATE PROCEDURE [dbo].[SP_SelDadosProduto]
	@CodigoProduto	int

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Seleciona os dados de um produto.

		Exemplo....... EXEC [dbo].[SP_SelDadosProduto] 1

	*/

	BEGIN

		SELECT CodigoProduto,
			   Nome,
			   Preco,
			   Estoque
			FROM [dbo].[Produtos]
			WHERE CodigoProduto = @CodigoProduto

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_InsProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_InsProduto]

GO

CREATE PROCEDURE [dbo].[SP_InsProduto]
	@Nome		varchar(50),
	@Preco		decimal(10,2),
	@Estoque	smallint

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Cadastra um novo produto.
		Retornos......: 0 - Processamento OK!
						1 - Erro ao inserir o produto.

		Exemplo....... EXEC [dbo].[SP_InsProduto] 'Arroz', 7.00, 100

	*/

	BEGIN

		INSERT INTO [dbo].[Produtos](Nome, Preco, Estoque)
			VALUES(@Nome, @Preco, @Estoque)

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_UpdProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_UpdProduto]

GO

CREATE PROCEDURE [dbo].[SP_UpdProduto]
	@CodigoProduto	int,
	@Nome			varchar(50),
	@Preco			decimal(10,2),
	@Estoque		smallint

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Atualiza as informações de um produto.
		Retornos......: 0 - Processamento OK!
						1 - Erro ao atualizar as informações do produto.

		Exemplo....... EXEC [dbo].[SP_UpdProduto] 1, 'Arroz', 7.50, 80

	*/

	BEGIN

		UPDATE [dbo].[Produtos]
			SET Nome = @Nome,
				Preco = @Preco,
				Estoque = @Estoque
			WHERE CodigoProduto = @CodigoProduto

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_DelProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_DelProduto]

GO

CREATE PROCEDURE [dbo].[SP_DelProduto]
	@CodigoProduto	int

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Deleta um produto.
		Retornos......: 0 - Processamento OK!
						1 - Exclusão não permitida, o produto esta vinculada a uma venda.
						2 - Erro ao excluir o produto.

		Exemplo....... EXEC [dbo].[SP_DelProduto] 1

	*/

	BEGIN

		IF EXISTS(SELECT TOP 1 1
					FROM [dbo].[VendaItens]
					WHERE CodigoProduto = @CodigoProduto)
			RETURN 1

		DELETE FROM [dbo].[Produtos]
			WHERE CodigoProduto = @CodigoProduto

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 2

		RETURN 0

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TRG_HistoricoProduto]') AND type = 'TR')
	DROP TRIGGER [dbo].[TRG_HistoricoProduto]

GO

CREATE TRIGGER [dbo].[TRG_HistoricoProduto]
	ON [dbo].[Produtos]
	FOR UPDATE

	AS

	/* Documentação

		Arquivo.......: Produto.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Manter um histórico dos produtos.

		Exemplo....... EXEC [dbo].[TRG_HistoricoProduto]

	*/

	BEGIN

		INSERT INTO [dbo].[HistoricoProdutos](CodigoProduto, Nome, Preco, Estoque)
			SELECT CodigoProduto,
				   Nome,
				   Preco,
				   Estoque
				FROM deleted

	END

GO


