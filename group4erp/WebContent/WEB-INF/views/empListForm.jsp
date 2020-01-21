	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 리스트</title>

<script>

$(document).ready(function(){	
	
	//headerSort("empListTable", 0);
	
	setTableTrBgColor(
				"empListTable",	//테이블 class 값
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
				"${getEmpBoardListCnt}"						//검색 결과 총 행 개수
				,"${hrListSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
				,"${hrListSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
				,"10"										//페이지 당 보여줄 페이지번호 개수
				,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
			)
		);
	
	inputData('[name=rowCntPerPage]',"${hrListSearchDTO.rowCntPerPage}");
	inputData('[name=selectPageNo]',"${hrListSearchDTO.selectPageNo}");
	inputData('[name=searchKeyword]',"${hrListSearchDTO.searchKeyword}");
	inputData('[name=sort]',"${hrListSearchDTO.sort}");
});

	function goSearch() {
		document.empListSearchForm.submit();
	}
	function goSearchAll() {
		document.empListSearchForm.reset();
		$("[name=empListSearchForm] [name=selectPageNo]").val(1);
		$("[name=empListSearchForm] [name=rowCntPerPage]").val(10);
		$("[name=empListSearchForm] [name=sort]").val('');
		document.empListSearchForm.submit();
	}
// 	function insertNewEmp() {
//		location.href="/group4erp/viewNewEmpJoin.do"
//	} 
	function goEmpContentForm(emp_no){
		//alert("emp_no="+emp_no);
		//return;
		var str = "emp_no="+emp_no
		location.href="/group4erp/viewEmpContentForm.do?"+str;
		/*
		$.ajax({
			url : "/group4erp/empViewContantProc.do"
			, type : "post"
			, data : "emp_no="+emp_no
			, success : function(upDelCnt){
				alert(999);
				return;
				location.replace("/group4erp/???????.do");
			}
			, error : function(){
				alert("서버 접속 실패");
			}
		});
		*/
		//location.replace("......");
	}
	function reset(){
		document.empListSearchForm.reset();
	}
</script>
</head>
<body>
<center>
	<h1>[직원 리스트]</h1>

	<form name="empListSearchForm" method="post" action="/group4erp/viewEmpList.do">
		[검색어]<input type="text" name="searchKeyword">&nbsp;&nbsp;<input type="button" value="검색" onClick="goSearch();">

	<!-- <form name="empListSearchForm" method="post" action="/group4erp/viewEmpList.do">
	[검색어]<input type="text" name="searchKeyword">&nbsp;&nbsp;<input type="button" value=" 검색 " onClick="goSearch();"> -->

	&nbsp;&nbsp;<input type="button" value="모두검색" onClick="goSearchAll();">
	&nbsp;&nbsp;<input type="button" value="초기화" onClick="reset();">
	 <table border=0 width=700>
	 	<tr>
	    	<td align=right>
	        [총 직원수] : ${getEmpBoardListCnt} 명&nbsp;&nbsp;&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value="10">10</option>
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	               <option value="30">30</option>
	            </select> 행보기
      </table>
      <input type="hidden" name="selectPageNo">
      <input type="hidden" name="sort">
	</form>
	
	<form name="empListForm" method="post" action="/group4erp/viewEmpInfo.do">
	
		<div id="blankArea"><br></div>
		<table class="empListTable tab" name="empListTable" cellpadding="5" cellspacing="5">		
				<tr>
	 				<th>번호</th>
				<c:choose>
					<c:when test="${param.sort=='1 desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼사번
					</c:when>
					<c:when test="${param.sort=='1 asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('1 desc'); goSearch();">▲사번
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('1 asc'); goSearch();">사번
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${param.sort=='2 desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼성명
					</c:when>
					<c:when test="${param.sort=='2 asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('2 desc'); goSearch();">▲성명
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('2 asc'); goSearch();">성명
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='dep_no desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼부서명
					</c:when>
					<c:when test="${param.sort=='dep_no asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('dep_no desc'); goSearch();">▲부서명
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('dep_no asc'); goSearch();">부서명
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='jikup_cd desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼직급
					</c:when>
					<c:when test="${param.sort=='jikup_cd asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('jikup_cd desc'); goSearch();">▲직급
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('jikup_cd asc'); goSearch();">직급
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${param.sort=='emp_email_office desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼사내 메일
					</c:when>
					<c:when test="${param.sort=='emp_email_office asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('emp_email_office desc'); goSearch();">▲사내 메일
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('emp_email_office asc'); goSearch();">사내 메일
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${param.sort=='7 desc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val(''); goSearch();">▼승인상태
					</c:when>
					<c:when test="${param.sort=='7 asc'}">
						<th style="cursor:pointer" onclick="$('[name=sort]').val('7 desc'); goSearch();">▲승인상태
					</c:when>
					<c:otherwise>
						<th style="cursor:pointer" onclick="$('[name=sort]').val('7 asc'); goSearch();">승인상태
					</c:otherwise>
				</c:choose>
			
			<c:forEach items="${requestScope.getEmpBoardList}" var="empList" varStatus="loopTagStatus">
				<tr style="cursor:pointer" onClick="goEmpContentForm(${empList.emp_no});">
					<td align=center>${getEmpBoardListCnt - empList.RNUM +1}</td>	<!-- <input type="hidden" value="${dep_no}">  -->	
					<td align=center>${empList.emp_no}</td>	<!-- <input type="hidden" value="${dep_no}">  -->
					<td align=center>${empList.emp_name}</td>
					<td align=center>${empList.dep_name}</td>
					<td align=center>${empList.jikup}</td>
					<td align=center>${empList.emp_email_office}</td>
					<c:if test="${empList.worktime_name!='미승인'}">
						<td align=center>${empList.worktime_name}&nbsp; 승인</td>
					</c:if>
					<c:if test="${empList.worktime_name=='미승인'}">
						<td align=center>미승인</td>
					</c:if>
				</tr>		
			</c:forEach>
		
		</table>
		<br>
		<!-- <input type="button" value="신규사원등록" onClick="insertNewEmp();"> -->
		<br><br>
		<c:if test="${getEmpBoardListCnt eq 0}">
				<h5>해당 결과가 없습니다.</h5>
		</c:if>
		<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
	</form>


	<!-- 
	<c:if test="EmployeeDTO.getEmp_no()!=null">
	<div class="empListContant">
		<a href="javascript:goClose();">[닫기]</a>
		<table class="tbcss1" width="600" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<th>이름
				<td>가나다
				<th>영어이름
				<td>rkskek
				<th colspan=4 width="30%">사원사진
			<tr>
				<th>주민등록번호
				<td colspan=3>111111-2222222
				<td rowspan=4 colspan=4 width="30%">no image
			<tr>
				<th>핸드폰번호
				<td colspan=3>010-1234-5678
			<tr>
				<th>이메일
				<td colspan=3>naver11@naver.com
			<tr>
				<th>회사이메일
				<td colspan=3>company11@company.com
			<tr>
				<th>주소
				<td colspan=5>전라북도 장수군 장수읍  개정농원길 20-43
				<th>휴직상태
				<td>X
			<tr>
				<th>입사일
				<td colspan=2>2019-12-25 수요일
				
				<th colspan=2>부서이름
				<td>총무과
				<th>성별
				<td>남
			<tr>
				<th>직업형태
				<td>정규직
				<th>직급
				<td>사원
				<th>연봉
				<td colspan=3>30,000,000
			<tr>
				<th>직속상관
				<th>부서이름
				<td>총무과
				<th>직급
				<td>대표이사
				<th>이름
				<td colspan=2>라마바
		</table>
	</div>
	</c:if>
	 -->
</center>

</body>
</html>