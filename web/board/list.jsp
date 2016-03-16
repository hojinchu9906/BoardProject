<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 2016-03-15
  Time: 오후 4:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR"
    import="java.util.*,com.sist.dao.*" %>

<%
    int curpage=0;
    int totalPage=0;

    //해당 테이블로터 데이터를 가져와 보여주기 위해서 dao를 생성함.
    BoardDAO boardDAO=BoardDAO.newInstance();

    //현재 페이지의 첫로우 정보는 사용자에게로부터 받음.
    String strPage=request.getParameter("page");
    if(strPage==null)
        strPage="1";

    //이 첫번째 로우가 담긴 페이지를 변수에 담음
    curpage=Integer.parseInt(strPage);      //정수형으로 파싱함.

    //전체 페이지 수 정보가 필요함.==>한 페이지당 보여줄 로우 수를 10개로해서 나눠서 보여줌.
    totalPage=boardDAO.boardTotal();

    //현재 페이지에 해당하는 로우(레코드) 10개 보여주기.
    List<BoardDTO> boardDTOList=boardDAO.boardListData(curpage);

    //전체 로우수
    int count=boardDAO.boardCount();
    //그중 해당 페이지에서 보여질 로우(레코드)수
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
                    <a href="insert.jsp">
                        <img src="image/btn_write.gif">
                    </a>
                </td>
            </tr>
        </table>

        <table border="0" width="700">
            <tr bgcolor="#ccccff">
                <th width="10%">번호</th>
                <th width="45%">글제목</th>
                <th width="15%">이름</th>
                <th width="20%">작성날짜</th>
                <th width="10%">조회수</th>
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
                        <!-- 글제목 열부분 출력-그중 댓글이 있는 경우를 먼저 기술함.-->
                        <td width="45% align=left">
                            <%
                                //글제목부분이 댓글이 있어 그룹으로 되었을때 출력내용 기술.
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
                            <!--글제목 열부분 출력  -->
                            <a href="content.jsp?no=<%=boardDTO.getNo()%>&page=<%=curpage%>"><%=boardDTO.getSubject()%></a>

                            <!-- 새글의 경우 new 표시-->
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
                            <%=boardDTO.getName()%>         <!--이름 열 출력 -->
                        </td>
                        <td width="20%" align="center">
                            <%=boardDTO.getRegdate().toString()%>           <!-- 작성일 출력 -->
                        </td>
                        <td width="10%" align="center">
                            <%=boardDTO.getHit()%>                          <!--조회수 출력 -->
                        </td>

                    </tr>
            <%
                    j++;
                }
            %>

        </table>

        <hr width="700">        <!-- 구분선 추가함-->
        <table border="0" width="700">
            <tr>
                <td align="left">
                    <select name="search">
                        <option value="name">이름</option>
                        <option value="subject">제목</option>
                        <option value="content">내용</option>
                    </select>

                    <input type="text" name="searchText" size="12">
                    <input type="image" src="image/btn_search.gif">
                </td>

                <!-- 아래 테이블의 두번째 열 추가함.-->
                <td align="right">
                    <a href="list.jsp?page=1">
                        <img src="image/begin.gif" border="0">
                    </a>
                    <a href="list.jsp?page=<%=curpage>1 ? curpage-1 : curpage%>">
                        <img src="image/prev.gif" border="0">
                    </a>
                    [1][2][3][4][5]
                    <a href="list.jsp?page=<%=curpage<totalPage ? curpage+1 : curpage%>">
                        <img src="image/next.gif" border="0">
                    </a>
                    <a href="list.jsp?page=<%=totalPage%>">
                        <img src="image/end.gif" border="0">
                    </a>
                        &nbsp;&nbsp;

                    <%=curpage %> page / <%=totalPage %> pages
                </td>
            </tr>

        </table>

    </center>
</body>
</html>












































































