<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!
String path = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String un = "system";
String pass = "system";
Connection con  = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
PrintWriter pw  = null;
HttpSession session = null;
String query = "select * from UniversityResultAb where ID = ? AND Password=?";
%>
<%!
public void jspInit()
{
try{
	Class.forName(path);
	con = DriverManager.getConnection(url, un, pass);
   }
	catch(Exception e)
	{
	
		e.printStackTrace();
	}
}
%>
<%!
public void jspDestroy()
{
	try
	{
		con.close();
		pstmt.close();
		rs.close();
		pw.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
%>
<%
try{
	String id = request.getParameter("id");
	String passw = request.getParameter("password");
	pw = response.getWriter();
	pstmt = con.prepareStatement(query);
	pstmt.setString(1,id);
	pstmt.setString(2,passw);
	rs = pstmt.executeQuery();
	if(rs.next())
	{
		int id1 = rs.getInt("id");
		String name1 = rs.getString("name");
		int m1  = rs.getInt("marks1");
		int m2 = rs.getInt("marks2");
		int m3 = rs.getInt("marks3");
		int avg = rs.getInt("avg");
		String passwo = rs.getString("password");
		
		pw.println(id1+ " "+name1+" "+ m1+ " "+m2+" "+m3+" "+avg+" "+passwo);
	}
	else{
		response.sendRedirect("/UniversityResultAb/invalid.html");
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>