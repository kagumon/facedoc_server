<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String uuid = (String)request.getAttribute("uuid");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="/static/js/sockjs.min.js"></script>
    <script src="/static/js/jquery-3.7.1.min.js"></script>
    <script src="/static/js/stomp.min.js"></script>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>메인화면</h1>
<a href="/screen/USR0001M01">의사로 로그인</a>
<hr>
<a href="/screen/USR0002M01">환자로 로그인</a>
</body>
</html>