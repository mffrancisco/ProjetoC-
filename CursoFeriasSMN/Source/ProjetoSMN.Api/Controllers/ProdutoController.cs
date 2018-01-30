using CursoFeriasSMN.Repository.Repositories;
using System.Web.Http;

namespace ProjetoSMN.Api.Controllers
{
    [RoutePrefix("api/produto")]
    public class ProdutoController : ApiController
    {
        private readonly ProdutoRepository _produtoRepository = new ProdutoRepository();

        [HttpGet,Route("listaProdutos")]
        public IHttpActionResult GetProdutos()
        {
            try
            {
                return Ok(_produtoRepository.GetProdutos());
            }
            catch
            {
                return BadRequest("Erro ao listar produtos");
            }
            
        }
    }
}