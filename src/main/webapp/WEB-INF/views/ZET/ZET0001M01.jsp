<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int d = (int)request.getAttribute("data");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <% for(int i=1; i<d; i++) { %>
        <h<%=i%>>hello world</h<%=i%>>
    <% } %>
</body>
</html>