<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 2016-03-16
  Time: ���� 5:14
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

    //�� �޾ƿ� ���� AO�� ����.
    //�ش� AO ��ü ����
    BoardDTO boardDTO=new BoardDTO();
    boardDTO.setName(name);
    boardDTO.setSubject(subject);
    boardDTO.setContent(content);
    boardDTO.setPwd(pwd);

    //���� �� ���� ��� ���̺� �߰��ؾ���.
    //�ش� ����� ���� �ִ� DAO�� �ż��带 ȣ����
    //�ϴ� dao ��ü ����.
    BoardDAO boardDAO=new BoardDAO.newInstance();

    boardDAO.boardInsert(boardDTO);
    //�Է��ϰ� ���� �ڵ����� ��ȯ(�����̷�Ʈ)
    response.sendRedirect("list.jsp");
%>
<html>
<head>
    <title>�۾��� �̺�Ʈ�� ���ó���ϴ� ������</title>
</head>
<body>

</body>
</html>








































