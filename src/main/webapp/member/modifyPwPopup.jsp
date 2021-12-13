<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
*{box-sizing: border-box;
            margin:0;
            }
body{
background-color:rgb(86, 86, 196);
}
.container{
	margin:auto;
	border:1px solid black;
	margin-top:60px;
	background-color:white;
	text-align:center;
}
h2{
	margin-top:20px;
}
input{
height:60px;
margin-left:40px;
}
#pwCheckBox{
	margin-left:190px;
	padding-bottom:20px;
	
}
.btnBox{
	text-align:center;
}
.btnBox>button{
	margin:30px
}
</style>
</head>
<body>
	<form action ="${pageContext.request.contextPath}/pwModifyProc.mem" method="post" id="pwModifyForm">
			<div class="container">
				<h2>비밀번호 변경</h2>
				<div class="row p-2">
					<div class="col-10 mb-4">
						<input type="password" id="password1" name="user_pw" class="form-control" placeholder="8~16자, 대소수특 각 1개 이상">
					</div>
					<span class="txtRegex" id="txtRegex_pw"></span>
				</div>
				<div class="row p-2">
					<div class="col-10 mb-4">
						<input type="password" id="password2" name="pwcheck" class="form-control" placeholder="8~16자, 대소수특 각 1개 이상">
					</div>
					<span class="txtRegex" id="txtRegex_pw2"></span>
				</div>
			</div>
				<div class="btnBox">
					<button type="button" id="btnModify" class="btn btn-primary" disabled>수정</button>
					<button type="button" id="btnBack" class="btn btn-secondary">뒤로가기</button>
				</div>
			</form>	
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>		
<script>
//2. 비밀번호 변경파트
  let password1 = document.getElementById("password1"); // pw1 입력창
  let password2 = document.getElementById("password2"); // pw2 입력창
  
  
        // 패스워드 정규식 - 일치하면 true, 아니면 false반환 (정규식 먹히는게 없어서 메서드 처리)
        // 대소수특 각1개 이상 존재 & 8~16자리의 글자
        function regexPw() {
            const regexPw1 = /[a-z]/;
            const regexPw2 = /[A-Z]/;
            const regexPw3 = /[0-9]/;
            const regexPw4 = /[~!@#$%^&*+._]/;
            const regexPw5 = /[\S]{8,16}/; // 공백제외, 8~16자리인지 검사(제대로 안먹힘ㅅㅂ)
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
            if (!regexPw()) {
                txtRegex_pw.innerText = "올바른 비밀번호를 입력하세요";
                txtRegex_pw.style.color = "red";
                $("#btnModify").attr("disabled", true);
            } else{
                txtRegex_pw.innerText = "";
                $("#btnModify").attr("disabled", true);
            }
        });

        // 두번째 패스워드 입력창 벗어날 때 일치하는 지 확인
        password2.addEventListener("change", function () {
            if (password2.value == "" || (password2.value !== password1.value) || !regexPw()) {
                txtRegex_pw2.innerText = "비밀번호가 일치하지 않습니다.";
                txtRegex_pw2.style.color = "red";
                $("#btnModify").attr("disabled", true);
            } else {
                txtRegex_pw2.innerText = "";
                $("#btnModify").attr("disabled",false);
            }
        });

$("#btnModify").click(function(){
	$("#pwModifyForm").submit();
});

$("#btnBack").click(function(){
	self.close();
});



</script>
</body>
</html>