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
<!-- <link href="/resources/common.css" rel="stylesheet" type="text/css">  -->
<title>입고 현황</title>
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


@charset "UTF-8";
	
/*-----------------------------------------------------------------------*/ 
body,form,td,th,pre { 
	font-size: 9pt; 
	color: black; 
	line-height: 160%; 
	font-family: 굴림,tahoma,돋움,verdana; 
} 

/*-----------------------------------------------------------------------*/ 
input { 
	font-size: 9pt; 
	color:black; 
	font-family: 굴림,tahoma,돋움,verdana; 
	height: 20px; 
} 
a:link {text-decoration:none;color:#696969} 
a:hover{text-decoration:none;color:#66ccff} 
a:visited {text-decoration:none;color:#330066} 
/*body,td,a,div,p,pre,input,textarea {font-family:굴림;font-size:9pt;}*/

.thcolor {
	background-color: #1AAB8A;
}

td{
	text-align:center;
}


</style>
	<script>
		/* var picker = new Pikaday({ 
			 field: document.getElementById('datepicker'),
			 format: 'yyyy-MM-dd',
			 toString(date, format) {
			   let day = ("0" + date.getDate()).slice(-2);
			   let month = ("0" + (date.getMonth() + 1)).slice(-2);
			   let year = date.getFullYear();
			   return `${year}-${month}-${day}`;
		 }
		}) */;
	
		$(document).ready(function(){

/* 			$('[name=rowCntPerPage]').change(function(){
				goSearch();
			}); */

			$('[name=rowCntPerPage]').change(function(){
				goWhSearch();
			});

 			setTableTrBgColor(
					"tableColor",			//테이블 class 값
					"${headerColor}",		//헤더 tr 배경색
					"${oddTrColor}",		//홀수행 배경색
					"${evenTrColor}",		//짝수행 배경색
					"${mouseOverColor}"		//마우스 온 시 배경색
			);
			
			var thSibling = $("#thisTable tr:eq(0)").siblings()
			//var thSiblingOdd = thSibling.filter(":odd");
			//var thSiblingEven =	thSibling.filter(":even");
			//thSibling.click(function(){
					//$(this).html(<b></b>);
					//$(this).attr('bgcolor', 'yellow');
					//$(this).siblings().removeAttr("bgcolor");
			//});
			
 			$(".pagingNumber").html(
				getPagingNumber(
					"${warehousingListCnt}"					//검색 결과 총 행 개수
					,"${warehousingSearchDTO.selectPageNo}"		//선택된 현재 페이지 번호
					,"${warehousingSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
					,"10"									//페이지 당 보여줄 페이지번호 개수
					,"goWhSearch();"							//페이지 번호 클릭 후 실행할 자스 코드
				)
			); 


 			$("#dateFrom").datepicker({
			    onSelect: function() { 
			    	//var date = $('#datepicker').datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
			        var dateObject = $(this).datepicker('getDate');
			        //alert(dateObject.val()); 
			    }
			});
 			$("#dateTill").datepicker({
			    onSelect: function() { 
			    	//var date = $('#datepicker').datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
			        var dateObject = $(this).datepicker('getDate');
			        //alert(dateObject.val()); 

			    }     
			});

			inputData( "[name=selectPageNo]", "${warehousingSearchDTO.selectPageNo}" );	
			inputData( "[name=rowCntPerPage]", "${warehousingSearchDTO.rowCntPerPage}" );
		    inputData('[name=wh_keyword]',"${warehousingSearchDTO.wh_keyword}");
		    inputData( "[name=dateFrom]", "${warehousingSearchDTO.dateFrom}" );
		    inputData( "[name=dateTill]", "${warehousingSearchDTO.dateTill}" );
		    <c:forEach items="${warehousingSearchDTO.wh_loc}" var="loc">
				inputData( "[name=wh_loc]", "${loc}" );
			</c:forEach>

		});
	
		function goWhSearch(){
			//alert($("[name=datepicker]").val());
			//alert($("[name=InoutListDate]").serialize());
			//var keyword1 = $("[name=InoutListDate] [name=keyword1]").val();
			//keyword1 = $.trim(keyword1);
			//$("[name=InoutListDate] [name=keyword1]").val(keyword1);
			//alert( $('[name=searchToday]').val() );
			//return;
			//alert( $("[name=dateFrom]").val() );
			//alert( $("[name=dateTill]").val() );
			document.warehousingSearchForm.submit();
		}

		function goTodaySearch(){
			$('[name=searchToday]').val('y'); 
			inputData( "[name=dateFrom]", null );
		    inputData( "[name=dateTill]", null );
		    /* alert( $("[name=dateFrom]").val() );
		    alert( $("[name=dateTill]").val() ); */
			goWhSearch();
		}

		function goWhSearchAll(){
			document.warehousingSearchForm.reset();
			$("[name=warehousingSearchForm] [name=selectPageNo]").val(1);
			$("[name=warehousingSearchForm] [name=rowCntPerPage]").val(10);
			$("[name=warehousingSearchForm] [name=sort]").val('');
			goWhSearch();
			
		}

		function goWarehousingContent(ele,order_inven_no ){
			//alert($(ele).parent().html());
			var test = $(ele).parent();

		    var delTr = $('[name=thisTr]');
		    if(delTr.size()>0){
		         delTr.remove();
		    }
			$.ajax({
				//alert( $('[name=warehousingSearchForm]').serialize() );
            	//-----------------------------
                // 호출할 서버쪽 URL 주소 설정
                //-----------------------------
                url : "/group4erp/warehousingContentProc.do"
                //----------------
                // 전송 방법 설정
                //----------------
                , type: "post"
                //--------------------------------------------
                // 서버로 보낼 파라미터명과 파라미터값을 설정       param1=aaaa&param2=zzzz
                //--------------------------------------------
                , data : "order_inven_no="+order_inven_no
                //, dataType:"JSON"
                //-----------------------------------------------------------
                // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
                // 매개변수 upDelCnt 에는 수정/삭제 적용행의 개수가 들어온다
                //-----------------------------------------------------------
                ,success : function(data){
                   	if(data != null){
                       		$("#contentTable td:eq(0)").text(data.emp_name);
                       		$("#contentTable td:eq(1)").text(data.order_dt);
                       		$("#contentTable td:eq(2)").text(data.order_stock_cnt);
                       		$("#contentTable td:eq(3)").text(data.cost+'원');
                       		$("#contentTable td:eq(4)").text(data.supply_rate);
                       		$("#contentTable td:eq(5)").text(data.store_req_dt);
                       		$("#contentTable td:eq(6)").text(data.branch_name);
                       		$("#contentTable td:eq(7)").text(data.isbn);
                       		$("#contentTable td:eq(8)").text(data.book_name);
                       		$("#contentTable td:eq(9)").text(data.book_publisher);
                       		$("#contentTable td:eq(10)").text(data.cat_name);
							//$("#contecnt").css("display", "block");	
							setTableTrBgColor(
									"tableColor",			//테이블 class 값
									"${headerColor}",		//헤더 tr 배경색
									"${oddTrColor}",		//홀수행 배경색
									"${evenTrColor}",		//짝수행 배경색
									"${mouseOverColor}"		//마우스 온 시 배경색
							);
							var insert = "<tr name='thisTr' bgcolor='white'><td colspan=5>"+$("#contecnt").html()+"</td></tr>"
							
							test.after(insert);
							
							
							
                   	}
							//$("#thisTable tr:eq(0)").siblings().click(function(){
	                        //}); 
                } 
                //---------------------------------------------------
                // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                //---------------------------------------------------
                , error : function(){
                   alert("서버 접속 실패");
                }
             });

		}
		
		function closeDiv(close){
			/* $("#contecnt").css("display", "none");	
			$("#thisTable tr").removeAttr("bgcolor"); */
			$('[name=thisTr]').remove();
			setTableTrBgColor(
					"tableColor",			//테이블 class 값
					"${headerColor}",		//헤더 tr 배경색
					"${oddTrColor}",		//홀수행 배경색
					"${evenTrColor}",		//짝수행 배경색
					"${mouseOverColor}"		//마우스 온 시 배경색
			);
			
	    }

	    function goWhConfirm(wh_no){
			alert(wh_no);

			$.ajax({
	            	//-----------------------------
	                // 호출할 서버쪽 URL 주소 설정
	                //-----------------------------
	                url : "/group4erp/whConfirmProc.do"
	                //----------------
	                // 전송 방법 설정
	                //----------------
	                , type: "post"
	                //--------------------------------------------
	                // 서버로 보낼 파라미터명과 파라미터값을 설정
	                //--------------------------------------------
	                , data : "wh_no="+wh_no
	                //-----------------------------------------------------------
	                // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
	                // 매개변수 upDelCnt 에는 수정/삭제 적용행의 개수가 들어온다
	                //-----------------------------------------------------------
	                ,success : function(whConfirmCnt){
		                	if(whConfirmCnt == 1){
			                      alert("입고가 확인되었습니다");
			                      goWhSearch();
			                      
			                }
//		                	else if(upDelCnt==-1){
//		                		alert("게시물이 삭제되어 수정할 수 없습니다.");	
//		                	}
//		                	else if(upDelCnt==-2){
//		                		alert("비밀번호가 잘못 입력되었습니다.");	
//		                	} 
			                else{
			                      alert("서버쪽 DB 연동 실패");
			                }
	                } 
	                //---------------------------------------------------
	                // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
	                //---------------------------------------------------
	                , error : function(){
	                   alert("서버 접속 실패");
	                }
	             });
		}


		function goReset(){
				document.warehousingSearchForm.reset();
		}

	</script>

</head>
<body><center>
	<h1>[입고 현황]</h1><br>
	
	<form name="warehousingSearchForm" method="post" action="/group4erp/goWarehousingList.do">
			<table class="tab2" width="600" border=1 bordercolor="#000000" cellpadding=5 align=center>
				<tr>
					<th bgcolor="gray">지역
					<td style="text-align:left" colspan=3 >
					<c:forEach items="${requestScope.branch}" var="branch" varStatus="loopTagStatus">
						<input type="checkbox" name="wh_loc" value="${loopTagStatus.index+1}">${branch.branch}
         			</c:forEach> 
	         <%--
	         <tr>
	         	<th>출판사
	         	<td align=center>
	         		<c:forEach items="${requestScope.publisher}" var="publisher" varStatus="loopTagStatus">
	         			<input type="checkbox" name="searchPublisher" value="${loopTagStatus.index+1}">${publisher.publisher}
	         		</c:forEach> 
	         --%>

	         	<tr>
					<th bgcolor="gray">일자
					<td style="text-align:left" ><input type="text" id="dateFrom" name="dateFrom" size='25'>
						&nbsp;~&nbsp;<input type="text" id="dateTill" name="dateTill" size='25'>
					<td><a style="cursor:pointer" onclick="goTodaySearch();">[금일 검색]</a>
					<!-- 
					<th>출판사
					<td style="text-align:left">
						<select name="searchPublisher">

							<option value="">--------</option>
							<c:forEach items="${requestScope.publisher}" var="publisher" varStatus="loopTagStatus">
								<option value="${publisher.publisher}">${publisher.publisher}</option>
							</c:forEach>
						</select></td>
					 -->
				</tr>
				<tr>
					<th bgcolor="gray">키워드
					<td style="text-align:left" colspan=3>
						<input type="text" name="wh_keyword" size=72>
					</td>
				</tr>
			</table>
			<br>
			<script>
	        $("#dateFrom").datepicker({ dateFormat: 'yy-mm-dd', onClose: function( selectedDate ) {    
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#dateTill").datepicker( "option", "minDate", selectedDate );
            }       });
	        $("#dateTill").datepicker({ dateFormat: 'yy-mm-dd', onClose: function( selectedDate ) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#dateFrom").datepicker( "option", "maxDate", selectedDate );
            }  });
	    	</script>
      
      <table><tr height=5><td></table>
      
		<input type="button" value="검색" onClick="goWhSearch();">
		<input type="button" value="모두검색" onClick="goWhSearchAll();">
		<input type="button" value="초기화" onClick="goReset();">
    
      <table border=0 width=70%>
			<tr>
				<td width=50%> &nbsp;
				<td class="fontLight" align=right>
					[총 개수] : ${warehousingListCnt}&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="rowCntPerPage">
						<option value="10">10
						<option value="15">15
						<option value="20">20
						<option value="25">25
						<option value="30">30
					</select> 행보기
				</td>
	  </table>
      <input type="hidden" name="selectPageNo">
      <input type="hidden" name="searchToday">
      <input type="hidden" name="sort">
      <%-- <input type="hidden" name="order_inven_no" value="${warehousingList.order_inven_no}"> --%>
      </form>


	<div id="contecnt" style="display:none;">
		<table class="tab" id="contentTable" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<th class="thcolor">주문자</th>  
				<th class="thcolor">발주신청일 </th> 
				<th class="thcolor">발주수량</th> 
				<th class="thcolor">발주금액</th> 
				<th class="thcolor">공급률</th> 
				<th class="thcolor">입고요청일</th> 
			</tr>	
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<th class="thcolor">지사</th> 
				<th class="thcolor">ISBN</th> 
				<th class="thcolor" colspan=2>책이름</th> 
				<th class="thcolor">출판사</th>
				<th class="thcolor">카테고리</th>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td colspan=2></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<!-- <div height=3></div> -->
		<!-- <table><tr height=1 border=0><td></td></tr></table> -->
		<br>
		<button onclick="closeDiv(this);">닫기</button>
	</div>
	
	
	<table><tr height=10><td></td></tr></table>
	
	
	<form name="warehousingList" method="post" action="/group4erp/goWarehousingList.do">
      <table class="tableColor tab" id="thisTable" width="80%" border=1 bordercolor="#000000" cellpadding=5 align=center>
         
         <tr>
            <th width="10%">No</th>
            
	           	<c:choose>
					<c:when test="${param.sort=='wh_no desc'}">
						<th width="20%" style="cursor: pointer"
							onclick="$('[name=sort]').val(''); goWhSearch();">▼입고번호
					</c:when>
					<c:when test="${param.sort=='wh_no asc'}">
						<th width="20%" style="cursor: pointer"
							onclick="$('[name=sort]').val('wh_no desc'); goWhSearch();">▲입고번호
						
					</c:when>
					<c:otherwise>
						<th width="20%" style="cursor: pointer"
							onclick="$('[name=sort]').val('wh_no asc'); goWhSearch();">입고번호
					</c:otherwise>
				</c:choose> 
						
				<c:choose>
						<c:when test="${param.sort=='wh_dt desc'}">
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val(''); goWhSearch();">▼입고일
							
						</c:when>
						<c:when test="${param.sort=='wh_dt asc'}">
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val('wh_dt desc'); goWhSearch();">▲입고일
							
						</c:when>
						<c:otherwise>
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val('wh_dt asc'); goWhSearch();">입고일
							
						</c:otherwise>
				</c:choose> 
				
				<c:choose>
						<c:when test="${param.sort=='order_inven_no desc'}">
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val(''); goWhSearch();">▼주문발주번호
						</c:when>
						<c:when test="${param.sort=='order_inven_no asc'}">
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val('order_inven_no desc'); goWhSearch();">▲주문발주번호
						</c:when>
						<c:otherwise>
							<th width="20%" style="cursor: pointer"
								onclick="$('[name=sort]').val('order_inven_no asc'); goWhSearch();">주문발주번호
						</c:otherwise>
				</c:choose>
            <th width="10%">입고</th>
          </tr>
         
         
           <c:forEach items="${requestScope.warehousingList}" var="warehousing" varStatus="loopTagStatus">
					<tr class="trcolor" style="cursor:pointer">
						<td align=center onClick="goWarehousingContent(this,${warehousing.order_inven_no});">
						${warehousingListCnt-(warehousingDTO.selectPageNo*warehousingDTO.rowCntPerPage-warehousingDTO.rowCntPerPage+1+loopTagStatus.index)+1}
						</td>
						<td align=center onClick="goWarehousingContent(this,${warehousing.order_inven_no});">${warehousing.wh_no}</td>
						<td align=center onClick="goWarehousingContent(this,${warehousing.order_inven_no});">${warehousing.wh_dt}</td>
						
						<td align=center onClick="goWarehousingContent(this,${warehousing.order_inven_no});">${warehousing.order_inven_no}</td>
						<c:if test="${empty warehousing.wh_dt}">
							<td align=center> <input type="button" value="입고" onclick="goWhConfirm(${warehousing.wh_no});"></td>
						</c:if>
						<c:if test="${!empty warehousing.wh_dt}">
							<td align=center onClick="goWarehousingContent(this,${warehousing.order_inven_no});">&nbsp;</td>
						</c:if>
					</tr>
			</c:forEach>
		
      </table>
     <table><tr height=10><td></table>
     	<c:if test="${warehousingListCnt eq 0}">
				<h3>해당 결과가 없습니다.</h3>
		</c:if>
		
	<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
	
	</form>
	
</center>
</body>
</html>