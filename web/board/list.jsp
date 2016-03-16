<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 2016-03-15
  Time: ���� 4:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR"
    import="java.util.*,com.sist.dao.*" %>

<%
    int curpage=0;
    int totalPage=0;

    //�ش� ���̺���� �����͸� ������ �����ֱ� ���ؼ� dao�� ������.
    BoardDAO boardDAO=BoardDAO.newInstance();

    //���� �������� ù�ο� ������ ����ڿ��Էκ��� ����.
    String strPage=request.getParameter("page");
    if(strPage==null)
        strPage="1";

    //�� ù��° �ο찡 ��� �������� ������ ����
    curpage=Integer.parseInt(strPage);      //���������� �Ľ���.

    //��ü ������ �� ������ �ʿ���.==>�� �������� ������ �ο� ���� 10�����ؼ� ������ ������.
    totalPage=boardDAO.boardTotal();

    //���� �������� �ش��ϴ� �ο�(���ڵ�) 10�� �����ֱ�.
    List<BoardDTO> boardDTOList=boardDAO.boardListData(curpage);

    //��ü �ο��
    int count=boardDAO.boardCount();
    //���� �ش� ���������� ������ �ο�(���ڵ�)��
   count=count-((curpage*10)-10);
%>
<html>
<head>
    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=EUC-KR">
    <title>BoardProject</title>
    <link rel="stylesheet" type="text/css" href="../css/board.css">
</head>
<body>
    <center>
        <img src="image/qna.jpg" width="700" height="100">
        <p></p>
        <table border="0" width="700">
            <tr>
                <td align="left">
                    <img src="image/btn_write.gif">
                </td>
            </tr>
        </table>

        <table border="0" width="700">
            <tr bgcolor="#ccccff">
                <th width="10%">��ȣ</th>
                <th width="45%">������</th>
                <th width="15%">�̸�</th>
                <th width="20%">�ۼ���¥</th>
                <th width="10%">��ȸ��</th>
            </tr>
            <%
                int j=0;
                String color="white";

                for(BoardDTO boardDTO: boardDTOList){
                    if(j%2==0)
                        color="white";
                    else
                        color="#FFEB3B";

                    %>
                    <tr bgcolor=<%=color%>>
                        <td width="10%" align="center"><%=count-- %></td>
                        <!-- ������ ���κ� ���-���� ����� �ִ� ��츦 ���� �����.-->
                        <td width="45% align=left">
                            <%
                                //������κ��� ����� �־� �׷����� �Ǿ����� ��³��� ���.
                                if(boardDTO.getGroup_tab()>0){
                                    for(int i=0;i<boardDTO.getGroup_tab();i++){
                                        %>
                                        &nbsp;&nbsp;
                            <%
                                    }
                            %>
                                    <img src="image/icon_reply.gif">
                            <%
                                }
                            %>
                            <!--������ ���κ� ���  -->
                            <a href="content.jsp?no=<%=boardDTO.getNo()%>&page=<%=curpage%>"><%=boardDTO.getSubject()%></a>

                            <!-- ������ ��� new ǥ��-->
                            <%
                                String todayStr=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
                                String dbdayStr=boardDTO.getRegdate().toString();
                                if(todayStr.equals(dbdayStr)){
                                    %>
                                    &nbsp;<sup><img src="image/icon_new%20(2).gif"></sup>
                            <%
                                }
                            %>
                        </td>
                        <td width="15" align="center">
                            <%=boardDTO.getName()%>         <!--�̸� �� ��� -->
                        </td>
                        <td width="20%" align="center">
                            <%=boardDTO.getRegdate().toString()%>           <!-- �ۼ��� ��� -->
                        </td>
                        <td width="10%" align="center">
                            <%=boardDTO.getHit()%>                          <!--��ȸ�� ��� -->
                        </td>

                    </tr>
            <%
                    j++;
                }
            %>

        </table>

        <hr width="700">        <!-- ���м� �߰���-->
        <table border="0 width=700">
            <tr>
                <td align="left">
                    <select name="search">
                        <option value="name">�̸�</option>
                        <option value="subject">����</option>
                        <option value="content">����</option>
                    </select>

                    <input type="text" name="searchText" size="12">
                    <input type="image" src="image/btn_search.gif">
                </td>

            </tr>

        </table>

    </center>
</body>
</html>












































































