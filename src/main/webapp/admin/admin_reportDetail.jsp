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

    </script>
    <style>
        .wrapper {
            width: 760px;
            height: 780px;
            margin: 0 auto;
            text-align: center;
        }
	   .titleBox{
	   		width: 710px;
	   		margin-left:18px;
	   }
        h2 {
            font-size: 30px;
            background-color:rgb(86, 86, 196);
            border-radius: 10px;
            color:white;
            padding-top:10px;
        }

        #title {
            margin-top: 20px;
            height: 70px;
        }

        .table_ {
            width: 90%;
            margin-left: 20px;
         
        }

        .title {
            width: 100;
        }

        td, th {
            border: 1px solid lightgray;
            height: 40px;
            text-align : center;
        }

        /* th {
        text-align : center;
            border: 2px solid black;
            height: 40px;
        } */

        .title {
            width: 70px;
        }

        .content {
            width: 150px;
        }

        .postContent {
            height: 270px;

        }

        .post_contentArea {
            height: 520px;
            text-align: left;
            vertical-align: top;
            width: 80%;
            border: 1px solid lightgray;
        }

        /*         .post_content_titleArea {
            margin-left: 10px;
        } */

        .post_content {
            margin-left: 24px;
            margin-right: 24px;
            width: 650px;
            height: 270px;
            border: 1px solid lightgray;
        }

        .post_content_bigTitle {
            margin-left: 25px;
            font-weight: bold;
            font-size: 25px;
            margin-top: 6px;
            margin-bottom: 6px
        }

        .post_content_title {
            font-weight: bold;
            height: 10px;
            margin-left: 10px;
            text-decoration: underline;
        }

        .post_content_text {
            height: 60px;
            margin-left: 15px;
        }

        span {
            font-weight: normal;
        }

        #report_content {
            height: 130px;
        }
        .buttons{
           margin-top:10px;
           border-top: 0;
        }   
    </style>
</head>

<body>

    <div class="wrapper">
        <!--header.html import했습니다. 수정시 header.html을 건드려주세요.-->
        <div id="header"></div>
        <div id="여기부터 쓰시면 됩니다.">
            <div class="wrapper">
                <div class="row titleBox" id="title">
                    <h2>신고 상세 조회</h2>
                </div>
                <div class="table_">
                    <table>
                        <tr>
                            <th class="title">신고자ID</th>
                            <td class="content">${reportDto.report_writer}</td>
                            <th class="title">신고타입</th>
                            <c:choose>
                                <c:when test="${reportDto.report_type eq 1}">
                                    <td class="content">게시물</td>
                                </c:when>
                                <c:when test="${reportDto.report_type eq 2}">
                                    <td class="content">댓글</td>
                                </c:when>
                            </c:choose>
                            <th class="title">신고내용</th>
                            <td class="content">${report_content}</td>
                        </tr>
                        <tr>
                            <th class="title2">신고번호</th>
                            <td colspan="2" class="content2">${reportDto.report_no}</td>
                            <th class="title2">신고일자</th>
                            <td colspan="2" class="content2">${reportDto.report_date}</td>
                        </tr>
                        <tr>
                            <td colspan="6" class="post_contentArea">
                                <p class="post_content_bigTitle">해당 게시글 내용</p>
                                <div class="post_content">
                                    <p class="post_content_title">해당 게시글 제목: <span></span></p>
                                    <div class="post_content_text">${boardDto.post_title}</div>
                                    <p class="post_content_title">해당 게시글 내용:</p>
                                    <div class="post_content_text">${boardDto.post_content}</div>
                                    <p class="post_content_title">해당 댓글 :</p>
                                    <div class="post_content_text">${commentDto.comment_content}</div>
                                </div>
                                <p class="post_content_bigTitle">신고 사유</p>
                                <div class="post_content" id="report_content">
                                    <div class="post_content_text">${reportDto.report_content}</div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="buttons">
                        <button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
                        <button type="button" id="btnTurnBack" class="btn btn-warning">돌아가기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $("#btnTurnBack").click(function(){
            window.close();
        })
        $("#btnDelete").click(function(){
        	let report_no = ${reportDto.report_no}
            if (confirm("신고번호 : " + report_no + " 신고건을 삭제처리 하시겠습니까?")) {
            	opener.location.href="/toDeleteProc.admRe?report_no=" + report_no;
            	window.close();
            }    
        })
       
    </script>
</body>
</html>