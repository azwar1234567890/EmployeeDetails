<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeForm.aspx.cs" Inherits="EmployeeDetails.EmployeeForm" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Details Form</title>

</head>
<body style="background-color:lightgray">
    <center>

        <h2>Employee Details</h2>
        <form id="Employee" runat="server">
            
            <table style="margin: 10px; border:1px solid red; border-radius: 8px; padding:10px ">
                <tr>
                    <td><label for="txtname">Employee Name:</label></td>
                    <td><asp:TextBox runat="server" ID="txtname" placeholder="Enter name"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><label for="txtsalary">Employee Salary:</label></td>
                    <td><asp:TextBox runat="server" ID="txtsalary" placeholder="Enter salary"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><label>Employee Gender:</label></td>
                    <td class="radio-buttons">
                        <asp:RadioButtonList runat="server" ID="rblgender" RepeatColumns="3"></asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td><label for="ddldesignation">Employee Designation:</label></td>
                    <td><asp:DropDownList runat="server" ID="ddldesignation"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td><label for="ddlstate">Employee State:</label></td>
                    <td><asp:DropDownList runat="server" ID="ddlstate"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="center" colspan="2">
                        <asp:Button runat="server" ID="btnsave" Text="Submit" OnClick="btnsave_Click" CssClass="btn-submit" />
                    </td>
                </tr>
            </table> 
            
                    <asp:GridView ID="gv" runat="server" style="text-align:center" Width="100%" AutoGenerateColumns="False" OnRowCommand="gv_RowCommand" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <Columns>
                            <asp:TemplateField HeaderText="S.No">
                                <ItemTemplate>
                                    <%#(Eval("emp_id")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Registration No.">
                                <ItemTemplate>
                                    <%# DateTime.Now.ToString("ddMMyyyy") + "/" + Eval("emp_id") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Employee Name">
                                <ItemTemplate>
                                    <%#(Eval("emp_name")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Salary Receive">
                                <ItemTemplate>
                                    <%#(Eval("emp_salary")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gender">
                                <ItemTemplate>
                                      <%# 
                                        Eval("emp_gender") != null ? 
                                        (Eval("emp_gender").ToString() == "1" ? "Male" : 
                                        (Eval("emp_gender").ToString() == "2" ? "Female" : "Other")) 
                                        : "Other" 
                                        %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Current Profile">
                                <ItemTemplate>
                                       <%# 
                                         Eval("emp_designation") != null ? 
                                         (Eval("emp_designation").ToString() == "1" ? "ADMINISTRATOR" : 
                                         (Eval("emp_designation").ToString() == "2" ? "EXECUTIVE" : 
                                         (Eval("emp_designation").ToString() == "3" ? "GROUP A" : 
                                         (Eval("emp_designation").ToString() == "4" ? "GROUP B" : 
                                         (Eval("emp_designation").ToString() == "5" ? "GROUP C" : 
                                         (Eval("emp_designation").ToString() == "6" ? "GROUP D" : 
                                         (Eval("emp_designation").ToString() == "7" ? "TEMPORARY" : "UNKNOWN"))))))) 
                                         : "UNKNOWN" 
                                         %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Current State">
                                <ItemTemplate>
                                    <%#
                                        (Eval("emp_state").ToString() == "1" ? "UTTAR PRADESH" :
                                        (Eval("emp_state").ToString() == "2" ? "MAHARASHTRA" :
                                        (Eval("emp_state").ToString() == "3" ? "HARIYANA" :
                                        (Eval("emp_state").ToString() == "4" ? "PUNJAB" :
                                        (Eval("emp_state").ToString() == "5" ? "UTTARAKHAND" :
                                        (Eval("emp_state").ToString() == "6" ? "TAMILNADU" : "OTHER"))))))
                                        %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button id="btnedit" runat="server" Text="Edit" CommandArgument='<%#(Eval("emp_id")) %>' Width="100%" CommandName="dbedit"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button id="btndel" runat="server" Text="Delete" CommandArgument='<%#(Eval("emp_id")) %>' width="100%" CommandName="dbdel"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="Tan" />
                        <HeaderStyle BackColor="Tan" Font-Bold="True" />
                        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                        <SortedAscendingCellStyle BackColor="#FAFAE7" />
                        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                        <SortedDescendingCellStyle BackColor="#E1DB9C" />
                        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                    </asp:GridView>
           
        </form>
         </center>
</body>
</html>

