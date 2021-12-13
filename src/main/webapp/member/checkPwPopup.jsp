<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<form action ="${pageContext.request.contextPath}/pwCheckProc.mem" method="post" id="pwCheckForm">
			<div class="container">
				<h2>비밀번호 확인</h2>
				<div class="row p-2">
					<div class="col-10 mb-4">
						<input type="password" id="password1" name="user_pw" class="form-control" placeholder="비밀번호 입력">
					</div>
				</div>
				<div class="row p-2">
					<div class="col-10 mb-4">
						<input type="password" id="password2" name="pwcheck" class="form-control" placeholder="비밀번호확인 입력">
					</div>
					<span class="txtRegex" id="txtRegex_pw"></span>
				</div>
			</div>
			<div class="btnBox">
				<button type="button" id="btnGo" class="btn btn-primary" disabled>완료</button>
				<button type="button" id="btnBack1" class="btn btn-secondary">뒤로가기</button>
			</div>
			</form>	
		
		
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script>
	//비밀번호 표시 
	
		// 변수 - 패스워드 관련
		//1. 비밀번호확인파트
		let password1 = document.getElementById("password1"); // pw1 입력창
		let password2 = document.getElementById("password2"); // pw2 입력창
		

		// 패스워드 입력창 벗어날 때 일치하는 지 확인
		password2.addEventListener("change", function () {
			if (password2.value == "" || (password2.value !== password1.value)) {
				txtRegex_pw.innerText = "비밀번호가 일치하지 않습니다.";
				txtRegex_pw.style.color = "red";
				$("#btnGo").attr("disabled", true);
			} else {
				txtRegex_pw.innerText = "";
				$("#btnGo").attr("disabled",false);
			}
			
		});
		
		$("#btnGo").click(function(){
			$("#pwCheckForm").submit();
		})
		
		$("#btnBack1").click(function(){
			self.close();
		})
		
	</script>	
	<script>
	$(document).ready(function(){
		if(${rs} == 1){
			alert("비밀번호가 변경되었습니다.");
			self.close();
		}else if(${rs} == false){
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			history.back();
		}
	})
	</script>
</body>
</html>