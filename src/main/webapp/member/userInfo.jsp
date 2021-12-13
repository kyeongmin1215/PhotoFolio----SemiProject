<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhotoFolio</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#header").load("/resources/header/header.jsp")      
         });
    </script>
    <style>
    /*제목부분*/
.titleInfo{
    position: relative;
    right:3.125rem; /*50px*/
    height: 6.25rem; /*100px*/
}
.titleInfo>h2{
    position: absolute;
    font-size: 50px; 
    top:0.625rem; /*10px*/
    left:48.75rem; /*780px*/
}
/*유저전체정보창(하늘색부분)*/
.userInfo{
	position:absolute;
 
    width:75rem; /*1200px*/
    height:78.125rem; /*1250px*/
    background-color: aliceblue;
    left:20.625rem; /*330px*/
}
.EveryInput{
    margin:auto;
    width:62.5rem; /*1000px*/
    height:81.25rem; /*1300px*/
    padding-top:0.625rem /*10px*/
}
.label{
    font-weight: 800;
}
.EveryInput>div{
    margin:2.5rem; /*40px*/
    margin-top:2.5rem; /*40px*/
}
  #image_container{
            width: 22.188rem; /*355px*/
            height: 22.188rem; /*355px*/  
            background-image: url("/upload/${dto.getProfilePhoto_path()}");
            background-size: cover;
            background-repeat: no-repeat;
            border-radius: 50%;
            padding-left:0;
            padding-right:0;
            overflow:hidden;
            
        }
 #image_container>img{
    width: 100%;
    height: 100%;
    object-fit:cover;
        }
#nicknameCheck, #nicknameBack, #emailCheck, #emailBack, #phoneBack, #phone_verification {
	display:none;
}
 #nicknameBack, #emailBack, #phoneBack{
 	margin-top:10px;
 }
#hiddenInput{
	margin-left:305px;
}
#hiddenInput2{
	margin-left:270px;
}
#hiddenInput, #hiddenInput2, #email_verification {
			display: none;
		}
.clsBtn{
	width:6.875rem; /*110px*/ 
}
.btnMD{
	width:8.125rem; /*130px*/
}
/*첫 시작화면시 버튼*/
.btnBox-first{
   /*position: absolute;*/
   text-aling:center;
   width:56.25rem; /*900px*/
   padding-left:50px;
   top:68.75rem; /*1100px*/
   visibility: visible;
}
.btnBox-first>div{
	text-align:center;
}
.btnBox-first>div>button{
    width:8.125rem; /*130px*/  
}
/*수정 눌렀을 시 버튼*/
.btnBox-last{
    position: absolute;
    width:56.25rem; /*900px*/
    top: 71.875rem; /*1150px*/
    left:23.125rem; /*370px*/
    visibility: hidden;
}
.btnBox-last>div>button{
    width:8.125rem; /*130px*/  
}

</style>
</head>
<body>

    <div class="wrapper">
        <div id="header"></div>
        <!-- 닉네임 출력 -->
        <div class="titleInfo">
            <h2>${dto.getUser_nickname() }<span>님의 정보</span></h2>
        </div>
        <!-- 유저정보 출력창 -->
    <div class="userInfo">
    	<form action="${pageContext.request.contextPath}/modifyProc.mem" id="modifyForm" method="post"
    	enctype="multipart/form-data">
            <div class="EveryInput">
            <!-- 아이디 영역 -> 수정 불가 -->
                <div class="row">
                    <div class="col-3 label">Login ID</div>
                    <div class="col-9">
                        <input type="text" id="user_id" name="user_id" class="form-control" value="${dto.getUser_id()}" readonly>
                    </div>
                </div>
                <!-- 닉네임영역 ->수정 가능(중복검사) -->
                <div class="row">
                	<input id="sub_nickname" value="${dto.getUser_nickname()}" name="subNN" hidden>
                    <div class="col-3 label">NickName</div>
                    <div class="col-7">
                        <input type="text" id="user_nickname" name="user_nickname" maxlength="10" value="${dto.getUser_nickname()}" class="form-control" readonly>
                        <div class="invalid-feedback">
						닉네임을 입력해주세요.
				    	</div>
				    	<span class="txtRegex" id="txtRegex_nickname"></span>
                    </div>
                    <div class="col-2" id="nicknameBtn-before">
                    	<button type="button" id="nicknameMD" class="btn btn-primary btnMD" disabled>수정</button>
                    	<button type="button" id="nicknameCheck" class="btn btn-primary clsBtn" disabled>중복 검사</button>
                    	<button type="button" id="nicknameBack" class="btn btn-secondary">취소</button>
                    </div>              
                </div>
                <!--프로필 영역-->
				<div class="row photoBox">
					<input value="${dto.getProfilePhoto_path()}" name="subFile" id="subFile" hidden>
    				<div class="col-3 label">Profile Image</div>
    				<div class="col-4">
       					 <div class="input-group mb-3">
       					 <c:if test="${empty loginSession.get('access_token') }">
       					 	<input type="file" class="form-control" name="file" accept="image/*" id="image" onchange="setThumbnail(event);" disabled>
       					 </c:if>
     	   		    	</div>
    				</div>
				    <div class="col-5" id="image_container"></div>
				</div>
                
                <!-- 이메일영역 -> 수정 가능(인증) -->
                <div class="row">
                	<input id="sub_email" value="${dto.getUser_email()}" hidden>
                    <div class="col-3 label">E-mail</div>
                    <div class="col-7">
                        <input type="text" id="user_email" name="user_email" maxlength="35" value="${dto.getUser_email()}" class="form-control" readonly>
                        <div class="invalid-feedback">
						이메일을 입력해주세요.
					    </div>
					    <span class="txtRegex" id="txtRegex_email"></span>
                    </div> 
                    <div class="col-2">
                    	<button type="button" id="emailMD" class="btn btn-primary btnMD" disabled>수정</button>
						<button type="button" class="btn btn-primary clsBtn" id="emailCheck" disabled>중복 검사</button>
						<button type="button" id="emailBack" class="btn btn-secondary">취소</button>
					</div>
                </div>
                <!--숨은 인증창-->
				<div class="row" id="hiddenInput2">
					<div class="col-md-9 mb-3">
						<input type="text" class="form-control" id="verification_input2" placeholder="인증번호 입력" required>
						<div class="invalid-feedback">
							이메일을 입력해주세요.
						</div>
					</div>
				<div class="col-md-3 mb-3">
					<button type="button" class="btn btn-primary" id="verification_submit2" disabled>인증번호 확인</button>
				</div>
			</div>
                
                <!-- 핸드폰영역 -> 수정가능(인증) -->
                <div class="row">
                	<input id="sub_phone_first" hidden>
                	<input id="sub_phone_second" hidden>
                	<input id="sub_phone_third" hidden>
                    <div class="col-3 label">Phone</div>
                    <div class="col-3">
                        <select name="phone_first" id="phone_first" class="form-select" aria-label="Default select example" disabled>
                            <option selected>010</option>
                            <option value="010">011</option>
                            <option value="010">016</option>
                            <option value="010">017</option>
                            <option value="010">018</option>
                        </select>
                        <span class="txtRegex" id="txtRegex_phone"></span>
                    </div>
                    <div class="col-2">
                        <input type="text" id="phone_second" name="phone_second" class="form-control" maxlength="4" readonly>
                    </div>
                    <div class="col-2">
                        <input type="text" id="phone_third" name="phone_third" class="form-control" maxlength="4" readonly>
                    </div>
                    <div class="col-2">
                    	 <button type="button" id="phoneMD" class="btn btn-primary btnMD" disabled>수정</button>
					     <button type="button" class="btn btn-primary" id="phone_verification" disabled>인증번호 발송</button>
				   		 <button type="button" id="phoneBack" class="btn btn-secondary">취소</button>
				    </div>
				    <!--숨은 인증창-->
		        	<div class="row my-4" id="hiddenInput">
				          <div class="col-md-6 mb-3">
					             <input type="text" class="form-control" id="verification_input" maxlength="4" placeholder="인증번호 입력" required>
				          </div>
				          <div class="col-md-6 mb-3">
				               	<button type="button" class="btn btn-primary" id="verification_submit" disabled>인증번호 확인</button>
				         </div>
		         	</div>
                    <input type="text" id="user_phone" name="user_phone" hidden>
                </div>
                
                <!-- 주소영역 -> 수정 가능  -->
                <div class="row">
                	<input id="sub_user_address" value="${dto.getUser_address()}" hidden>
                    <div class="col-3 label">Address</div>
                    <div class="col-9">
                    	<!-- 주소 병합한 곳 -->
                        <input type="text" id="user_address" name="user_address" class="form-control" value="${dto.getUser_address()}" readonly>
                    </div>
                </div>
                <div class="row addressBox">
                    <div class="col-3"></div>
                    <div class="col-4">
                        <input type="text" id="sample4_postcode" class="form-control" placeholder="우편번호" readonly>
                    </div>
                    <div class="col-4">
                        <input type="button" id="postbtn" class="btn btn-primary"onclick="sample4_execDaumPostcode()" value="우편번호 찾기" disabled>
                    </div>
                </div>
                <div class="row addressBox">
                    <div class="col-3"></div>
                    <div class="col-9">
                        <input type="text" id="sample4_roadAddress" class="form-control" placeholder="도로명주소" readonly>
                        <span id="guide" style="color:#999;display:none"></span>
                    </div>
                </div>
                <div class="row addressBox">
                    <div class="col-3"></div>
                    <div class="col-4">
                        <input type="text" id="sample4_detailAddress" class="form-control" placeholder="상세주소" readonly>
                    </div>
                    <div class="col-5">
                        <input type="text" id="sample4_extraAddress" class="form-control" placeholder="참고항목" readonly>
                    </div>
                </div>
                <div class="row btnBox-first">
                    <div class="col-3">
                        <button type="button" class="btn btn-success" id="btnModify">개인정보수정</button>
                    </div>
                    <div class="col-3" id="btnPwModifyBox">
                        <button type="button" class="btn btn-info" id="btnPwModify">비밀번호변경</button>
                    </div>
                    <div class="col-3">
                        <button type="button" class="btn btn-danger" id="btnDelete">회원탈퇴</button>
                    </div>
                    <div class="col-3">
                        <button type="button" class="btn btn-dark" id="btnHome">홈으로</button>
                    </div>
                </div>
                <div class="row btnBox-last">
                    <div class="col-3">
                        <button type="button" class="btn btn-success" id="btnGo">완료</button>
                    </div>
                    <div class="col-3">
                        <button type="button" class="btn btn-dark" id="btnBack">뒤로가기</button>
                    </div>
                </div>
            </div>
            </form>
        </div>
    
        
    </div>
   
    <script>
    
    
        
    //핸드폰 값 분할해서 찢어줌 
    let phone = "${dto.getUser_phone()}"
    
    document.getElementById("phone_second").value = phone.substring(3,7)
    document.getElementById("phone_third").value = phone.substring(7);
    document.getElementById("sub_phone_first").value = phone.substring(0,3);
    document.getElementById("sub_phone_second").value = phone.substring(3,7)
    document.getElementById("sub_phone_third").value = phone.substring(7);
    </script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	
	<script>
	//우편 API
	
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        //개인정보수정버튼 클릭시 아이디 제외한 인풋창 풀림 + 수정,완료 버튼 보이게함
        $("#btnModify").click(function(){
            $("#btnUpload").attr("readonly", false);        
            $("#phoneMD").attr("disabled", false);
            $("#sample4_detailAddress").attr("readonly", false);
            $("#postbtn").attr("disabled", false);
            $("#btnUpload").attr("disabled",false);
            $("#nicknameMD").attr("disabled", false);
            $("#emailMD").attr("disabled", false);
            $(".btnBox-first").css("visibility", "hidden");
            $(".btnBox-last").css("visibility", "visible");
            $("#image").attr("disabled", false);
        })
        
        		/***** 닉네임 영역 *****/
		//수정버튼 클릭시 중복검사와 취소버튼 나타남
        $("#nicknameMD").click(function(){
        	$("#nicknameCheck").attr("disabled", false);
        	$("#user_nickname").attr("readonly", false);
        	$("#nicknameCheck").css("display", "block");
        	$("#nicknameBack").css("display", "block");
        	$("#nicknameMD").css("display", "none");
        });
        
		// 변수 - 닉네임 관련
		let nickname = document.getElementById("user_nickname"); // nickname 입력창
		let nicknameCheck = document.getElementById("nicknameCheck"); // nickname 중복검사 버튼

		// 닉네임 정규식(통과하면 true, 아니면 false반환)
		function regexNickname() {
			const regexNickname = /[a-zA-Z0-9ㄱ-힣]{2,16}/; // 2~16자리 대소수한
			return regexNickname.test(nickname.value);
		}

		// 닉네임 중복검사(정규식 통과해야 검사하기)
		nicknameCheck.addEventListener("click", function () {
			if (regexNickname()) { // 정규식 통과할경우 중복검사 진행
				$.ajax({
					type: "post",
					url: "${pageContext.request.contextPath}/nicknameCheckProc.mem",
					data: {
						"nickname": nickname.value
					}
				}).done(function (data) { // 중복이 아니면 String형 false반환
					// 안내문구 출력 & 중복이 아니면 readOnly활성화 & 중복 검사 버튼 비활성화
					if (data == "false") {
						alert("사용 가능한 닉네임입니다.");
						nickname.readOnly = "true";
						nicknameCheck.disabled = "disabled";
					} else {
						alert("이미 존재하는 닉네임입니다. 다시 입력해주세요.");
					}
				}).fail(function (e) {
					console.log(e);
				});
			} else {
				txtRegex_nickname.innerText = "올바른 닉네임을 입력하세요.";
				txtRegex_nickname.style.color = "red";
			}
		});

		// 닉네임 입력창 벗어날 때 정규식 검사(중복검사 버튼과 겹침)
		nickname.addEventListener("change", function() {
		    if(!regexNickname()) {
				txtRegex_nickname.innerText = "올바른 닉네임을 입력하세요.";
				txtRegex_nickname.style.color = "red";
		    } else {
				txtRegex_pw.innerText = "";
			}
		});
		
		//취소버튼 클릭시 모든버튼과 값을 원위치
		$("#nicknameBack").click(function(){
			
			document.getElementById("user_nickname").value = document.getElementById("sub_nickname").value
			$("#user_nickname").attr("readonly", true);
			$("#nicknameCheck").attr("disabled", true);
			$("#nicknameCheck").css("display", "none");
        	$("#nicknameBack").css("display", "none");
        	$("#nicknameMD").css("display", "block");
		})
		
		/***** 이메일 영역 *****/
		
		//수정버튼 클릭시 중복검사와 취소버튼 나타남
		 $("#emailMD").click(function(){
        	$("#emailCheck").attr("disabled", false);
        	$("#verification_submit2").attr("disabled", false);
        	$("#user_email").attr("readonly", false);
        	$("#emailCheck").css("display", "block");
        	$("#emailBack").css("display", "block");
        	$("#emailMD").css("display", "none");
        });
		
		// 변수 - 이메일 관련
		let email = document.getElementById("user_email"); // 이메일 입력창
        let emailCheck = document.getElementById("emailCheck") // 중복 검사 버튼
		let verification_input2 = document.getElementById("verification_input2"); // 인증번호 입력창
		let verification_submit2 = document.getElementById("verification_submit2"); // 인증번호 확인버튼
		let verification_number2 = 0; // 인증번호 4자리 수 담을 공간

		// 이메일 정규식(정규식 문구 올바른지 검증 필요)
		function regexEmail() {
			const regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			return regexEmail.test(email.value);
		}

		// 이메일 입력창 벗어날 때 정규식 검사
		email.addEventListener("change", function () {
			if (!regexEmail()) {
				txtRegex_email.innerText = "이메일을 제대로 입력하세요.";
				txtRegex_email.style.color = "red";
			} else {
				txtRegex_email.innerText = "";
			}
		});

        // 이메일 중복검사 
        emailCheck.addEventListener("click", function() {
            if(regexEmail()) { // 정규식 통과해야 중복 검사
                $.ajax({
					type: "post",
					url: "${pageContext.request.contextPath}/emailCheckProc.mem",
					data: {
						"email": email.value
					}
				}).done(function (data) { // 중복이 아니면 String형 false반환
					if (data == "false") {
						alert("사용 가능한 이메일입니다. 인증번호를 보냈습니다."); // 안내문구 출력
						email.readOnly = "true"; // 이메일 입력창 잠그기
						emailCheck.disabled = "disabled"; // 이메일 중복검사 버튼 비활성화
						document.getElementById("hiddenInput2").style.display = "flex"; // 인증번호 입력창 띄우기
						sendEmail(); // 중복검사 통과함과 동시에 인증메일 발송하기
					} else {
						alert("이미 존재하는 이메일입니다. 다시 입력해주세요.");
					}
				}).fail(function (e) {
					console.log(e);
				});
            } else {
				txtRegex_email.innerText = "이메일을 제대로 입력하세요.";
				txtRegex_email.style.color = "red";
			}
        });

		// 인증메일 발송 
		function sendEmail() {
			$.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/sendEmailProc.mem",
				data: {
					"email": email.value
				}
			}).done(function (data) {
				// console.log("email 인증번호 4자리 : " + data);
				verification_number2 = data;
			}).fail(function (e) {
				console.log(e);
			});
		}

		// 4자리 인증번호 입력 후 확인 버튼 클릭시
		verification_submit2.addEventListener("click", function () {
			// 인증번호 입력 입력창과 실제 인증번호 같으면
			if (verification_input2.value == verification_number2) {
				alert("인증번호 일치");
				verification_input2.readOnly = "true"; // 이메일 입력창 잠금
				document.getElementById("hiddenInput2").style.display = "none"; // 인증번호 입력창 숨기기
			} else {
				alert("인증번호 불일치");
			}
		});
		
		//취소버튼 클릭시 모든버튼과 값을 원위치
		$("#emailBack").click(function(){
			
			document.getElementById("user_email").value = document.getElementById("sub_email").value
			$("#user_email").attr("readonly", true);
			$("#emailCheck").attr("disabled", true);
			$("#verification_submit2").attr("disabled", true);
			$("#emailCheck").css("display", "none");
        	$("#emailBack").css("display", "none");
        	$("#emailMD").css("display", "block");
        	$("#hiddenInput").css("display","none");
		})
		/***** 휴대전화 영역 *****/

		//수정버튼 클릭시 중복검사와 취소버튼 나타남
		$("#phoneMD").click(function(){
        	$("#phone_verification").attr("disabled", false);
        	$("#phone_first").attr("disabled", false);
        	$("#verification_submit").attr("disabled", false);
        	$("#phone_second").attr("readonly", false);
            $("#phone_third").attr("readonly", false);
        	$("#phone_verification").css("display", "block");
        	$("#phoneBack").css("display", "block");
        	$("#phoneMD").css("display", "none");
        });
		
		// 변수 -  휴대전화 관련
		let phone1 = document.getElementById("phone_first") // 번호 첫번째 영역
		let phone2 = document.getElementById("phone_second"); // 번호 중간 영역
		let phone3 = document.getElementById("phone_third"); // 번호 뒷자리 영역
		let phone_verification = document.getElementById("phone_verification"); // 인증번호 발송 버튼
		let verification_input = document.getElementById("verification_input"); // 인증번호 입력창(숨어있음)
        let verification_submit = document.getElementById("verification_submit"); // 인증번호 확인 버튼
		let phoneNumber = 0; // 휴대번호 11자리 담을 공간
		let verification_number = 0; // 4자리 인증번호 담을 공간

		// 휴대전화 정규식(통과하면 true, 아니면 false 반환)
		function regexPhone() {
			const regexPhone2 = /[0-9]{4,4}/;
			const regexPhone3 = /[0-9]{4,4}/;
			// 휴대전화 번호 중간 영역, 마지막 영역 모두 정규식 통과했을 경우
			if (regexPhone2.test(phone2.value) && regexPhone3.test(phone3.value)) {
				return true;
			} else {
				return false;
			}
		}

		// 휴대전화 인증 버튼 클릭시
		phone_verification.addEventListener("click", function () {
			if (regexPhone()) { // 정규식 통과해야 인증절차 진행
				// 번호 수정 차단 & 숨은 인증창 띄우기 & 인증번호 발송 알림창 띄우기
				phone1.disabled = "false";
				phone2.readOnly = "true";
				phone3.readOnly = "true";
				document.getElementById("hiddenInput").style.display = "flex";
				alert("인증번호가 발송되었습니다.");
				// 휴대전화 번호 서버로 넘겨서 문자발송 처리하기
				phoneNumber = phone1.value + phone2.value + phone3.value;
				$.ajax({
					type: "post",
					url: "${pageContext.request.contextPath}/sendSmsProc.mem",
					data: {
						"phoneNumber": phoneNumber
					}
				}).done(function (data) {
					// 서버에서 생성된 무작위 4자리 인증번호를 변수에 저장
					verification_number = data;
                    phone_verification.disabled = "disabled";
				}).fail(function (e) {
					console.log(e);
				});
			} else { // 정규식 미통과 경우
				alert("번호를 정확히 입력해주세요.");
			}
		});

		// 4자리 인증번호 입력 후 확인버튼 클릭시
		verification_submit.addEventListener("click", function () {
			// console.log("verification_input.value : " + verification_input.value);
			// console.log("verification_number : " + verification_number);

			// 입력한 번호와, 서버에서 생성한 번호가 일치할 때
			if (verification_number == verification_input.value) {
				alert("인증번호 일치"); // 알림창 띄우기
				verification_input.readOnly = "true"; // 인증번호 입력창 잠그기
				verification_submit.disabled = "disabled"; // 인증 발송 버튼 잠그기
			} else { // 일치하지 않는 경우
				alert("인증번호 불일치");
			}
		});
		//취소버튼 클릭시 모든버튼과 값을 원위치
		$("#phoneBack").click(function(){
			
			document.getElementById("phone_first").value = document.getElementById("sub_phone_first").value;
			document.getElementById("phone_second").value = document.getElementById("sub_phone_second").value
			document.getElementById("phone_third").value = document.getElementById("sub_phone_third").value
			$("#phone_first").attr("disabled", true);
			$("#phone_second").attr("readonly", true);
            $("#phone_third").attr("readonly", true);
			$("#phone_verification").attr("disabled", true);
			$("#phone_verification").css("display", "none");
			$("#verification_submit").attr("disabled", true);
        	$("#phoneBack").css("display", "none");
        	$("#phoneMD").css("display", "block");
        	$("#hiddenInput").css("display","none");
		})

        //뒤로가기 클릭시 다시 초기화면으로 돌아감
        $("#btnBack").click(function(){
            location.reload();
        })

        //홈으로 클릭시 메인화면으로 
        $("#btnHome").click(function(){
            location.href = "${pageContext.request.contextPath}/toMain.mem";
        })
        //회원탈퇴 클릭시 alert창으로 동의 받고 회원탈퇴
        $("#btnDelete").click(function(){
        	let YN = confirm("정말 탈퇴하시겠습니까?");
        	if(YN==true){
        		location.href="${pageContext.request.contextPath}/deleteProc.mem"
        	}
        })
        //수정버튼 클릭시 비밀번호확인팝업->비밀번호 변경창으로
        $("#btnPwModify").click(function(){
        	 let uri = "/toPwPopup.mem";
        	 let name = "비밀번호 확인";
        	 let option = "left=600, width=600, height=400, top=100";
        	 
        	 window.open(uri,name,option);
        });
        
        $("#image").on("change", function (e) {
			$("#profilePhoto").css("display","none");
		});
      //사진 미리보기 기능 
        function setThumbnail(event) { 
            var reader = new FileReader(); 
            
            reader.onload = function(event) {
                var img = document.createElement("img"); 
                img.setAttribute("src", event.target.result); 
                document.querySelector("div#image_container").appendChild(img);
                }; 
                reader.readAsDataURL(event.target.files[0]);
                };
                
          //개인정보페이지에 사진띄우기        
         const kakaoLog = "${loginSession.get('access_token')}";
         const photoPath = "${dto.getProfilePhoto_path()}";   
              if(kakaoLog != ""){
                 	//일반로그인일경우 사진경로 다르게 변경
                 	$("#image_container").css({	
                  		"background-image": "url('" + photoPath + "')"		
                   	});
                   }
              
              // test
              console.log(photoPath);
                   
        //카카오 로그인일 경우 비밀번호 수정버튼 감추기 
        	if(kakaoLog != ""){
        		$("#btnPwModifyBox").css({
        			"display" : "none"
        		})
        	}
       
		
		// 완료 버튼 - 공백없고, 정규식 검사 모두 다시 돌려서 통과하면 submit처리(프로필 사진, 상세주소는 필수 아님)
		$("#btnGo").click(function(){
			// 변수 - 주소 관련
			let postcode = document.getElementById("sample4_postcode"); // 우편번호
			let roadAddr = document.getElementById("sample4_roadAddress"); // 도로명주소
			let detailAddr = document.getElementById("sample4_detailAddress"); // 상세주소
			let extraAddr = document.getElementById("sample4_extraAddress"); // 참고항목
			
			
			
			 if(!nicknameCheck.disabled) {
				alert("닉네임 중복검사를 해주세요.");
                return;
             
			 }else if(!emailCheck.disabled || !verification_submit2.disabled){
				 alert("이메일 인증 및 중복검사를 해주세요.");
	             return;
			//else if(!$("#agreement").is(":checked")) {
              //  alert("개인정보 수집 및 이용 동의를 해주세요.");
                //return;
			 }else if(!phone_verification.disabled || !verification_submit.disabled){
				 alert("핸드폰 인증 및 중복검사를 해주세요.");
	             return;
			 
            }else { // 모든 검사를 통과하면, 휴대전화/주소 값 합쳐서 양식 제출
				document.getElementById("user_phone").value = phone1.value + phone2.value + phone3.value;
            	if(postcode.value=="" || roadAddr==""){
            		document.getElementById("user_address").value = document.getElementById("sub_user_address").value;
            	}else{
            		document.getElementById("user_address").value = postcode.value + " " + roadAddr.value + " " + detailAddr.value + extraAddr.value;
            		}
            
				document.getElementById("modifyForm").submit();
			}
		});
    </script>
</body>
</html>