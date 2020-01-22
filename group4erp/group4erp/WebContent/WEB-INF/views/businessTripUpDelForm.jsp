<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP페이지 처리 방식 선언하기 -->

<!-- 현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서는 UTF-8 방식으로 인코딩한다 라고 설정함 / 현재 이 JSP페이지는 UTF-8방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할수 있는 방법이다. -->
<!DOCTYPE html>
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<!-- 유일하게 WEB-INF 루트 경로를 쓸수 있다. -->
<%@ include file="/WEB-INF/views/common.jsp" %>

<!-- 만약에 상세보기할 게시판 글이 없으면 경고하고 이전 화면으로 이동하기 -->
<%-- 
<c:if test="${empty businessTripDTO}">
	<script>
		alert("게시글이 삭제되어있습니다!");
		location.replace("/group4erp/businessTripList.do");
	</script>
</c:if> 
--%>

<!-- 로그인 화면 구성하는 HTML태그 코딩하기 -->
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger{cursor: pointer;}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker{cursor: pointer;}

 input[type="date"]::-webkit-calendar-picker-indicator,
 input[type="date"]::-webkit-inner-spin-button {
     display: none;
     appearance: none;
 }
 
 input[type="date"]::-webkit-calendar-picker-indicator {
   color: rgba(0, 0, 0, 0); /* 숨긴다 */
   opacity: 1;
   display: block;
   background: url(https://mywildalberta.ca/images/GFX-MWA-Parks-Reservations.png) no-repeat; /* 대체할 아이콘 */
   width: 20px;
   height: 20px;
   border-width: thin;
}
</style>
<title>
글 수정/삭제
</title>
<script>
	$(document).ready(function(){
		$("#datepicker5").datepicker({
			dateFormat: 'yy-mm-dd'
		});
		$("#datepicker6").datepicker({
			dateFormat: 'yy-mm-dd'
		});
		
		if(
			("${businessTripDTO.login_emp_id}"=="${businessTripDTO.mgr_no}")
				||
			("${businessTripDTO.login_dep_no}"==6)
				||
			("${businessTripDTO.login_jikup}"=="대표이사")
		  ){
				$(".approved").show();
			}else{
				$(".approved").hide();
			}
	});
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }


	            document.getElementById("destination2").value = addr;

	        }
	    }).open();
	}
function checkBusinessTripUpDelAppForm(upDelApp){
		
		//매개변수로 들어온 upDel에 "del"이 저장되어있으면 즉, 삭제 버튼을 눌렀으면 암호 확인하고 삭제 여부를 물어보기
		if(upDelApp=='del'){
			
			$("[name=upDelApp]").val("del");
					
			//alert($('[name=boardUpDelForm]').serialize());		
			
			if(confirm("정말 삭제 하시겠습니까?")==false) return;
		
		}else if(upDelApp=='up'){
			$("[name=upDelApp]").val("up");
			if( is_empty('[name=destination]') ){
				alert("출장지를 입력해주세요.");
				$("[name=destination]").focus();
				return;
			}
			if( is_empty('[name=work_outside_reason]') ){
				alert("출장사유를 입력해주세요.");
				$("[name=work_outside_reason]").focus();
				return;
			}
			if( is_empty('[name=outside_start_time]') ){
				alert("출장날짜를 입력해주세요.");
				$("[name=outside_start_time]").focus();
				return;
			}
			if( is_empty('[name=outside_end_time]') ){
				alert("출장날짜를 입력해주세요.");
				$("[name=outside_end_time]").focus();
				return;
			} 
			var startDate = $( "[name=outside_start_time]" ).val();
		    var startDateArr = startDate.split('-');
		    var endDate = $( "[name=outside_end_time]" ).val();
		    var endDateArr = endDate.split('-');
		    var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
		    var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
		          
		    if(startDateCompare.getTime() > endDateCompare.getTime()) {
		              
		        alert("시작날짜와 종료날짜를 확인해 주세요.");
				$("[name=outside_start_time]").focus();
		         return;
		    }if(confirm("정말 수정하시겠습니까?")==false){return;}
		    
		}else if(upDelApp=='app'){
			$("[name=upDelApp]").val("app");
			if(confirm("정말 승인 하시겠습니까?")==false)
			 return;
		}
			
		    	
			

		
		 $.ajax({
			//호출할 서버쪽 URL주소 설정
			url : "/group4erp/businessTripUpDelAppProc.do"
			//전송 방법 설정
			, type : "post"
			//서버로 보낼 파라미터명과 파라미터값을 설정
			, data : $('[name=businessTripUpDel]').serialize()
			//서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			//매개변수 upDelCnt에는 입력 행의 개수가 들어온다.
			, success : function(businessTripUpDelAppCnt){
				if(upDelApp=='up'){
					if(businessTripUpDelAppCnt==1){
						alert("수정 성공!");
						location.replace('/group4erp/businessTripList.do')
					}else if(upCnt==-1){
						alert("게시물이 삭제되어 수정할 수 없습니다!");
					}else{
						alert("서버쪽 DB연동 실패!");
					}
				}else if(upDelApp=='del'){
					if(businessTripUpDelAppCnt==1){
						alert("삭제 성공!");
						location.replace('/group4erp/businessTripList.do')
					}else if(delCnt==-1){
						alert("이미 삭제된 게시물입니다!");
					}else{
						alert("서버쪽 DB연동 실패!");
					}
				}else if(upDelApp=='app'){
					if(businessTripUpDelAppCnt==1){
						alert("승인 완료");
						location.replace('/group4erp/businessTripList.do')
					}else if(businessTripUpDelAppCnt==-1){
						alert("이미 삭제된 게시물입니다!");
					}else if(businessTripUpDelAppCnt==-2){
						alert("이미 승인된 게시물입니다.");
					}else{
						alert("서버쪽 DB연동 실패!");
					}
				}
			}
			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function(){
				alert("서버 접속 실패");
			}
		});
	}
	</script>	
</script>
</head>
<body><center><br><br><br>
	<form name="businessTripUpDel" method="post" action="/group4erp/businessTripUpDelProc.do">
		<b>수정/삭제</b>
		<br>
		<table class="tbcss1" width="500" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr align=center>
				<th bgcolor="gray" >사원 번호</th>
				<td >${businessTripDTO.emp_no}</td>
				<th bgcolor="gray" >직급</th>
				<td >${businessTripDTO.jikup}</td>
			</tr>
			<tr align=center>
				<th bgcolor="gray" width=60>사원명</th>
				<td >${businessTripDTO.emp_name}</td>
				<th bgcolor="gray" width=60>부서명</th>
				<td >${businessTripDTO.dep_name}</td>
			</tr>
			<tr align=center>
				<th bgcolor="gray">담당자 명</th>
				<td>${businessTripDTO.mgr_name}</td>
				<th bgcolor="gray">결제 여부</th>
				<td>
					<c:choose>
								<c:when test="${businessTripDTO.travel_payment eq 'Y'}">
									승인
								</c:when>
								<c:when test="${businessTripDTO.travel_payment eq 'N'}">
									반려
								</c:when>
								<c:otherwise>
									대기중
								</c:otherwise>				
					</c:choose>
				</td>
			</tr>
			<tr>
				<th bgcolor="gray">출장날짜</th>
				<td colspan=3>
					<input type="text" id="datepicker5" name="outside_start_time" value="${businessTripDTO.outside_start_time}" readonly>
					~
					<input type="text" id="datepicker6" name="outside_end_time" value="${businessTripDTO.outside_end_time}"  readonly>
				</td>
			</tr>
			<tr>
				<th bgcolor="gray">출장지</th>
				<td colspan=3>
					<input type="text" size="40" maxlength="50" id="destination2" name="destination" value="${businessTripDTO.destination}"> <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					
				</td>
			</tr>
			<tr>
				<th bgcolor="gray">출장 사유</th>
				<td colspan=3>
					<textarea name="work_outside_reason" rows="13" cols="40" maxlength="500" >${businessTripDTO.work_outside_reason}
					</textarea>
				</td>
			</tr>
		</table>
		<table><tr heigth=4><td></td></table>
		<table>
			<tr heigth=4>
				<input type="hidden" name="work_outside_seq" value="${businessTripDTO.work_outside_seq}">	
				<input type="hidden" name="upDelApp" value="up">
				<td>
					<div class="approved" style="display:none">
							<input type="button" value="승인" onclick="checkBusinessTripUpDelAppForm('app')">
					</div>
				</td>
				<td>
					<input type="button" value="수정" onclick="checkBusinessTripUpDelAppForm('up')">
				</td>
				<td>
					<input type="button" value="삭제" onclick="checkBusinessTripUpDelAppForm('del')">
				</td>
				<td>
					<input type="button" value="목록보기" onclick="location.replace('/group4erp/businessTripList.do')">
				</td>
			</tr>
		</table>
	</form>
	<form name="businessTripList" method="post" action="/group4erp/businessTripList.do">
		<!-- 게시판 상세보기 화면을 구성하는 글의 고유번호를 hidden 태그에 저장 -->
		<!-- 수정/삭제를 하려면 현재 글의 고유번호를 알아야하기 때문 -->
		<input type="hidden" name="work_outside_seq" value="${businessTripDTO.work_outside_seq}">
		<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
		<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
	</form>
	 
</body>
</html>