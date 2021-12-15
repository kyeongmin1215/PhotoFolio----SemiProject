<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>.
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
        	 $("#header").load("/resources/header/header_admin.jsp");
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

        /*메뉴 항목 회원관리 에 밑줄 긋기*/
        #adminMenu_user {
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

        /*회원, 게시물, 신고 테이블 가운데 정렬*/
        tr {
            text-align: center;
        }

        /*테이블 속 데이터들 링크*/
        .userDataLink {
            color: black;
            text-decoration: none;

        }

        /*검색 카테고리, 검색창, 버튼*/
        #admin_search_Area {
            height: 40px;
            vertical-align: bottom;
            margin-left: 20px;
            margin-right: 20px;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        /*검색 카테고리 select*/
        #search_category {
            text-align: center;
            height: 30px;
        }

        /*검색창*/
        #search_input {
            width: 45%;
        }

        /*탈퇴버튼*/
        .footer {
            text-align: right;
        }
    </style>
</head>

<body>
    <c:choose>
        <c:when test="${!empty rs}">
           <c:choose>
               <c:when test ="${rs eq 'success'}">
                  <script>alert("탈퇴 처리 되었습니다.");</script>
               </c:when>
               <c:otherwise>
                  <script>alert("탈퇴 처리 되었습니다.");</script>
               </c:otherwise>
           </c:choose>
        </c:when>
    </c:choose>
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
                                <p class="menu" id="adminMenu_home"><a href="/toMain.admHome" class="menu_link">AdminHome</a>
                                </p>
                            </tr>
                            <tr>
                                <p class="menu" id="adminMenu_user"><a href="/toUserManagement.admMem?currentPage=1"
                                        class="menu_link">회원
                                        관리</a></p>
                            </tr>
                            <tr>
                                <p class="menu" id="adminMenu_post"><a href="/toBoardManagement.admBo?currentPage=1"
                                        class="menu_link">게시글
                                        관리</a></p>
                            </tr>
                            <tr>
                                <p class="menu" id="adminMenu_report"><a href="/toReportManagement.admRe?currentPage=1"
                                        class="menu_link">신고
                                        관리</a></p>
                            </tr>
                        </table>
                    </div>
                    <div class="col-9 admin_content">
                        <div class="row admin_content_blank"></div>
                        <div class="row admin_title">
                            <h1>회원 정보 관리</h1>
                        </div>
                        <div class="row admin_searchArea">

                            <c:choose>
                                <c:when test="${empty value}">
                                    <form action="/searchProc.admMem?currentPage=1" method="post" id="searchForm">
                                        <div class="col admin_search" id="admin_search_Area">
                                            <select name="search_category" id="search_category">
                                                <option value="idOrNickname">아이디/닉네임</option>
                                                <option value="email">이메일</option>
                                                <option value="phone">휴대폰 번호</option>
                                            </select>
                                            <span><input type="text" id="search_input" name="search_input"
                                                    placeholder="회원 정보 검색"></span>
                                            <button type="button" class="btn btn-success btn-sm" name="search_button"
                                                id="search_button">검색</button>
                                        </div>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="/searchProc.admMem?currentPage=1" method="post" id="searchForm">
                                        <div class="col admin_search" id="admin_search_Area">
                                            <select name="search_category" id="search_category">
                                                <option value="idOrNickname" <c:if
                                                    test="${search_category eq 'idOrNickname'}">
                                                    selected='selected'
                                                    </c:if> >아이디/닉네임</option>
                                                <option value="email" <c:if test="${search_category eq 'email'}">
                                                    selected='selected'</c:if>>이메일</option>
                                                <option value="phone" <c:if test="${search_category eq 'phone'}">
                                                    selected='selected'</c:if>>휴대폰 번호</option>
                                            </select>
                                            <span><input type="text" id="search_input" name="search_input"
                                                    value="${value}"></span>
                                            <button type="button" class="btn btn-success btn-sm" name="search_button"
                                                id="search_button">검색</button>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="row">
                            <div class="table_container">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th class="col-1 checkAll"><input type="checkbox" id="checkAll">
                                            </th>
                                            <th class="col-2">닉네임</th>
                                            <th class="col-2">아이디</th>
                                            <th class="col-3">이메일</th>
                                            <th class="col-2"> 작성 게시물 수</th>
                                            <th class="col-2">가입일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="dto" items="${list}">
                                            <tr>
                                                <td><input type="checkbox" class="check_box" name="check_box">
                                                </td>
                                                <td><a href="/toUserInfo.admMem?id=${dto.userDto.user_id}" class="userDataLink">
                                                        <c:out value="${dto.userDto.user_nickname}" />
                                                    </a></td>
                                                <td><a href="/toUserInfo.admMem?id=${dto.userDto.user_id}" class="userDataLink">
                                                        <c:out value="${dto.userDto.user_id}" />
                                                    </a></td>
                                                <td><a href="/toUserInfo.admMem?id=${dto.userDto.user_id}" class="userDataLink">
                                                        <c:out value="${dto.userDto.user_email}" />
                                                    </a></td>
                                                <td><a href="/toUserInfo.admMem?id=${dto.userDto.user_id}" class="userDataLink">
                                                        <c:out value="${dto.postCnt}" />
                                                    </a></td>
                                                <td><a href="/toUserInfo.admMem?dto=${dto.userDto.user_id}" class="userDataLink">
                                                        <c:out value="${dto.userDto.user_signup_date}" />
                                                    </a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row footer">
                            <div class="col-3"></div>
                            <div class="col-6">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <c:choose>
                                            <c:when test="${empty value}">
                                                <c:if test="${naviMap.get('needPrev') eq true}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/toUserManagement.admMem?currentPage=${naviMap.get('startNavi')-1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:forEach var="i" begin="${naviMap.get('startNavi')}"
                                                    end="${naviMap.get('endNavi')}">
                                                    <li class="page-item"><a class="page-link"
                                                            href="/toUserManagement.admMem?currentPage=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <c:if test="${naviMap.get('needNext') eq true}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/toUserManagement.admMem?currentPage=${naviMap.get('endNavi')+1}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${naviMap.get('needPrev') eq true}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/searchProc.admMem?currentPage=${naviMap.get('startNavi')-1}&search_category=${search_category}&search_input=${value}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:forEach var="i" begin="${naviMap.get('startNavi')}"
                                                    end="${naviMap.get('endNavi')}">
                                                    <li class="page-item"><a class="page-link"
                                                            href="/searchProc.admMem?currentPage=${i}&search_category=${search_category}&search_input=${value}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <c:if test="${naviMap.get('needNext') eq true}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="//searchProc.admMem?currentPage=${naviMap.get('endNavi')+1}&search_category=${search_category}&search_input=${value}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>

                                    </ul>
                                </nav>
                            </div>
                            <div class="col-3">
                                <button type="button" class="btn btn-danger" id="btnWithDraw">탈퇴</button>
                            </div>
                            <span>

                            </span>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>



        $('#checkAll').click(function (e) { //최상단 체크박스 : 전체체크/ 전체체크해제
            let checkcheck = $('.check_box').map(function (index, element) {
                return element.checked = (e.target).checked;
            })
        })




        $('.check_box').click(function () {
            let check_box_length = $('.check_box').length; //체크박스 갯수 
            let checked_box_length = $(".check_box:checked").length; //체크된 박스 갯수
            if (checkAll.checked) {
                checkAll.checked = false;
            } else if (check_box_length == checked_box_length) {
                checkAll.checked = true;
            }
        });

        $("#search_button").click(function () {
            if ($('#search_input').val() == "") {
                alert("회원 정보를 입력해 주세요.");
                return;
            } else {
                $('#searchForm').submit();
            }
        })

        $("#search_category").change(function () {
            console.log($("#search_category option:selected").val());
        })


        $("#btnWithDraw").click(function () {
            let users = test();
            console.log(users);
            if (confirm("아이디 : " + users + " 회원을 탈퇴처리 하시겠습니까?")) {
                location.href = "/toDeleteProc.admMem?users=" + users;
            }
        })

        function test() {
            var select_obj = '';
            let checked_box = $('input[class="check_box"]:checked');
            checked_box.each(function (index, item) {
                if (index != 0) {
                    select_obj += ', ';
                }
                let td = item;
                console.log(td);
                let tr = item.parentElement.parentElement;
                console.log(tr);
                let value = ((tr.children[2]).textContent).trim(); //id 값
                console.log("value : ")
                console.log(value);
                // select_obj += "'"+$(".check_box:eq(2)").val()+"'";
                select_obj += "'" + value + "'";

                // console.log($(".check_box:eq(2).text"));
            });
            return select_obj;
        }

    </script>
</body>

</html>