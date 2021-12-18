<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>게시글 등록</title>
<script type="text/javascript">
        $(document).ready(function(){
            $("#header").load("resources/header/header.jsp");
            
         });
       </script>
<style>
 
 .Wrapper{
 	background-color:#ececf8;
 	
 }

/* ========== 게시글 추가 ========== */
/* 게시글 전체 컨테이너 */
.insertPostContainer {
    margin: auto;
    width: 1600px;
    border: 1px solid lightgray;
    border-radius: 5px;
    background-color:white;
}

/* 전체 row(튜플,행) */
.row {
    margin-top: 10px;
    margin-bottom: 10px;
}
/* 카테고리 선택 버튼 */
.btnCategory {
    border-radius: 5px;
    background-color: #cfcfcf;
    border: none;
    color: black;
    font-weight: 900;
    height: 50px;
    width: 100px;
    font-size: 15px;
    
}
/* 카테고리 선택 버튼:hover */
.btnCategory:hover {
    border-radius: 5px;
    background-color: #5656c4;
    border: none;
    color: white;
    font-weight: 900;
    height: 50px;
    width: 100px;
    font-size: 15px;
    
}
#post_title {
    width: 98%;
}
/* 사진 첨부 */
#formFile {
    width: 100%;
}
/* 내용입력textarea */
#post_content {
    width: 98%;
    resize: none;
    height: 200px;
}
/* 확인 버튼 */
#btnConfirm {
    border-radius: 5px;
    background-color: #5656c4;
    border: none;
    color: white;
    font-weight: 900;
    height: 50px;
    width: 100px;
    font-size: 20px;
   
}
/* 취소 버튼 */
#btnCancel {
    border-radius: 5px;
    background-color: rgb(196, 2, 2);
    border: none;
    color: white;
    font-weight: 900;
    height: 50px;
    width: 100px;
    font-size: 20px;
}
/* 카테고리 버튼 클릭시 */
.clicked {
 border-radius: 5px;
    background-color: #5656c4;
    border: none;
    color: white;
    font-weight: 900;
    height: 50px;
    width: 100px;
    font-size: 15px;
    }

</style>

</head>
<body>

	  <!-- ======================================== 헤더 ======================================== -->

   
    <div class="Wrapper">
        <div id="header"></div>

        <!-- ======================================== 게시글 추가 영역 ======================================== -->

        <div class="insertPostContainer mt-5 mb-5">
        	<form action="${pageContext.request.contextPath}/insertProc.bo" method="post" 
        	id="insertForm" enctype="multipart/form-data">
            <!-- ========== 게시글 상단 ========== -->
            <div class="row d-flex">
                <!-- ========== 번호,ID,카테고리,조회수 -->
                <div class="col-12 d-none">
                    <!-- 포스트 번호 -->
                    <input type="text" id="post_no" name="post_no">
                    <!-- 작성자 -->
                    <input type="text" id="post_writer" name="post_writer">
                    <!-- 카테고리 번호 -->
                    <input type="text" id="category_no" name="category_no" value="">
                    <!-- 게시글 조회수 -->
                    <!-- <div id="post_view" name="post_view"></div> -->
                </div>
                <div class="col-1 d-flex justify-content-center mb-3 mt-3">
                    <div><h5>카테고리</h5></div>
                </div>
                <div class="col-11 mb-3 mt-1">
                    <div>
                        <button type="button" class="btnCategory" id="category_no1" value="1">일러스트</button>
                        <button type="button" class="btnCategory" id="category_no2" value="2">포토</button>
                        <button type="button" class="btnCategory" id="category_no3" value="3">페인팅</button>
                        <button type="button" class="btnCategory" id="category_no4" value="4">캘러그래피</button>
                        <button type="button" class="btnCategory" id="category_no5" value="5">디자인</button>
                        <button type="button" class="btnCategory" id="category_no6" value="6">조각</button>
                        <button type="button" class="btnCategory" id="category_no7" value="7">기타</button>
                    </div>
                </div>
                <div class="col-1 d-flex justify-content-center mt-1 mb-1">
                    <div><h5>제목</h5></div>
                </div>
                <div class="col-11 d-flex justify-content-start">
                    <input type="text" id="post_title" name="post_title" class="form-control" maxlength="40" placeholder="제목을 입력 해주세요">
                </div>
            </div>

            <div class="row d-flex justify-content-start">
                <div class="col-1 d-flex justify-content-center">
                    <div><h5>글쓴이</h5></div>
                </div>
                <div class="col-1 d-flex justify-content-start">
                    <div id="post_writer_nickname" name="post_writer_nickname"></div>
                </div>
                
            </div>
            <!-- ========== 게시글 내용 ========== -->
            <div class="row d-flex justify-content-center mt-5">
                <div class="col-1 d-flex justify-content-center">
                    <div><h5>사진첨부</h5></div>
                </div>
                <div class="col-11 d-flex justify-content-start mb-5">
                    <div class="mb-3">
                        <input class="form-control" type="file" id="formFile" name="photo_path"
                        accept="image/*" onchange="readImg(event)"/>
                      </div>
                </div>
                <div class="col-12 d-flex justify-content-center mb-5">
					  <!-- 사진 미리보기 -->
                    <div id="preview"></div>
                </div>
                <div class="col-1 d-flex justify-content-center">
                    <div><h5>내용입력</h5></div>
                </div>
                <div class="col-11 d-flex justify-content-start">
                    <textarea id="post_content" name="post_content" class="form-control" placeholder="내용을 입력 해주세요" value="123"></textarea>
                </div>
            </div>
            <!-- ========== 게시글 하단 ========== -->
            <div class="row">
                <div class="col-6 d-flex justify-content-end">
                    <button type="button" id="btnConfirm">등록</button>
                </div>
                <div class="col-6 d-flex justify-content-start">
                    <button type="button" id="btnCancel">취소</button>
                </div>
            </div>
            </form>
        </div>



        
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    

    <!-- ===================================================== 스크립트 영역 ===================================================== -->
    <script>
    // 카테고리 버튼 클릭
    $('.btnCategory').on("click",function(){
       let id_check = $(this).attr("value");
      $("#category_no").val(id_check);
      console.log(id_check);
    });

      let btnCategory = document.getElementsByClassName("btnCategory");
       function handleClick(event) {
         if (event.target.classList[1] === "clicked") {
           event.target.classList.remove("clicked");
         } else {
           for (let i = 0; i < btnCategory.length; i++) {
              btnCategory[i].classList.remove("clicked");
           }
           event.target.classList.add("clicked");
         }
       }
       function init() {
         for (let i = 0; i < btnCategory.length; i++) {
            btnCategory[i].addEventListener("click", handleClick);
         }
       }
       init();
    
       
    // 이미지 미리 보기
    function readImg(event) {
       let reader = new FileReader();
       
       reader.onload = function(e) {
          let img = document.createElement("img");
          img.setAttribute("src", e.target.result);
          document.querySelector("div#preview").appendChild(img);
       };
       reader.readAsDataURL(event.target.files[0]);
    }

     // 게시글 등록 버튼
     $("#btnConfirm").on("click", function(){
    	
         let post_writer = document.getElementById("post_writer");
         let post_writer_nickname = document.getElementById("post_writer_nickname");
         let category_no = document.getElementById("category_no");
         let photo_path = document.getElementById("formFile");
       let post_title = document.getElementById("post_title")
       let post_content = document.getElementById("post_content");
       
       let fileType = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
       let imgFile = $('#formFile').val();

         
         if(post_title.value == "") {
             alert("제목을 입력 해주세요.");
             return;
         } else if (photo_path.value == "") {
             alert("사진을 등록 해주세요.");
             return;
         }else if (!imgFile.match(fileType)) {
             alert("이미지 확장자를 확인 해주세요");
             return;
         }else if (post_content.value == "") {
             alert("내용을 입력 해주세요.");
             return;
         }else if(category_no.value == ""){
        	 alert("카테고리를 선택해주세요.")
        	 return;
         }
         $("#insertForm").submit();
    });

     // 취소버튼(뒤로감)
     $("#btnCancel").on("click", function(){
         location.href = "${pageContext.request.contextPath}/toUserPage.bo?currentPage=1";
     });

     $(document).ready(function() {
		    getNickname();
		});
     
   //닉네임 ajax로 출력
		function getNickname() {
		    $.ajax({
		        type: "get",
		        url: "${pageContext.request.contextPath}/selectNN.mem",
		        dataType: "json"
		    }).done(function(rs) {
		        if(!(rs == "fail")) {
		        	 let nickname = rs
		        	 console.log(nickname);
         
                     $("#post_writer_nickname").append(nickname); 
		                
		            
		        } else {
		            console.log("수신 실패");
		        }
		    }).fail(function(e) {
		        console.log(e);
		    });
		}

		// 이미지 미리보기 할때 사진 변환
	    function readInputFile(e){
	        let sel_files = [];
	        
	        sel_files = [];
	        $('#preview').empty();
	        
	        let files = e.target.files;
	        let fileArr = Array.prototype.slice.call(files);
	        let index = 0;
	        
	        fileArr.forEach(function(f){
	           if(!f.type.match("image/*")){
	               alert("이미지 확장자만 업로드 가능합니다.");
	                return;
	            };
	            if(files.length < 2){
	               sel_files.push(f);
	                let reader = new FileReader();
	                reader.onload = function(e){
	                   let html = `<a id=img_id_${index}><img src=${e.target.result} data-file=${f.name} /></a>`;
	                    $('previewreview').append(html);
	                    index++;
	                };
	                reader.readAsDataURL(f);
	            }
	        })
	    }
	    $('#formFile').on('change',readInputFile);
    </script>
</body>
</html>