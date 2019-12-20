<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원별 휴가현황</title>

</head>
<body><center>
	<h1>[직원 휴가 현황]</h1><br>
	기준일 : 2019년 12월 19일
	<form name="empDayOffList" method="post" action="/group4erp/viewEmpDayOffList.do">
		
		<table class="tbcss1" name="dayOffList" cellpadding="5" cellspacing="5" width="500">
			<thead>
				<tr>
					<th style="cursor:pointer">소속 부서
					<th style="cursor:pointer">직급
					<th style="cursor:pointer">성명
					<th style="cursor:pointer">휴가 종류
					<th style="cursor:pointer">복귀 예정일
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${requestScope.getDayOffList}" var="dayoff" varStatus="loopTagStatus">
					<tr style="cursor:pointer">
						<%-- <td align=center>
							${boardListAllCnt - 
								(boardSearchDTO.selectPageNo*boardSearchDTO.rowCntPerPage-boardSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1} --%>
						<td align=center> ${dayoff.dep_name}
						<td align=center> ${dayoff.jikup}
						<td align=center> ${dayoff.emp_name}
						<td align=center> ${dayoff.dayoff_name}
						<td align=center> ${dayoff.end_day_off}
					</tr>
				</c:forEach>
			</tbody>
		
			
			
			<!-- <tr>
				<th>소속 부서 ▼ </th><th>직급 ▼ </th><th>성명 ▼ </th><th>휴가 종류 ▼ </th><th>복귀 예정일 ▼</th>
			</tr>
			<tr>
				<td>기획부</td><td>과장</td><td>박민아</td><td>연차</td><td>2019.12.24</td>
			</tr>
			<tr>
				<td>영업부</td><td>사원</td><td>김설현</td><td>연차</td><td>2019.12.26</td>
			</tr> -->
		
		</table>
	
	</form>

</center>
</body>
</html>