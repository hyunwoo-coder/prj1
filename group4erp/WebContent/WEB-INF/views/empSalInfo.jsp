<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여명세서(직원별)</title>
</head>
<body><center>
	
	<form name="salInfoForm" method="post" action=" ">
		<h1>[${timeDTO.now_year}년도 급여명세서]</h1><br>
		직책 : 대표이사	&nbsp;&nbsp;성명 : 김**<br>
		<table class="tbcss1" name="salInfoForm" cellpadding="5" cellspacing="5">
			<tr>
				<th rowspan="2">지급일 </th>성명</th><th colspan="6">지급내역</th><th colspan="7">공제내역</th><th rowspan="2">실수령액</th>
			</tr>
			<tr>
				<!-- 지급내역 목록 -->
				<td>기본급 </td> <td>식대 </td><td>초과근무수당</td><td>성과수당</td><td>차량유지비</td><td>합계</td>
				<!-- 공제내역 목록-->
				<td>갑근세 </td> <td>주민세 </td><td>고용보험</td><td>건강보험</td><td>국민연금</td><td>기타</td><td>합계</td>
			</tr>
			
			<tr style="cursor:pointer" onClick="/group4erp/viewEmpSalInfo.do">
				<td>2019.11.25</td><td>4,250,000</td><td>100,000</td> <td>50,000</td> <td>25,000</td> <td>100,000</td> <td>4,525,000</td>
				
				<td>112,520</td><td>10,250</td><td>35,200</td><td>141,720</td> <td>191,230</td> <td>.</td><td>490,920</td><td>4,034,080</td>
			</tr>
	
		
		
		</table>
		<br>
				[1][2][3][4][5][6][7][8][9][10]
	</form>



</center>

</body>
</html>