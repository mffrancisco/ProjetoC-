using CursoFeriasSMN.Application.Applications;
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
    }
}