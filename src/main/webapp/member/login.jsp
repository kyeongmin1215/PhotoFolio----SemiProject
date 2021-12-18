<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
        <title>login</title>
    <style>
        body{
            background-color:rgb(86, 86, 196);
        }
        /*container*/
        .container {
            max-width: 680px;
            margin-top: 80px;
            padding: 70px;
            background: #fff;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
        }
        
        /*** 로그인 영역 ***/

        /*Login 타이틀 폰트*/
        h1 {
            font-weight: bold;
            margin: 0;
        }
        /*로그인 관련 요소 wrapper*/
        .loginElements-Wrapper {
            width: 60%;
        }
        /*입력창, 로그인 버튼*/
        .loginElements-Wrapper > #id,#password,#btnLogin { 
            border-radius: 12px;
        }
        /*로그인 버튼*/
        .loginElements-Wrapper > #btnLogin {
            width: 100%;
        }
        /*카카오 로그인 버튼 이미지 wrapper*/
        #btnKakaoLogin-Wrapper {
            height: 38px;
            border-radius: 12px;
            background-color: #FEE500;
            cursor: pointer;
        }
        /*카카오 로그인 버튼 이미지*/
        .loginElements-Wrapper > img {
            height: 100%;
        }
        /*id,pw 찾기 버튼*/
        .findWrapper > a {
            color: gray;
            text-decoration: none;
        }
        .findWrapper > a:hover {
            color: gray;
        }

        /*** modal영역 ***/

        /*default hide*/
        #findEmailArea,
        #sendNum_Wrapper,
        #sendNum_Wrapper2,
        #btnModalCall,
        #btnModalCall2,
        #secondWrap {
            display: none;
        }
        /*인증 관련 버튼들*/
        .clsBtn {
            width: 100%;
        }
    </style>
</head>

<body>
    <!--로그인 영역-->
    <div class="container">
        <form action="${pageContext.request.contextPath}/loginProc.mem" method="post" id="formLogin">
            <div class="row">
                <div class="col d-flex justify-content-center">
                    <h1>Login</h1>
                </div>
            </div>
            <div class="row">
                <!--아이디 입력-->
                <div class="col-12 d-flex justify-content-center mt-5">
                    <div class="form-floating loginElements-Wrapper">
                        <input type="text" class="form-control" id="id" name="user_id" placeholder="">
                        <label for="id">ID</label>
                    </div>
                </div>
                <!--패스워드 입력-->
                <div class="col-12 d-flex justify-content-center mt-2">
                    <div class="form-floating loginElements-Wrapper">
                        <input type="password" class="form-control clsInput" id="password" name="user_password"
                            placeholder="">
                        <label for="password">Password</label>
                    </div>
                </div>
                 <!--로그인 버튼-->
                <div class="col-12 d-flex justify-content-center mt-4">
                    <div class="loginElements-Wrapper">
                        <button type="button" class="btn btn-outline-secondary" id="btnLogin">Login</button>
                    </div>
                </div>
                <!--카카오 로그인 버튼-->
                <div class="col-12 d-flex justify-content-center mt-1">
                    <div class="loginElements-Wrapper d-flex justify-content-center" id="btnKakaoLogin-Wrapper">
                        <img src="/resources/imgTmp/kakao_login_large_narrow.png">
                    </div>
                </div>
                <!--Join / Find ID / Find Password-->
                <div class="col-12 d-flex justify-content-center mt-4 findWrapper">
                    <a href="${pageContext.request.contextPath}/toSignup.mem">Sign up</a>
                    <span>&nbsp;|&nbsp;</span>
                    <a href="#" onclick="modalCall()">Find ID</a>
                    <span>&nbsp;|&nbsp;</span>
                    <a href="#" onclick="modalCall2()">Find Password</a>
                </div>
            </div>
        </form>
    </div>

    <!-- 아이디 찾기 modal -->
    <div class="modal fade" id="findIdModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="Wrapper">
                        <!--아이디 찾기 - 휴대전화-->
                        <div class="row">
                            <div class="col">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="exampleRadios"
                                        id="exampleRadios1" value="option1" checked>
                                    <label class="form-check-label" for="exampleRadios1">
                                        휴대전화로 찾기
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!--아이디 찾기 - 휴대전화 입력-->
                        <div class="row" id="findPhoneArea">
                            <div class="col-12">
                                <p>회원정보에 등록된 휴대전화와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.</p>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="phone1">휴대전화</label>
                                <select class="form-select" aria-label="Default select example" id="phone1"
                                    name="phone1" required>
                                    <option selected>010</option>
                                    <option value="1">011</option>
                                    <option value="2">016</option>
                                    <option value="2">017</option>
                                    <option value="3">018</option>
                                </select>
                                <span class="txtRegex" id="txtRegex_phone"></span>
                            </div>
                            <div class="col-md-5 mb-3">
                                <label for="phone2">&nbsp;</label>
                                <input type="text" class="form-control" id="phone2" name="phone2" maxlength="8">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="btnSendPhone">&nbsp;</label>
                                <button type="button" class="btn btn-primary clsBtn" id="btnSendPhone">인증번호
                                    받기</button>
                            </div>
                        </div>
                        <!--아이디 찾기 - 휴대전화 인증번호 입력-->
                        <div class="row" id="sendNum_Wrapper2">
                            <div class="col-md-8 mb-3">
                                <label for="inputNumber2">인증번호</label>
                                <input type="text" class="form-control" id="inputNumber2" placeholder="인증번호 입력"
                                    required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="btnSubmit2">&nbsp;</label>
                                <button type="button" class="btn btn-primary clsBtn" id="btnSubmit2">인증번호
                                    확인</button>
                            </div>
                        </div>
                        <!--아이디 찾기 - 경계선-->
                        <hr class="mb-4">
                        <!--아이디 찾기 - 이메일-->
                        <div class="row">
                            <div class="col">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="exampleRadios"
                                        id="exampleRadios2" value="option2">
                                    <label class="form-check-label" for="exampleRadios2">
                                        이메일로 찾기
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!--아이디 찾기 - 이메일 입력-->
                        <div class="row" id="findEmailArea">
                            <div class="col-12">
                                <p>회원정보에 등록된 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
                            </div>
                            <div class="col-md-8 mb-3">
                                <label for="email">이메일</label>
                                <input type="text" class="form-control" id="email" name="email" maxlength="35"
                                    placeholder="이메일 입력" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="emailCheck">&nbsp;</label>
                                <button type="button" class="btn btn-primary clsBtn" id="btnSendEmail">인증번호
                                    받기</button>
                            </div>
                        </div>
                        <!--아이디 찾기 - 이메일 인증번호 입력-->
                        <div class="row" id="sendNum_Wrapper">
                            <div class="col-md-8 mb-3">
                                <label for="inputNumber">인증번호</label>
                                <input type="text" class="form-control" id="inputNumber" placeholder="인증번호 입력" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="btnSubmit">&nbsp;</label>
                                <button type="button" class="btn btn-primary clsBtn" id="btnSubmit">인증번호 확인</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 찾기 modal -->
    <div class="modal fade" id="findPwModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">비밀번호 찾기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!--비밀번호 찾기 - 아이디 입력-->
                    <div class="pwFindWrapper" id="firstWrap">
                        <p>아이디를 입력해주세요.</p>
                        <div class="row my-4">
                            <div class="col-md-12 mb-3 py-2">
                                <input type="text" class="form-control" id="inputId" name="user_id"
                                    placeholder="PhotoFolio 아이디" maxlength="9">
                            </div>
                            <div class="col-md-12 mb-3 d-flex justify-content-center">
                                <button class="btn btn-primary clsBtn" type="button" id="idCheck">다음</button>
                            </div>
                        </div>
                    </div>
                    <!--비밀번호 찾기 - 휴대전화-->
                    <div class="pwFindWrapper" id="secondWrap">
                        <div class="row" id="radioArea2">
                            <div class="col-12">
                                <p>회원정보에 등록된 이메일과 입력한 이메일이 같아야, 새 비밀번호를 받을 수 있습니다.</p>
                            </div>
                            <div class="col-md-8 mb-3">
                                <label for="email2">이메일</label>
                                <input type="text" class="form-control" id="email2" name="email" maxlength="35"
                                    placeholder="이메일 입력" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="btnSendEmail2">&nbsp;</label>
                                <button type="button" class="btn btn-primary clsBtn" id="btnSendEmail2">전송</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--modal 호출 버튼-->
    <button type="button" class="btn btn-primary clsModal" data-bs-toggle="modal" data-bs-target="#findIdModal"
        id="btnModalCall">
    </button>
    <button type="button" class="btn btn-primary clsModal" data-bs-toggle="modal" data-bs-target="#findPwModal"
        id="btnModalCall2">
    </button>

    <script>
        /*** 로그인 영역 ***/

        // FindID으로 모달창 열기
        function modalCall() {
            document.getElementById("btnModalCall").click();
        }
        // Find Password으로 모달창 열기
        function modalCall2() {
            document.getElementById("btnModalCall2").click();
        }
        // 로그인 버튼 클릭시
        document.getElementById("btnLogin").addEventListener("click", function () {
            loginRequest();
        });
        // 카카오 로그인 클릭시
        document.getElementById("btnKakaoLogin-Wrapper").addEventListener("click", function() {
            location.href = "${pageContext.request.contextPath}/toKakaoLogin.mem";
        });
        // 입력창에서 enter키 입력시 로그인 요청
        const id = document.getElementById("id");
        const password = document.getElementById("password");
        id.addEventListener("keypress", function (e) {
            if (e.keyCode == 13 && id.value !== "" && password.value !== "") {
                // id, pw 값 존재
                loginRequest();
            }
            if (e.keyCode == 13 && (id.value == "" || password.value == "")) {
                alert("ID or PW를 제대로 입력해주세요.");
            }
        });
        password.addEventListener("keypress", function (e) {
            if (e.keyCode == 13 && id.value !== "" && password.value !== "") {
                // id, pw 값 존재
                loginRequest();
            }
            if (e.keyCode == 13 && (id.value == "" || password.value == "")) {
                alert("ID or PW를 제대로 입력해주세요.");
            }
        });
     // 로그인 요청
        function loginRequest() {
            const data = $("#formLogin").serialize();
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/loginProc.mem",
                data: data
            }).done(function (data) {
                if (data == "true") { // 로그인 성공 -> 메인 페이지로 이동
                    location.href = "${pageContext.request.contextPath}/toHome.ho";
                } else {
                    alert("ID 혹은 Password를 제대로 입력하세요.");
                }
            }).fail(function (e) {
                console.log(e);
            });
        }

        /*** 아이디 찾기 modal ***/

        // 라디오 버튼 스위칭
        document.addEventListener("click", function (e) {
            if (e.target.id == "exampleRadios1") {
                document.getElementById("findPhoneArea").style.display = "flex";
                document.getElementById("findEmailArea").style.display = "none";
            } else if (e.target.id == "exampleRadios2") {
                document.getElementById("findPhoneArea").style.display = "none";
                document.getElementById("findEmailArea").style.display = "flex";
            }
        });
        // 인증번호 받기 버튼 (아이디 찾기 - 휴대전화 인증)
        let user_id2 = ""; 
        document.getElementById("btnSendPhone").addEventListener("click", function () {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/findIdByPhoneProc.mem",
                data: {
                    phone: document.getElementById("phone1").value
                        + document.getElementById("phone2").value
                }
            }).done(function (data) {
                if (data == "false") {
                    alert("존재하지 않는 휴대전화입니다.");
                } else { 
                    user_id2 = data;
                    alert("인증번호를 입력해주세요");
                    document.getElementById("sendNum_Wrapper2").style.display = "flex"; 
                    sendNumberByPhone(); 
                    document.getElementById("btnSendPhone").disabled = "disabled";
                }
            }).fail(function (e) {
                console.log(e);
            });
        });
        // 인증번호 발송 (아이디 찾기 - 휴대전화 인증)
        let verification_number2 = 0; 
        function sendNumberByPhone() {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/sendSmsProc.mem",
                data: {
                    phoneNumber: document.getElementById("phone1").value
                        + document.getElementById("phone2").value
                }
            }).done(function (data) {
                verification_number2 = data;
            }).fail(function (e) {
                console.log(e);
            });
        }
        // 인증번호 확인 버튼 (아이디 찾기 - 휴대전화 인증)
        const inputNumber2 = document.getElementById("inputNumber2"); 
        document.getElementById("btnSubmit2").addEventListener("click", function () {
            if (inputNumber2.value == verification_number2) {
                alert("당신의 아이디는 " + user_id2 + " 입니다."); 
                document.getElementById("inputNumber2").readOnly = "true"; 
                document.getElementById("btnSubmit2").disabled = "disabled"; 
                $('#findIdModal').modal('hide');
            } else {
                alert("인증번호를 잘못 입력하셨습니다.");
            }
        });
        // 인증번호 받기 버튼  (아이디 찾기 - 이메일 인증)
        let user_id = ""; 
        document.getElementById("btnSendEmail").addEventListener("click", function () {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/findIdByEmailProc.mem",
                data: {
                    email: document.getElementById("email").value
                }
            }).done(function (data) {
                if (data == "false") {
                    alert("존재하지 않는 이메일입니다.");
                } else {
                    user_id = data;
                    alert("인증번호를 입력해주세요");
                    document.getElementById("sendNum_Wrapper").style.display = "flex"; 
                    sendNumberByEmail(); 
                    document.getElementById("btnSendEmail").disabled = "disabled";
                }
            }).fail(function (e) {
                console.log(e);
            });
        });
        // 인증번호 발송 (아이디 찾기 - 이메일 인증)
        let verification_number = 0; 
        function sendNumberByEmail() {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/sendEmailProc.mem",
                data: {
                    email: document.getElementById("email").value
                }
            }).done(function (data) {
                verification_number = data;
            }).fail(function (e) {
                console.log(e);
            });
        }
        // 인증번호 확인 버튼 (아이디 찾기 - 이메일 인증)
        const inputNumber = document.getElementById("inputNumber"); 
        document.getElementById("btnSubmit").addEventListener("click", function () {
            if (inputNumber.value == verification_number) {
                alert("당신의 아이디는 " + user_id + " 입니다."); 
                document.getElementById("inputNumber").readOnly = "true"; 
                document.getElementById("btnSubmit").disabled = "disabled"; 
                $('#findIdModal').modal('hide');
            } else {
                alert("인증번호를 잘못 입력하셨습니다.");
            }
        })

        // 아이디 입력 후, 다음 버튼 클릭시 
        let inputId = document.getElementById("inputId");
        document.getElementById("idCheck").addEventListener("click", function () {
            $.ajax({ 
                type: "post",
                url: "${pageContext.request.contextPath}/idCheckProc.mem",
                data: {
                    id: inputId.value
                }
            }).done(function (data) {
                if (data == "true") { 
                    document.getElementById("firstWrap").style.display = "none";
                    document.getElementById("secondWrap").style.display = "inline-block";
                } else if(data == "kakao") {
                    alert("카카오 회원은 해당 기능을 사용할 수 없습니다.");
                } else {
                    alert("아이디를 제대로 입력하세요.");
                }
            }).fail(function (e) {
                console.log(e);
            });
        });

        $(".modal").on("hidden.bs.modal", function(){
            $("input").val("");
            document.getElementById("firstWrap").style.display = "block";
            document.getElementById("secondWrap").style.display = "none";
        });

        // 이메일로 패스워드 발급 
        document.getElementById("btnSendEmail2").addEventListener("click", function () {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/emailCheckProc.mem",
                data: {
                    email: document.getElementById("email2").value
                }
            }).done(function (data) {
                if (data == "false") {
                    alert("이메일을 정확히 입력해주세요");
                } else {
                    sendPasswordByEmail();
                }
            }).fail(function (e) {
                console.log(e);
            });
        });
        // 임시 패스워드 발송
        function sendPasswordByEmail() {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/findPwByEmailProc.mem",
                data: {
                    id: inputId.value,
                    email: document.getElementById("email2").value
                }
            }).done(function (data) {
                if (data == "true") {
                    alert("패스워드를 이메일로 발송했습니다.");
                    $('#findPwModal').modal('hide');
                } else {
                    alert("패스워드 발송 실패.");
                }
            }).fail(function (e) {
                console.log(e);
            });
        }
    </script>

</body>

</html>