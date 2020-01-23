<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여명세서(직원별)</title>
<script>
	$(document).ready(function() {

		headerSort("empSalInfo", 0);

		setTableTrBgColor(
				"empSalInfo",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
		);
	
		$('[name=rowCntPerPage]').change(function(){

			goSearch();
		});

		
		$(".pagingNumber").html(

				getPagingNumber(
					"${myPayCheckCnt}"						//검색 결과 총 행 개수
					,"${salListSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
					,"${salListSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
					,"10"										//페이지 당 보여줄 페이지번호 개수
					,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
				)
			);

		//검색 후 입력양식에 넣었던 검색 조건들 세팅하기
		//$('[name=empSalForm] [name=rowCntPerPage]').val("${salListSearchDTO.rowCntPerPage}");
		//$('[name=empSalForm] [name=selectPageNo]').val("${salListSearchDTO.selectPageNo}");
		
		inputData('[name=rowCntPerPage]', "${salListSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${salListSearchDTO.selectPageNo}");
		inputData('[name=sort]',  "${salListSearchDTO.sort}");
		/* $('[name=rowCntPerPage]').val("${salListSearchDTO.rowCntPerPage}");
		$('[name=selectPageNo]').val("${salListSearchDTO.selectPageNo}");
		$('[name=sort]').val("${salListSearchDTO.sort}"); */

		//$('[name=rowCntPerPage]').val($('[name=empSalForm] [name=rowCntPerPage]').val());
		//$('[name=selectPageNo]').val($('[name=empSalForm] [name=selectPageNo]').val());
		
		//inputData("[name=sort]", "${salListSearchDTO.sort}");

	});
	
	
	function goSearch() {
		document.empSalForm.submit();
	}

	function goSearchAll() {
		document.empSalForm.reset();

		$('[name=selectPageNo]').val("1");
		$('[name=rowCntPerPage]').val("15");
		goSearch();
	}
		
</script>
</head>
<body><center>
	
	<h1>[급여 지급 내역]</h1><br>
	직책 : ${jikup}	&nbsp;&nbsp; 성명 :${emp_name}  <br>
	
	<form name="empSalForm" method="post" action="/group4erp/viewEmpSalInfo.do">
<<<<<<< HEAD

		<input type="hidden" name="selectPageNo">
		<input type="hidden" name="sort">

	
		<table class="tab" cellpadding="5" cellspacing="5">
			<tr>			
				<td align="right">
	        	[전체] : ${myPayCheckCnt}건&nbsp;&nbsp;&nbsp;&nbsp;
	           	 <select name="rowCntPerPage">
	              		<option value="10">10</option>
	               		<option value="15">15</option>
	               		<option value="20">20</option>
	               		<option value="25">25</option>
	               		<option value="30">30</option>
	            	</select> 행보기
	    		</td>


		
		<table>
			<tr height=10>
				<td></td>

			</tr>

			</form>
			<tr>
				<td>
					<table class="empSalInfo tab" cellpadding="5" cellspacing="5">

		</table>
			
		<input type="hidden" name="selectPageNo">
		<input type="hidden" name="sort">

		
	
	
	<table name="outerBorder" cellpadding="5" cellspacing="5">
		<tr>			
			<td align="right">
	        [전체] : ${myPayCheckCnt}개&nbsp;&nbsp;&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value="10">10</option>
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	               <option value="30">30</option>
	            </select> 행보기 
	    	</td>
		</tr>
		
		<tr>
			<td>
				<table class="empSalInfo tab" name="empSalInfo" cellpadding="5" cellspacing="5">

				
					<tr align="center">
						<th rowspan="2">번호</th>
						
						<c:choose>
							<c:when test="${param.sort=='salary_dt desc'}">
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼지급일</th>
							</c:when>
							<c:when test="${param.sort=='salary_dt asc'}">
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val('salary_dt desc'); goSearch();">▲지급일</th>
							</c:when>
							<c:otherwise>
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val('salary_dt asc'); goSearch();">지급일</th>
							</c:otherwise>
						</c:choose>
						
						<th colspan="3">지급내역</th>
						
						<th colspan="5">공제내역</th>
						
						<c:choose>
							<c:when test="${param.sort=='real_sal desc'}">
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼실수령액</th>
							</c:when>
							<c:when test="${param.sort=='real_sal asc'}">
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val('real_sal desc'); goSearch();">▲실수령액</th>
							</c:when>
							<c:otherwise>
								<th rowspan="2" style="cursor:pointer" onclick="$('[name=sort]').val('real_sal asc'); goSearch();">실수령액</th>
							</c:otherwise>
						</c:choose>
						
					</tr>
					<tr align="center">
						<!-- 지급내역 목록 -->
						<c:choose>
							<c:when test="${param.sort=='month_sal desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼기본급</td>
							</c:when>
							<c:when test="${param.sort=='month_sal asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('month_sal desc'); goSearch();">▲기본급</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('month_sal asc'); goSearch();">기본급</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='mess_allowance desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼식대</td>
							</c:when>
							<c:when test="${param.sort=='mess_allowance asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('mess_allowance desc'); goSearch();">▲식대</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('mess_allowance asc'); goSearch();">식대</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='bus_trip_bonus desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼보너스</td>
							</c:when>
							<c:when test="${param.sort=='bus_trip_bonus asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('bus_trip_bonus desc'); goSearch();">▲보너스</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('bus_trip_bonus asc'); goSearch();">보너스</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='sum_payable desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼합계</td>
							</c:when>
							<c:when test="${param.sort=='sum_payable asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('sum_payable desc'); goSearch();">▲합계</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('sum_payable asc'); goSearch();">합계</td>
							</c:otherwise>
						</c:choose>
						<!-- 공제내역 목록-->
						<c:choose>
							<c:when test="${param.sort=='emp_insurance desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼고용보험</td>
							</c:when>
							<c:when test="${param.sort=='emp_insurance asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('emp_insurance desc'); goSearch();">▲고용보험</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('emp_insurance asc'); goSearch();">고용보험</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='health desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼건강보험</td>
							</c:when>
							<c:when test="${param.sort=='health asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('health desc'); goSearch();">▲건강보험</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('health asc'); goSearch();">건강보험</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='pension desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼국민연금</td>
							</c:when>
							<c:when test="${param.sort=='pension asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('pension desc'); goSearch();">▲국민연금</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('pension asc'); goSearch();">국민연금</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='deduct desc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼합계</td>
							</c:when>
							<c:when test="${param.sort=='deduct asc'}">
								<td style="cursor:pointer" onclick="$('[name=sort]').val('deduct desc'); goSearch();">▲합계</td>
							</c:when>
							<c:otherwise>
								<td style="cursor:pointer" onclick="$('[name=sort]').val('deduct asc'); goSearch();">합계</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<c:forEach items='${myPayCheckList}' var="myPayCheckList" varStatus="loopTagStatus">
						<tr align="center">	
							<td>${myPayCheckCnt - myPayCheckList.RNUM +1}</td>
							<td>${myPayCheckList.salary_dt}</td>
							<td>${myPayCheckList.month_sal}</td>
							<td>${myPayCheckList.mess_allowance}</td>
							<td>
								<c:if test="${myPayCheckList.bus_trip_bonus eq null}">
									0
								</c:if>
					
								<c:if test="${!(myPayCheckList.bus_trip_bonus eq null)}">
									${myPayCheckList.bus_trip_bonus}
								</c:if>
							</td>
							<td>${myPayCheckList.sum_payable}</td>
							<td>${myPayCheckList.emp_insurance}</td>
							<td>${myPayCheckList.health}</td>
							<td>${myPayCheckList.pension}</td> 
							<td>${myPayCheckList.deduct} </td>
							<td>${myPayCheckList.real_sal}</td>
						</tr>
		
					 </c:forEach>
				</table>
			</td>
		</tr>
	
	</table>

	<div>&nbsp; <span class="pagingNumber"></span>&nbsp;</div>

	</form>

	<h5>귀하의 노고에 감사드립니다.</h5>
	<input type="button" value="뒤로 가기" onClick="javascript:history.go(-1);">
</center>

</body>
</html>