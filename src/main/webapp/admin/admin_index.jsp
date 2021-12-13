<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>adminHome</title>
    
    <!-- bootstarp 링크 -->
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

    <!-- jquery 링크 --> 
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
        
    <!-- header import 링크 -->    
    <script type="text/javascript">
        $(document).ready(function () {
            $("#header").load("/resources/header/header_admin.jsp")
        });
    </script>
    <style>
        /*전체틀*/
        .container {
            width: 1100px;
            height: 1500px;
            /* border: 1px solid black; */
            margin: 0 auto;
            /* background-color: black; */
        }

        /*헤더 하단 공백*/
        .blank {
            height: 80px;
        }

        /*헤더 하단 공백*/
        .admin_menu {

            /* border: 1px solid steelblue; */
            height: 800px;
            border-top: none;
            border-left: none;
            border-bottom: none;
        }

        /*메뉴 최상단 공백 (마진top 넣는게 나을수도)*/
        .menu_blank {
            height: 40px;
        }

        /*메뉴 목록 항목별 p태그*/
        .menu {
            font-size: 30px;
            text-align: center;
            font-weight: bold;
            color: #584c4c;
            margin: 10px;
            font-family: 'Nanum Gothic', sans-serif;
        }

        /*메뉴 속 a태그*/
        .menu_link {
            color: #584c4c;
            text-decoration: none;
        }

        /*메뉴 hover 했을 때 글씨 커지는 효과*/
        .menu:hover {
            font-size: 33px;
            color: #584c4c;
        }

        /*메뉴 hover 했을 때 a태그 글자색 바뀌지 않도록 기존 색과 맞춤*/
        .menu_link:hover {
            color: #584c4c;
        }

        /*메뉴 항목 AdminHome에 밑줄 긋기*/
        #admin_home {
            /* background-color: #5656c4; */
            border-bottom: 1px solid #5656c4;
            border-width: 7px;
        }

        /*메뉴바 옆 내용이 들어가는 부분 전체 틀*/
        .admin_content {
            /* border: 1px solid black; */
            height: 800px;
        }

        /*'관리자 페이지'라고 적힌 제목*/
        .admin_title {
            font-family: 'Nanum Gothic', sans-serif;
            margin-bottom: 23px;
            text-align: center;
            font-weight: bold;
        }

        /*'관리자페이지' 제목 위 공백*/
        .admin_content_blank {
            height: 20px;
        }

        /*오늘 가입, 게시물, 신고 내역 전체틀*/
        .today_record {
            height: 150px;
            padding-left: 20px;
            padding-right: 20px;
            margin-top: 20px;
        }

        /*오늘 내역 항목 각각 (오늘 가입자수/게시물수/신고건수)*/
        .today_record_content {
            border: 1px solid steelblue;
            border-width: 2px;
            border-left: none;
            border-right: none;
        }

        /*오늘 내역 항목 중 '오늘 게시물 수' 아이디 : 양옆 border를 넣고 싶어서 만듬*/
        #today_record_content_mid {
            border-right: 1px dotted black;
            border-left: 1px dotted black;
        }

        /*오늘 내역 항목 중 항목별 이름*/
        .today_record_title {
            height: 30%;
            /* border: 1px solid black; */
            font-weight: bold;
            color: #584c4c;
            font-family: 'Nanum Gothic', sans-serif;
            font-size: 23px;
            text-align: center;
            padding-top: 10px;
        }

        /*오늘 내역 항목 중 번호를 적는 부분*/
        .today_record_number {
            height: 70%;
            /* border: 1px solid black; */
            text-align: center;
            font-family: 'Nanum Gothic', sans-serif;
            font-size: 60px;
        }


        /*오늘 내역 중 가입자, 게시물, 신고 단어 강조를 위한 span*/
        .today_record_word {
            color: rgb(221, 24, 24);
        }

        /*오늘 내역 번호 옆 '건, 명'등의 단위를 적는 부분*/
        .today_record_number_unit {
            font-size: 25px;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <!--header.html import했습니다. 수정시 header.html을 건드려주세요.-->
        <div id="header"></div>
        <div id="여기부터 쓰시면 됩니다.">
            <div class="container">
                <div class="row blank"></div>
                <div class="row ">
                    <div class="col-3 admin_menu">
                        <table class="menuBar">
                            <tr>
                                <div class="menu_blank"></div>
                            </tr>
                            <tr>
                                <p class="menu" id="admin_home"><a href="/toMain.admHome" class="menu_link">AdminHome</a></p>
                            </tr>
                            <tr>
                                <p class="menu"><a href="/toUserManagement.admMem?currentPage=1" class="menu_link">회원 관리</a></p>
                            </tr>
                            <tr>
                                <p class="menu"><a href="/toBoardManagement.admBo?currentPage=1" class="menu_link">게시글 관리</a></p>
                            </tr>
                            <tr>
                                <p class="menu"><a href="/toReportManagement.admRe?currentPage=1" class="menu_link">신고 관리</a></p>
                            </tr>
                        </table>
                    </div>
                    <div class="col-9 admin_content">
                        <div class="row admin_content_blank"></div>
                        <div class="row admin_title">
                            <h1>관리자 페이지</h1>
                        </div>
                        <div class="row today_record">
                            <div class="col-4 today_record_content">
                                <div class="today_record_title">오늘 <span class="today_record_word">가입자</span> 수
                                </div>
                                <div class="today_record_number">${today_signup}<span
                                        class="today_record_number_unit">명</span></div>
                            </div>
                            <div class="col-4 today_record_content" id="today_record_content_mid">
                                <div class="today_record_title">오늘 <span class="today_record_word">게시물</span> 수
                                </div>
                                <div class="today_record_number">${today_post}<span
                                        class="today_record_number_unit">건</span></div>
                            </div>
                            <div class="col-4 today_record_content">
                                <div class="today_record_title">오늘 <span class="today_record_word">신고</span> 건수
                                </div>
                                <div class="today_record_number">${today_report}<span
                                        class="today_record_number_unit">건</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
    
    </script>

</body>

</html></html>