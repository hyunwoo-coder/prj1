<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래명세서 발급 내역</title>
<script>

$(document).ready(function(){

	headerSort("tranSpecIssueList", 0);

	setTableTrBgColor(
			"tranSpecIssueList",	//테이블 class 값
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
				"${tranSpecIssueCnt}"						//검색 결과 총 행 개수
				,"${tranSpecSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
				,"${tranSpecSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
				,"10"										//페이지 당 보여줄 페이지번호 개수
				,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
			)
		);

	inputData('[name=rowCntPerPage]',"${tranSpecSearchDTO.rowCntPerPage}");
	inputData('[name=selectPageNo]',"${tranSpecSearchDTO.selectPageNo}");
	inputData('[name=searchKeyword]',"${tranSpecSearchDTO.searchKeyword}");
	inputData("[name=sort]", "${tranSpecSearchDTO.sort}");
	
});


	function goSearch() {
		var keyword = $("[name=searchKeyword]").val();
		keyword = $.trim(keyword);
		$("[name=searchKeyword]").val(keyword);
		
		document.corpSearchForm.submit();
	}

	function goSearchAll() {
		document.corpSearchForm.reset();

		$('[name=corpSearchForm] [name=selectPageNo]').val("1");
		$('[name=corpSearchForm] [name=rowCntPerPage]').val("15");
		$("[name=corpSearchForm] [name=sort]").val('');
		goSearch();
	}
	
	function goReset() {
		document.corpSearchForm.reset();
	}
</script>
</head>
<body><center>
	<h1>[거래명세서 발급 내역]</h1>
	
	<form name="corpSearchForm" method="post" action="/group4erp/viewTranSpecIssueList.do">
	[검색어]&nbsp;<input type="text" name="searchKeyword">&nbsp;&nbsp;<input type="button" value="검색" onClick="goSearch();">
	
	&nbsp;&nbsp;<input type="button" value="모두검색" onClick="goSearchAll();">
	&nbsp;&nbsp;<input type="button" value="초기화" onClick="goReset();">
	 <table border=0>
	 	<tr>
	    	
      </table>
     <input type="hidden" name="selectPageNo">
    <input type="hidden" name="sort" >
		
	<div>&nbsp; <span class="pagingNumber"></span>&nbsp;</div>
	<table>
		<tr height=10>
			<td></td>
		</tr>
	</table>

</form> 

	<table border="0" cellpadding="5" cellspacing="5">
		<tr>			
			<td align="right">
	        [전체] : ${tranSpecIssueCnt}개&nbsp;&nbsp;&nbsp;&nbsp;
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
				<table class="tranSpecIssueList tab" name="tranSpecIssueList" cellpadding="5" cellspacing="5">
					<tr>
						<th>번호</th>						
						<c:choose>
							<c:when test="${param.sort=='1 desc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 발급번호</th>
							</c:when>
							<c:when test="${param.sort=='1 asc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val('1 desc'); goSearch(); "> ▲ 발급번호</th>
							</c:when>			
							<c:otherwise>
								<th style="cursor:pointer" onClick="$('[name=sort]').val('1 asc'); goSearch();  ">발급번호</th>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='3 desc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 사업자번호</th>
							</c:when>
							<c:when test="${param.sort=='3 asc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val('3 desc'); goSearch(); "> ▲ 사업자번호</th>
							</c:when>			
							<c:otherwise>
								<th style="cursor:pointer" onClick="$('[name=sort]').val('3 asc'); goSearch();  ">사업자번호</th>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='4 desc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 상호명</th>
							</c:when>
							<c:when test="${param.sort=='4 asc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val('4 desc'); goSearch(); "> ▲ 상호명</th>
							</c:when>			
							<c:otherwise>
								<th style="cursor:pointer" onClick="$('[name=sort]').val('4 asc'); goSearch();  ">상호명</th>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='5 desc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 사업자명</th>
							</c:when>
							<c:when test="${param.sort=='5 asc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val('5 desc'); goSearch(); "> ▲ 사업자명</th>
							</c:when>			
							<c:otherwise>
								<th style="cursor:pointer" onClick="$('[name=sort]').val('5 asc'); goSearch();  ">사업자명</th>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${param.sort=='7 desc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 발급일시</th>
							</c:when>
							<c:when test="${param.sort=='7 asc'}">
								<th style="cursor:pointer" onClick="$('[name=sort]').val('7 desc'); goSearch(); "> ▲ 발급일시</th>
							</c:when>			
							<c:otherwise>
								<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goSearch();  ">발급일시</th>
							</c:otherwise>
						</c:choose>
						
						
						<c:forEach items='${tranSpecIssueList}' var="tranSpecIssueList" varStatus="loopTagStatus">
							<tr style="cursor:pointer">
							<td>${tranSpecIssueCnt-tranSpecIssueList.RNUM+1}</td>
							<td>${tranSpecIssueList.issue_no}</td>
							<td>${tranSpecIssueList.corp_no}</td>
							<td>${tranSpecIssueList.corp_name}</td>
							<td>${tranSpecIssueList.ceo_name}</td>
							<td>${tranSpecIssueList.issue_dt}</td>				
							</tr>
						</c:forEach>
			
					</tr>
	
				</table>
			</td>
		</tr>
		
	</table>

	
</center>
		<c:if test="${tranSpecIssueCnt eq 0}">
				<h5>해당 결과가 없습니다.</h5>
		</c:if>
</body>
</html>