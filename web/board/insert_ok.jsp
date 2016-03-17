<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 2016-03-16
  Time: 오후 5:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="EUC-KR" import="com.sist.dao.*" %>
<%
    request.setCharacterEncoding("EUC-KR");
    String name=request.getParameter("name");
    String subject=request.getParameter("subject");
    String content=request.getParameter("content");
    String pwd=request.getParameter("pwd");

    //위 받아온 값을 AO에 설정.
    //해당 AO 객체 생성
    BoardDTO boardDTO=new BoardDTO();
    boardDTO.setName(name);
    boardDTO.setSubject(subject);
    boardDTO.setContent(content);
    boardDTO.setPwd(pwd);

    //이제 이 값을 디비 테이블에 추가해야함.
    //해당 기능을 갖고 있는 DAO의 매서드를 호출함
    //일단 dao 객체 생성.
    BoardDAO boardDAO=new BoardDAO.newInstance();

    boardDAO.boardInsert(boardDTO);
    //입력하고 나서 자동으로 전환(리다이렉트)
    response.sendRedirect("list.jsp");
%>
<html>
<head>
    <title>글쓰기 이벤트시 결과처리하는 페이지</title>
</head>
<body>

</body>
</html>








































