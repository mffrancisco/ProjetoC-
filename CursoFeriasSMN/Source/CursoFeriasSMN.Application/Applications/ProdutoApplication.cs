using CursoFeriasSMN.Application.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace CursoFeriasSMN.Application.Applications
{
    public class ProdutoApplication
    {
        private readonly string _enderecoApi = $"{ApiConfig.EnderecoApi}/produto";

        public Response<IEnumerable<ProdutoModel>> GetProdutos()
        {
            using (var client = new HttpClient())
            {
                var response = client.GetAsync($"{_enderecoApi}/listarProdutos").Result;
                return new Response<IEnumerable<ProdutoModel>>(response.Content.ReadAsStringAsync().Result, response.StatusCode);
            }
        }
    }
}
