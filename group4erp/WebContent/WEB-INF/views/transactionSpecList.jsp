<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래 내역 리스트</title>
<script>

	$(document).ready(function() {
		//headerSort("tranSpecInTb", 0);
		headerSort("tranSpecOutTb", 0);
		
		
		var issueYn = '${corpSearchDTO.issueYn}';

		if(issueYn != null) {
			if(issueYn.indexOf(",") >=0) {
				issueYn=issueYn.replace(/,/gi, "");
			}
			
		}
		
		$("[name=issueYn]").change(function() {
			
			var cnt = $(this).filter(":checked").length;
					
			if(cnt==1) {
				//change 이벤트가 발생한 체크박스의 형제들의 체크를 모두 풀기
				$(this).siblings().prop("checked", false);				
			} 
		});
		
		setTableTrBgColor(
				"tranSpecOutTb",	//테이블 class 값
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
					"${corp_tran_cnt}"						//검색 결과 총 행 개수
					,"${corpSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
					,"${corpSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
					,"10"										//페이지 당 보여줄 페이지번호 개수
					,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
				)
		);

		inputData('[name=rowCntPerPage]',"${corpSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${corpSearchDTO.selectPageNo}");
		inputData('[name=sort]', "${corpSearchDTO.sort}");		
		inputData('[name=issueYn]', '${corpSearchDTO.issueYn}');
		
		
		$('[name=rowCntPerPage]').val("${corpSearchDTO.rowCntPerPage}");
		$('[name=searchKeyword]').val("${corpSearchDTO.searchKeyword}");
		$('[name=selectPageNo]').val("${corpSearchDTO.selectPageNo}");
		$('[name=issueYn]').filter("[ value='${param.issueYn}' ]").prop("checked", true);
		//$('[name=date]').filter("[value='${date}']").prop("checked", true);
			
	});

	function viewTranSpec(order_no) {
		//alert("주문번호 "+order_no+"로 해당 거래명세서 조회 기능 구현 예정");
		$("[name=order_no]").val(order_no);
		document.tranSpecTable.submit();
	}

	function goSearch() {
		var keyword = $("[name=corpSearchForm] [name=searchKeyword]").val();
		keyword = $.trim(keyword);
		$("[name=corpSearchForm] [name=searchKeyword]").val(keyword);
		
		document.corpSearchForm.submit();
	}
	goReset

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
	<h1>[거래 내역]</h1><br>
	
	<form name="corpSearchForm" method="post" action="/group4erp/viewTranSpecList.do">
		<table class="tab" border="0" cellpadding="5" cellspacing="5">
			<tr>
				<td align="right">[거래명세서 발급 여부]</td><td>발급 : <input type="checkbox" name="issueYn" value="y" />
															미발급 : <input type="checkbox" name="issueYn" value="n" /></td>
			</tr>
			<tr>
				<td align="right">[검색어]</td><td><input type="text" name="searchKeyword">&nbsp;&nbsp;
													<input type="button" value="검색" onClick="goSearch();">&nbsp;&nbsp;
													<input type="button" value="모두검색" onClick="goSearchAll();">&nbsp;&nbsp;
													<input type="button" value="초기화" onClick="goReset();">
				</td>
			</tr>
		</table>
	<br> 
	
     <input type="hidden" name="selectPageNo">
     <input type="hidden" name="sort">
     <input type="hidden" name="issueYn">
		
	
	<table>
		<tr height=10>
			<td></td>
		</tr>
	</table>
	</form> 
	
	
	
	<table border="0" cellpadding="5" cellspacing="5">
		<tr>
			<td align = "right">
	        [전체] : ${corp_tran_cnt} 건 공급함&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value="10">10</option>
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	               <option value="30">30</option>
	            </select> 행보기
			</td>
		</tr>
		
		
		<tr><!-- 메인 목록 -->
			
			<td>
			<table class="tranSpecOutTb tab" name="transactionSpecTb" cellpadding="5" cellspacing="5">
				<tr>
				<th>번호</th>
				<c:choose>
					<c:when test="${param.sort=='1 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 주문번호</th>
					</c:when>
					<c:when test="${param.sort=='1 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('1 desc'); goSearch(); "> ▲ 주문번호</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('1 asc'); goSearch();  ">주문번호</th>
					</c:otherwise>
				</c:choose>
		
				<c:choose>
					<c:when test="${param.sort=='2 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 사업자번호</th>
					</c:when>
					<c:when test="${param.sort=='2 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('2 desc'); goSearch(); "> ▲ 사업자번호</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('2 asc'); goSearch();  ">사업자번호</th>
					</c:otherwise>
				</c:choose>
		
				<c:choose>
					<c:when test="${param.sort=='3 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 상호명</th>
					</c:when>
					<c:when test="${param.sort=='3 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 desc'); goSearch(); "> ▲ 상호명</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 asc'); goSearch();  ">상호명</th>
					</c:otherwise>
				</c:choose>
		
		<%-- <c:choose>
			<c:when test="${param.sort=='4 desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('4 asc'); goSearch();  "> ▼ 사업자명</th>
			</c:when>
			<c:when test="${param.sort=='4 asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('4 desc'); goSearch(); "> ▲ 사업자명</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('4 asc'); goSearch();  ">사업자명</th>
			</c:otherwise>
		</c:choose>--%>
		
			<c:choose>
				<c:when test="${param.sort=='5 desc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 주문수량</th>
				</c:when>
				<c:when test="${param.sort=='5 asc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val('5 desc'); goSearch(); "> ▲ 주문수량</th>
				</c:when>			
				<c:otherwise>
					<th style="cursor:pointer" onClick="$('[name=sort]').val('5 asc'); goSearch();  ">주문수량</th>
				</c:otherwise>
			</c:choose>
		
		<%--<c:choose>
			<c:when test="${param.sort=='6 desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('6 asc'); goSearch();  "> ▼ 단가</th>
			</c:when>
			<c:when test="${param.sort=='6 asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('6 desc'); goSearch(); "> ▲ 단가</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('6 asc'); goSearch();  ">단가</th>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='7 desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goSearch();  "> ▼ 총액</th>
			</c:when>
			<c:when test="${param.sort=='7 asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('7 desc'); goSearch(); "> ▲ 총액</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goSearch();  ">총액</th>
			</c:otherwise>
		</c:choose>  --%>
		
			<c:choose>
				<c:when test="${param.sort=='8 desc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 주문일</th>
				</c:when>
				<c:when test="${param.sort=='8 asc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val('8 desc'); goSearch(); "> ▲ 주문일</th>
				</c:when>			
				<c:otherwise>
					<th style="cursor:pointer" onClick="$('[name=sort]').val('8 asc'); goSearch();  ">주문일</th>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${param.sort=='9 desc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 거래명세서 발급</th>
				</c:when>
				<c:when test="${param.sort=='9 asc'}">
					<th style="cursor:pointer" onClick="$('[name=sort]').val('9 desc'); goSearch(); "> ▲ 거래명세서 발급</th>
				</c:when>			
				<c:otherwise>
					<th style="cursor:pointer" onClick="$('[name=sort]').val('9 asc'); goSearch();  ">거래명세서 발급</th>
				</c:otherwise>
			</c:choose>
			</tr>
	
			<c:forEach items='${corp_tran_list}' var="tranList" varStatus="loopTagStatus">
			<tr style="cursor:pointer" <c:if test="${tranList.issueYn == 0}"> onClick="viewTranSpec('${tranList.order_books_no}'); "</c:if>>
				<td>${corp_tran_cnt-tranList.RNUM+1}</td><!-- 수정필요 -->
				<td>${tranList.order_books_no}</td>
				<td>${tranList.corp_no}</td>
				<td>${tranList.corp_name}</td>
				<%--<td>${tranList.ceo_name}</td> --%>
				<td>${tranList.books_qty}</td>
				<%--<td>${tranList.book_price}</td>
				<td>${tranList.tot_cost}</td> --%>
				<td>${tranList.order_dt}</td>
				<td align="center">
					<c:if test="${tranList.issueYn != 0}">
						발급완료
					</c:if>
					<c:if test="${tranList.issueYn == 0}">
						미발급<!-- <input type="button" value="발급" onClick="issueTranSpec();"> --></td>
					</c:if>
			</tr>
			</c:forEach>
		</table>
		</td>
		</tr><!-- 메인 목록 끝 -->
	
	</table>
	
	<div>&nbsp; <span class="pagingNumber"></span>&nbsp;</div>
	
	<form name="tranSpecTable" method="post" action="/group4erp/viewTranSpecInfo.do">
		
		<input type="hidden" name="order_no">
	</form>
	
	

</center>

</body>
</html>