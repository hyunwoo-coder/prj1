<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 재고관리</title>
<script>

$(document).ready(function(){   

   $('[name=rowCntPerPage]').change(function(){
      goSearchBookInven();
   });
   
   $(".pagingNumber").html(
         getPagingNumber(
            "${bookListCnt}"                  //검색 결과 총 행 개수
            ,"${invenSearchDTO.selectPageNo}"         //선택된 현재 페이지 번호
            ,"${invenSearchDTO.rowCntPerPage}"      //페이지 당 출력행의 개수
            ,"10"                              //페이지 당 보여줄 페이지번호 개수
            ,"goSearchBookInven();"                  //페이지 번호 클릭 후 실행할 자스코드
         )
      );
   
   setTableTrBgColor(
			"bookTable"								//테이블 class값
			, "${headerColor}"									//해더 tr 배경색
			, "${oddTrColor}"									//홀수행 배경색
			, "${evenColor}"									//짝수행 배경색
			, "${mouseOverColor}"								//마우스 온 시 배경색
	);

   inputData('[name=rowCntPerPage]',"${invenSearchDTO.rowCntPerPage}");
   inputData('[name=selectPageNo]',"${invenSearchDTO.selectPageNo}");
   inputData('[name=searchPublisher]',"${invenSearchDTO.searchPublisher}");
   inputData('[name=is_print]',"${invenSearchDTO.is_print}");
   inputData('[name=book_keyword]',"${invenSearchDTO.book_keyword}");
   inputData('[name=sort]',"${invenSearchDTO.sort}");
   	<c:forEach items="${invenSearchDTO.category_name}" var="cat">
		inputData( "[name=category_name]", "${cat}" );
	</c:forEach>
	<c:forEach items="${invenSearchDTO.size_cd}" var="size_cd">
		inputData( "[name=size_cd]", "${size_cd}" );
	</c:forEach>
	<c:forEach items="${invenSearchDTO.inventory_loc}" var="loc">
		inputData( "[name=inventory_loc]", "${loc}" );
	</c:forEach>


	$("[name=is_print]").change(function(){
		if ( $(this).is(":checked") ){
			$(this).siblings().prop("checked", false);
		}
		$(this).siblings().prop("checked", false);
	});

	
   
});

   function goSearchBookInven(){
      //alert("검색기능 구현중");

      //alert(  $("[name=book_inventory_search_form]").serialize()   );
  
      //alert(  $("[name=book_inventory_search_form]").serialize()   );

      document.book_inventory_search_form.submit();
   }


   function goAllSearchBookInven(){
      //alert("모두검색기능 구현중");
      //document.book_inventory_search_form.reset();
      //goSearchBookInven();


		document.book_inventory_search_form.reset();
		$("[name=book_inventory_search_form] [name=selectPageNo]").val(1);
		$("[name=book_inventory_search_form] [name=rowCntPerPage]").val(10);
		$("[name=book_inventory_search_form] [name=sort]").val('');
		goSearchBookInven();
   }
   
   function goNewBookInfo(){
	   //alert("책등록 구현중");
	   //return;
	   location.href="/group4erp/viewSignUpBook.do";
   }
   
   function goBookContentForm(isbn13_search){
	   //alert("상세보기 구현중"+str);
	   //return;
	   var str = "isbn13_search="+isbn13_search;
	   location.href="/group4erp/viewBookContentForm.do?"+str;
   }
   
   function goAllReset(){
	   document.book_inventory_search_form.reset();
   }

</script>
<!--
<style>
   .table_layout{width:98%}
   
   table{width:100%}

</style>
-->
</head>
<body>
	<center>
		<!-- <h5 align="left">재고현황 -> 도서정보조회</h5> -->
		<h1>[재고 관리]</h1>
		<form name="book_inventory_search_form" method="post"
			action="/group4erp/goBookList.do">
			<!-- <div class="table_layout">  -->

			<table class="tab2" bordercolor="#000000" cellspacing="5"
				cellpadding="5" align=center>
				<!-- <colgroup>
            <col width="20%" />
            <col width="*" />
         </colgroup> -->
				<tr>
					<th>분야
					<td align=left colspan=5><c:forEach
							items="${requestScope.category}" var="cat"
							varStatus="loopTagStatus">
							<input type="checkbox" name="category_name" value="${cat.cat_name}">${cat.cat_name}
         	</c:forEach> <!-- 
            <input type="checkbox" name="category_name" value="소설">소설
            <input type="checkbox" name="category_name" value="사회">사회
            <input type="checkbox" name="category_name" value="과학">과학
            <input type="checkbox" name="category_name" value="IT">IT
            <input type="checkbox" name="category_name" value="예술">예술
            <input type="checkbox" name="category_name" value="종교">종교
            <input type="checkbox" name="category_name" value="만화">만화
            <input type="checkbox" name="category_name" value="여행">여행
            <input type="checkbox" name="category_name" value="잡지">잡지
            <input type="checkbox" name="category_name" value="요리">요리
             -->
				<tr>
					<th>판형
					<td align=left colspan=5><c:forEach
							items="${requestScope.size}" var="size" varStatus="loopTagStatus">
							<input type="checkbox" name="size_cd" value="${loopTagStatus.index+1}">${size.size_name}
         	</c:forEach> <!-- 
            <input type="checkbox" name="size_cd" value="01">신국판
            <input type="checkbox" name="size_cd" value="02">국판
            <input type="checkbox" name="size_cd" value="03">46판
            <input type="checkbox" name="size_cd" value="04">46배판
            <input type="checkbox" name="size_cd" value="05">크라운판
            <input type="checkbox" name="size_cd" value="06">국배판
            <input type="checkbox" name="size_cd" value="07">타블로이드
            -->
				<tr>
					<th>지역
					<td align=left colspan=5><c:forEach
							items="${requestScope.inventory_loc}" var="inven"
							varStatus="loopTagStatus">
							<input type="checkbox" name="inventory_loc" value="${loopTagStatus.index+1}">${inven.branch_name}
             </c:forEach>
				<tr>
					<th>출판사
					<td align=left><select name="searchPublisher">
							<option value="">--------</option>
							<c:forEach items="${requestScope.publisher}" var="publisher"
								varStatus="loopTagStatus">
								<option value="${publisher.publisher}">${publisher.publisher}</option>
							</c:forEach>
							<th>판매 상황
						<td align=left><input type="checkbox" name="is_print"
								value="n">절판 <input type="checkbox" name="is_print"
								value="y">판매중
						<tr>
								<th>키워드
								<td colspan=5><input type="text" name="book_keyword"
									size=78>
			</table>
			<!-- </div> -->
			<br> <input type="button" value="  검색  "
				onclick="goSearchBookInven();">&nbsp;&nbsp; <input
				type="button" value="모두검색" onclick="goAllSearchBookInven();">&nbsp;&nbsp;
			<input type="button" value="초기화" onclick="goAllReset();">

			<table border=0 width=700>
				<tr>
					<td align=right>[검색 수량] : ${bookListCnt} 종 <select
						name="rowCntPerPage">
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
							<option value="25">25</option>
							<option value="30">30</option>
					</select> 행보기
			</table>
			<input type="hidden" name="selectPageNo">
			<!-- header sort를 하기 위한 hidden Tag -->
			<input type="hidden" name="sort">
		</form>

		<br>
		<form>
			<table class="bookTable tab" border=0 cellspacing=0 cellpadding=5 width="80%">
				<tr>
					<th width="6%">번호
					 <c:choose>
							<c:when test="${param.sort=='isbn13 desc'}">
								<th width="14%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼책번호
							</c:when>
							<c:when test="${param.sort=='isbn13 asc'}">
								<th width="14%" style="cursor: pointer"
									onclick="$('[name=sort]').val('isbn13 desc'); goSearchBookInven();">▲책번호
								
							</c:when>
							<c:otherwise>
								<th width="14%" style="cursor: pointer"
									onclick="$('[name=sort]').val('isbn13 asc'); goSearchBookInven();">책번호
							</c:otherwise>
					</c:choose> 
						
					<c:choose>
							<c:when test="${param.sort=='book_name desc'}">
								<th width="30%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼책이름
								
							</c:when>
							<c:when test="${param.sort=='book_name asc'}">
								<th width="30%" style="cursor: pointer"
									onclick="$('[name=sort]').val('book_name desc'); goSearchBookInven();">▲책이름
								
							</c:when>
							<c:otherwise>
								<th width="30%" style="cursor: pointer"
									onclick="$('[name=sort]').val('book_name asc'); goSearchBookInven();">책이름
								
							</c:otherwise>
					</c:choose> 
					
					<c:choose>
							<c:when test="${param.sort=='3 desc'}">
								<th width="6%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼카테고리
							</c:when>
							<c:when test="${param.sort=='3 asc'}">
								<th width="6%" style="cursor: pointer"
									onclick="$('[name=sort]').val('3 desc'); goSearchBookInven();">▲카테고리
							</c:when>
							<c:otherwise>
								<th width="6%" style="cursor: pointer"
									onclick="$('[name=sort]').val('3 asc'); goSearchBookInven();">카테고리
							</c:otherwise>
					</c:choose>
					
					<c:choose>
							<c:when test="${param.sort=='publisher desc'}">
								<th width="10%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼출판사
								
							</c:when>
							<c:when test="${param.sort=='publisher asc'}">
								<th width="10%" style="cursor: pointer"
									onclick="$('[name=sort]').val('publisher desc'); goSearchBookInven();">▲출판사
								
							</c:when>
							<c:otherwise>
								<th width="10%" style="cursor: pointer"
									onclick="$('[name=sort]').val('publisher asc'); goSearchBookInven();">출판사
								
							</c:otherwise>
					</c:choose>
					
					<c:choose>
							<c:when test="${param.sort=='is_print desc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼절판여부
								
							</c:when>
							<c:when test="${param.sort=='is_print asc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('is_print desc'); goSearchBookInven();">▲절판여부
								
							</c:when>
							<c:otherwise>
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('is_print asc'); goSearchBookInven();">절판여부
								
							</c:otherwise>
					</c:choose> 
						
					<c:choose>
							<c:when test="${param.sort=='to_number(book_price) desc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼가격
								
							</c:when>
							<c:when test="${param.sort=='to_number(book_price) asc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('to_number(book_price) desc'); goSearchBookInven();">▲가격
								
							</c:when>
							<c:otherwise>
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('to_number(book_price) asc'); goSearchBookInven();">가격
								
							</c:otherwise>
					</c:choose> 
					
					<c:choose>
							<c:when
								test="${param.sort=='(select s.isbn_cnt from stock_info s where s.isbn13=b.isbn13) desc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼수량
							</c:when>
							<c:when
								test="${param.sort=='(select s.isbn_cnt from stock_info s where s.isbn13=b.isbn13) asc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('(select s.isbn_cnt from stock_info s where s.isbn13=b.isbn13) desc'); goSearchBookInven();">▲수량
							</c:when>
							<c:otherwise>
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('(select s.isbn_cnt from stock_info s where s.isbn13=b.isbn13) asc'); goSearchBookInven();">수량
							</c:otherwise>
					</c:choose>
					
					<c:choose>
							<c:when test="${param.sort=='12 desc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchBookInven();">▼재고위치
							</c:when>
							<c:when test="${param.sort=='12 asc'}">
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('12 desc'); goSearchBookInven();">▲재고위치
							</c:when>
							<c:otherwise>
								<th style="cursor: pointer"
									onclick="$('[name=sort]').val('12 asc'); goSearchBookInven();">재고위치
							</c:otherwise>
					</c:choose>
					
					
					
					<c:forEach items="${requestScope.BookList}"
							var="book" varStatus="loopTagStatus">
							<tr style="cursor: pointer"
								onClick="goBookContentForm(${book.ISBN13});">
								<td align=center>${bookListCnt-(invenSearchDTO.selectPageNo*invenSearchDTO.rowCntPerPage-invenSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1}
								<td align=center>${book.ISBN13}
								<td align=center>${book.book_name}
								<td align=center>${book.cat_name}
								<td align=center>${book.publisher}
								<td align=center>${book.is_print=='y'?'판매중':'절판'}
								<td align=center>${book.book_price}
								<td align=center>${book.book_cnt}
								<td align=center>${book.branch_name}
						</c:forEach> <!-- <tr><td colspan=8 align=center> DB 연동 실패(아직 구현중)  -->
			</table>

			<br>


			<div>
				&nbsp;<span class="pagingNumber"></span>&nbsp;
			</div>


			<input type="button" value=" 책 등록 " onclick="goNewBookInfo();">
		</form>
</body>
</html>