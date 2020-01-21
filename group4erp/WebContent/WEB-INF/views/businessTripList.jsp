<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>출장 신청 리스트</title>
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
		
		setTableTrBgColor(
				"businessTripListTable",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
		);
		
		$("#datepicker3").datepicker({
			dateFormat: 'yy-mm-dd'
		});
		$("#datepicker4").datepicker({
			dateFormat: 'yy-mm-dd'
		});
		
		
		$('[name=rowCntPerPage]').change(function(){
			goSearch();
		});
		
		
		$(".pagingNumber").html(
				getPagingNumber(
				"${businessTripListAllCnt}"						//검색 결과 총 행 개수
				,"${businessTripSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
				,"${businessTripSearchDTO.rowCntPerPage}"			//페이지 당 출력행의 개수
				,"15"										//페이지 당 보여줄 페이지번호 개수
				,"goSearch();"								//페이지 번호 클릭 후 실행할 자스코드
			)
		);

		inputData('[name=rowCntPerPage]',"${businessTripSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${businessTripSearchDTO.selectPageNo}");
		inputData('#selectSearch',"${businessTripSearchDTO.searchKey}");
		inputData('#searchKeyword',"${businessTripSearchDTO.keyword}");
		inputData('#sort',"${businessTripSearchDTO.sort}");
		inputData('#datepicker3',"${businessTripSearchDTO.startTime}");
		inputData('#datepicker4',"${businessTripSearchDTO.endTime}");
		<c:forEach items="${businessTripSearchDTO.payment}" var="payment">
			inputData('[name=payment]',"${payment}");
		</c:forEach> 
		
});

	

	function goSearch(){
		var startDate = $( "[name=outside_start_time]" ).val();
	    var startDateArr = startDate.split('-');
	    var endDate = $( "[name=outside_end_time]" ).val();
	    var endDateArr = endDate.split('-');
	    var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
	    var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
	          
	    if(startDateCompare.getTime() > endDateCompare.getTime()) {
	              
	        alert("시작날짜와 종료날짜를 확인해 주세요.");
			$("[name=outside_start_time]").focus();
	         return;
	    }
		
		var  keyword = $("#searchKeyword").val();
		var  searchKey = $("#selectSearch").val();
		var  outsideTime = $("#datepicker3").val();
		var  comebackTime = $("#datepicker4").val();

		
		$("#searchKey").val(searchKey);
		$("#keyword").val(keyword);
		$("#startTime").val(outsideTime);
		$("#endTime").val(comebackTime);

		document.getBusinessTripListSearchForm.submit();
	}
	
	function goAllSearch(){
		document.getBusinessTripListSearchForm.reset();
		$('[name=getBusinessTripListSearchForm] [name=rowCntPerPage]').val('10');
		$('[name=getBusinessTripListSearchForm] [name=selectPageNo]').val('1');
		$('[name=getBusinessTripListSearchForm] [name=sort]').val('');
		goSearch();
	}
	
	function goReset(){
		document.getBusinessTripListSearchForm.reset();
	}
	
																					
	function goBusinessTripContentsForm(work_outside_seq,emp_no,travel_payment,dep_no,mgr_no,jikup){
			if( 
				(
					("${businessTripDTO.login_emp_id}"== emp_no)
						||
					(
						("${businessTripDTO.login_mgr_no}"==mgr_no)
							&&
						("${businessTripDTO.login_dep_no}"==dep_no)
					)
						||
					("${businessTripDTO.login_dep_no}"==6)
						||
					("${businessTripDTO.login_jikup}"=="대표이사")
				) 
				&& 
				(travel_payment =="W")){
						var str = "work_outside_seq="+work_outside_seq+"&"+emp_no+"&"+$('[name=getBusinessTripListSearchForm]').serialize();
						location.href="/group4erp/businessTripUpDelForm.do?"+str;
					}else{
						var str = "work_outside_seq="+work_outside_seq+"&"+emp_no+"&"+$('[name=getBusinessTripListSearchForm]').serialize();
						location.href="/group4erp/businessTripContentsForm.do?"+str;}
	}

	function goBusinessTripForm() {
		location.href="/group4erp/businessTripForm.do";
	}
	
</script>

</head>
<body>
<center>
	<h1>[출장 리스트]</h1>
	<form name="getBusinessTripListSearchForm" id="getBusinessTripListSearchForm" method="post" action="/group4erp/businessTripList.do">
		
     <table class="tab" >
     	<tr>
     		<th>출장 날짜</th>
     		<td colspan="2">
				출발<input type="text" id="datepicker3" name="outside_start_time" readonly>
				~
				복귀<input type="text" id="datepicker4" name="outside_end_time" readonly>
				&nbsp;&nbsp;&nbsp;
			</td>
     	</tr>
     	<tr>
     		<th>결재 상태</th>
     		<td colspan="2">
     			<input type="checkbox" name='payment' class="payment" value="Y">승인
         		<input type="checkbox" name='payment' class="payment" value="W">대기중
         		<input type="checkbox" name='payment' class="payment" value="N">반려
     		</td>
     	</tr>

      	<tr>
      		<th>검색조건</th>
      		<td >
			<select id = "selectSearch">
					<option>------</option>
					<option value="emp_name">성명</option>
					<option value="dep_name">부서</option>
					<option value="mgr_name">담당자</option>
			</select>
				
					<input type="text" id="searchKeyword">
					
				</span>

			</td>
		</tr>
		</table>
	 	<table><td></td></table>
	 			
				<input type="button" value=" 검색 " onClick="goSearch();">&nbsp;&nbsp;
				<input type="button" value="모두검색" onClick="goAllSearch();">&nbsp;&nbsp;
				<input type="button" value="초기화" onClick="goReset();">
			
	 <table border=0 width=700>
	 	<tr>
	    	<td align=right>
	        [총 개수] : ${businessTripListAllCnt}&nbsp;&nbsp;&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value=10>10</option>
	               <option value=15>15</option>
	               <option value=20>20</option>
	               <option value=25>25</option>
	               <option value=30>30</option>
	            </select> 행보기
      </table>
     
        <input type="hidden" name="searchKey" id="searchKey" >
		<input type="hidden" name="keyword" id="keyword">
		<input type="hidden" name="selectPageNo"> 
        <input type="hidden" name="startTime" id="startTime">
        <input type="hidden" name="endTime" id="endTime">
        <input type="hidden" name="sort" id="sort">
	    <!-- <input type="hidden" name="travel_payment" id="travel_payment"> -->
        <!--  <input type="text" name="payment" id="payment"> -->
        <!-- <input type="hidden" name="work_outside_seq" id="work_outside_seq"> -->
        
	</form>
	
	<div id="blankArea"><br></div>
		<table class="businessTripListTable tab"  name="businessTripListTable" cellpadding="5" cellspacing="5">		
			<thead>
				<tr>
					
					<th>번호</th>
					
			
					<c:choose>
						<c:when test="${param.sort=='3 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼성명</th>
						</c:when>
						<c:when test="${param.sort=='3 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('3 desc'); goSearch();">▲성명</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('3 asc'); goSearch();">성명</th>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${param.sort=='c.jikup_cd desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼직급</th>
						</c:when>
						<c:when test="${param.sort=='c.jikup_cd asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('c.jikup_cd desc'); goSearch();">▲직급</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('c.jikup_cd asc'); goSearch();">직급</th>
						</c:otherwise>
					</c:choose>
					
					

					<c:choose>
						<c:when test="${param.sort=='4 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼부서명</th>
						</c:when>
						<c:when test="${param.sort=='4 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('4 desc'); goSearch();">▲부서명</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('4 asc'); goSearch();">부서명</th>
						</c:otherwise>
					</c:choose>

					
	
					<c:choose>
						<c:when test="${param.sort=='7 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼출발 날짜</th>
						</c:when>
						<c:when test="${param.sort=='7 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('7 desc'); goSearch();">▲출발 날짜</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('7 asc'); goSearch();">출발 날짜</th>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${param.sort=='8 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼복귀 예정 날짜</th>
						</c:when>
						<c:when test="${param.sort=='8 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('8 desc'); goSearch()">▲복귀 예정 날짜</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('8 asc'); goSearch();">복귀 예정 날짜</th>
						</c:otherwise>
					</c:choose>

					
					<c:choose>
						<c:when test="${param.sort=='9 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼담당자</th>
						</c:when>
						<c:when test="${param.sort=='9 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('9 desc'); goSearch()">▲담당자</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('9 asc'); goSearch();">담당자</th>
						</c:otherwise>
					</c:choose>
					
					
					<c:choose>
						<c:when test="${param.sort=='10 desc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('outside_start_time desc'); goSearch();">▼결재</th>
						</c:when>
						<c:when test="${param.sort=='10 asc'}">
							<th style="cursor:pointer" onclick="$('[name=sort]').val('10 desc'); goSearch()">▲결재</th>
						</c:when>
						<c:otherwise>
							<th style="cursor:pointer" onclick="$('[name=sort]').val('10 asc'); goSearch();">결재</th>
						</c:otherwise>
					</c:choose>
					
					
				</tr>
					
			</thead>
			<tbody>
				
			<c:forEach items="${businessTripList}" var="businessList" varStatus="loopTagStatus">
			<tr class="tab" style="cursor:pointer" onClick="goBusinessTripContentsForm(${businessList.work_outside_seq}
																						,${businessList.emp_no}
																						,'${businessList.travel_payment}'
																						,${businessList.dep_no}
																						,${businessList.mgr_no}
																						,'${businessList.jikup}');">
					<td align=center>${businessTripListAllCnt - businessList.RNUM + 1}</td>	
					<td align=center>
						${businessList.emp_name}
					</td>
					<td align=center>${businessList.jikup}</td>
					<td align=center>${businessList.dep_name}</td>
					<td align=center>${businessList.outside_start_time}</td>
					<td align=center>${businessList.outside_end_time}</td>
					<td align=center>
						<c:choose>
							<c:when test="${businessList.mgr_name ne ' '}">
								${businessList.mgr_name}
							</c:when>
							<c:otherwise>
									-
							</c:otherwise>				
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${businessList.travel_payment eq 'Y'}">
								승인
							</c:when>
							<c:when test="${businessList.travel_payment eq 'N'}">
								반려
							</c:when>
							<c:otherwise>
								대기중
							</c:otherwise>				
						</c:choose>
					</td>
			</tr>		
			</c:forEach>
			
			</tbody>
		</table>
		<c:if test="${businessTripListAllCnt eq 0}">
						<h5>해당 결과가 없습니다.</h5>
		</c:if>
		<br>
		<input type="button" value="출장 신청" onClick="goBusinessTripForm();">	
		<br><br>
		
		
		
		<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
		
		

</center>

</body>
</html>