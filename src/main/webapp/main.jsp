<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="icon" type="image/png" href="http://example.com/myicon.png"> 
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/3.1.8/imagesloaded.pkgd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/masonry/3.3.1/masonry.pkgd.min.js"></script>

    <script type="text/javascript">
    
    
        $(document).ready(function(){
            $("#header").load("resources/header/header.jsp")
            
            var $container = $("#masonry-container");
        	$container.imagesLoaded(function () {
        	    $container.masonry();
        	});
         });
     	
        
    </script>
    <style>
    /*캐러셀 나오는 부분만*/
.Main{
    position: relative;
    width:100rem; /*1600px*/
    background-color: aliceblue;
    height: auto;
    left:9.375rem; /*150px*/
}
        /*캐러셀 안의 사진*/
.card-img>img{
    width:31.25rem; /*500px*/
    height: 12.5rem; /*200px*/
}
        /*사진아래 검은색처리부분*/
.card-img-overlay{
    position: absolute;
    top:6.25rem; /*100px*/
    height: 6.25rem; /*100px*/
    background-color: #00000050;
}
        /*캐러셀 문구*/
.card-img-overlay>p{
    color: white;
    font-size: large;
    padding-top: 0.938rem; /*15px*/
    font-weight: 900;
}
        
@media (max-width: 767px) {
.carousel-inner .carousel-item > div {
    display: none;
    }
.carousel-inner .carousel-item > div:first-child {
    display: block;
    }
}

.carousel-inner .carousel-item.active,
.carousel-inner .carousel-item-next,
.carousel-inner .carousel-item-prev {
    display: flex;
}

/* medium and up screens */
@media (min-width: 768px) {
    
.carousel-inner .carousel-item-end.active,
.carousel-inner .carousel-item-next {
    transform: translateX(25%);
    }
    
.carousel-inner .carousel-item-start.active, 
.carousel-inner .carousel-item-prev {
    transform: translateX(-25%);
    }
}

.carousel-inner .carousel-item-end,
.carousel-inner .carousel-item-start { 
    transform: translateX(0);
}
/*게시글나오는부분만*/
 .Main2{
    position: relative;
    width:100rem; /*1600px*/
    background-color: aliceblue;
    height: auto;
    left:9.375rem; /*150px*/
}
/*게시글1개 전체부분*/
.item {
    margin : 0.625rem; /*10px*/
    width : 300px; /*300px*/
    height: auto;
    background-color : #FFFFFF;
    
    border-radius : 10px;
    float : left;
    border:1px solid lightgray;
}
/*게시글 사진*/
#photoBox>img{
    width: 100%;
    height: auto;
    border-top-left-radius : 7px;
    border-top-right-radius : 7px;
}
/*유저정보부분*/
#infoBox{
    width: 100%;
    height: 12.5rem; /*200px*/
}
/*게시글제목부분*/
.infoBox_header{
    height: 30%;
    margin-left: 0.625rem; /*10px*/
}
.infoBox_header>a{
	text-decoration: none;
}
.infoBox_header>a>p{
    font-size: x-large;
    padding-top: 0.625rem; /*10px*/
    color:black;
}
/*프로필사진+아이디부분*/
.infoBox_main{
    height: 40%;
    margin-left: 1.25rem; /*20px*/
    padding-top: 0.625rem; /*10px*/
}
.infoBox_main>div{
    float: left;
}
#info_profilePhoto{ 
    width: 2.5rem; /*40px*/
    height: 2.5rem; /*40px*/
    border-radius: 30px;
    cursor: pointer;
}
#infoBox_main_nickname>a{
	text-decoration:none;
}
#infoBox_main_nickname>a>p{
    font-size: medium;
    padding-left: 1.25rem; /*20px*/
    padding-top: 0.938rem; /*15px*/
    color:black;
    
}
/*게시글정보(좋아요,댓글,조회수)*/
.infoBox_footer{
    height: 30%;
    margin-left:15px;
}
.infoBox_footer>div{
    float: left;
    width: 45px; /*50px*/
    text-align: center;
    padding-top: 0.625rem; /*10px*/
}
/*=====================================================================*/
/*푸터*/
.Footer{
    position: relative;
    width:118.75rem; /*1900px*/
    height:6.25rem; /*100px*/
    background-color: #5656c4;
}
#footer_logo{
    position:absolute;
    font-size:50px;
    color:white;
    font-style: italic;
    font-weight: bold;
    text-shadow: 6px 2px 2px gray;
    left:15rem; /*240px*/
    top:0.625rem; /*10px*/
}
#footer_Info{
    position:absolute;
    font-size: large;
    color: white;
    left:43.75rem; /*700px*/
    top:1.25rem; /*20px*/
    font-weight: 800;
}
#footer_Info>span{
    font-style: italic;
    font-weight: bold;
    text-shadow: 6px 2px 2px gray;
}
#footer_Info2{
	position:absolute;
    font-size: large;
    color: white;
    left:50rem; /*600px*/
    top:3.75rem; /*60px*/
    font-weight: 800;
}
#footer_Info2>a:hover{
	color:black;
	cursor:pointer;
}
    </style>
</head>
<body>
<div class="wrapper">
    <div id="header"></div>
	<div class="Main">
		 <!--캐러셀-->
            <div class="container text-center my-3">
                <!--위쪽 제목 -->
                <h1 class="font-weight-light">Category of Photofolio</h1>
                <div class="row mx-auto my-auto justify-content-center">
                    <div id="recipeCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner" role="listbox">	
                            <div class="carousel-item active">
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=1">
                                        <div class="card-img">
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3RfENSzOHZLPBqLXMRt_2aYYHG5J1kqzcBw&usqp=CAU" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>일러스트</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="carousel-item" value=2>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=2">
                                        <div class="card-img">
                                            <img src="data:image/jpeg;base64,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" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>포토</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item" value=3>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=3">
                                        <div class="card-img">
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwrRb2CMNFKTz0v_qZ2ksO73oDmaeyz_QGsA&usqp=CAU" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>페인팅</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item" value=4>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=4">
                                        <div class="card-img">
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnTywW3P3LDPAN6esUiKTrDHpHFB-SudKk4A&usqp=CAU" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>캘리그라피</p>
                                        </div>
                                     </a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item" value=5>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=5">
                                        <div class="card-img">
                                            <img src="data:image/png;base64,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" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>디자인</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item" value=6>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=6">
                                        <div class="card-img">
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNmsNzJExGNtJsfUjHXz6l6aD22QHWVTk-Hw&usqp=CAU" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>조각</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item" value=7>
                                <div class="col-md-3">
                                    <div class="card">
                                    <a href="${pageContext.request.contextPath }/toSearchByCategory.bo?category_no=7">
                                        <div class="card-img">
                                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAFUBAhc5PmNbLhLZNJjtRnFjTIqlDac4r-w&usqp=CAU" class="img-fluid">
                                        </div>
                                        <div class="card-img-overlay">
                                            <p>기타</p>
                                        </div>
                                    </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control-prev bg-transparent w-aut" href="#recipeCarousel" role="button" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </a>
                        <a class="carousel-control-next bg-transparent w-aut" href="#recipeCarousel" role="button" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
                <h5 class="mt-2 fw-light">The best and most beautiful things in the world cannot be seen or even touched-they must be felt with the heart.</h5>
                <h5 class="mt-2 fw-ligth">-Helen Keller</h5>
            </div>
      	</div><!-- 메인끝 -->
   
      	<!-- 메인2 시작 -->
      	<div class="Main2">
      		<!--게시글영역-->
      		
            <div id="masonry-container">
                <!--게시글-->
                  <c:forEach items="${list}" var="list">
                  	<div class = "item">
                		<!--사진단-->
                		<a href="${pageContext.request.contextPath}/toDetailPost.bo?post_no=${list.getPost_no()}">
	                   <div id="photoBox">
	                   
	                   			<img src="${pageContext.request.contextPath}/files/${list.getSystem_name()}">
	                   		
	                   </div>
	                   </a>
	                   <!--유저정보단-->
	                   <div id="infoBox">
	                       <!--게시글제목부분-->
	                       <div class="infoBox_header">
	                       		<a href="${pageContext.request.contextPath}/toDetailPost.bo?post_no=${list.getPost_no()}">
	                       			<p>${list.getPost_title() }</p>
	                       		</a>   
	                       </div>
	                       <!--유저프로필부분-->
	                       <div class="infoBox_main">
	                           <!--유저프로필사진-->
	                           <div id="infoBox_main_profile">
	                             	
		                               	  <a href = "${pageContext.request.contextPath}/indToUser.bo?currentPage=1&user_id=${list.getPost_writer()}">
		                               	  	<img class="toUserPage" src="${pageContext.request.contextPath}/upload/${list.getProfilephoto_path()}" id="info_profilePhoto">
		                               	  </a>
									      	      
	                           </div>
	                           <!--유저아이디-->
	                           <div id="infoBox_main_nickname">
	                           		<a href = "${pageContext.request.contextPath}/indToUser.bo?currentPage=1&user_id=${list.getPost_writer()}">
	                           		 	<p>${list.getPost_writer_nickname() }</p>
	                           		</a> 
	                           </div>
	                       </div>
	                       <!--게시글정보부분-->
	                       <div class="infoBox_footer">
	                           <!--좋아요-->
	                           <div>
	                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-emoji-smile" viewBox="0 0 16 16">
	                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
	                                <path d="M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
	                              </svg>
	                           </div>
	                           <div>${list.getLikeCnt() }</div>
	                           <!--댓글-->
	                           <div>
	                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
	                                <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
	                                <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
	                              </svg>
	                           </div>
	                           <div>${list.getCommentCnt()}</div>
	                           <!--조회수-->
	                           <div>
	                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
	                                <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
	                                <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
	                              </svg>
	                           </div>
	                           <div>${list.getPost_view_count() }</div>
	                       </div>
	                   </div>
                	</div>
                  </c:forEach>

           </div> <!-- 메인2영역끝 -->    
      	</div><!-- 메인2끝 --> 	
      	<div class="Footer">
      		<p id="footer_logo">PhotoFolio</p>
            <p id="footer_Info">T 02- 0000- 0000  &nbsp;|&nbsp;  A 서울 강남구 테헤란로 14길 6  &nbsp;|&nbsp;  Copyright 2021 ©<span>Photofolio</span>. All right reserved. </p>
            <p id="footer_Info2">포토폴리오 운영팀:help@photofolio.com | <a>이용약관</a> | <a><b>개인정보처리방침</b></a></p>
        </div>
</div>

  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script>
   
      let items = document.querySelectorAll('.carousel .carousel-item')

        items.forEach((el) => {
            const minPerSlide = 4
            let next = el.nextElementSibling
            for (var i=1; i<minPerSlide; i++) {
                if (!next) {
                // wrap carousel by using first child
                next = items[0]
                }
                let cloneChild = next.cloneNode(true)
                el.appendChild(cloneChild.children[0])
                next = next.nextElementSibling
            }
        })
      
        
    </script>
</body>
</html>