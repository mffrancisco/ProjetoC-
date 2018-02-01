using CursoFeriasSMN.Repository.Repositories;
using ProjetoSMN.Domain.Entidades;
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

        [HttpPost, Route("cadastraProduto")]
        public IHttpActionResult PostProduto(Produto produto)
        {
            try
            {
                var retorno = _produtoRepository.CadastraProduto(produto);

                if (retorno != null)
                {
                    return BadRequest(retorno);
                }

                return Ok("Produto Cadastrado com Sucesso");
            }
            catch
            {
                return BadRequest("Algo deu errado!");
            }
        }
    }
}