<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger {
	cursor: pointer;
}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker {
	cursor: pointer;
}

input[type="date"]::-webkit-calendar-picker-indicator, input[type="date"]::-webkit-inner-spin-button
{
	display: none;
	appearance: none;
}

input[type="date"]::-webkit-calendar-picker-indicator {
	color: rgba(0, 0, 0, 0); /* 숨긴다 */
	opacity: 1;
	display: block;
	background:
		url(https://mywildalberta.ca/images/GFX-MWA-Parks-Reservations.png)
		no-repeat; /* 대체할 아이콘 */
	width: 20px;
	height: 20px;
	border-width: thin;
}
</style>

<% String emp_num = (String)session.getAttribute("emp_id"); %>

<script>
	$(document).ready(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#datepicker2").datepicker({
			dateFormat : 'yy-mm-dd'
		});

	});

	function goBusinessTripList() {
		location.replace("/group4erp/businessTripList.do");
	}

	function reset() {
		document.businessTripForm.reset();
	}


	function checkBusinessTripRegForm(){
		
		if( is_empty($("#emp_no")) ){
			alert("사원번호를 입력해주세요.");

			$("#emp_no").focus();
			return;
		}

		if (is_empty($("#destination"))) {
			alert("목적지를 입력해주세요.");
			$("#destination").focus();
			return;
		}

		if (is_empty($("#datepicker1"))) {
			alert("출장 희망일을 입력해주세요.");
			$("#datepicker1").focus();
			return;
		}

		if (is_empty($("#datepicker2"))) {
			alert("출장 희망일을 입력해주세요.");
			$("#datepicker2").focus();
			return;
		}
		var startDate = $( "[name=outside_start_time]" ).val();
	    var startDateArr = startDate.split('-');
	    var endDate = $( "[name=outside_end_time]" ).val();
	    var endDateArr = endDate.split('-');
	    var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
	    var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
	          
	    if(startDateCompare.getTime() > endDateCompare.getTime()) {
	              
	        alert("출발날짜와 복귀날짜를 확인해 주세요.");
			$("[name=outside_start_time]").focus();
	         return;
	    }

		if (is_empty($("#work_outside_reason"))) {
			alert("출장사유를 입력해주세요.");
			$("#work_outside_reason").focus();
			return;
		}
		if( is_valid_pattern($("#emp_no"), /^[0-9]{6}$/)==false ){
			alert("사원번호 숫자 4개를 입력해주세요");
			return;
		}
		

		if(confirm("정말 저장하시겠습니까?")==false){return;}
		
		$.ajax({
			url : "/group4erp/businessTripRegProc.do",
			type : "post",
			data : $('[name=businessTrip]').serialize(),
			success : function(businessTripRegCnt) {
				if (businessTripRegCnt == 1) {
					alert("출장 신청 완료");
					location.replace('/group4erp/businessTripList.do')
				} else {
					alert("출장 신청 실패 관리자에게 문의 바람.");
				}
			},
			error : function() {
				alert("businessTripRegForm 서버 접속 실패");
			}
		});
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
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

				document.getElementById("destination").value = addr;

			}
		}).open();
	}

	function goBack(){
		history.back();
	}
</script>


<meta charset="UTF-8">
<title>출장신청&보고</title>
</head>
<body><center>
	<form name="businessTrip" id="businessTrip" method="post" action="/group4erp/businessTripRegProc.do">
	<b>출장 신청서</b>
	<table class="work_outside_info tab" name="work_outside_info" cellpadding="5" cellspacing="5">
		<tr>
			<th>사원 번호</th>
				<td>
					<input type="text" id="emp_no" name="emp_no" value=<%=emp_num %> readonly>
				</td>
		</tr>
		
		<tr>
			<th>출장지</th>
				<td>
					<input type="text" size="50" id="destination" name="destination" ><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">											
				</td>
		</tr>
		
		<tr>
			<th >출장날짜</th>
				<td>
					<input type="text" id="datepicker1" name="outside_start_time">
					~
					<input type="text" id="datepicker2" name="outside_end_time">
					&nbsp;&nbsp;&nbsp;
				</td>
		</tr>
			<!-- <tr>
				<th>목적지</th>
				<td><input type="text" size="50" id="destination"
					name="destination" readOnly> <input type="button"
					onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
			</tr> -->
		<tr>
			<th >출장 사유</th>
				<td >
					<textarea name="work_outside_reason" cols="50" rows="10" id="work_outside_reason" maxlenght="500"></textarea>
				</td>
		</tr>
		</table>
		
		<input type="button" class="approval" value="결재 신청" onClick="checkBusinessTripRegForm()">
		<input type="button" value="초기화" onClick="reset()"> 
		<input type="button" value="뒤로가기" onclick="goBack()">
		<input type="button" value="목록보기" onClick="goBusinessTripList()">
	</form>
	</center>
</body>
</html>