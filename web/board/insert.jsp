<%--
  Created by IntelliJ IDEA.
  User: sist
  Date: 2016-03-16
  Time: ���� 4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR" %>
<html>
<head>
    <title>�۾��� JSP</title>
    <link rel="stylesheet" type="text/css" href="../css/board.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <script>
        $(function(){

        });

    </script>
</head>
<body>
    <center>
        <img src="image/qna.jpg" width="500" height="100">
        <p></p>
        <form method="post" action="insert_ok.jsp" id="form">
            <table border="1" bordercolor="blue" width="500" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table border="0" width="500">
                            <tr>
                                <td width="15%" align="right">����</td>
                                <td width="85%" align="left">
                                    <input type="text" name="name" size="12" id="name">
                                </td>
                            </tr>

                            <tr>
                                <td width="15%" align="right">������</td>
                                <td width="85%" align="left">
                                    <input type="text" name="subject" size="53" id="subject">
                                </td>
                            </tr>

                            <tr>
                                <td width="15%" align="right" valign="top">�� ����</td>
                                <td width="85%" align="left">
                                    <textarea rows="10" cols="50" name="content" id="content"></textarea>
                                </td>
                            </tr>


                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>

































































