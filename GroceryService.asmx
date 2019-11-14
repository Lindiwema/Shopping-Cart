using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Grocery
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class GroceryService : System.Web.Services.WebService
    {
       
        [WebMethod]
        public void GetGrocery_()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<Grocery> groceries = new List<Grocery>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetGrocery_", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Grocery grocery = new Grocery();
                    grocery.ID = Convert.ToInt32(rdr["ID"]);
                    grocery.GroceryID = rdr["GroceryID"].ToString();
                    grocery.GroceryCategory = rdr["GroceryCategory"].ToString();
                    grocery.ProductName = rdr["ProductName"].ToString();
                    grocery.ProductDescription = rdr["ProductDescription"].ToString();
                    grocery.QTY = rdr["QTY"].ToString();
                    grocery.ProductImageUrl = rdr["ProductImageUrl"].ToString();

                    groceries.Add(grocery);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(groceries));
        }
        
    }
}
