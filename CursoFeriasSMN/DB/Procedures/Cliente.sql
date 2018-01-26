IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelClientes]') AND objectproperty(id, N'IsPROCEDURE') = 1)
DROP PROCEDURE [dbo].[SP_SelClientes]

GO

CREATE PROCEDURE [dbo].[SP_SelClientes]

	AS

	/* Documentação

		Arquivo.......: Cliente.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Seleciona clientes já cadastrados.

		Exemplo....... EXEC [dbo].[SP_SelClientes]

	*/

	BEGIN
	
		SELECT CodigoCliente,
			   CodigoEndereco,
			   CPF,
			   Nome,
			   Telefone,
			   Email
			FROM [dbo].[Clientes]
			ORDER BY Nome

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelDadosCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
DROP PROCEDURE [dbo].[SP_SelDadosCliente]

GO

CREATE PROCEDURE [dbo].[SP_SelDadosCliente]
	@CodigoCliente	int

	AS

	/* Documentação

		Arquivo.......: Cliente.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Seleciona os dados do clientes

		Exemplo....... EXEC [dbo].[SP_SelDadosCliente] 1

	*/

	BEGIN
	
		SELECT cl.CodigoCliente,
			   cl.CPF,
			   cl.Nome,
			   cl.Telefone,
			   cl.Email,
			   cl.Numero,
			   cl.Complemento,
			   en.CodigoEndereco,
			   en.Cep,
			   en.Logradouro,
			   en.Bairro,
			   en.Cidade,
			   en.UF
			FROM [dbo].[Clientes] cl
				INNER JOIN [dbo].[Enderecos] en
					ON en.CodigoEndereco = cl.CodigoEndereco
			WHERE cl.CodigoCliente = @CodigoCliente

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_InsCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
DROP PROCEDURE [dbo].[SP_InsCliente]

GO

CREATE PROCEDURE [dbo].[SP_InsCliente]
	@CPF			varchar(14),
	@Nome			varchar(50),
	@Telefone		varchar(15) = NULL,
	@Email			varchar(50) = NULL,
	@Cep			int,
	@Logradouro		varchar(50),
	@Bairro			varchar(30),
	@Cidade			varchar(30),
	@UF				char(2),
	@Numero			smallint,
	@Complemento	varchar(30) = NULL

	AS

	/* Documentação

		Arquivo.......: Cliente.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Cadastrar um novo cliente
		Retornos......: 0 - Processamento OK!
						1 - Erro ao inserir o endereço.
						2 - Erro ao inserir o cliente.

		Exemplo....... EXEC [dbo].[SP_InsCliente] '45104130843', 'Bruno Alves', NULL, NULL, 14407702, 'Rua: Professora Vanda Gonzaga', 'Recanto Capitão Heliodorio', 'Franca', 'SP', 981, NULL

	*/

	BEGIN

		DECLARE @SequencialEndereco	int

		BEGIN TRANSACTION

			INSERT INTO [dbo].[Enderecos](Cep, Logradouro, Bairro, Cidade, UF)
				VALUES(@Cep, @Logradouro, @Bairro, @Cidade, @UF)

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 1
				END

			SET @SequencialEndereco = SCOPE_IDENTITY()

			INSERT INTO [dbo].[Clientes](CodigoEndereco, CPF, Nome, Telefone, Email, Numero, Complemento)
				VALUES(@SequencialEndereco, @CPF, @Nome, @Telefone, @Email, @Numero, @Complemento)

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 2
				END

		COMMIT TRANSACTION
		RETURN 0

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_UpdDadosCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
DROP PROCEDURE [dbo].[SP_UpdDadosCliente]

GO

CREATE PROCEDURE [dbo].[SP_UpdDadosCliente]
	@CodigoCliente	int,
	@CodigoEndereco	int,
	@CPF			varchar(14),
	@Nome			varchar(50),
	@Telefone		varchar(15) = NULL,
	@Email			varchar(50) = NULL,
	@Cep			int,
	@Logradouro		varchar(50),
	@Bairro			varchar(30),
	@Cidade			varchar(30),
	@UF				char(2),
	@Numero			smallint,
	@Complemento	varchar(30) = NULL

	AS

	/* Documentação

		Arquivo.......: Cliente.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Atualiza as informações do cliente
		Retornos......: 0 - Processamento OK!
						1 - Erro ao atualizar as informações do cliente.
						2 - Erro ao atualizar as informações do endereço.

		Exemplo....... EXEC [dbo].[SP_UpdDadosCliente] 1, 1, 34528929643, 'Bruno Alves', 16992302449, 'bruno@smn.com.br', 69313530, 'Rua América Sarmento Ribeiro', 'Tancredo Neves', 'Boa Vista', 'RR', 10, 'AP. 50'

	*/

	BEGIN
	
		BEGIN TRANSACTION

			UPDATE [dbo].[Clientes]
				SET CPF = @CPF,
					Nome = @Nome,
					Telefone = @Telefone,
					Email = @Email,
					Numero = @Numero,
					Complemento = @Complemento
				WHERE CodigoCliente = @CodigoCliente

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 1
				END

			UPDATE [dbo].[Enderecos]
				SET Cep = @Cep,
					Logradouro = @Logradouro,
					Bairro = @Bairro,
					Cidade = @Cidade,
					UF = @UF
				WHERE CodigoEndereco = @CodigoEndereco

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 2
				END

		COMMIT TRANSACTION
		RETURN 0

	END

GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_DelCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
DROP PROCEDURE [dbo].[SP_DelCliente]

GO

CREATE PROCEDURE [dbo].[SP_DelCliente]
	@CodigoCliente	int,
	@CodigoEndereco int

	AS

	/* Documentação

		Arquivo.......: Cliente.sql
		Autor.........: Bruno Alves
		Data..........: 04/01/2017
		Objetivo......: Atualiza as informações do cliente
		Retornos......: 0 - Processamento OK!
						1 - Erro ao deletar o cliente.
						2 - Erro ao deletar o endereço.

		Exemplo....... EXEC [dbo].[SP_DelCliente] 1, 1

	*/

	BEGIN
	
		BEGIN TRANSACTION

			DELETE FROM [dbo].[Clientes]
				WHERE CodigoCliente = @CodigoCliente

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					RETURN 1
					ROLLBACK TRANSACTION
				END

			DELETE FROM [dbo].[Enderecos]
				WHERE CodigoEndereco = @CodigoEndereco

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					RETURN 2
					ROLLBACK TRANSACTION
				END

		COMMIT TRANSACTION
		RETURN 0

	END

GO