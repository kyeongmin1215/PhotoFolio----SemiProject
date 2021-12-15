<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 *{box-sizing: border-box;
            margin:0;}
       
       /*위로 올리는 버튼*/
.toUpBtn{
    position:fixed;
    z-index: 2;
    right:0.625rem; /*10px*/
    bottom:0.625rem; /*10px*/
    cursor: pointer;
    display: none;
} 
        .Wrapper{
            border: 1px solid black;  
            margin: auto;
            width:118.75rem;/*1900px*/     
            overflow: hidden;                                                                                                          
        }
        .Header{
            position: relative;
            height: 4.688rem; /*75px*/
            /* border-bottom:1px solid black; */
            background-color: rgb(86, 86, 196);
            width: 120rem;/*1900px*/
            z-index: 1;
        }
        /*로고, 검색창, 알림,프로필영역 나눔*/
        .Header>div{
            float: left; 
        }
        /*로고 CSS*/
        #logoBox{
            width:20%;
            height: 100%; 
        }
        #logoBox>p{
            position: absolute;
            color:white;
            font-size: xX-large;
            font-style: italic;
            font-weight: bold;
            text-shadow: 6px 2px 2px gray;
            top:0.688rem; /*11px*/
            left:9.375rem; /*150px*/
            cursor: pointer;
        }
        /*검색창영역 CSS*/
        #inputBox{
            width:40%;
            height: 100%;
        }
        .search-wrapper {
            position: absolute;
            transform: translate(-100%, -50%);
            top:2.188rem; /*35px*/
            left:75rem; /*1200px*/
        }
        .search-wrapper.active {}
        
        .search-wrapper .input-holder {    
            height: 4.375rem; /*70px*/
            width:4.375rem; /*70px*/
            overflow: hidden;
            background: #5656c4;
            border-radius:6px;
            position: relative;
            transition: all 0.3s ease-in-out;
        }
        .search-wrapper.active .input-holder {
            width:28.125rem; /*450px*/
            border-radius: 50px;
            background: white;
            transition: all .5s cubic-bezier(0.000, 0.105, 0.035, 1.570);
        }
        .search-wrapper .input-holder .search-input {
            width:100%;
            height: 3.125rem; /*50px*/
            padding:0rem 4.375rem 0rem 1.25rem; /*0 70 0 20px*/
            opacity: 0;
            position: absolute;
            top:0px;
            left:0px;
            background: transparent;
            box-sizing: border-box;
            border:none;
            outline:none;
            font-family:"Open Sans", Arial, Verdana;
            font-size: 1rem; /*16px*/
            font-weight: 400;
            line-height: 1.25rem; /*20px*/
            color: white;
            transform: translate(0, 60px); 
            transition: all .3s cubic-bezier(0.000, 0.105, 0.035, 1.570);
            transition-delay: 0.3s;
        }
        .search-wrapper.active .input-holder .search-input {
            opacity: 1;
            transform: translate(0, 10px); 
        }
        .search-wrapper .input-holder .search-icon {
            width:4.375rem; /*70px*/
            height:4.375rem; /*70px*/
            border:none;
            border-radius:6px;
            background: #5656c4;
            padding:0px;
            outline:none;
            position: relative;
            z-index: 2;
            float:right;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }
        .search-wrapper.active .input-holder .search-icon {
            width: 3.125rem; /*50px*/
            height:3.125rem; /*50px*/
            margin: 0.625rem; /*10px*/
            border-radius: 30px;
        }
        .search-wrapper .input-holder .search-icon span {
            width:1.375rem; /*22px*/
            height:1.375rem; /*22px*/
            display: inline-block;
            vertical-align: middle;
            position:relative;
            transform: rotate(45deg);
            transition: all .4s cubic-bezier(0.650, -0.600, 0.240, 1.650);
        }
        .search-wrapper.active .input-holder .search-icon span {
            transform: rotate(-45deg);
        }
        .search-wrapper .input-holder .search-icon span::before, .search-wrapper .input-holder .search-icon span::after {
            position: absolute; 
            content:'';
        }
        /*돋보기 손잡이*/
        .search-wrapper .input-holder .search-icon span::before {
            width: 0.25rem; /*4px*/
            height: 1.25rem; /*20px*/
            left: 0.5rem; /*8px*/
            top: 1.188rem; /*19px*/
            border-radius: 2px;
            background: white;
        }
        .search-wrapper .input-holder .search-icon span::after {
            width: 1.875rem; /*30px*/
            height: 1.875rem; /*30px*/
            left: -0.313rem; /*-5px*/
            top: -0.563rem; /*-9px*/
            border-radius: 16px;
            border: 4px solid white;
        }
        .search-wrapper .close {
            position: absolute;
            z-index: 1;
            top:1.5rem; /*24px*/
            right:1.25rem; /*20px*/
            width:1.563rem; /*25px*/
            height:1.563rem; /*25px*/
            cursor: pointer;
            transform: rotate(-180deg);
            transition: all .3s cubic-bezier(0.285, -0.450, 0.935, 0.110);
            transition-delay: 0.2s;
        }
        .search-wrapper.active .close {
            right:-1.875rem; /*-30px*/
            transform: rotate(45deg);
            transition: all .6s cubic-bezier(0.000, 0.105, 0.035, 1.570);
            transition-delay: 0.5s;
        }
        .search-wrapper .close::before, .search-wrapper .close::after {
            position:absolute;
            content:'';
            background: white;
            border-radius: 2px;
        }
        .search-wrapper .close::before {
            width: 0.313rem; /*5px*/
            height: 1.563rem; /*25px*/
            left: 0.625rem; /*10px*/
            top: 0px;
        }
        .search-wrapper .close::after {
            width: 1.563rem; /*25px*/
            height: 0.313rem; /*5px*/
            left: 0px;
            top: 0.625rem; /*10px*/
        }
        
        /*알림창영역*/
        #noticeBox{
            width: 10%;
            height: 100%;
            text-align: center;
            padding-top:0.938rem; /*15px*/
            
        }
        /*알림창 종 이미지 */
        #noticeBox>svg{
            position: absolute;
            color: white;
            cursor: pointer;
            left:81.875rem; /*1310px*/
        }
        /*알림창*/
        #noticeBox>div{
            position: absolute;
            width:18.75rem; /*300px*/
            height: auto; /*300px*/
            top:4.688rem; /*75px*/
            left:73.938rem; /*1183*/
            display: none;
            background-color:white;
            border:1px solid black;
        }
        /*업로드영역*/
        #uploadBox{
            width: 10%;
            height: 100%;
        }
        /*업로드버튼 효과처리*/
        .uploadBtn {
            position: absolute;
            border: none;
            background: rgba(86,86,196,1);
              background: linear-gradient(0deg, rgba(86,86,196,1) 0%, rgba(86,86,196,1) 100%);
              color: #fff;
              overflow: hidden;
              width:7.5rem; /*120px*/
              height: 2.5rem; /*40px*/
              top:1.125rem; /*18px*/
              left:89.188rem; /*1427px*/
          }
          /*업로드 아이콘*/
          .uploadBtn>svg{
            position: absolute;
            left:0.625rem; /*10px*/
            top:0.125rem; /*2px*/
          }
          /*업로드 문구*/
          .uploadBtn>span{
            position: absolute;
            left:3.75rem; /*60px*/
          }
          .uploadBtn:hover {
              text-decoration: none;
              color: #fff;
          }
          .uploadBtn:before {
              content: '';
              display: inline-block;
              top: -11.25rem; /*-180px*/
              left: 1.875rem; /*30px*/
              width: 1.875rem; /*30px*/
              height: 10%;
              background-color: #fff;
              animation: shiny-btn1 3s ease-in-out infinite;
          }
          .uploadBtn:hover{
            opacity: .7;
          }
          .uploadBtn:active{
            box-shadow:  4px 4px 6px 0 rgba(255,255,255,.3),
                        -4px -4px 6px 0 rgba(116, 125, 136, .2), 
              inset -4px -4px 6px 0 rgba(255,255,255,.2),
              inset 4px 4px 6px 0 rgba(0, 0, 0, .2);
          }
          @-webkit-keyframes shiny-btn1 {
              0% { -webkit-transform: scale(0) rotate(45deg); opacity: 0; }
              80% { -webkit-transform: scale(0) rotate(45deg); opacity: 0.5; }
              81% { -webkit-transform: scale(4) rotate(45deg); opacity: 1; }
              100% { -webkit-transform: scale(50) rotate(45deg); opacity: 0; }
          }
        
        /*프로필영역*/
        #profileBox{
            width:20%;
            height: 100%;
        }
        #profilePhoto{ /*프로필사진*/
            position: absolute;
            width: 3.125rem; /*50px*/
            height: 3.125rem; /*50px*/
            border-radius: 30px;
            margin-top:0.625rem; /*10px*/
            left: 101.25rem; /*1620px*/
            cursor: pointer;
            overflow:hidden;
        }
     	 #profilePhoto>img{
    		width: 100%;
   			height: 100%;
   		 	object-fit:cover;
        }
        /*프로필메뉴*/
        #profileMenu{
            position: absolute;
            background-color: #5656c4;
            text-align: center;
            width:12.5rem; /*200px*/
            height: 200px; /*200px*/
            top:4.688rem; /*75px*/
            left:96.875rem; /*1550px*/
            display:none;
        }
        #profileMenu>ul{ 
            list-style: none;
            padding-left: 0;
            height: 100%;
            cursor: pointer;
        }
        #profileMenu>ul>a>li{
            border: 1px solid white;
            height: 33%;
            padding-top: 0.938rem; /*15px*/
        }
        #profileMenu>ul>a{
            text-decoration: none;
            color:white;
            font-size: large;
        }
        /*프로필 메뉴 호버했을때의 효과*/
        #profileMenu>ul>a:hover{
            color:rgb(86, 86, 196);
        }
        #profileMenu>ul>a>li:hover {
            background-color: white;
        }
        /*로그인 영역*/
        #loginBox{
            width: 20%;
            height: 100%;
        
        }
        
        /*로그인 버튼처리*/
        
        .loginBtn{/*버튼 움직일때는 이 값을 건드리기*/
            position: absolute;
            left: 100rem; /*1600px*/
            top:1.063rem; /*17px*/
            border:none;
            box-shadow: none;
            width: 8.125rem; /*130px*/
            height: 2.5rem; /*40px*/
            line-height: 2.625rem; /*42px*/
            -webkit-perspective: 230px;
            perspective: 230px;
          }
          .loginBtn span {
            background: rgb(166, 166, 221);
          background: linear-gradient(0deg, rgb(166, 166, 221) 0%, rgb(86, 86, 196) 100%);
            display: block;
            position: absolute;
            width: 8.125rem; /*130px*/
            height: 2.5rem; /*40px*/
            box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
             7px 7px 20px 0px rgba(0,0,0,.1),
             4px 4px 5px 0px rgba(0,0,0,.1);
            border-radius: 5px;
            margin:0;
            text-align: center;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            -webkit-transition: all .3s;
            transition: all .3s;
            top:0;
            left:0;
            color:white;
          }
          .loginBtn span:nth-child(1) {
            box-shadow:
             -7px -7px 20px 0px #fff9,
             -4px -4px 5px 0px #fff9,
             7px 7px 20px 0px #0002,
             4px 4px 5px 0px #0001;
            -webkit-transform: rotateX(90deg);
            -moz-transform: rotateX(90deg);
            transform: rotateX(90deg);
            -webkit-transform-origin: 50% 50% -20px;
            -moz-transform-origin: 50% 50% -20px;
            transform-origin: 50% 50% -20px;
          }
          .loginBtn span:nth-child(2) {
            -webkit-transform: rotateX(0deg);
            -moz-transform: rotateX(0deg);
            transform: rotateX(0deg);
            -webkit-transform-origin: 50% 50% -20px;
            -moz-transform-origin: 50% 50% -20px;
            transform-origin: 50% 50% -20px;
          }
          .loginBtn:hover span:nth-child(1) {
            box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
             7px 7px 20px 0px rgba(0,0,0,.1),
             4px 4px 5px 0px rgba(0,0,0,.1);
            -webkit-transform: rotateX(0deg);
            -moz-transform: rotateX(0deg);
            transform: rotateX(0deg);
          }
          .loginBtn:hover span:nth-child(2) {
            box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
             7px 7px 20px 0px rgba(0,0,0,.1),
             4px 4px 5px 0px rgba(0,0,0,.1);
           color: transparent;
            -webkit-transform: rotateX(-90deg);
            -moz-transform: rotateX(-90deg);
            transform: rotateX(-90deg);
          }
          
          /*** notice영역 ***/

.noti_table {
    width: 100%;
}
.noti_userImg_wrapper {
    width: 70px;
}
#noti_userImg {
    width: 50px;
    height: 50px;
    border-radius: 75%;
}
.noti_msg {
    width: 200px;
}
.noti_msg > span {
    font-size: small;
}
.noti_delete {
    margin: 10px;
    text-align: right;
}
.noti_delete > img {
    opacity: 70%;
    cursor: pointer;
}
.noti_date {
    width: 200px;
    /* height: 25px; */
}
.noti_date > span {
    font-size: small;
}
</style>
</head>
<body>
 <!--위로 올리는 버튼-->
    <div class="toUpBtn">
        <svg xmlns="http://www.w3.org/2000/svg" id="toUp" width="35" height="35" fill="currentColor" class="bi bi-arrow-up-circle-fill" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
          </svg>
    </div>     
    <div class="Header">
            <!--로고 영역-->
            <div id="logoBox">
                <p id="logo">PhotoFolio</p>
            </div>
            <!--검색창 영역-->
            <div id="inputBox">
                <div class="search-wrapper">
                    <div class="input-holder">
                        <input onkeyup="enterkey();" type="text" id="search-input" class="search-input" placeholder="Type to search" style="color: black;" />
                        <!-- <input type="text" class="search-input" placeholder="Type to search" style="color: black;"/> -->
                        <button class="search-icon" onclick="searchToggle(this, event);"><span></span></button>
                    </div>
                    <span class="close" onclick="searchToggle(this, event);"></span>
                </div>
            </div>
            <!--알림창 버튼영역 (아이콘 클릭시 알림창 내려옴) + 비로그인시 숨김-->
				<div id="noticeBox">
					<c:if test="${!empty loginSession}">
				      <svg xmlns="http://www.w3.org/2000/svg" id="noticeImg" width="45" height="45" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
				          <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
				      </svg> 
				      <div id="notice">
				      		<table class="noti_table">
				      		</table>
				            <!--동적 추가-->
				        </div>
				    </c:if>
				</div>
            <!--업로드 버튼영역 + 비로그인시 숨김-->
            
	            <div id="uploadBox">
	            	<c:if test="${!empty loginSession}">
	                <button class="custom-btn uploadBtn">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-upload" viewBox="0 0 16 16">
	                        <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"/>
	                        <path d="M7.646 1.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 2.707V11.5a.5.5 0 0 1-1 0V2.707L5.354 4.854a.5.5 0 1 1-.708-.708l3-3z"/>
	                      </svg>
	                    <span>Upload</span>
	                    <div class="dot">
	                    </div>
	                </button>
	                </c:if>
	            </div>
            
            
            <c:choose>
	            <c:when test ="${!empty loginSession}">
	            <!--로그인 후의 프로필영역(프로필클릭시 메뉴단 내려옴)-->
			        <div id="profileBox">
			            <div id="profilePhoto">
			            <c:choose>
			            	<c:when test="${!empty loginSession.get('access_token') }">
			            		<img src="${loginSession.get('profilePhoto_path') }">
			           		 </c:when>
			           		 <c:otherwise>
			            		<img src="/upload/${loginSession.get('profilePhoto_path') }">
			            	 </c:otherwise>  
			            </c:choose>  
			            </div>
			            <div id=profileMenu>
			                <ul>
			                    <a href="${pageContext.request.contextPath}/toUserPage.bo?currentPage=1"><li>My Page</li></a>
			                    <a href="#" id="btnMyInfo"><li>My Infomation</li></a>
			                    <a href="${pageContext.request.contextPath}/logoutProc.mem"><li>Log Out</li></a>
			                </ul>
			            </div>
			        </div>
	            </c:when>     
	            <c:otherwise>
	            	 <!--로그인 전의 로그인버튼영역-->
	            	<div id="loginBox">
	                	<button type="button" class="custom-btn loginBtn"><span>Click!</span><span>Log In</span>
	                	</button>
	           		</div>
	            </c:otherwise>
            </c:choose>            	           	 
        </div>
    	
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
  
    <script>
        //일정길이 내려갔을때 위로 올리는 버튼 드러남
        $( window ).scroll( function() {
            if ( $( this ).scrollTop() > 200 ) {
                $( '.toUpBtn' ).fadeIn();
            } else {
                $('.toUpBtn').fadeOut();
            }
        } );

        //클릭했을 때 스르륵 올라가는 애니메이션
        $( '.toUpBtn' ).click( function() {
            $( 'html, body' ).animate( { scrollTop : 0 }, 100 );
            return false;
        } );
        //검색창 열리고 닫히는 스크립트
        function searchToggle(obj, evt){
            var container = $(obj).closest('.search-wrapper');
                if(!container.hasClass('active')){
                    container.addClass('active');
                    evt.preventDefault(); 
                }else if(container.find('.search-input').val()!=""){
                	let inputVal = container.find('.search-input').val();
                	console.log("inputVal : 1 : "+inputVal);
                	console.log("1 : "+ container.find('.search-input').val());
                	console.log("눌림 눌림");
                    location.href ="/toSearchByIdOrNickname.bo?inputVal="+inputVal;
                }else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
                    container.removeClass('active');
                    // clear input
                    var inputVal = container.find('.search-input').val();
                    console.log("inputVal : "+inputVal);
                    
                   /*  container.find('.search-input').val(''); */
                }
        }
        
        function enterkey(){
            if (window.event.keyCode == 13) {
               console.log($('#search-input').val());
               if($('#search-input').val()!=""){
                    let inputVal = $('#search-input').val();
                     location.href ="/toSearchByIdOrNickname.bo?inputVal="+inputVal;
                 }
            }
         }
        
        
        
        
			        /* function searchToggle(obj, evt){
			            var container = $(obj).closest('.search-wrapper');
			                if(!container.hasClass('active')){
			                    container.addClass('active');
			                    evt.preventDefault();
			                }
			                else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
			                    container.removeClass('active');
			                    // clear input
			                    container.find('.search-input').val('');
			                }
			        } */
			        //종버튼 클릭하면 알림창 나타나기/없어지기
			        $("#noticeImg").click(function(){
			            let submenu = $(this).next("div");
			            if(submenu.is(":visible")){
			                submenu.fadeOut();
			            }else{
			                submenu.fadeIn();
			            }
			        });
			        //로그인후 프로필 클릭하면 목록창이 나옴
			        $("#profilePhoto").click(function(){
			            let submenu = $(this).next("div");
			            if(submenu.is(":visible")){
			                submenu.fadeOut();
			            }else{
			                submenu.fadeIn();
			            }
			        });
			      //로고누르면 메인으로 
			        $("#logo").click(function(){
			            location.href="${pageContext.request.contextPath}/"
			        })
			        //My Infomation 누르면 개인정보페이지로 이동
			        $("#btnMyInfo").click(function(){
			            location.href="${pageContext.request.contextPath}/toMyPage.mem"
			        })
			        //로그인 버튼 누르면 로그인창 뜨도록
			        $(".loginBtn").click(function(){
			        	location.href="${pageContext.request.contextPath}/toLogin.mem"
			        })
			        $(".uploadBtn").click(function(){
			        	location.href="${pageContext.request.contextPath}/toInsertPost.bo"
			        })
			        
			        $(document).ready(function() {
			    getNoti(); // 로드되면 1회 실행
			    setInterval(getNoti, 3000); // 3초마다 재실행
			});
			      
			   let notiShare = "";
			
			function getNoti() {
			    $.ajax({
			        type: "get",
			        url: "${pageContext.request.contextPath}/selectNotiProc.bo",
			        dataType: "json"
			    }).done(function(rs) {
			        if(!(rs == "fail")) {
			        	 $(".noti_table").empty(); // 기존 리스트 제거
			            for (let noti of rs) {
	                        let image = "";
	                        if (noti.user_type == 3) { // kakao user
	                            image = '<img id="noti_userImg" src="' + noti.profilephoto_path + '">';
	                        } else {
	                            image = '<img id="noti_userImg" src="/upload/' + noti.profilephoto_path + '">';
	                        }
	                        let notiList = '<tr>'
	                            + '<td class="noti_userImg_wrapper">'
	                            + image
	                            + '</td>'
	                            + '<td class="noti_msg">'
	                            + '<span>' + noti.notiDto.noti_msg + '</span><br>'
	                            + '<span>' + noti.notiDto.noti_date + '</span>'
	                            + '</td>'
	                            + '<td class="noti_delete">'
	                            + '<img src="${pageContext.request.contextPath}/resources/imgTmp/trash.svg" id="' + noti.notiDto.noti_no + '">'
	                            + '</td>'
	                            + '</tr>';
	                        notiShare = notiList; 
	                        $(".noti_table").append(notiList); 
			                
			            }
			        } else {
			            console.log("수신 실패");
			        }
			    }).fail(function(e) {
			        console.log(e);
			    });
			}
			
			// 알림 삭제
			$(document).on("click", ".noti_delete > img", function(e) { // 바인딩 처리
			    $.ajax({
			        type: "post",
			        url: "${pageContext.request.contextPath}/deleteNotiProc.bo",
			        data: {
			            noti_no: e.target.id
			        }
			    }).done(function(rs){
			        console.log(rs);
			        if(rs == "true") {
			            $(e.target).parents("tr").remove();
			        }
			    }).fail(function(e){
			        console.log(e);
			    });
			});
    </script>
</body>
</html>