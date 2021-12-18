<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script type="text/javascript">
        $(document).ready(function(){
            $("#header").load("/resources/header/header_admin.jsp")      
         });
</script>
<style>
@charset "UTF-8";

* {
	box-sizing: border-box;
	margin: 0;
}

/* 게시글 전체 컨테이너 */
.postDetailContainer {
	border: 1px solid lightgray;
	width: 1200px;
	height: auto;
	margin: auto;
}

/*댓글 전체 컨테이너 */
.commentContainer {
	border: 1px solid lightgray;
	width: 1200px;
	height: auto;
	margin: auto;
}

/*============================게시글 제목====================================*/
.post_title {
	border-bottom: double;
	width: 100%;
	height: 100px;
}

#btnReport {
	width: 80px;
}

#followBtn, #followingBtn {
	width: 100px;
	background-color: rgb(86, 86, 196);
}
/*========================================================================*/
/*===================게시글 메인=========================================*/
.post_main {
	width: 100%;
	height: auto;
}

#post_title {
	border: none;
}

.writerInfo{
    margin-left:10px;
}

.uploadBox {
	width: 1000px;
	margin: auto;
	display: none; /*수정버튼 클릭시 보이게할것*/
}

.photoBox {
	width: 1000px;
	height: auto;
	margin: auto;
}

.contentBox {
	width: 1000px;
	margin: auto;
	height: auto;
	border: 1px solid lightgray;
}

.contentBox>textarea {
	min-height: 5rem;
	resize: none;
	border: none;
	overflow-y: hidden;
}

.btnBox {
	text-align: right;
	margin-right: 10px;
}

.btnBox>div>button {
	background-color: rgb(86, 86, 196);
}

#btnsBox {
	display: block; /*자기게시글일 경우만 display:block 해줄것*/
}

#btnModifyDetailBox {
	display: none; /*수정버튼 누를때만 display:block 해줄것*/
}

#beforeGoodBtnBox {
	display: block; /*초기화면이면 block */
}

#afterGoodBtnBox {
	display: none; /*초기화면이면 none*/
}

#beforeGoodBtn {
	color: blue;
	border: 1px solid blue;
	background-color: white;
}

#afterGoodBtn {
	color: white;
	background-color: blue;
}
/*따봉 색깔 논의 필요*/
#afterGoodBtn>svg {
	color: gray;
}

/*==================================================================*/
/*===========================댓글 영역 ==============================*/
.commentTitle {
	border-bottom: 1px double gray;
}

.cmt-showBox {
	margin-left: 30px;
}

.cmt-showBox>div {
	height: 50px;
}

.cmtReport {
	padding: 2px;
	border-radius: 10px;
}

#comment_content {
	resize: none;
	border: none;
	width: 400px;
	overflow: visible;
}

#btnReModify, #btnReDelete, #btnReBack {
	background-color: rgb(86, 86, 196);
}

#btnReDelete {
	background-color: rgb(86, 86, 196);
}

#beforeReBtnBox {
	display: block; /*수정버튼 누르면 none*/
	text-align: right;
	width: 100%;
}

.btnBox {
	height: 40px;
}

#afterReBtnBox {
	display: none; /*수정버튼 누르면 block*/
	text-align: right;
	width: 100%;
	padding-bottom: 20px;
}

.commentInput {
	border: 1px solid gray;
	margin: auto;
	width: 1100px;
}

#content-cmt {
	width: 900px;
	min-height: 5rem;
	resize: none;
	overflow-y: hidden;
}

#modi_content_cmt {
	width: 900px;
	min-height: 5rem;
	resize: none;
}

#btnReInsert {
	width: 100px;
	height: 80px;
	margin-left: 40px;
	background-color: rgb(86, 86, 196);
}

.cmtReport {
	margin-bottom: 65px;
}

.modiBox {
	border: 1px solid gray;
	margin: auto;
	width: 1100px;
	margin-right: 80px;
}

#btnReGo {
	width: 100px;
	height: 80px;
	margin-left: 40px;
	background-color: rgb(86, 86, 196);
}
</style>
</head>
<body>
	<div class="Wrapper">

		<!-- 헤더쪽(링크로 불러옴) -->
		<div id="header"></div>

		<!-- 게시글쪽 -->
		<div class="postDetailContainer mt-5 mb-5">
			<form action="${pageContext.request.contextPath}/modifyProc.admBo"
				method="post" id="modifyPost" enctype="multipart/form-data">
				<!-- 게시글 제목단 -->
				<div class="post_title">
					<!-- 게시글제목+신고버튼 함께 담을 공간 -->
					<div class="row mt-2 mx-1" id="post_title_head">
						<!-- 게시글 제목 -->
						<input type="text" class="" id="post_no" name="post_no"
							value="${dto.getPost_no()}" hidden>
						<div class="col-11" id="title">
							<h2>
								<input type="text" id="post_title" name="post_title"
									value="${dto.getPost_title() }" readonly>
							</h2>
						</div>
						<div class="col-11 writerInfo">
            				<span>by ${dto.getPost_writer_nickname() } || ${dto.getPost_createdDate() } || 조회수 ${dto.getPost_view_count() }</span>
            			</div>
					</div>
				</div>


				<!-- 게시글사진 + 게시글내용 + 수정삭제버튼 담을 곳 -->
				<div class="post_main">
					<!-- 수정시 사진파일 업로드시킬 인풋창 -->
					<div class="mt-4 uploadBox">
						<input class="form-control form-control-sm" id="formFileSm"
							name="photo_path" type="file" accept="image/*"
							onchange="readImg(event)" />
					</div>
					<!-- 게시글 사진 불러올 공간 -->
					<div class="row my-4 photoBox">
						<img id="post_img"
							src="${pageContext.request.contextPath}/files/${dtoFile.getSystem_name()}">
					</div>
					<!-- 사진 미리 보기 -->
					<div class="row my-4 photoBox" id="preview"></div>
					<!-- 게시글 내용 불러올 공간 -->
					<div class="row contentBox">
						<textarea id="post_content" onkeydown="resize(this)"
							onkeyup="resize(this)" name="post_content" readonly>${dto.getPost_content() }</textarea>
					</div>
					<!-- 수정,삭제 버튼 공간(다른사용자 게시글일 경우 hidden) -->
					
						<div class="row my-4 btnBox" id="btnsBox">
							<div class="col">
								<button type="button" id="btnModify" class="btn btn-dark">Edit</button>
								<button type="button" id="btnDelete" class="btn btn-dark">Delete</button>
							</div>
						</div>
						<!-- 수정버튼 누를경우 완료, 취소 버튼 나타내기 -->
						<div class="row my-4 btnBox" id="btnModifyDetailBox">
							<div class="col">
								<button type="button" id="btnGo" class="btn btn-dark">Confirm</button>
								<button type="button" id="btnBack" class="btn btn-dark">Cancel</button>
							</div>
						</div>

				</div>
			</form>
		</div>
		<!-- 게시글 div끝  -->

		<!-- 댓글부분 -->
		<div class="commentContainer">
			<!-- 댓글 제목 -->
			<div class="row mx-2 my-2 commentTitle">
				<div class="col">
					<h2>
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
							fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
	                                <path
								d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
	                                <path
								d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
	                            </svg>
						<span>Reply</span>
					</h2>
				</div>
			</div>
			<!-- 댓글 내용부분 -->
			<div class="row commentMain">
				<!-- 댓글(1파트) -->
				<div class="cmt-showBox"></div>
			</div>
			<!-- 댓글 div끝 -->
		</div>
		<!-- 전체 div 끝 -->

		<script src="https://code.jquery.com/jquery-3.6.0.js"
			integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
			crossorigin="anonymous"></script>

		<script>
	//텍스트창 자동 길이늘림
	function resize(obj) {
	    obj.style.height = '1px';
	    obj.style.height = (12 + obj.scrollHeight) + 'px';
	}
	
	//게시글 수정버튼 누를경우 처리
	$("#btnModify").click(function(){
		$("#btnsBox").css("display","none");
		$("#btnModifyDetailBox").css("display","block");
		$(".uploadBox").css("display", "block");
		$("#post_title").attr("readonly", false);
		$("#post_content").attr("readonly", false);
		$("#post_title").css("border","1px solid black");
	})
	
	// 수정 이미지 미리 보기
    	function readImg(event) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			$("#post_img").remove();
    			let img = document.createElement("img");
    			img.setAttribute("src", e.target.result);
    			document.querySelector("div#preview").appendChild(img);
    		};
    		reader.readAsDataURL(event.target.files[0]);
    	}
	
	// 수정 확인 버튼 처리 
	$("#btnGo").on("click", function(){
		let photo_path = document.getElementById("formFileSm");
		let post_title = document.getElementById("post_title")
		let post_content = document.getElementById("post_content");
		
		 if(post_title.value == "") {
            alert("제목을 입력 해주세요.");
            return;
		 }  else if (post_content.value == "") {
            alert("내용을 입력 해주세요.");
            return;
         }
         $("#modifyPost").submit();
	})
	
	// 게시물 삭제 버튼
	$("#btnDelete").on("click", function(){
		confirm("삭제 하시겠습니까?");
		location.href = "${pageContext.request.contextPath}/deleteProc.admBo?post_no=${dto.getPost_no()}";
	})
	
	//뒤로돌아가기
	$("#btnBack").click(function(){
		location.reload();
	})
	
	
		// 댓글 영역
	
		// 페이지 로드되자마자 댓글도 ajax 로 로드
		$(document).ready(function(){
			getCommentList();
		})
		
		// 댓글 등록
		$("#btnReInsert").on("click", function(){
			let data = $("#cmtForm").serialize(); // 댓글 form 안의 데이터 직렬화
			console.log(data);
			$("#content-cmt").val("");
			if(${!empty loginSession}){
				$.ajax({
					// aJax 댓글 추가
					url : "${pageContext.request.contextPath}/insertProc.co"
					, type : "post"
					, data : data				
				}).done(function(rs){
					if(rs == "success"){
						getCommentList();// 댓글 동록에 성공하면 댓글 리스트 리로드
					}else if(rs == "fail"){
						alert("댓글 등록에 실패했습니다."); // 댓글 등록에 실패하면 alert 
					}				
				}).fail(function(e){
					console.log(e);
				});
			}else{
				alert("로그인을 하고 서비스를 이용해 주세요.");
				location.href="${pageContext.request.contextPath}/member/login.jsp"
			}
			
			
		});		
	
		// ajax를 이용해 댓글을 불러오는 함수
		function getCommentList(){		
			$.ajax({
				type : "get"
				,async:false
				, url : "${pageContext.request.contextPath}/getCommentProc.co?post_no=${dto.getPost_no()}"
				, dataType : "json"
			}).done(function(data){
				console.log(data);
				$(".cmt-showBox").empty();
				for(let cmt_dto of data){
							let comment = "<div class='row mb-2 mx-1 my-3'>"
							+ "<div class='col-6'>"
							+ "<div class='comment_content' name='comment_content'>" + cmt_dto.content + "</div>"
							+ "<button tpye='button' id = 'cmtReport' value='" + cmt_dto.comment_no + "' class='btn btn-danger btn-sm cmtReport'>신고</button>"
							+ "</div>"
							+ "<div class='col-3'>"
							+ cmt_dto.user_nickname +  "|" +cmt_dto.createdDate
							+ "</div>"
							+ "<div class='col-2 btnBox'>"
							+ "</div>"
							+ "</div>"
							+"<form method='post' id='modiCmtForm'>"
							+ "<div class='modiBox' hidden>"
							+"<div class='row mx-2 mb-2 mt-2'>"
							+"<div class='col'>"
                			+"<label>댓글수정</label>"
	                		+"</div>"
	                		+"<div class='row mx-2  comment-body'>"
							+"<div class='col-10 comment-input'>"
							+"<textarea id='modi_content_cmt' name='modi_comment_content' class='modi_content_cmt' onkeydown='resize(this)' onkeyup='resize(this)'>"+cmt_dto.content +"</textarea>"
							+"</div>"
							+"<div class='col-2 comment-input'>"
							+"<button type='button' id='btnReGo'  value='" + cmt_dto.comment_no + "' class='btn btn-dark btnReGo'>Edit</button>"
							+"</div>"
							+"</div>"
							+ "</div>"
							+"</form>"
							$(".cmt-showBox").append(comment);
							
							let btns="<div class='col-3' class='reBtnBox' id='beforeReBtnBox'>"
								+" <button type='button' id='btnReModify' value='" +cmt_dto.comment_no + "' class='btn btn-dark btn-sm btnReModify'>Edit</button>"
								+ "<button type='button' id='btnReDelete' value='" + cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Delete</button>"
								+"</div>"
								+"<div class='col-3' class='reBtnBox' id='afterReBtnBox'>"
								+"<button type='button' id='btnReBack' class='btn btn-dark btn-sm'>Cancel</button>"
								+"</div>"

								$(".btnBox:last").append(btns);
							
							}
						
			}).fail(function(e){
	    		console.log(e);
	    	});
			}
				
	
		 //댓글수정버튼 클릭시 확인,취소버튼 나오면서 인풋창 readonly해제          
		$(document).on('click', '.btnReModify', function(e){
			console.log()
			var index = $(".btnReModify").index(this);  //index 구하기 
/* 			console.log(index);
			console.log($(".modiBox")[index]);
			console.log($(".modiBox")[index]);
			console.log($(".modiBox")[index]); */
			$(this).parent().css("display", "none");
			$(this).parent().next().css("display", "block");
			$(".modiBox").eq(index).attr("hidden", false);
			
		})
			
		
		 
		//댓글삭제버튼 클릭시 댓글삭제
		$(document).on('click', '#btnReDelete', function(){
			let data = $("#cmtForm").serialize();
			let value = $(this).val();
			
			$.ajax({
				// aJax 댓글 삭제
				url : "${pageContext.request.contextPath}/deleteProc.co?comment_no="+value
				, type : "post"
				, data : data				
			}).done(function(rs){
				if(rs == "success"){
					getCommentList();// 댓글 삭제에 성공하면 댓글 리스트 리로드
				}else if(rs == "fail"){
					alert("댓글 삭제에 실패했습니다."); // 댓글 삭제에 실패하면 alert 
				}				
			}).fail(function(e){
				console.log(e);
			});
		})
		
		//버튼 클릭 시 댓글 최종 수정 
		$(document).on('click', '.btnReGo', function(){
			let data =  $("#modiCmtForm").serialize();
			let value = $(this).val();
			console.log("comment_no : "+value);
			var index = $(".btnReGo").index(this);
			console.log("index : "+index);
			let content = $(".modi_content_cmt").eq(index);
			console.log(content);
			console.log(content.val());
			$.ajax({
				url : "${pageContext.request.contextPath}/modifyProc.co?comment_no="+value+"&comment_content=" + content.val()
				,type : "post"
				,data : data
			}).done(function(rs){
				getCommentList();
			}).fail(function(e){
				console.log(e);
			});
			
		})
		//뒤로가기버튼 클릭 시 다시 댓글조회해서 초기화시킴
		$(document).on('click', '#btnReBack', function(){
			$.ajax({
				type : "get"
				,async: false
				, url : "${pageContext.request.contextPath}/getCommentProc.co?post_no=${dto.getPost_no()}"
				, dataType : "json"
			}).done(function(data){
				console.log(data);
				$(".cmt-showBox").empty();
				for(let cmt_dto of data){
					let comment = "<div class='row mb-2 mx-1 my-3'>"
						+ "<div class='col-6'>"
						+ "<div class='comment_content' name='comment_content'>" + cmt_dto.content + "</div>"
						+ "<button tpye='button' id = 'cmtReport' value='" + cmt_dto.comment_no + "' class='btn btn-danger btn-sm cmtReport'>신고</button>"
						+ "</div>"
						+ "<div class='col-3'>"
						+ cmt_dto.user_nickname +  "|" +cmt_dto.createdDate
						+ "</div>"
						+ "<div class='col-2 btnBox'>"
						+ "</div>"
						+ "</div>"
						+"<form method='post' id='modiCmtForm'>"
						+ "<div class='modiBox' hidden>"
						+"<div class='row mx-2 mb-2 mt-2'>"
						+"<div class='col'>"
            			+"<label>댓글수정</label>"
                		+"</div>"
                		+"<div class='row mx-2  comment-body'>"
						+"<div class='col-10 comment-input'>"
						+"<textarea id='modi_content_cmt' name='modi_comment_content' class='modi_content_cmt' onkeydown='resize(this)' onkeyup='resize(this)'>"+cmt_dto.content +"</textarea>"
						+"</div>"
						+"<div class='col-2 comment-input'>"
						+"<button type='button' id='btnReGo'  value='" + cmt_dto.comment_no + "' class='btn btn-dark btnReGo'>Edit</button>"
						+"</div>"
						+"</div>"
						+ "</div>"
						+"</form>"
						$(".cmt-showBox").append(comment);
						
						let btns="<div class='col-3' class='reBtnBox' id='beforeReBtnBox'>"
							+" <button type='button' id='btnReModify' value='" +cmt_dto.comment_no + "' class='btn btn-dark btn-sm btnReModify'>Edit</button>"
							+ "<button type='button' id='btnReDelete' value='" + cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Delete</button>"
							+"</div>"
							+"<div class='col-3' class='reBtnBox' id='afterReBtnBox'>"
							+"<button type='button' id='btnReBack' class='btn btn-dark btn-sm'>Cancel</button>"
							+"</div>"

							$(".btnBox:last").append(btns);
						
						}
						
			}).fail(function(e){
	    		console.log(e);
	    	});
			
	})
	
	</script>
</body>
</html>