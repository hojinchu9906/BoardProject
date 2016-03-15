package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sist on 2016-03-15.
 */
public class BoardDAO {
    //디비와의 연결을 위한 객체
    private Connection connection;
    //디비로 쿼리문을 보내고 받을 때 사용하는 스트림 객체
    private PreparedStatement preparedStatement;
    //디비 주소
    private final String URL="jdbc:oracle:thin:@211.238.142.20:1521:ORCL";
    //싱글폰으로 객체 생성하기 위해 객체 선언
    private  static BoardDAO boardDAO;

    //생성자에서 오라클 디비 드라이버 등록
    private BoardDAO(){
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    //디비와 연결하는 메소드
    public void getConnection(){
        try{
            connection= DriverManager.getConnection(URL,"scott5","tiger5");
        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    //디비와의 연결해제 하는 메소드
    public void disConnection(){
        try {
            if(preparedStatement!=null) preparedStatement.close();
            if(connection!=null) connection.close();
        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    //싱글톤으로 객체 생성
    public static BoardDAO newInstance(){
        if(boardDAO==null)
            boardDAO=new BoardDAO();
        return boardDAO;
    }

    //기능 추가
    //리스트 목록 구하기
    public List<BoardDTO> boardListData(int page){
        //해당 디비로부터 받은 데이터를 저장해둘 컬랙션 객체 생성
        List<BoardDTO> boardDTOList=new ArrayList<>();

        //연결해서 데이터 받아서 위 컬랙션에 추가하여 리턴함.
        try{
            getConnection();

            //데이터 얻어오는 데 필요한 변수 추가 선언
            int rowSize=10;     //한페이지당 10개의 레코드(로우) 보여주기.
            int start=(rowSize*page)-(rowSize-1);           //선택한 페이지에서 시작하는 로우(레코드)
            int end=rowSize*page;                           //선택한 페이지에서의 마지막 로우(레코드)

            //쿼리문 작성
            /*
             NO                                        NOT NULL NUMBER
             NAME                                      NOT NULL VARCHAR2(34)
             SUBJECT                                   NOT NULL VARCHAR2(1000)
             CONTENT                                   NOT NULL CLOB
             PWD                                       NOT NULL VARCHAR2(10)
             REGDATE                                            DATE
             HIT                                                NUMBER
             GROUP_ID                                           NUMBER
             GROUP_STEP                                         NUMBER
             GROUP_TAB                                          NUMBER
             ROOT                                               NUMBER
             DEPTH                                              NUMBER
             */
            String sql="SELECT no,subject,name,regdate,hit,group_tab,num "
                        +"FROM (SELECT no,subject,name,regdate,hit,group_tab, rownum as num "
                        +"FROM (SELECT no,subject,name,regdate,hit,group_tab "
                        +"FROM board ORDER BY group_id DESC,group_step ASC)) "
                        +"WHERE num BETWEEN " +start+ " AND " +end;

            //쿼리문 보내기위한 스트림객체 구하기
            preparedStatement=connection.prepareStatement(sql);

            //해당 쿼리문 실행
            ResultSet resultSet=preparedStatement.executeQuery();

            //임시로 저장한 테이블로부터의 쿼리 결과값을 처음의 컬랙션에 요소로 추가하기. 결국 해당 값을 리턴함.
            while(resultSet.next()){
                //오고가는 것은 결국 AO이므로 AO 객체 생성함.
                BoardDTO boardDTO=new BoardDTO();
                //쿼리문의 결과를 각 레코드단위로 받아와 매번AO에 셋팅함.
                //no,subject,name,regdate,hit,group_tab
                boardDTO.setNo(resultSet.getInt(1));
                boardDTO.setSubject(resultSet.getString(2));
                boardDTO.setName(resultSet.getString(3));
                boardDTO.setRegdate(resultSet.getDate(4));
                boardDTO.setHit(resultSet.getInt(5));
                boardDTO.setGroup_tab(resultSet.getInt(6));

                //이 한 로우를 컬력션에 add.
                boardDTOList.add(boardDTO);
            }
            //쿼리문 다 싷행하고 나서 resultSet 종료
            resultSet.close();

        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }finally {
            disConnection();
        }

        return boardDTOList;
    }

    //기능 추가2
    //총페이지 수 구하기- 게시글이 증가를 하면 총페이지 수도 증가함.
    public int boardTotal(){
        int total=0;
        //디비 테이블로부터 구해서 값을 넓겨 받는다.
        try{
            getConnection();
            //총페이지 수 구하는 쿼리문 작성
            String sql="SELECT CEIL(COUNT(*)/10) FROM board";

            //해당 쿼리문 넘겨줄 스트림 객체 구하기
            preparedStatement=connection.prepareStatement(sql);
            //쿼리문 실행하기
            ResultSet resultSet=preparedStatement.executeQuery();
            resultSet.next();
            total=resultSet.getInt(1);
            resultSet.close();
        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }finally {
            disConnection();
        }
        return total;
    }

    //총페이지 다음으로 보여지는
    //총 로우(레코드) 개수 ==> 이것은 한페이지에 10개씩의 로우를 보여지게 하기 위함.
    public int boardCount(){
        int total=0;
        //연결해서 쿼리문 보내어, 실행해서 결과값을 컬랙션에 담아 리턴함.
        try{
            getConnection();
            //쿼리문 작성
            String sql="SELECT COUNT(*) FROM board";
            //스트림 객체 생성
            preparedStatement=connection.prepareStatement(sql);
            //쿼리문 실행
            ResultSet resultSet=preparedStatement.executeQuery();
            //하나의 결과값 리턴해 보여줌.
            resultSet.next();
            total=resultSet.getInt(1);
            //더이상 필요없는 해당 리절트셋 종료
            resultSet.close();
        }catch (Exception ex){
            System.out.println(ex.getMessage());
        }finally {
            disConnection();
        }
        return total;
    }
}








































































