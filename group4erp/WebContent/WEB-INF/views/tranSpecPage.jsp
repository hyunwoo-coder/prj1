<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file ="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래명세서</title>

<script>

	function issueTranSpec(order_no) {
		
		$.ajax({
			url : "/group4erp/issueTranSpec.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			data : $('[name=issueTranSpecForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정
			
			success : function(saveCnt) {
				if(saveCnt == 1) {
					alert("발급 성공!");
					
					location.replace("/group4erp/viewTranSpecIssueList.do");
				} else if(delCnt==-1) {	
					alert("발급 실패");
					
					location.replace("/group4erp/viewTranSpecList.do");

				} else {
					alert("서버쪽 DB 연동 실패!");
				}
			}

			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
				alert("서버 접속 실패!");
			}	
		});
	}

	function printPage() {

		alert("거래명세서 인쇄 기능 구현 예정");
	}

</script>

</head>
<body><center>
	<h1>거래명세서</h1>
	
	
		<table class="tranSpecTable tab" style="background:white;" name="tranSpecTable" cellpadding="5" cellspacing="5" width="500">

		<c:forEach items="${tranSpecList}" var="tranSpecList" varStatus="loopTagStatus">
			<tr>
				<td rowspan="5" width="100">공급받는자</td><td width="100">상호</td><td>${tranSpecList.corp_name} </td>
			</tr>
				<tr><td>사업자번호</td><td name="corp_no">${tranSpecList.corp_no} </td></tr>
				<tr><td>사업자명</td><td name="ceo_name">${tranSpecList.ceo_name}</td></tr>
				<tr><td>소재지</td><td name="corp_addr">${tranSpecList.corp_addr}</td></tr>
				<tr><td>연락처</td><td name="corp_tel">${tranSpecList.corp_tel}</td></tr>
				<tr><td>FAX</td><td name="corp_fax">${tranSpecList.corp_fax}</td></tr>
				
				<tr><td>거래일시</td><td colspan="2" name="order_dt">${tranSpecList.order_dt}</td></tr>
				<tr><td>품명</td><td colspan="2" name="book_name">${tranSpecList.book_name} &nbsp;(isbn : ${tranSpecList.isbn13})</td></tr>
				<tr><td>주문번호</td></td><td colspan="2" name="order_books_no"> ${tranSpecList.order_books_no}</td></tr>
				<tr><td>수량</td><td colspan="2" name="qty">${tranSpecList.books_qty} 권</td></tr>
				<tr><td>단가</td><td colspan="2" name="unit_price">${tranSpecList.book_price} 원</td></tr>
				<tr><td>공급가액</td><td colspan="2">${tranSpecList.tot_cost} 원</td></tr>	
				<%-- <tr><td>부가세액</td><td colspan="2">${tranSpecList.tax} 원</td></tr> --%>	
			</c:forEach>		
		</table>
	
	
	<!-- <input type="button" value="임시저장" onClick="saveTempTranSpec('${order_no}');"> -->
	<input type="button" value="발급" onClick="issueTranSpec('${order_no}');">
	<input type="button" value="인쇄" onClick="printPage();">
	<br>
	
	<form name="issueTranSpecForm" method="post" action="/group4erp/issueTranSpec.do">
		<input type="hidden" name="order_no" value="${order_no}">
	</form>
	
</center>

</body>
</html>