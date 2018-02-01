using System.Collections.Generic;
using System.Runtime.Remoting.Messaging;
using CursoFeriasSMN.Repository.DataBase;
using ProjetoCursoFeriasSMN.Repository.DataBase;
using ProjetoSMN.Domain.Entidades;

namespace CursoFeriasSMN.Repository.Repositories
{
    public class ProdutoRepository : Execucao

    {
        private static readonly Conexao conexao = new Conexao();

        public ProdutoRepository() : base(conexao)
        {

        }

        public IEnumerable<Produto> GetProdutos()
        {
            ExecuteProcedure("[dbo].[SP_SelProdutos]");
            var produtos = new List<Produto>();

            using (var reader = ExecuteReader())
            {
                while (reader.Read())
                {
                    produtos.Add(new Produto
                    {
                        CodigoProduto = reader.ReadAsInt("CodigoProduto"),
                        Nome = reader.ReadAsString("Nome"),
                        Preco = reader.ReadAsDecimal("Preco"),
                        Estoque = reader.ReadAsShort("Estoque")
                    });
                }
            }
            return produtos;
        }

        public string CadastraProduto(Produto produto)
        {
            ExecuteProcedure("SP_InsProduto");
            AddParameter("@Nome", produto.Nome);
            AddParameter("@Preco", produto.Preco);
            AddParameter("@Estoque", produto.Estoque);

            var retorno = ExecuteNonQueryWithReturn();

            if (retorno == 1)
                return "Erro ao inserir o produto";

            return null;
        }
    }
}
