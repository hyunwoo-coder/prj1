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
<title>출고 현황 </title>
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
	
	$("#datepicker1").datepicker({
		dateFormat: 'yy-mm-dd'
		,onClose: function( selectedDate ) {
			$("#datepicker2").datepicker( "option", "minDate", selectedDate );
		} 
	    ,onSelect: function() { 
	        var dateObject = $(this).datepicker('getDate');
	    }
	});
	$("#datepicker2").datepicker({
		dateFormat: 'yy-mm-dd'
		,onClose: function( selectedDate ) {
	        $("#datepicker1").datepicker( "option", "maxDate", selectedDate );
	    }
	    ,onSelect: function() { 
	        var dateObject = $(this).datepicker('getDate');
	    }
	});
	
	 $('[name=rowCntPerPage]').change(function(){
		 goSearchRelease();
	 });
	   
	   
	 $(".pagingNumber").html(
			 getPagingNumber(
					 "${releaseListCnt}"                  //검색 결과 총 행 개수
	            	,"${invenSearchDTO.selectPageNo}"         //선택된 현재 페이지 번호
	            	,"${invenSearchDTO.rowCntPerPage}"      //페이지 당 출력행의 개수
	            	,"10"                              //페이지 당 보여줄 페이지번호 개수
	            	,"goSearchRelease();"                  //페이지 번호 클릭 후 실행할 자스코드
	            	)
	         );
	   
	 setTableTrBgColor(
				"releaseListTable"								//테이블 class값
				, "${headerColor}"									//해더 tr 배경색
				, "${oddTrColor}"									//홀수행 배경색
				, "${evenColor}"									//짝수행 배경색
				, "${mouseOverColor}"								//마우스 온 시 배경색
	);
	 inputData('[name=rowCntPerPage]',"${invenSearchDTO.rowCntPerPage}");
	 inputData('[name=selectPageNo]',"${invenSearchDTO.selectPageNo}");
	 inputData('[name=searchPublisher]',"${invenSearchDTO.searchPublisher}");
	 inputData('[name=keyword1]',"${invenSearchDTO.keyword1}");
	 inputData('[name=dateFrom]',"${invenSearchDTO.dateFrom}");
	 inputData('[name=dateTill]',"${invenSearchDTO.dateTill}");
	 <c:forEach items="${invenSearchDTO.inventory_loc}" var="loc">
		inputData( "[name=inventory_loc]", "${loc}" );
	 </c:forEach>
});

	function goSearchRelease(){
		//alert("검색 기능 구현중");
		//alert( $("[name=bookReleaseSearch]").serialize() );
		//return;
		
		//alert($('[name=dateFrom]').val());
		//return;
		document.bookReleaseSearch.submit();
	}

	function goAllSearchRelease(){
		//alert("모두검색 기능 구현중");
		document.bookReleaseSearch.reset();
		//$("[name=book_inventory_search_form] [name=sort]").val('');
		goSearchRelease();
	}
	
	function goClose(){
		$('[name=thisTr]').remove();
	}

	
	function goReleaseContentForm(ele,all_order_no){
		/*
		var str = "all_order_no="+all_order_no;
		location.href="/group4erp/goReleaseContentForm.do?"+str;
		*/
		/*
		alert("all_order_no="+all_order_no+"  ele=>"+ele);
		return;
		*/
		var str = "all_order_no="+all_order_no;
		
		var test = $(ele).parent();
		/*
		alert(test.html());
		return;
		*/
	    var delTr = $('[name=thisTr]');
	    if(delTr.size()>0){
	         delTr.remove();
	    }
		
		$.ajax({
			//호출할 서버쪽 URL주소 설정
			url : "/group4erp/goReleaseContentForm.do"
			//전송 방법 설정
			, type : "POST"
			//서버로 보낼 파라미터명과 파라미터값을 설정
			, data : str
			, dataType : "JSON"
			//서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			//매개변수 upDelCnt에는 입력 행의 개수가 들어온다.
			, success : function(data){
				if(data!=null){
					if(data.check_order_num=='cus'){
						$("#contecntTable1 td:eq(0)").text(data.isbn13);
						$("#contecntTable1 td:eq(1)").text(data.cus_id);
						$("#contecntTable1 td:eq(2)").text(data.book_name);
						$("#contecntTable1 td:eq(3)").text(data.order_delivery_addr);
						$("#contecntTable1 td:eq(4)").text(data.order_dt);
						$("#contecntTable1 td:eq(5)").text(data.book_qty);
						$("#contecntTable1 td:eq(6)").text(data.publisher);
						$("#contecntTable1 td:eq(7)").text(data.book_price);
						$("#contecntTable1 td:eq(8)").text(data.all_book_price);
						$("#contecntTable1 td:eq(9)").text(data.emp_name);
						var insert = "<tr name='thisTr' bgcolor='white'><td colspan=5>"+$("#allContent #contecnt1").html()+"</td></tr>"
						
						test.after(insert);
						return;
					}
					if(data.check_order_num=='corp'){
						if(data.branch_name==null){
							$("#contecntTable2 td:eq(0)").text(data.isbn13);
							$("#contecntTable2 td:eq(1)").text(data.cus_id);
							$("#contecntTable2 td:eq(2)").text(data.book_name);
							$("#contecntTable2 td:eq(3)").text(data.order_delivery_addr);
							$("#contecntTable2 td:eq(4)").text(data.corp_name);
							$("#contecntTable2 td:eq(5)").text(data.corp_area);
							$("#contecntTable2 td:eq(6)").text(data.ceo_name);
							$("#contecntTable2 td:eq(7)").text(data.order_dt);
							$("#contecntTable2 td:eq(8)").text(data.book_qty);
							$("#contecntTable2 td:eq(9)").text(data.publisher);
							$("#contecntTable2 td:eq(10)").text(data.book_price);
							$("#contecntTable2 td:eq(11)").text(data.all_book_price);
							$("#contecntTable2 td:eq(12)").text(data.emp_name);
							
							var insert = "<tr name='thisTr' bgcolor='white'><td colspan=5>"+$("#allContent #contecnt2").html()+"</td></tr>"
							
							test.after(insert);
							return;
						}
						if(data.branch_name!=null){
							$("#contecntTable3 td:eq(0)").text(data.isbn13);
							$("#contecntTable3 td:eq(1)").text(data.emp_name);
							$("#contecntTable3 td:eq(2)").text(data.book_name);
							$("#contecntTable3 td:eq(3)").text(data.branch_name);
							$("#contecntTable3 td:eq(4)").text(data.order_dt);
							$("#contecntTable3 td:eq(5)").text(data.book_qty);
							$("#contecntTable3 td:eq(6)").text(data.publisher);
							
							var insert = "<tr name='thisTr' bgcolor='white'><td colspan=5>"+$("#allContent #contecnt3").html()+"</td></tr>"
							
							test.after(insert);
							return;
							
						}
					}
					
				}
				
				
			}
			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function(){
				alert("서버 접속 실패");
			}
		});
		
		
	}
	
	function searchToday(){
		
		$('[name=searchToday]').val('y');
		
		var date = new Date();
		
		var todayY = date.getFullYear();
		var todayM = date.getMonth()+1;
		var todayD = date.getDate();
		
		if(todayM<10) todayM = '0'+todayM;
		if(todayD<10) todayD = '0'+todayD;
		
		var today = todayY+'-'+todayM+'-'+todayD;
		
		
		$('[name=dateFrom]').val(today);
		$('[name=dateTill]').val(today);
		
		goSearchRelease();
	}

	
	function goReleaseUp(all_order_no){
		
		var str = "all_order_no="+all_order_no;
		
		$.ajax({
			//호출할 서버쪽 URL주소 설정
			url : "/group4erp/goReleaseUp.do"
			//전송 방법 설정
			, type : "POST"
			//서버로 보낼 파라미터명과 파라미터값을 설정
			, data : str
			//서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			//매개변수 upDelCnt에는 입력 행의 개수가 들어온다.
			, success : function(updateCnt){
				if(updateCnt==1){
					alert("출고 날짜 등록 성공");
					location.replace("/group4erp/goReleaseList.do")
				}else if(updateCnt==0){
					alert("출고 날짜 등록 실패");
				}else if(updateCnt==-1){
					alert("재고가 부족합니다!");
				}else { alert("서버 오류!"); }
			}
			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function(){
				alert("서버 접속 실패");
			}
		});
		
	}

	function goReset(){
		document.bookReleaseSearch.reset();
		//$('[name=bookReleaseSearch]').reset();
	}
	
</script>

</head>
<body><center>
<h1>[출고 현황]</h1>
		<form name="bookReleaseSearch" method="post" action="/group4erp/goReleaseList.do">

		<table class="tab2"  border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
			<th>지역
			<td align=left colspan=3>
	        	<c:forEach items="${requestScope.inventory_loc}" var="inven" varStatus="loopTagStatus">
             		<input type="checkbox" name="inventory_loc" value="${inven.branch_name}">${inven.branch_name}
            	</c:forEach>
			<tr>
			<th>일자
			<td>
				<input type="text" id="datepicker1" name="dateFrom">
				&nbsp;~&nbsp;
				<input type="text" id="datepicker2" name="dateTill">
			<th>출판사
			<td align=center>
				<select name="searchPublisher">
					<option value="">--------------</option>
					<c:forEach items="${requestScope.publisher}" var="publisher" varStatus="loopTagStatus">
                  		<option value="${publisher.publisher}">${publisher.publisher}</option>
               		</c:forEach>
				</select>
			<tr>
			<th>키워드
			<td colspan=3><input type="text" name="keyword1" size=50>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a style="cursor:pointer" onclick="searchToday();">[금일 검색]</a>
			
		</table>
		<br>
			<input type="button" onClick="goSearchRelease();" value="검색">
			<input type="button" onClick="goAllSearchRelease();" value="모두검색">
			<input type="button" onClick="goReset();" value="초기화">
     	<table border=0 width=700>
         <tr>
            <td align=right>
            [검색 수량] : ${releaseListCnt} 개
               <select name="rowCntPerPage">
                  <option value="10">10</option>
                  <option value="15">15</option>
                  <option value="20">20</option>
                  <option value="25">25</option>
                  <option value="30">30</option>
               </select> 행보기
     	</table>
      	<input type="hidden" name="selectPageNo" value="${invenSearchDTO.selectPageNo}">
      	<input type="hidden" name="searchToday">
      	<input type="hidden" name="sort">
		</form>

		<br><br><br>
		<table class="releaseListTable tab" width="80%" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<th width="10%">No
				<c:choose>
							<c:when test="${param.sort=='r.release_no desc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchRelease();">▼출고번호
							</c:when>
							<c:when test="${param.sort=='r.release_no asc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('r.release_no desc'); goSearchRelease();">▲출고번호
								
							</c:when>
							<c:otherwise>
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('r.release_no asc'); goSearchRelease();">출고번호
							</c:otherwise>
					</c:choose> 
						
					<c:choose>
							<c:when test="${param.sort=='r.release_dt desc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchRelease();">▼출고일시
								
							</c:when>
							<c:when test="${param.sort=='r.release_dt asc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('r.release_dt desc'); goSearchRelease();">▲출고일시
								
							</c:when>
							<c:otherwise>
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('r.release_dt asc'); goSearchRelease();">출고일시
								
							</c:otherwise>
					</c:choose> 
					
					<c:choose>
							<c:when test="${param.sort=='3 desc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val(''); goSearchRelease();">▼주문번호
							</c:when>
							<c:when test="${param.sort=='3 asc'}">
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('3 desc'); goSearchRelease();">▲주문번호
							</c:when>
							<c:otherwise>
								<th width="20%" style="cursor: pointer"
									onclick="$('[name=sort]').val('3 asc'); goSearchRelease();">주문번호
							</c:otherwise>
					</c:choose>
				<th width="10%">비고
			<c:forEach items="${requestScope.releaseList}" var="release" varStatus="loopTagStatus">
	            <tr>
		          	<td style="cursor:pointer" onClick="goReleaseContentForm(this,${release.all_order_no});" align=center>${releaseListCnt-
		                  (invenSearchDTO.selectPageNo*invenSearchDTO.rowCntPerPage-invenSearchDTO.rowCntPerPage+1+loopTagStatus.index)
		                  +1}
		            <td style="cursor:pointer" onClick="goReleaseContentForm(this,${release.all_order_no});" align=center>${release.release_no}
		            <td style="cursor:pointer" onClick="goReleaseContentForm(this,${release.all_order_no});" align=center>${release.release_dt}
		            <td style="cursor:pointer" onClick="goReleaseContentForm(this,${release.all_order_no});" align=center>${release.all_order_no}
	            	<c:if test="${release.release_dt=='X'}">
	            		<td align=center>
	            		<input type="button" value="출고" onclick="goReleaseUp(${release.all_order_no});">
	            	</c:if>
	            	<c:if test="${release.release_dt.length()>1}">
	            		<td style="cursor:pointer" onClick="goReleaseContentForm(this,${release.all_order_no});" align=center>	
	            		------
	            	</c:if>
         	</c:forEach>
		</table>
		<br>
		<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
	<div id="allContent" style="display:none;">
		<div id="contecnt1" style="dispaly:none;">
			<table border=0 width=700>
	 			<tr>
	 				<td align=right>
						<a href="javascript:goClose();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[닫기]</a>
			</table>
			<table class="tab" id="contecntTable1" border=1 bordercolor="#000000" cellpadding=5 align=center>
				<tr>
					<th>책번호
					<td colspan=2>111
					<th>고객ID
					<td colspan=2>222
				<tr>
					<th>책이름
					<td colspan=5>333
				<tr>
					<th>고객 배송지
					<td colspan=5>444
				<tr>
					<th>주문일시
					<td>555
					<th>주문 수량
					<td>
					<th>출판사
					<td>
				<tr>
					<th>책가격
					<td>
					<th>총 가격
					<td>
					<th>담당직원
					<td>
			</table>
		</div>
		
		<div id="contecnt2" style="dispaly:none;">
			<table border=0 width=700>
	 			<tr>
	 				<td align=right>
						<a href="javascript:goClose();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[닫기]</a>
			</table>
			<table class="tab" id="contecntTable2" border=1 bordercolor="#000000" cellpadding=5 align=center>
				<tr>
					<th>책번호
					<td colspan=2>
					<th>사업자ID
					<td colspan=2>
				<tr>
					<th>책이름
					<td colspan=5>
				<tr>
					<th>사업자 배송지
					<td colspan=5>
				<tr>
					<th>회사명
					<td>
					<th>분야
					<td>
					<th>대표자명
					<td>
				<tr>
					<th>주문일시
					<td>
					<th>주문 수량
					<td>
					<th>출판사
					<td>
				<tr>
					<th>책가격
					<td>
					<th>총 가격
					<td>
					<th>담당직원
					<td>
			</table>
		</div>
		
		<div id="contecnt3" style="dispaly:none;">
			<table border=0 width=700>
	 			<tr>
	 				<td align=right>
						<a href="javascript:goClose();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[닫기]</a>
			</table>
			<table class="tab" id="contecntTable3" border=1 bordercolor="#000000" cellpadding=5 align=center>
				<tr>
					<th>책번호
					<td colspan=2>
					<th>담당직원
					<td colspan=2>
				<tr>
					<th>책이름
					<td colspan=5>
				<tr>
					<th>지사 위치
					<td colspan=5>$
				<tr>
					<th>주문일시
					<td>
					<th>주문 수량
					<td>
					<th>출판사
					<td>
			</table>
		</div>
	</div>
		<!-- <br>
		<input type="button" value="  주문정보수정  " onclick="goUpdateRelease();">&nbsp;&nbsp;
		<input type="button" value="  주문 삭제  " onclick="goDeleteRelease();">&nbsp;&nbsp;

		</div> -->
		<c:if test="${releaseListCnt eq 0}">
				<h5>검색결과가 없습니다.</h5>
		</c:if>

		<script>
			
			
			
		</script>
	</body>
</html>