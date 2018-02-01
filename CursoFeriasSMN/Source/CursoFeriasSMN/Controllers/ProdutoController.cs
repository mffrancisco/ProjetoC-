using CursoFeriasSMN.Application.Applications;
using CursoFeriasSMN.Application.Models;
using System.Net;
using System.Web.Mvc;

namespace CursoFeriasSMN.Controllers
{
    public class ProdutoController : Controller
    {
        private readonly ProdutoApplication _produtoApplication = new ProdutoApplication();

        public ActionResult ListarProdutos()
        {
            var response = _produtoApplication.GetProduto();

            if(response.Status != HttpStatusCode.OK)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Content(response.ContentAsString);
            }

            return View("GridProdutos", response.Content);
        }

        /*public ActionResult CadastrarProduto()
        {
            return View("");
        }*/

        public ActionResult CadastrarProduto(ProdutoModel produto)
        {
            var response = _produtoApplication.PostProduto(produto);

            if (response.Status != HttpStatusCode.OK)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Content(response.ContentAsString);
            }

            return Content(response.Content);
        }
    }
}