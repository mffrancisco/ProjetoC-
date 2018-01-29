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
                        Nome = reader.ReadAsString("Nome")
                    });
                }
            }
        }
    }
}
