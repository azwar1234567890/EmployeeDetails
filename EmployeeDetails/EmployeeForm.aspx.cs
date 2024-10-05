using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Security.Cryptography.X509Certificates;

namespace EmployeeDetails
{
    public partial class EmployeeForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("data source=ITD-LIS-WS-040\\SQLEXPRESS; initial catalog=employeedetails2024; integrated security=true");
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                displaygender();
                displaydesignation();
                displaystate();
                displaygridview();
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            if(btnsave.Text == "Submit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbinsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_name", txtname.Text);
                cmd.Parameters.AddWithValue("@emp_salary", txtsalary.Text);
                cmd.Parameters.AddWithValue("@emp_gender", rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("@emp_designation", ddldesignation.SelectedValue);
                cmd.Parameters.AddWithValue("@emp_state", ddlstate.SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
                clear();
                displaygridview();
            }
            else if(btnsave.Text == "Update")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbupdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", ViewState["Id"]);
                cmd.Parameters.AddWithValue("@emp_name", txtname.Text);
                cmd.Parameters.AddWithValue("@emp_salary", txtsalary.Text);
                cmd.Parameters.AddWithValue("@emp_gender", rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("@emp_designation", ddldesignation.SelectedValue);
                cmd.Parameters.AddWithValue("@emp_state", ddlstate.SelectedValue);
                cmd.ExecuteNonQuery();
                con.Close();
                displaygridview();
                btnsave.Text = "Submit";
                clear();
            }
        }

        public void displaygender()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("displaygender", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close();
            rblgender.DataValueField = "gen_id";
            rblgender.DataTextField = "gen_name";
            rblgender.DataSource = dt;
            rblgender.DataBind();

        }
        public void displaydesignation()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("displaydesignation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close(); 
            ddldesignation.DataValueField = "designation_id";
            ddldesignation.DataTextField = "designation_name";
            ddldesignation.DataSource = dt;
            ddldesignation.DataBind();
            ddldesignation.Items.Insert(0, new ListItem("--Select--", "0"));

        }

        public void displaystate()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("displaystate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close();           
            ddlstate.DataValueField = "state_id";
            ddlstate.DataTextField = "state_name";
            ddlstate.DataSource = dt;
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("--Select--", "0"));

        }

        public void displaygridview()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("displaygridview", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            con.Close();
            gv.DataSource = dt;
            gv.DataBind();

        }

        public void clear()
        {
            txtname.Text = " ";
            txtsalary.Text = " ";
            rblgender.ClearSelection() ;
            ddldesignation.SelectedValue = "0" ;
            ddlstate.SelectedValue = "0" ;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "dbdel")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbdelete", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", e.CommandArgument);
                cmd.ExecuteNonQuery();
                con.Close();
                displaygridview();
            }
            else if (e.CommandName == "dbedit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbedit", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", e.CommandArgument);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                con.Close();
                txtname.Text = dt.Rows[0][1].ToString();
                txtsalary.Text = dt.Rows[0][2].ToString();
                rblgender.SelectedValue = dt.Rows[0][3].ToString();
                ddldesignation.SelectedValue = dt.Rows[0][4].ToString();
                ddlstate.SelectedValue = dt.Rows[0][5].ToString();
                btnsave.Text = "Update";
                ViewState["Id"] = e.CommandArgument;

            }

        }
    }
}