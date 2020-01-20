<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>반품 현황</title>
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
			goSearch();
		})
      
      $(".pagingNumber").html(
               getPagingNumber(
                  "${returnOrderCnt}"                  //검색 결과 총 행 개수
                  ,"${returnSearchDTO.selectPageNo}"         //선택된 현재 페이지 번호
                  ,"${returnSearchDTO.rowCntPerPage}"      //페이지 당 출력행의 개수
                  ,"10"                              //페이지 당 보여줄 페이지번호 개수
                  ,"goSearch();"                  //페이지 번호 클릭 후 실행할 자스코드
               )
            );

      setTableTrBgColor(
         "returnOrderTable",   //테이블 class 값
         "${headerColor}",         //헤더 tr 배경색
         "${oddTrColor}",      //홀수행 배경색
         "${evenTrColor}",   //짝수행 배경색
         "${mouseOverColor}"         //마우스 온 시 배경색
      );

      inputData('[name=rowCntPerPage]',"${returnSearchDTO.rowCntPerPage}");
      inputData('[name=selectPageNo]',"${returnSearchDTO.selectPageNo}");
      inputData('[name=dateFrom]',"${returnSearchDTO.dateFrom}");
      inputData('[name=dateTill]',"${returnSearchDTO.dateTill}");
      inputData('[name=searchKeyword]',"${returnSearchDTO.searchKeyword}");
      inputData('[name=sort]',"${returnSearchDTO.sort}");
      <c:forEach items="${returnSearchDTO.return_cd}" var="cdReturn">
         inputData( "[name=return_cd]", "${cdReturn}" );
      </c:forEach>
      
   });


   function goSearch() {

      var keyword = $("[name=returnSearchForm] [name=searchKeyword]").val();
      keyword = $.trim(keyword);
      $("[name=returnSearchForm] [name=searchKeyword]").val(keyword);
      document.returnSearchForm.submit();
   }

   function goSearchAll() {
      document.returnSearchForm.reset();
      $('[name=returnSearchForm] [name=selectPageNo]').val("1");
      $('[name=returnSearchForm] [name=rowCntPerPage]').val("10");
      $("[name=returnSearchForm] [name=sort]").val('');
      goSearch();
   }
   
   function goReturnInfo(idx, pk_no){
      //alert("반품 사유 상세정보 기능 구현중");
      
      //alert("this="+idx+"pk_no="+pk_no);
      
      var thisTr = $(idx);
      
      var delTr = $('[name=thisTr]');
       if(delTr.size()>0){
            delTr.remove();
       }
      
      var datastr = "pk_no="+pk_no;
      
      $.ajax({

            url : "/group4erp/goReturnOrderContent.do"
            
            , type: "post"
            
            , data : datastr
            
            //, dataType:"JSON"
            
            ,success : function(data){
                  if(data != null){
                         $("#contentTable td:eq(0)").text(data.id);
                         $("#contentTable td:eq(1)").text(data.return_order_dt);
                         $("#contentTable td:eq(2)").text(data.book_name);
                         $("#contentTable td:eq(3) [name=info]").text(data.return_comment);

                  var insert = "<tr name='thisTr' bgcolor='white'><td colspan=4>"+$("#contecnt").html()+"</td></tr>"
                  
                  thisTr.after(insert);
                  
                  
                  
                  }
            }
         , error : function(){
                 alert("서버 접속 실패");
           }
      
      });
   }
      
   function closeDiv(){

      $('[name=thisTr]').remove();
      
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
      
      goSearch();
   }
   
	function goReset(){
		//alert(1)
			document.returnSearchForm.reset();
		//$('[name=bookReleaseSearch]').reset();
	}

</script>
</head>
<body><center>
   <h1>반품 현황</h1>
   
   <form name="returnSearchForm" method="post" action="/group4erp/goReturnOrderList.do">
   <table class="tab" name="tab1" cellpadding="5" cellspacing="5">
      <tr>
         <td>[사유별]</td><td><input type="checkbox" value="01" name="return_cd">파손
                           <input type="checkbox" value="03" name="return_cd">변심
                           <input type="checkbox" value="02" name="return_cd">오배송
                           <input type="checkbox" value="04" name="return_cd">제작사 요청
                           <input type="checkbox" value="05" name="return_cd">기타</td>
      </tr>
      <tr>
         <td>[접수 날짜]
         <td>
            <input type="text" id="datepicker1" name="dateFrom" size=15>&nbsp;~&nbsp;
            <input type="text" id="datepicker2" name="dateTill" size=15>
      </tr>
      <tr>
         <td>[검색어]</td><td><input type="text" name="searchKeyword">&nbsp;&nbsp;
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a style="cursor:pointer" onclick="searchToday();">[금일 검색]</a>
         <input type="hidden" name="searchToday">
         </td>
      </tr>
   </table>
   <br>
   <input type="button" value="검색" onClick="goSearch();">&nbsp;&nbsp;
   <input type="button" value="모두검색" onClick="goSearchAll();">&nbsp;&nbsp;
   <input type="button" value="초기화" onClick="goReset();">
    <table border=0 width=700>
       <tr>
          <td align=right>
           [전체] : ${returnOrderCnt}개&nbsp;&nbsp;&nbsp;&nbsp;
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
   <table>
      <tr height=10>
         <td></td>
      </tr>
   </table>
</form> 
   
   <div id="contecnt" style="display:none;">
      <table class="tab" id="contentTable" width=600 border=1 bordercolor="#000000" cellpadding=5 align=center>
      
         <tr>
            <th>ID</th>
            <td></td>
            <th>반품 접수 날짜</th>
            <td></td>
         </tr>
         <tr>
            <th>책 제목</th>
            <td colspan=3></td>
         </tr>
         <tr>
            <th>세부내용</th>
            <td colspan=3>
               <textarea name="info" cols=60 rows=10 readonly> </textarea>
            </td>
         </tr>
      </table>
      <table><tr height=1><td></td></tr></table>
      <div align=center><button onclick="closeDiv();">닫기</button></div>
   </div>
   

   <table class="returnOrderTable tab" width="700" name="returnOrderTable" cellpadding="5" cellspacing="5" align=center>
      <tr>
          <th disabled>번호</th>
      <c:choose>
         <c:when test="${param.sort=='1 desc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▲ 반품접수번호</th>
         </c:when>
         <c:when test="${param.sort=='1 asc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val('1 desc'); goSearch(); "> ▼ 반품접수번호</th>
         </c:when>         
         <c:otherwise>
            <th style="cursor:pointer" onClick="$('[name=sort]').val('1 asc'); goSearch();  ">반품접수번호</th>
         </c:otherwise>
      </c:choose>
      
      <c:choose>
         <c:when test="${param.sort=='2 desc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▲ 주문번호</th>
         </c:when>
         <c:when test="${param.sort=='2 asc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val('2 desc'); goSearch(); "> ▼ 주문번호</th>
         </c:when>         
         <c:otherwise>
            <th style="cursor:pointer" onClick="$('[name=sort]').val('2 asc'); goSearch();  ">주문번호</th>
         </c:otherwise>
      </c:choose>
      
      <c:choose>
         <c:when test="${param.sort=='3 desc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▲ isbn</th>
         </c:when>
         <c:when test="${param.sort=='3 asc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val('3 desc'); goSearch(); "> ▼ isbn</th>
         </c:when>         
         <c:otherwise>
            <th style="cursor:pointer" onClick="$('[name=sort]').val('3 asc'); goSearch();  ">isbn</th>
         </c:otherwise>
      </c:choose>
      
      <c:choose>
         <c:when test="${param.sort=='4 desc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▲ 반품사유</th>
         </c:when>
         <c:when test="${param.sort=='4 asc'}">
            <th style="cursor:pointer" onClick="$('[name=sort]').val('4 desc'); goSearch(); "> ▼ 반품사유</th>
         </c:when>         
         <c:otherwise>
            <th style="cursor:pointer" onClick="$('[name=sort]').val('4 asc'); goSearch();  ">반품사유</th>
         </c:otherwise>
      </c:choose>

      </tr>
      <c:forEach items='${returnOrderList}' var="reOrder" varStatus="loopTagStatus">
         <tr style="cursor:pointer" onclick="goReturnInfo(this, '${reOrder.return_sales_no}');">
            <td align="center">${returnOrderCnt - reOrder.RNUM + 1}</td>
            <td align="center">${reOrder.return_sales_no}</td>
            <td align="center">${reOrder.order_no}</td>
            <td align="center">${reOrder.isbn13}</td>
            <td align="center">${reOrder.return_cause}</td>
         </tr>
      </c:forEach>
   </table>
   <div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
</center>

</body>
</html>