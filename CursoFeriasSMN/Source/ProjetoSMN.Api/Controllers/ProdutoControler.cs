using CursoFeriasSMN.Repository.Repositories;
using System.Net.Http;
using System.Web.Http;

namespace ProjetoSMN.Api.Controllers
{
    [RoutePrefix("api/produto")]
    public class ProdutoControler : ApiController
    {
        private readonly ProdutoRepository _produtoRepository = new ProdutoRepository();

        public IHttpActionResult GetProdutos()
        {
            return Ok(_produtoRepository.GetProdutos());
        }
    }
}