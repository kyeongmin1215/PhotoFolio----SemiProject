<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="icon" type="image/png" href="http://example.com/myicon.png"> 
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">
        $(document).ready(function(){
            $("#header").load("/resources/header/header.jsp")      
         });
</script>
<style>
@charset "UTF-8";
*{box-sizing: border-box;
    margin:0;}

/* 게시글 전체 컨테이너 */
.postDetailContainer{
	border:1px solid lightgray;
	width:1200px;
	height:auto;
	margin:auto;
}

/*댓글 전체 컨테이너 */
.commentContainer{
	border:1px solid lightgray;
	width:1200px;
	height:auto;
	margin:auto;
}



/*============================게시글 제목====================================*/

.post_title{
	border-bottom:double;
	width:100%;
	height:100px;
	
}
#btnReport{
	width:80px;
	
	
}
#followBtn, #followingBtn{
	width:100px;
	background-color:rgb(86, 86, 196);
	
}
/*========================================================================*/
/*===================게시글 메인=========================================*/
.post_main{
	
	width:100%;
	height:auto;
}
#post_title{
	border:none;
}
.uploadBox{
	width:1000px;
	margin:auto;
	display:none; /*수정버튼 클릭시 보이게할것*/
}
.photoBox{
	width:1000px;
	height:auto;
	margin:auto;
}
.contentBox{
	width:1000px;
	margin:auto;
	height:auto;
	border:1px solid lightgray;
}
.contentBox>textarea{
 	min-height: 5rem;
	resize:none;
	border:none;
	overflow-y: hidden;

}

.btnBox{
	text-align:right;
	margin-right:10px;
	
}
.btnBox>div>button{
	background-color:rgb(86, 86, 196);
}
#btnsBox{
	display:block; /*자기게시글일 경우만 display:block 해줄것*/
}
#btnModifyDetailBox{
	display:none; /*수정버튼 누를때만 display:block 해줄것*/
}

#beforeGoodBtnBox{
	display:block; /*초기화면이면 block */
}
#afterGoodBtnBox{
	display:none; /*초기화면이면 none*/
}
#beforeGoodBtn{
	color:blue;
	border:1px solid blue;
	background-color:white;
}

#afterGoodBtn{
	color:white;
	background-color: blue;
}
/*따봉 색깔 논의 필요*/
#afterGoodBtn>svg{
	color:gray;
}

/*==================================================================*/
/*===========================댓글 영역 ==============================*/
.commentTitle{
	border-bottom: 1px double gray;
}
.cmt-showBox{
	margin-left:30px;
	
}
.cmt-showBox>div{
	height:50px;
	
}
.cmtReport{
	padding:2px;
	border-radius: 10px;
}
#comment_content{
	resize:none;
	border:none;
	width:400px;
	overflow:visible;


}
#btnReModify, #btnReDelete, #btnReBack {
	background-color: rgb(86, 86, 196);
}
#btnReDelete{
	background-color: rgb(86, 86, 196);
}
#beforeReBtnBox{
	display:block; /*수정버튼 누르면 none*/
	text-align:right;
	width:100%;
}
.btnBox{
	height:40px;
}
#afterReBtnBox{
	display:none; /*수정버튼 누르면 block*/
	text-align:right;
	width:100%;
	padding-bottom:20px;
}

.commentInput{
	border:1px solid gray;
	margin:auto;
	width:1100px;
}

#content-cmt{
	width:900px;
	min-height: 5rem;
	resize:none;
	overflow-y: hidden;
}
#modi_content_cmt{
	width:900px;
	min-height: 5rem;
	resize:none;
}
#btnReInsert{
	width:100px;
	height:80px;
	margin-left:40px;
	background-color:rgb(86, 86, 196);
}
.cmtReport{
	margin-bottom:65px;
}
.modiBox{
	border:1px solid gray;
	margin:auto;
	width:1100px;
	margin-right:80px;
}
#btnReGo{
	width:100px;
	height:80px;
	margin-left:40px;
	background-color:rgb(86, 86, 196);
}
</style>
</head>
<body>
	<div class="Wrapper">
	
		<!-- 헤더쪽(링크로 불러옴) -->
		<div id="header"></div>
		
		<!-- 게시글쪽 -->
		<div class="postDetailContainer mt-5 mb-5">
			<form action="${pageContext.request.contextPath}/modifyProc.bo" method="post" id="modifyPost"
			enctype="multipart/form-data">
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
            			<!-- 신고버튼 -->
            			<c:if test="${!empty loginSession}">
	            			<div class="col-1" id="reportBtnBox">
	            				<button type="button" value="게시글번호 넣어주세요." class="btn btn-danger" id="btnReport">
	            					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-diamond-fill" viewBox="0 0 16 16">
	  								<path d="M9.05.435c-.58-.58-1.52-.58-2.1 0L.436 6.95c-.58.58-.58 1.519 0 2.098l6.516 6.516c.58.58 1.519.58 2.098 0l6.516-6.516c.58-.58.58-1.519 0-2.098L9.05.435zM8 4c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995A.905.905 0 0 1 8 4zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
									</svg>
									<span>신고</span>
	            				</button>
	            			</div>
            			</c:if>
            		</div>
            		<!-- 사용자,등록일,조회수, 팔로우버튼 담을 공간 -->
            		<div class="row mx-4" id="post_title_main">
            			<!-- 사용자, 등록일, 조회수 -->
            			<div class="col-11 mt-2">
            				<span>by ${dto.getPost_writer_nickname() } || ${dto.getPost_createdDate() } || 조회수 ${dto.getPost_view_count() }</span>
            			</div>
            			<!-- 팔로우 버튼 -->
            			<c:if test="${!empty loginSession}">
	            			<div class="col-1 mb-2">
	            				<button type="button" class="btn btn-dark" id="followingBtn">팔로잉</button>
	            				<button type="button" class="btn btn-dark" id="followBtn">팔로우+</button>
	            			</div>
            			</c:if>
            		</div>
            	</div>	
            	
            	 
            	<!-- 게시글사진 + 게시글내용 + 수정삭제버튼 담을 곳 -->
            	<div class="post_main">
            		<!-- 수정시 사진파일 업로드시킬 인풋창 -->
					<div class="mt-4 uploadBox">
						<input class="form-control form-control-sm" id="formFileSm"
							name="photo_path" type="file" accept="image/*"
							onchange="readImg(event)"/>
					</div>
					<!-- 게시글 사진 불러올 공간 -->
            		<div class="row my-4 photoBox">
            			<img id="post_img" src="${pageContext.request.contextPath}/files/${dtoFile.getSystem_name()}">
            		</div>
            		<!-- 사진 미리 보기 -->
					<div class="row my-4 photoBox" id="preview"></div>
            		<!-- 게시글 내용 불러올 공간 -->
            		<div class="row contentBox">
            			<textarea id="post_content" onkeydown="resize(this)" onkeyup="resize(this)"
							name="post_content" readonly>${dto.getPost_content() }</textarea>
            		</div>
            		<!-- 수정,삭제 버튼 공간(다른사용자 게시글일 경우 hidden) -->
            		<c:set var="id" value="${dto.getPost_writer()}"/>
	                <c:if test="${id eq loginSession.get('user_id')}">
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
            		</c:if>
            		<!-- 종아요 버튼 -->
            		<!-- 버튼 누르기전 좋아요 -->
            		<c:if test="${!empty loginSession}">
	            		<div class="row my-2 btnBox"id="beforeGoodBtnBox">
	            			<div class="col">
	            				<button type="button" id="beforeGoodBtn" class="btn btn-light">
									<span class="totalCount">${totalCount}</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
									  <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
									</svg>
								</button>
	            			</div>
	            		</div>
	            			<!-- 버튼 누른 후 좋아요 -->
	            		<div class="row my-2 btnBox"id="afterGoodBtnBox">
	            			<div class="col">
	            				<button type="button" id="afterGoodBtn" class="btn btn-light">
									<span class="totalCount">${totalCount}</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
									  <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
									</svg>
								</button>
	            			</div>
	            		</div>
            		</c:if>
            		
            	</div>  	
            </form>
        </div><!-- 게시글 div끝  -->
        
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
		                
		                <!-- 댓글입력부분 -->
		                <div class="commentInput">
		                <form method="post" id="cmtForm">
		                	<div class="row mx-2 mb-2 mt-2">
		                		<div class="col">
		                			<label>댓글쓰기</label>
		                		</div>
		                	</div>
		                	<div class="row mx-2  comment-body">
		                		<div class="col-10 comment-input">
		                			<textarea id="content-cmt" name="comment_content" onkeydown='resize(this)' onkeyup='resize(this)'></textarea>
		                		</div>
		                		<div class="col-2 comment-input">
		                			<button type="button" id="btnReInsert" class="btn btn-dark">등록</button>
		                		</div>
		                		<input type="text" name="currentPage" value="${currentPage}" hidden>
								<input type="text" name="post_no" value="${dto.getPost_no()}" hidden>
								<input type="text" name="comment_writer_id" value="${dto.getPost_writer()}" hidden>
		                	</div>	
		                	</form>
		                </div>
	       </div><!-- 댓글 div끝 -->  
	</div><!-- 전체 div 끝 -->
	
	 <script src="https://code.jquery.com/jquery-3.6.0.js"
      integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
      crossorigin="anonymous"></script>
      
	<script>
	//텍스트창 자동 길이늘림
	function resize(obj) {
	    obj.style.height = '1px';
	    obj.style.height = (12 + obj.scrollHeight) + 'px';
	}
	
	//좋아요 버튼 변동
	//좋아요 기록할 경우 
	$("#beforeGoodBtn").click(function(){
		$("#beforeGoodBtnBox").css("display","none");
		$("#afterGoodBtnBox").css("display","block");
	})
	//좋아요 해제할 경우
	$("#afterGoodBtn").click(function(){
		$("#beforeGoodBtnBox").css("display","block");
		$("#afterGoodBtnBox").css("display","none");
	})
	
	
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
		location.href = "${pageContext.request.contextPath}/deleteProc.bo?post_no=${dto.getPost_no()}";
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
							+ "<div id='comment_content' name='comment_content'>" + cmt_dto.content + "</div>"
							+ "<button tpye='button' id = 'cmtReport' value='" + cmt_dto.comment_no + "' class='btn btn-danger btn-sm cmtReport'>신고</button>"
							+ "</div>"
							+ "<div class='col-3'>"
							+ cmt_dto.user_nickname +  "|" +cmt_dto.createdDate
							+ "</div>"
							+ "<div class='col-2 btnBox'>"
							+ "</div>"
							+ "</div>"
							+"<form method='post' id='modiCmtForm'>"
							+ "<div class='modiBox'  hidden>"
							+"<div class='row mx-2 mb-2 mt-2'>"
							+"<div class='col'>"
                			+"<label>댓글수정</label>"
	                		+"</div>"
	                		+"<div class='row mx-2  comment-body'>"
							+"<div class='col-10 comment-input'>"
							+"<textarea id='modi_content_cmt' name='modi_comment_content' onkeydown='resize(this)' onkeyup='resize(this)'>"+cmt_dto.content +"</textarea>"
							+"</div>"
							+"<div class='col-2 comment-input'>"
							+"<button type='button' id='btnReGo'  value='" + cmt_dto.comment_no + "' class='btn btn-dark'>Edit</button>"
							+"</div>"
							+"</div>"
							+ "</div>"
							+"</form>"
							$(".cmt-showBox").append(comment);
							
							
							
							if(${loginSession.get('user_id')} == cmt_dto.user_id){
										let btns="<div class='col-3' class='reBtnBox' id='beforeReBtnBox'>"
										+" <button type='button' id='btnReModify' value='" +cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Edit</button>"
										+ "<button type='button' id='btnReDelete' value='" + cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Delete</button>"
										+"</div>"
										+"<div class='col-3' class='reBtnBox' id='afterReBtnBox'>"
										+"<button type='button' id='btnReBack' class='btn btn-dark btn-sm'>Cancel</button>"
										+"</div>"

										$(".btnBox:last").append(btns);
										
										    
									}
							
							
							
							}
							
						
			}).fail(function(e){
	    		console.log(e);
	    	});
			}
				
		/*** 팔로우 테스트 ***/

		// 팔로우 버튼 전환 function
		function changeDisplay_follow(firstVal, lastVal) {
			document.getElementById("followBtn").style.display = firstVal; // 팔로우 하기 전
			document.getElementById("followingBtn").style.display = lastVal; // 팔로우 누른 뒤
		}

		// 로그인 유저가 작성자를 팔로우 한 적이 있으면, 팔로우 버튼이 눌린 상태로 로드되어야 함
		if(${checkFollow}) {
			changeDisplay_follow("none", "block");
		} else {
			changeDisplay_follow("block", "none");
		}

		// 로그인 유저와 작성자가 동일하다면 팔로우 버튼이 존재해서는 안됨
		if("${dto.getPost_writer()}" == "${loginSession.get('user_id')}") {
			document.getElementById("followBtn").remove();
			document.getElementById("followingBtn").remove();
		}

		// 버튼 변동 처리
		document.addEventListener("click", function(e) {
			if(e.target.id == "followBtn") { // 팔로우+ 버튼을 누를 때
				changeDisplay_follow("none", "block");
				follow("add");
			} else if(e.target.id == "followingBtn") { // 팔로잉 버튼을 누를 때 (언팔하겠다)
				changeDisplay_follow("block", "none");
				follow("remove");
			}
		});
		// 팔로우 처리
		function follow(count) {
			let followCount = 0; // 서버로 보낼 값
			if(count == "add") {  // count값이 add이면 +1처리
				followCount = 1;
			} else if(count == "remove") { // count값이 remove이면 -1처리
				followCount = -1;
			}
			$.ajax({ 
				type: "post",
				url: "${pageContext.request.contextPath}/followProc.bo",
				data: { 
					followCount: followCount,
					writer: "${dto.getPost_writer()}"
				}
			}).done(function(rs) {
				console.log(rs);
			}).fail(function(e) {
				console.log(e);
			});
		}
		
		/*** 좋아요 버튼 ***/

		// 좋아요 버튼 전환 function
		function changeDisplay_goodBtn(firstVal, lastVal) {
			document.getElementById("beforeGoodBtnBox").style.display = firstVal;
			document.getElementById("afterGoodBtnBox").style.display = lastVal;
		}

		//좋아요 버튼 변동
		//좋아요 기록할 경우 
		$("#beforeGoodBtn").click(function(){
			// $("#beforeGoodBtnBox").css("display","none");
			// $("#afterGoodBtnBox").css("display","block");
			changeDisplay_goodBtn("none", "block");
			goodCount("add"); // 좋아요 +1 메서드 호출
		})
		//좋아요 해제할 경우
		$("#afterGoodBtn").click(function(){
			// $("#beforeGoodBtnBox").css("display","block");
			// $("#afterGoodBtnBox").css("display","none");
			changeDisplay_goodBtn("block", "none");
			goodCount("remove"); // 좋아요 -1 메서드 호출
		})

		// 좋아요 판별
		if(${likeCheck}) { 
			// 유저가 이 게시물에 좋아요를 누른 적이 있다면, 좋아요 버튼이 눌린 상태로 게시물이 로드되어야 함
			// document.getElementById("beforeGoodBtnBox").style.display = "none";
			// document.getElementById("afterGoodBtnBox").style.display = "block";
			changeDisplay_goodBtn("none", "block");
		} else { // 그런 적 없다면 그냥 비어있는 좋아요 버튼 출력
			// document.getElementById("beforeGoodBtnBox").style.display = "block";
			// document.getElementById("afterGoodBtnBox").style.display = "none";
			changeDisplay_goodBtn("block", "none");
		}

		// 좋아요 Count처리
		function goodCount(count) {
			let goodCount = 0; // 서버로 보낼 값
			if(count == "add") {  // count값이 add이면 +1처리
				goodCount = 1;
			} else if(count == "remove") { // count값이 remove이면 -1처리
				goodCount = -1;
			}
			$.ajax({ 
				type: "post",
				url: "${pageContext.request.contextPath}/goodCountProc.bo",
				data: { // 로그인 한 유저 id는 Controller에서 세션으로 가져 올 생각
					goodCount: goodCount,
					postNo: "${dto.getPost_no()}"
				}
			}).done(function(rs) {
	        console.log("좋아요 수 :" + rs);
				// 총 count수를 rs에 받아서, count수를 span태그에 삽입
				document.getElementsByClassName("totalCount")[0].innerHTML = rs;
				document.getElementsByClassName("totalCount")[1].innerHTML = rs;
			}).fail(function(e) {
				console.log(e);
			});
		}
		
		 //댓글수정버튼 클릭시 확인,취소버튼 나오면서 인풋창 readonly해제          
		$(document).on('click', '#btnReModify', function(){
			$(this).parent().css("display", "none");
			$(this).parent().next().css("display", "block");
			$(".modiBox").attr("hidden", false);
			
			
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
		$(document).on('click', '#btnReGo', function(){
			let data =  $("#modiCmtForm").serialize();
			let value = $(this).val();
			let content = $("#modi_content_cmt").val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/modifyProc.co?comment_no="+value+"&comment_content=" + content
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
				,async:false
				, url : "${pageContext.request.contextPath}/getCommentProc.co?post_no=${dto.getPost_no()}"
				, dataType : "json"
			}).done(function(data){
				console.log(data);
				$(".cmt-showBox").empty();
				for(let cmt_dto of data){
							let comment = "<div class='row mb-2 mx-1 my-3'>"
							+ "<div class='col-6'>"
							+ "<div id='comment_content' name='comment_content'>" + cmt_dto.content + "</div>"
							+ " <button tpye='button' id = 'cmtReport' value='" + cmt_dto.comment_no + "' class='btn btn-danger btn-sm cmtReport'>신고</button>"
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
							+"<textarea id='modi_content_cmt' name='modi_comment_content' onkeydown='resize(this)' onkeyup='resize(this)'>"+cmt_dto.content +"</textarea>"
							+"</div>"
							+"<div class='col-2 comment-input'>"
							+"<button type='button' id='btnReGo'  value='" + cmt_dto.comment_no + "' class='btn btn-dark'>Edit</button>"
							+"</div>"
							+"</div>"
							+ "</div>"
							+"</form>"
							$(".cmt-showBox").append(comment);
						
							

							if(${loginSession.get('user_id')} == cmt_dto.user_id){
									let btns="<div class='col-3' class='reBtnBox' id='beforeReBtnBox'>"
									+" <button type='button' id='btnReModify' value='" +cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Edit</button>"
									+ "<button type='button' id='btnReDelete' value='" + cmt_dto.comment_no + "' class='btn btn-dark btn-sm'>Delete</button>"
									+"</div>"
									+"<div class='col-3' class='reBtnBox' id='afterReBtnBox'>"
									+"<button type='button' id='btnReBack' class='btn btn-dark btn-sm'>Cancel</button>"
									+"</div>"
									
									$(".btnBox:last").append(btns);
								}
							
							}
						
			}).fail(function(e){
	    		console.log(e);
	    	});
			
	})
	// 신고버튼 클릭 처리 btnReport, cmtReport
	$("#btnReport").on("click", function(){
		let url = "${pageContext.request.contextPath}/toReport.re?post_no=${dto.getPost_no()}&report_type=1&reported_comment_no=0";
		let name = "신고하기";
		let option = "width=750, height=760, top=300";
		window.open(url, name, option);
	})
	$(document).on('click', '#cmtReport', function(){
		let val = $('#cmtReport').val();
		console.log(val);
		let url = "${pageContext.request.contextPath}/toReport.re?post_no=${dto.getPost_no()}&report_type=2&reported_comment_no="+val;
		let name = "신고하기";
		let option = "width=750, height=760, top=300";
		window.open(url, name, option);
	})
	</script>
</body>
</html>