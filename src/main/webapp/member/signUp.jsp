<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	    <title>회원가입</title>
    <style>
     body{
  background-color:rgb(86, 86, 196);
  }
        h1 {
            font-weight: bold;
            margin: 0;
        }

        p {
            margin: 0;
            font-size: small;
            color: gray;
        }

        input::placeholder {
            font-size: smaller;
        }

        #daum-postcode input {
            width: 100%;
        }

        #btnCancel {
            text-align: right;
        }

        .container {
            max-width: 680px;
            margin-top: 80px;
            padding: 32px;
            background: #fff;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
        }

        .profileImg-Wrapper>div {
            float: left;
        }

        .profileImg-Wrapper>div:nth-child(2) {
            padding: 20px;
        }

        .profileImg-Wrapper span {
            font-size: small;
        }

        #profileImg {
            width: 100px;
            height: 100px;
            border: 1px solid lightgray;
            border-radius: 50%;
            background-image: url("/resources/imgTmp/squid-game-6723533_960_720.webp");
            background-size: 100%;
            cursor: pointer;
        }

        #btnUploadFake {
            margin: 5px;
        }

        #btnUpload {
            display: none;
        }

        #hiddenInput,
        #hiddenInput2,
        #email_verification {
            display: none;
        }

        .clsBtn {
            width: 100%;
            background-color:rgb(86, 86, 196);
            border:1px solid rgb(86, 86, 196);
        }
        .clsBtn:hover{
        	background-color:#b4b4e4;
        }

		.btnPost{
			background-color:rgb(86, 86, 196);
			border:1px solid rgb(86, 86, 196);
		}
		.btnPost:hover{
			background-color:#b4b4e4;
		}
        .txtRegex {
            font-size: smaller;
        }
    </style>
</head>

<body>
    <form action="${pageContext.request.contextPath}/signupProc.mem" method="post" id="signupForm"
        enctype="multipart/form-data">
        <div class="container">
            <div class="row my-4">
                <div class="col p-3 d-flex justify-content-center">
                    <h1>회원가입</h1>
                </div>
            </div>
            <!--프로필 영역-->
            <div class="row my-4">
                <div class="col d-flex justify-content-center">
                    <div id="profileImg"></div>
                </div>
            </div>
            <input type="file" name="file" accept="image/*" id="btnUpload">

            <!--아이디 영역-->
            <div class="row my-4">
                <div class="col-md-9 mb-3">
                    <label for="id">아이디</label>
                    <input type="text" class="form-control" id="id" name="id" placeholder="6~9자 이내의 영문자, 숫자" maxlength="9" required>
                    <span class="txtRegex" id="txtRegex_id"></span>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="name">&nbsp;</label>
                    <button class="btn btn-primary clsBtn" type="button" id="idCheck">중복 검사</button>
                </div>
            </div>

            <!--패스워드 영역-->
            <div class="row my-4">
                <div class="col-md-6 mb-3">
                    <label for="password1">비밀번호 (8~16자 이내)</label>
                    <input type="password" class="form-control" id="password1" name="password1" maxlength="16"
                        placeholder="대소문자, 숫자, 특수문자 각 1개 이상" required>
                    <div class="invalid-feedback">
                        패스워드를 입력해주세요.
                    </div>
                    <span class="txtRegex" id="txtRegex_pw"></span>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="password2">비밀번호 확인</label>
                    <input type="password" class="form-control" id="password2" name="password2" maxlength="16"
                        placeholder="대소문자, 숫자, 특수문자 각 1개 이상" required>
                    <div class="invalid-feedback">
                        패스워드를 입력해주세요.
                    </div>
                </div>
            </div>

            <!--닉네임 영역-->
            <div class="row my-4">
                <div class="col-md-9 mb-3">
                    <label for="nickname">닉네임</label>
                    <input type="text" class="form-control" id="nickname" name="nickname" maxlength="10"
                        placeholder="한글, 영문자 2~10자 이내" required>
                    <span class="txtRegex" id="txtRegex_nickname"></span>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="name">&nbsp;</label>
                    <button class="btn btn-primary clsBtn" type="button" id="nicknameCheck">중복 검사</button>
                </div>
            </div>

            <!--이메일 영역-->
            <div class="row my-4">
                <div class="col-md-9 mb-3">
                    <label for="email">이메일</label>
                    <input type="text" class="form-control" id="email" name="email" maxlength="35" placeholder="이메일 입력"
                        required>
                    <div class="invalid-feedback">
                        이메일을 입력해주세요.
                    </div>
                    <span class="txtRegex" id="txtRegex_email"></span>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="emailCheck">&nbsp;</label>
                    <button type="button" class="btn btn-primary clsBtn" id="emailCheck">중복 검사</button>
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
                    <button type="button" class="btn btn-primary clsBtn" id="verification_submit2">인증번호 확인</button>
                </div>
            </div>

            <!--휴대전화 영역-->
            <div class="row my-4">
                <div class="col-md-3 mb-3">
                    <label for="phone1">휴대전화</label>
                    <select class="form-select" aria-label="Default select example" id="phone1" name="phone1" required>
                        <option selected>010</option>
                        <option value="1">011</option>
                        <option value="2">016</option>
                        <option value="2">017</option>
                        <option value="3">018</option>
                    </select>
                    <span class="txtRegex" id="txtRegex_phone"></span>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="phone2">&nbsp;</label>
                    <input type="text" class="form-control" id="phone2" name="phone2" maxlength="4">
                </div>
                <div class="col-md-3 mb-3">
                    <label for="phone3">&nbsp;</label>
                    <input type="text" class="form-control" id="phone3" name="phone3" maxlength="4">
                </div>
                <div class="col-md-3 mb-3">
                    <label for="phone_verification">&nbsp;</label>
                    <button type="button" class="btn btn-primary clsBtn" id="phone_verification">인증번호 발송</button>
                </div>
            </div>
            <!--숨은 인증창-->
            <div class="row my-4" id="hiddenInput">
                <div class="col-md-6 mb-3">
                    <input type="text" class="form-control" id="verification_input" maxlength="4" placeholder="인증번호 입력"
                        required>
                </div>
                <div class="col-md-6 mb-3">
                    <button type="button" class="btn btn-primary clsBtn" id="verification_submit">인증번호 확인</button>
                </div>
            </div>
            <!--휴대전화번호 병합하여 저장할 곳-->
            <div class="d-none">
                <input type="text" id="user_phone" name="user_phone">
            </div>

            <!--주소 영역-->
            <div class="row my-4" id="daum-postcode">
                <div class="col-12 col-md-6 my-2">
                    <input type="text" class="form-control" id="sample4_postcode" name="postcode" placeholder="우편번호"
                        readonly>
                </div>
                <div class="col-12 col-md-6 my-2">
                    <div id="wrap-findPostcode"><input type="button" onclick="sample4_execDaumPostcode()"
                            value="우편번호 찾기" class="btn btn-primary btnPost"></div>
                </div>
                <div class="col-12 col-md-6 my-2"><input type="text" class="form-control" id="sample4_roadAddress"
                        name="roadAddress" placeholder="도로명주소" readonly></div>
                <div class="col-12 col-md-6 my-2"><input type="text" class="form-control" id="sample4_jibunAddress"
                        placeholder="지번주소" readonly></div>
                <div class="col-12 col-md-6 my-2"><input type="text" class="form-control" id="sample4_detailAddress"
                        name="detailAddress" placeholder="상세주소"></div>
                <div class="col-12 col-md-6 my-2"><input type="text" class="form-control" id="sample4_extraAddress"
                        name="extraAddress" placeholder="참고항목" readonly></div>
                <!--주소 병합하여 저장할 곳-->
                <div class="col-12 d-none">
                    <input type="text" id="user_address" name="user_address">
                </div>
            </div>

            <!--경계선 + 동의 버튼-->
            <hr class="mb-4">
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="aggrement">
                <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
            </div>

            <!--버튼 영역-->
            <div class="row my-4">
                <div class="col">
                    <button class="btn btn-primary btn-lg clsBtn" type="button" id="btnSubmit">가입 완료</button>
                </div>
            </div>

            <!--프로필 이미지 경로 담을 곳-->
            <input type="text" id="input_profileImgUrl" name="input_profileImgUrl" hidden>
        </div>
    </form>
    <!--footer-->
    <footer class="my-3 text-center text-small">
        <p class="mb-1">&copy; 2021 PhotoFolio</p>
    </footer>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
        /***** 아이디 영역 *****/

        // 변수 - 아이디 관련
        let id = document.getElementById("id"); // 아이디 입력창
        let idCheck = document.getElementById("idCheck"); // 중복검사 버튼
        let txtRegex_id = document.getElementById("txtRegex_id"); // 정규식 경고문구

        // 아이디 정규식(통과하면 true, 아니면 false 반환)
        function regexId() {
            const regexId = /^[a-zA-Z0-9_]{6,9}$/;
            return regexId.test(id.value);
        }

        // 아이디 입력창 벗어날 때 정규식 검사(중복검사 버튼과 겹침)
        id.addEventListener("change", function () {
            if (!regexId()) {
                txtRegex_id.innerText = "아이디를 올바르게 입력해주세요.";
                txtRegex_id.style.color = "red";
            } else {
                txtRegex_id.innerText = "";
            }
        });

        // 아이디 중복검사 클릭
        idCheck.addEventListener("click", function () {
            if (regexId()) { // 정규식 통과해야 중복검사 가능
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/idCheckProc.mem",
                    data: {
                        "id": id.value
                    }
                }).done(function (data) { // 중복이 아니면 String형 false반환
                    if (data == "false") { // 중복이 아닐 경우
                        alert("사용 가능한 아이디입니다.");
                        id.readOnly = "true"; // 입력창 잠그기
                        idCheck.disabled = "disabled"; // 중복검사 버튼 잠그기
                    } else {
                        alert("이미 존재하는 아이디입니다. 다시 입력해주세요.");
                    }
                }).fail(function (e) {
                    console.log(e);
                });
            } else { // 정규식 미통과 경우
                txtRegex_id.innerText = "아이디를 올바르게 입력해주세요.";
                txtRegex_id.style.color = "red";
            }
        });

        /***** 패스워드 영역 *****/

        // 변수 - 패스워드 관련
        let password1 = document.getElementById("password1"); // pw1 입력창
        let password2 = document.getElementById("password2"); // pw2 입력창

        // 대소수특 각1개 이상 존재 & 8~16자리의 글자
        function regexPw() {
            const regexPw1 = /[a-z]/;
            const regexPw2 = /[A-Z]/;
            const regexPw3 = /[0-9]/;
            const regexPw4 = /[~!@#$%^&*+._]/;
            const regexPw5 = /[\S]{8,16}/; 
            const regexPw = [regexPw1, regexPw2, regexPw3, regexPw4];
            let checkRegex = [false, false, false, false];
            // 패스워드 글자 하나씩 분리하여 대소수특 존재하는지 검사
            for (let i = 0; i < password1.value.length; i++) {
                for (let j = 0; j < regexPw.length; j++) {
                    if (regexPw[j].test(password1.value.substr(i, 1)) || checkRegex[j] == true) {
                        checkRegex[j] = true;
                    }
                }
            }
            if (checkRegex[0] && checkRegex[1] && checkRegex[2] && checkRegex[3] && regexPw5.test(password1.value)) {
                return true;
            } else {
                return false;
            }
        }

        // 첫번째 패스워드 입력창 벗어날 때 정규식 검사
        password1.addEventListener("change", function () {
            if (!regexPw() && password2.value == "") {
                txtRegex_pw.innerText = "올바른 비밀번호를 입력하세요";
                txtRegex_pw.style.color = "red";
            } else if (regexPw() && (password2.value == password1.value)) {
                txtRegex_pw.innerText = "";
            }
        });

        // 두번째 패스워드 입력창 벗어날 때 일치하는 지 확인
        password2.addEventListener("change", function () {
            if (password2.value == "" || (password2.value !== password1.value) || !regexPw()) {
                txtRegex_pw.innerText = "올바른 비밀번호를 입력하세요";
                txtRegex_pw.style.color = "red";
            } else {
                txtRegex_pw.innerText = "";
            }
        });

        /***** 닉네임 영역 *****/

        // 변수 - 닉네임 관련
        let nickname = document.getElementById("nickname"); // nickname 입력창
        let nicknameCheck = document.getElementById("nicknameCheck"); // nickname 중복검사 버튼
        let txtRegex_nickname = document.getElementById("txtRegex_nickname");
        
        // 닉네임 정규식
        function regexNickname() {
            const regexNickname = /^[a-zA-Zㄱ-힣]{2,10}$/; // 2~10자리 대소수한
            return regexNickname.test(nickname.value);
        }

     // 닉네임 입력창 검사
        nickname.addEventListener("change", function () {
            if (!regexNickname()) {
                txtRegex_nickname.innerText = "올바른 닉네임을 입력하세요.";
                txtRegex_nickname.style.color = "red";
            } else {
                txtRegex_nickname.innerText = "";
            }
        });
     
        // 닉네임 중복검사
        nicknameCheck.addEventListener("click", function () {
            if (regexNickname()) {
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/nicknameCheckProc.mem",
                    data: {
                        "nickname": nickname.value
                    }
                }).done(function (data) {
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


        /***** 이메일 영역 *****/

        // 변수 - 이메일 관련
        let email = document.getElementById("email"); // 이메일 입력창
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
        emailCheck.addEventListener("click", function () {
            if (regexEmail()) { // 정규식 통과해야 중복 검사
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

        /***** 휴대전화 영역 *****/

        // 변수 -  휴대전화 관련
        let phone1 = document.getElementById("phone1") // 번호 첫번째 영역
        let phone2 = document.getElementById("phone2"); // 번호 중간 영역
        let phone3 = document.getElementById("phone3"); // 번호 뒷자리 영역
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
                document.getElementById("hiddenInput").style.display = "none"; // 숨기기
            } else { // 일치하지 않는 경우
                alert("인증번호 불일치");
            }
        });

        /***** 그 외 *****/

        // 카카오 유저 회원가입
        let kakaoLogin = false;
        let kakao_id = "";
        if ("${userInfo.get('nickname')}" !== "") {
            kakaoLogin = true;
            const kakao_nickname = "${userInfo.get('nickname')}";
            const kakao_profileImgUrl = "${userInfo.get('profile_image_url')}";
            const kakao_email = "${userInfo.get('email')}";
            kakao_id = "${userInfo.get('id')}";

            nickname.value = kakao_nickname;
            email.value = kakao_email;
            input_profileImgUrl.value = kakao_profileImgUrl;
            $("#profileImg").css({
                "background-image": "url('" + kakao_profileImgUrl + "')"
            });

            id.readOnly = "true";
            password1.readOnly = "true";
            password2.readOnly = "true";
            nickname.readOnly = "true";
            idCheck.disabled = "disabled";
            nicknameCheck.disabled = "disabled";
        }

        // 프로필 사진 영역
        $("#profileImg").on("click", function () {
            $("#btnUpload").click();
        });
        $("#btnUpload").on("change", function (e) {
            readImage(e.target);
        });
        function readImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.addEventListener("load", function (e) {
                    $("#profileImg").css({
                        "background-image": "url('" + e.target.result + "')"
                    });
                });
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 완료 버튼 
        document.getElementById("btnSubmit").addEventListener("click", function () {
            // 변수 - 주소 관련
            let postcode = document.getElementById("sample4_postcode"); // 우편번호
            let roadAddr = document.getElementById("sample4_roadAddress"); // 도로명주소
            let detailAddr = document.getElementById("sample4_detailAddress"); // 상세주소
            let extraAddr = document.getElementById("sample4_extraAddress"); // 참고항목

            if (kakaoLogin) {
                if (email.value == "" || !regexEmail()) {
                    alert("이메일을 제대로 입력해주세요.");
                    return;
                } else if (!regexPhone()) {
                    alert("휴대전화를 제대로 입력해주세요.");
                    return;
                } else if (!verification_input.readOnly) {
                    alert("휴대전화 인증을 해주세요.");
                    return;
                } else if (postcode.value == "" || roadAddr == "") {
                    alert("우편번호 찾기를 진행해주세요.");
                    return;
                } else {
                    id.value = kakao_id;
                    document.getElementById("user_phone").value = phone1.value + phone2.value + phone3.value;
                    document.getElementById("user_address").value = postcode.value + " " + roadAddr.value + " " + detailAddr.value + extraAddr.value;
                    document.getElementById("signupForm").submit();
                }
            } else {
                if (id.value == "" || !regexId()) {
                    alert("아이디를 제대로 입력해주세요.");
                    return;
                } else if (password1.value == "" || password2.value == "" || !regexPw()) {
                    alert("패스워드를 제대로 입력해주세요.");
                    return;
                } else if (!regexPhone()) {
                    alert("휴대전화를 제대로 입력해주세요.");
                    return;
                } else if (nickname.value == "" || !regexNickname()) {
                    alert("닉네임을 제대로 입력해주세요.");
                    return;
                } else if (email.value == "" || !regexEmail()) {
                    alert("이메일을 제대로 입력해주세요.");
                    return;
                } else if (postcode.value == "" || roadAddr == "") {
                    alert("우편번호 찾기를 진행해주세요.");
                    return;
                } else if (!id.readOnly) {
                    alert("아이디 중복검사를 해주세요.");
                    return;
                } else if (!nickname.readOnly) {
                    alert("닉네임 중복검사를 해주세요.");
                    return;
                } else if (!verification_input.readOnly) {
                    alert("휴대전화 인증을 해주세요.");
                    return;
                } else {
                    document.getElementById("user_phone").value = phone1.value + phone2.value + phone3.value;
                    document.getElementById("user_address").value = postcode.value + " " + roadAddr.value + " " + detailAddr.value + extraAddr.value;
                    document.getElementById("signupForm").submit();
                }
            }
        });

        // 다음 우편번호 API
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function sample4_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample4_postcode').value = data.zonecode;
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                    document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    if (roadAddr !== '') {
                        document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                    } else {
                        document.getElementById("sample4_extraAddress").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                }
            }).open();
        }


    </script>
</body>

</html>