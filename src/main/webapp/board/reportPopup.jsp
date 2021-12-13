<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<title>신고하기</title>
<style>
* {
	box-sizing: border-box;
	font-weight: bold;
	font-size: 16px;
}

div {
	/* border:1px solid lightgray */
	
}
/* 신고 전체 컨테인너 */
.reportContainer {
	width: 700px;
	margin: auto;
}

.reportTitleBox {
	background-color: #5656c4;
	color: white;
	padding: 0%;
	margin-top: 0%;
	border-radius: 5px;
	height: 60px;
	align-items: center;
}

.bodyBox {
	margin: auto;
}
/* 라디오박스 COL*/
.radioBox {
	padding: 10px;
}
/* 신고 라디오박스 버튼 */

/* 신고내용_기타(textarea) */
#report_content {
	resize: none;
	width: 100%;
	height: 150px;
	overflow: scroll;
}
/* 신고하기 버튼 */
#btnReport {
	width: 100%;
	height: 40px;
	background-color: red;
	color: white;
	border-radius: 5px;
	border: none;
}
/* 팝업창 닫기 버튼 */
#btnCancel {
	width: 100%;
	height: 40px;
	background-color: gray;
	color: white;
	border-radius: 5px;
	border: none;
}
</style>
</head>
<body>
	<div class="reportContainer form-control mt-2">

		<div class="row reportTitleBox">
			<!-- 신고팝업창 제목 -->
			<div class="col-12">
				<h3>Report</h3>
			</div>
		</div>

		<!-- 신고내용 경고문 -->
		<div class="row mt-2">
			<div class="col-12">
				이 글이 이용규칙 위반으로 운영진에 의해 삭제되어야 마땅하다고 생각 된다면 신고해주세요 신고 3회 이상의 들을 삭제 될 수
				있으며 이용규칙에 위배되는 들을 여러 차례 게시하여 신고를 많이 받은 회원은 제한 조치가 취해집니다. <br>
				신고는 반대의견을 표시하는 기능이 아닙니다. 글 작성자의 의견을 반대할 경우 신고할수 없습니다. 신고에 부적합한 글을
				지속적으로 신고하는 회원 에게는 제한 조치가 취해질 수 있습니다.
			</div>
		</div>

		<!-- 신고 타입, 내용 -->
		<form id="reportForm" method="post">
			<div class="row bodyBox form-control mt-3 ml-3">
				<div class="col-12 radioBox p-3">
					<p>
						<input type="radio" class="report" name="report_content_no"
							value="1" checked="checked" />부적절한 언행 사용(욕설, 성적 발언, 정치, 종교 혐오 발언
						등)
					</p>
					<p>
						<input type="radio" class="report" name="report_content_no"
							value="2" />유해한 컨텐츠 사용(광고, 거짓정보, 자극적인 컨텐츠)
					</p>
					<p>
						<input type="radio" class="report" name="report_content_no"
							value="3" />따돌림 혹은 괴롭힘
					</p>
					<p>
						<input type="radio" class="report" name="report_content_no"
							value="4" />지적 재산권 침해
					</p>
					<p>
						<input type="radio" class="report" name="report_content_no"
							value="5" />저작권 침해
					</p>
					<p>
						<input type="radio" name="report_content_no" id="etcReport"
							value="6" />기타
					</p>
				</div>
				<div class="col-12">
					<textarea id="report_content" name="report_content"
						placeholder="신고내용을 입력 해주세요." readonly></textarea>
				</div>

				<!-- 신고타입, 신고자, 신고내용, 게시글번호, 댓글번호, 댓글내용 번호 -->
				<div class="d-none">
					<input type="text" name="reported_post_no" value="${post_no}">
					<input type="text" name="report_type" value="${report_type}">
					<input type="text" name="reported_comment_no"
						value="${reported_comment_no}">
				</div>
			</div>
		</form>

		<!-- 신고버튼 -->
		<div class="row">
			<div class="col-2 d-flex justify-content-start mt-3">
				<button type="button" id="btnReport">신고하기</button>
			</div>
			<div class="col-2 d-flex justify-content-start mt-3">
				<button type="button" id="btnCancel">닫기</button>
			</div>
		</div>
	</div>
	<script>
		// 기타 라디오박스 클릭시 textarea 활성		
		$("input:radio[id=etcReport]").click(function(e) {
			console.log(e.target);
			$("#report_content").attr("readonly", false);
		});

		// 다른 라디오박스 클릭시 textarea 비활성
		$("input:radio[class=report]").click(function(e) {
			console.log(e.target);
			$("#report_content").val("");
			$("#report_content").attr("readonly", true);
		});

		// 신고하기 버튼 클릭시 처리
		$("#btnReport").on("click", function() {
			let data = $("#reportForm").serialize(); // 댓글 form 안의 데이터 직렬화
			console.log(data);
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/reportProc.re",
				data : data
			// 신고 하기 성공시	
			}).done(function(rs) {
				if (rs == "success") {
					alert("신고가 등록 되었습니다.");
					window.close();
				} else if (rs == "fail") {
					alert("신고 등록에 실패 했습니다.");
				}
			// 신고 하기 실패시	
			}).fail(function(e) {
				console.log(e);
				alert("신고 등록에 실패 했습니다.");
			});
		});
		
		// 신고팝업창 닫기 버튼 클릭시
		$("#btnCancel").on("click",function(){
			self.close();
		});
		
		
		// 신고 리스트 출력(리스틑 관리자 페이지 에서 출력) 
		
	</script>
</body>
</html>