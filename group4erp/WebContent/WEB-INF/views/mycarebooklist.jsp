<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<title>담당 상품 조회</title>
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
<script>

	$(document).ready(function(){	

		//goSearchMyWorkList();
		
		$('[name=rowCntPerPage]').change(function(){
			goSearchMyWorkList();
		});
		
		$(".pagingNumber").html(
				getPagingNumber(
					"${myWorkListAllCnt}"						//검색 결과 총 행 개수
					,"${myWorkSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
					,"${myWorkSearchDTO.rowCntPerPage}"			//페이지 당 출력행의 개수
					,"10"										//페이지 당 보여줄 페이지번호 개수
					,"goSearchMyWorkList();"					//페이지 번호 클릭 후 실행할 자스코드
				)
			);
		inputData("[name=selectPageNo]", "${myWorkSearchDTO.selectPageNo}");
		inputData("[name=rowCntPerPage]", "${myWorkSearchDTO.rowCntPerPage}");
		inputData("[name=search_keyword]", "${myWorkSearchDTO.search_keyword}");
		inputData("[name=searchCategory]", "${myWorkSearchDTO.searchCategory}");
		inputData("[name=is_print]", "${myWorkSearchDTO.is_print}");
		
		<c:forEach items="${myWorkSearchDTO.category}" var="category">
			inputData("[name=category]", "${category}");
		</c:forEach>


		$("[name=is_print]").change(function(){
			if ( $(this).is(":checked") ){
				$(this).siblings().prop("checked", false);
			}
			$(this).siblings().prop("checked", false);
		});

	});
	
	function goSearchMyWorkList(){
		if( is_empty('[name=mycarebooklist] [name=search_keyword]') ){
			$('[name=search_keyword]').val("");
		}
		
		//키워드 앞뒤에 공백이 있으면 제거하고 다시 넣어주기
		
		var search_keyword = $('[name=mycarebooklist] [name=search_keyword]').val();
		search_keyword = $.trim(search_keyword);
		
		$('[name=search_keyword]').val(search_keyword);
		//alert($('[name=mycarebooklist]').serialize());
		document.mycarebooklist.submit();
		
		/*
		$.ajax({
			url : "/group4erp/goMyCareBookList.do"
			, type : "post"
		  , data : document.mycarebooklist.submit()
		});
		*/
	}
	
	function goAllSearchMyWorkList(){
		
		//name=boardListForm을 가진 form 태그 내부의 모든 입력양식에 value값을 비우거나 체크를 푼다.
		document.mycarebooklist.reset();
		
		$('[name=mycarebooklist] [name=rowCntPerPage]').val('20');
		$('[name=mycarebooklist] [name=selectPageNo]').val('1');
		$("[name=mycarebooklist] [name=sort]").val('');
		goSearchMyWorkList();
	}
   
   function booKInvenFill(idx,isbn) {

      //alert("도서 발주 기능 구현중 "+idx+"/"+isbn);
  
   	  var thisTr = $(idx).parent().parent();
   	  var trindex = thisTr.index();
   	  $(idx).addClass('fillbtu');

      //alert('999');
      var delTr = $('.mycarebookTable [name=test]');
      if(delTr.size()>0){
    	  delTr.remove();
      }
      
      //alert(trindex);
      //$('.mycarebookTable tbody tr:eq('+idx+')').append(" <tr> <td>");
      //$('.mycarebookTable tbody tr:eq('+idx+')').after(" <tr align=center> <td colspan=7> </td> </tr>");
      //var str = $('.qqq').html();
      //var thisTr = $(idx).parent().parent();
      
      
      var wares = "<tr name='test' align=center> <td colspan=7>"
      wares += "<div class='www'>"
      wares += "<form name='wareHousingForm'>"
      wares += "<table class='innertable' align=center>"
      wares += "<tr> <th>발주수량 <td><input type='text' name='isbn_cnt'>권"
      wares += "<tr> <th>입고요청일 <td><input type='text' id='datepicker' name='datepicker'>"
      wares += "<tr> <th>공급률 <td><input tyep='text' name='supply_rate' value='60'>%&nbsp;&nbsp;&nbsp;*(기본 60%)"
      wares += "</table> </from>"
      wares += "<div style='heigth:100;'></div>"
      wares += "<input type='button' value='발주신청' name='wareHousing'> &nbsp;&nbsp;"
      wares += "<input type='button' value='닫기' onclick='closeTr();'> </div>"

      thisTr.after(wares);

      $("#datepicker").datepicker({ 
              dateFormat: 'yy-mm-dd'
             ,minDate : 'today'
           ,onSelect: function() { 
                var dateObject = $(this).datepicker('getDate');
            }
       });   

      
      //$('.mycarebookTable tbody tr:eq('+idx+')').after(wares);
      //$('.mycarebookTable tbody tr:eq('+(idx+1)+') td:eq(0)').html(wares);
      //var sss =  $('.mycarebookTable tbody tr:eq('+(idx+1)+') td:eq(0)').html();
      //alert(sss);
      //return;
      
      $('[name=wareHousing]').click(function(){
    	  
    	  var wareData = "isbn=" + isbn + "&" + $('[name=wareHousingForm]').serialize();
    	  
    	  $.ajax({
              url : "/group4erp/myBookWarehousingProc.do"
              , type: "post"
              , data : wareData
              ,success : function(data){
                 	if(data == 1){
                 		alert("발주 성공");
                 		location.replace("/group4erp/goMyCareBookList.do");
                 	}else{ alert("발주 실패"); }
              } 
              , error : function(){ alert("서버 접속 실패"); }
           }); 
      });
 
   }
   
   function closeTr(){
	   $('[name=test]').remove();
   }
   
	function goAllReset(){
		document.mycarebooklist.reset();
	}

   

</script>

</head>
<body>
	<center>
	<h1 class="fontBold" style="font-size:15pt">[담당 상품 조회]</h1>
   <form name="mycarebooklist" method="post" action="/group4erp/goMyCareBookList.do">
   <!-- <div class="table_layout"> -->
   <input type="hidden" name="emp_no" value="<%=(String)session.getAttribute("emp_id") %>">
      <table class="mycarebookSearch tab" border=1 bordercolor="#000000" cellpadding=5 align=center>
         <!-- <colgroup>
            <col width="20%" />
            <col width="*" />
         </colgroup> -->

         
         <%-- 
         <tr>
         <th bgcolor="gray">분야
         <td align=center>
         <c:forEach items="${requestScope.categoryList}" var="categoryList" varStatus="loopTagStatus">
            <input type="checkbox" name="category" value="${categoryList.cat_cd}">${categoryList.cat_name}
         </c:forEach>
         <tr>
         <th bgcolor="gray">판형
         <td align=center>
         <c:forEach items="${requestScope.bookSize}" var="bookSize" varStatus="loopTagStatus">
            <input type="checkbox" name="category_name" value="${bookSize.size_cd}">${bookSize.size_name}
         </c:forEach>
         <tr>
         <th bgcolor="gray">지역
         <td align=center>
         <c:forEach items="${requestScope.branchList}" var="branchList" varStatus="loopTagStatus">
            <input type="checkbox" name="category_name" value="${branchList.branch_cd}">${branchList.branch_name}
         </c:forEach>
         <tr>
         <th bgcolor="gray">출판사
         <td align=center>
            <select name="publisher">
               <option value="">
               <c:forEach items="${requestScope.publisherList}" var="publisherList" varStatus="loopTagStatus">
                  <option value="${publisherList.publisher}">${publisherList.publisher}
               </c:forEach>
            <!-- 
               <option value="출판사1">출판사1
               <option value="출판사2">출판사2
               <option value="출판사3">출판사3
               <option value="출판사4">출판사4
               <option value="출판사5">출판사5
                --> --%>
         <tr>

         <th>절판 상황
         <td align=left>
            <input type="checkbox" name="is_print" value="y">절판
            <input type="checkbox" name="is_print" value="n">판매중
         
         <tr>
         <th>키워드
         <td>
            <select name="searchCategory">
               <option value="전체">전체
               <option value="책번호">책번호
               <option value="책이름">책이름
               <option value="카테고리">카테고리
               <option value="보유지점">보유지점
            </select>
            <input type="text" name="search_keyword" size=40>
      </table>
      <!-- </div> -->
      <br>
      <input type="button" value="  검색  " onclick="goSearchMyWorkList();">&nbsp;&nbsp;
      <input type="button" value="모두검색" onclick="goAllSearchMyWorkList();">&nbsp;&nbsp;
      <input type="button" value="초기화" onclick="goAllReset();">
      <table border=0 width=700>
         <tr>
            <td align=right>
               총 개수 : ${myWorkListAllCnt}&nbsp;&nbsp;&nbsp;&nbsp;
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
      
      
      <table class="mycarebookTable tab" width="80%" border=0 cellspacing=5 cellpadding=5 >
      	<thead>
         <tr bgcolor="gray">
         	<th width="4%">No
            <c:choose>
					<c:when test="${param.sort=='b.ISBN13 desc'}">
						<th width="9%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼책번호
					</c:when>
					<c:when test="${param.sort=='b.ISBN13 asc'}">
						<th width="9%" style="cursor: pointer"
							onclick="$('[name=sort]').val('b.ISBN13 desc'); goSearchMyWorkList();">▲책번호
					</c:when>
					<c:otherwise>
						<th width="9%" style="cursor: pointer"
							onclick="$('[name=sort]').val('b.ISBN13 asc'); goSearchMyWorkList();">책번호
					</c:otherwise>
			</c:choose> 
            <c:choose>
					<c:when test="${param.sort=='b.book_name desc'}">
						<th width="25%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼책 이름
					</c:when>
					<c:when test="${param.sort=='b.book_name asc'}">
						<th width="25%" style="cursor: pointer"
							onclick="$('[name=sort]').val('b.book_name desc'); goSearchMyWorkList();">▲책 이름
					</c:when>
					<c:otherwise>
						<th width="25%" style="cursor: pointer"
							onclick="$('[name=sort]').val('b.book_name asc'); goSearchMyWorkList();">책 이름
					</c:otherwise>
			</c:choose>
            <c:choose>
					<c:when test="${param.sort=='3 desc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼카테고리
					</c:when>
					<c:when test="${param.sort=='3 asc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('3 desc'); goSearchMyWorkList();">▲카테고리
					</c:when>
					<c:otherwise>
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('3 asc'); goSearchMyWorkList();">카테고리
					</c:otherwise>
			</c:choose>
            <c:choose>
					<c:when test="${param.sort=='to_number(b.book_price) desc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼가격
					</c:when>
					<c:when test="${param.sort=='to_number(b.book_price) asc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('to_number(b.book_price) desc'); goSearchMyWorkList();">▲가격
					</c:when>
					<c:otherwise>
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('to_number(b.book_price) asc'); goSearchMyWorkList();">가격
					</c:otherwise>
			</c:choose>
            <c:choose>
					<c:when test="${param.sort=='13 desc'}">
						<th width="7%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼수량
					</c:when>
					<c:when test="${param.sort=='13 asc'}">
						<th width="7%" style="cursor: pointer"
							onclick="$('[name=sort]').val('13 desc'); goSearchMyWorkList();">▲수량
					</c:when>
					<c:otherwise>
						<th width="7%" style="cursor: pointer"
							onclick="$('[name=sort]').val('13 asc'); goSearchMyWorkList();">수량
					</c:otherwise>
			</c:choose>
			<c:choose>
					<c:when test="${param.sort=='14 desc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼보유지점
					</c:when>
					<c:when test="${param.sort=='14 asc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('14 desc'); goSearchMyWorkList();">▲보유지점
					</c:when>
					<c:otherwise>
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('14 asc'); goSearchMyWorkList();">보유지점
					</c:otherwise>
			</c:choose>
			
            
			
			<c:choose>
					<c:when test="${param.sort=='9 desc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goSearchMyWorkList();">▼절판 상황
					</c:when>
					<c:when test="${param.sort=='9 asc'}">
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('9 desc'); goSearchMyWorkList();">▲절판 상황
					</c:when>
					<c:otherwise>
						<th width="8%" style="cursor: pointer"
							onclick="$('[name=sort]').val('9 asc'); goSearchMyWorkList();">절판 상황
					</c:otherwise>
			</c:choose>
			<th width="8%">비고</th>
        </thead>
        <tbody>    
         <c:forEach items="${requestScope.MyCareBookList}" var="MyCareBookList" varStatus="loopTagStatus">
         <tr>   

			<td align=center>${myWorkListAllCnt-(myWorkSearchDTO.selectPageNo*myWorkSearchDTO.rowCntPerPage-myWorkSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1}
            <td align=center>${MyCareBookList.ISBN13}
            <td align=center>${MyCareBookList.book_name}
            <td align=center>${MyCareBookList.cat_name}
            <td align=center>${MyCareBookList.book_price}
            <td align=center>${MyCareBookList.ISBN_cnt}
            <td align=center>${MyCareBookList.branch_name}
			<td align=center>${MyCareBookList.is_print}

            <td align=center>
               <c:if test="${MyCareBookList.ISBN_cnt < 100}">
                  <input type="button" value="발주" onClick="booKInvenFill(this,'${MyCareBookList.ISBN13}');" >
               </c:if>
               <c:if test="${MyCareBookList.ISBN_cnt >= 100}">
                  --
               </c:if>  
         </c:forEach>
         </tbody>
      </table>
      <br>
        <input type="hidden" name="selectPageNo">
      <div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
   		
</body>
</html>