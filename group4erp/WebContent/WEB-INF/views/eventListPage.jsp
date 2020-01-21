<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/common.jsp" %>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 행사 신청</title>

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

		$("#evnt_start_dt").datepicker({
	   	 	onSelect: function() { 
	   	 		//var date = $('#datepicker').datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
	   	    	 var dateObject = $(this).datepicker('getDate');
	   	    	 //alert(dateObject.val()); 
	   		}
		});

		$("#evnt_end_dt").datepicker({
	    	onSelect: function() { 
	    			//var date = $('#datepicker').datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
	       		var dateObject = $(this).datepicker('getDate');
	       	 	//alert(dateObject.val()); 
	   		}
		});
		
	
		headerSort("eventListTable", 0);
		$(".updateArea").hide();
		
		setTableTrBgColor(
				"eventListTable",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
		);
		

		$('[name=rowCntPerPage]').change(function(){
			goSearch();
			//document.eventSearchRowForm.submit();
		});
	
		$(".pagingNumber").html(
			getPagingNumber(
				"${eventAllCnt}"						//검색 결과 총 이벤트 개수
				,"${eventSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
				,"${eventSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
				,"10"										//페이지 당 보여줄 페이지번호 개수
				,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
			)
		);

		inputData('[name=rowCntPerPage]',"${eventSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${eventSearchDTO.selectPageNo}");
		inputData("[name=searchKeyword]", "${eventSearchDTO.searchKeyword}");
		inputData("[name=sort]", "${eventSearchDTO.sort}");	

		<c:forEach items="${eventSearchDTO.evnt_category}" var="evnt_category">
			inputData("[name=evnt_category]", "${evnt_category}");
		</c:forEach>
		<c:forEach items="${eventSearchDTO.evnt_stat}" var="evnt_stat">
			inputData("[name=evnt_stat]", "${evnt_stat}");
		</c:forEach>
		
	});

	function reserveEvent() {
		//alert("이벤트 신청 페이지");
		location.replace("/group4erp/eventScheduling.do");
	}

	function goSearch() {
		
		document.searchEvntForm.submit();
	}

	function goSearchAll() {
		document.searchEvntForm.reset();

		$('[name=searchEvntForm] [name=sort]').val("1");
		$('[name=searchEvntForm] [name=selectPageNo]').val("1");
		$('[name=searchEvntForm] [name=rowCntPerPage]').val("15");
		//$("[name=searchEvntForm] [name=sort]").val('');
		
		goSearch();
	}

	function goReset(){
		document.searchEvntForm.reset();
	}

	function updateEventInfo(idx, evnt_no, evnt_title, evnt_start_dt, evnt_end_dt, evnt_comment) {
		
		var thisTr = $(idx).parent().parent();
		var delTr = $('.eventListTable [name=test]');

		if(delTr.size()>0){
			delTr.remove();
		}

		evnt_start_dt = evnt_start_dt.substr(0, 10);
		evnt_end_dt = evnt_end_dt.substr(0, 10);

	      //alert(evnt_start_dt +" / "+evnt_end_dt);
	      //$('.mycarebookTable tbody tr:eq('+idx+')').append(" <tr> <td>");
	      //$('.mycarebookTable tbody tr:eq('+idx+')').after(" <tr align=center> <td colspan=7> </td> </tr>");
	      
	      //var str = $('.qqq').html();
	          
	      //var thisTr = $(idx).parent().parent();
	      
	      
	      var htmlCode = "<tr name='test' align=center> <td colspan=7>"
	      htmlCode += "<form name='updateEventForm'>"
	      htmlCode += "<table class='innertable tab' align=center>"
	      htmlCode += "<tr> <th>이벤트 종류 <td><select name='evnt_cd'>"
		  htmlCode += 									"<option value='1'>매대판매행사</option>"
		  htmlCode += 									"<option value='2'>야외판매</option>"
		  htmlCode += 									"<option value='3'>할인전</option>"
		  htmlCode += 									"<option value='4'>기부행사</option>"
		  htmlCode += 									"<option value='5'>온라인 설문조사</option>"
		  htmlCode += 						"</select> </td></tr>"
	      htmlCode += "<tr> <th>이벤트 타이틀</th> <td><input type='text' name='evnt_title' value='"+evnt_title+"'></td></tr>"
	      htmlCode += "<tr> <th>시작일</th> <td><input type='text' name='evnt_start_dt' value='"+evnt_start_dt+"'></td></tr>"
	   	  htmlCode += "<tr> <th>종료일</th> <td><input type='text' name='evnt_end_dt' value='"+evnt_end_dt+"'></td></tr>"
	   	  htmlCode += "<tr> <th>메시지</th> <td><textarea name='evnt_comment' value='"+evnt_comment+"'>"+evnt_comment+"</textarea></td></tr>"
	      htmlCode += "</table>"
	      htmlCode += "<input type='hidden' name='evnt_no' value="+evnt_no+">"
	      htmlCode += "<input type='button' value='저장' name='updateEvent' onClick='updateEventProc();'>&nbsp;"
		  htmlCode += "<input type='button' value='닫기' name='closeTr' onClick='closeThisTr(this);'>&nbsp;"
	      htmlCode += "</form>"
		  htmlCode += "</tr>"
		  htmlCode += "<script>"
		  htmlCode += "$('[name=evnt_start_dt]').datepicker({ dateFormat: 'yy-mm-dd' });"
		  htmlCode += "$('[name=evnt_end_dt]').datepicker({ dateFormat: 'yy-mm-dd' });"
		  htmlCode += "</script"+">"
		   
	      thisTr.after(htmlCode);
	    
	}

	function closeThisTr(idx) {
		
		$(idx).parent().parent().remove();

	}


	function updateEventProc() {

		$.ajax({
			url : "/group4erp/updateEventProc.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			data : $('[name=updateEventForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정
			
			success : function(upCnt) {
				if(upCnt >= 1) {
					alert("수정 성공!");
					
					location.replace("/group4erp/viewEventList.do");
				} else if(upCnt==-1) {	
					alert("이벤트가 이미 삭제되었습니다!");
					
					location.replace("/group4erp/viewEventList.do");

				} else {
					alert("서버쪽 DB 연동 실패!");
				}
			}

			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
				alert("서버 접속 실패!");
			}	
		});
		
	}
	

	function deleteNotYetEvent() {
		
		var evnt_no = [];
		var cnt=0;

		$("[name=delCheckBox]").each(function() {
		
			var thisObj = $(this);

			if(thisObj.is(":checked")) {
				
				evnt_no.push(thisObj.val());
			}
		});
					
		if(evnt_no.length==0) {
			alert("선택된 이벤트가 없습니다.");

			return;
		}

		$("[name=evnt_no]").val(evnt_no);

		//alert($('[name=deleteCorpForm]').serialize());
		$.ajax({
			url : "/group4erp/deleteEvntProc.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			data : $('[name=deleteEvntForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정
			
			success : function(delCnt) {
				if(delCnt>=1) {
					alert("삭제 성공!");
					
					location.replace("/group4erp/viewEventList.do");
				} else if(delCnt==-1) {	
					alert("이벤트가 이미 삭제되었습니다!");
					
					location.replace("/group4erp/viewEventList.do");

				} else {
					alert("서버쪽 DB 연동 실패!");
				}
			}

			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
				alert("서버 접속 실패!");
			}	
		});
	}

	</script>
</head>
<body><center>

	<h1>[이벤트 현황]</h1>
    
	<form name="searchEvntForm" method="post" action="/group4erp/viewEventList.do">
		<table class="tab" cellpadding="5" cellspacing="5">
			<!-- <tr>
				<td>[행사별] </td><td><input type="checkbox" name="allOrMine" value='a'>전체보기 &nbsp;
									<input type="checkbox" name="allOrMine" value='m'>담당 행사만 보기</td>
			</tr> -->
			<tr> <!-- DB 연동할 것 -->
				<td valign="top">[종류별]</td><td><input type="checkbox" value="01" name="evnt_category">매대판매
								<input type="checkbox" value="02" name="evnt_category">야외판매
								<input type="checkbox" value="03" name="evnt_category">할인전
								<input type="checkbox" value="04" name="evnt_category">기부행사<br>
								<input type="checkbox" value="05" name="evnt_category">온라인 설문조사
								<input type="checkbox" value="06" name="evnt_category">저자강연회
								<input type="checkbox" value="07" name="evnt_category">선착순증정
				</td>
			</tr>
			<tr>
				<td>[상태별]</td><td><input type="checkbox" value="01" name="evnt_stat">대기중
									<input type="checkbox" value="03" name="evnt_stat">심사중
									<input type="checkbox" value="02" name="evnt_stat">진행중
									<input type="checkbox" value="04" name="evnt_stat">종료
				</td>
			</tr>
			<tr>
				<td>[검색어]</td><td><input type="text" name="searchKeyword">&nbsp;&nbsp;<input type="button" value="검색" onClick="goSearch();">&nbsp;&nbsp;
									<input type="button" value="모두검색" onClick="goSearchAll();">
									<input type="button" value="초기화" onClick="goReset();">
							</td>
			</tr>
		</table>

		<input type="button" value="이벤트 신청" onClick="reserveEvent();">&nbsp;
		<input type="button" value="삭제" onClick="deleteNotYetEvent();"><br><br>
	
		<div id="comment" style="color:red;">
					<h5>* 대기중인 이벤트 행사만 삭제할 수 있습니다.<br>
					 * 이벤트 행사는 최소 1달 전에 신청하셔야 합니다.</h5>		
		</div>
		
		<input type="hidden" name="selectPageNo">
		<input type="hidden" name="sort">
		
	<table border="0" cellpadding="5" cellspacing="5">
		<tr>
			<td align="right">[전체 행사 횟수] : ${eventAllCnt}회 &nbsp;<%--${emp_name} ${jikup} 님 담당 행사 : ${eventCnt}회 --%></td>
			<td align="right"  valign="center" width="100">
				
					<select name="rowCntPerPage">
	              		<option value="10">10</option>
	               		<option value="15">15</option>
	               		<option value="20">20</option>
	               		<option value="25">25</option>
	               		<option value="30">30</option>
	            	</select> 행보기
	
	        </td>
		</tr>
	</form>
		<tr>
			<td colspan="2" align="center">
			<form name="eventScheduleForm" method="post" action="/group4erp/reserveEvent.do">
			<table class="eventListTable tab" name="eventListTable" cellpadding="5" cellspacing="5">
				<tr>
				<th></th>
				<th>번호</th>
				<c:choose>
					<c:when test="${param.sort=='1 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 이벤트 번호</th>
					</c:when>
					<c:when test="${param.sort=='1 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('1 desc'); goSearch(); "> ▲ 이벤트 번호</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('1 asc'); goSearch();  ">이벤트 번호</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='3 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 이벤트 종류</th>
					</c:when>
					<c:when test="${param.sort=='3 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 desc'); goSearch(); "> ▲ 이벤트 종류</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 asc'); goSearch();  ">이벤트 종류</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='4 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 타이틀</th>
					</c:when>
					<c:when test="${param.sort=='4 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('4 desc'); goSearch(); "> ▲ 타이틀</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('4 asc'); goSearch();  ">타이틀</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='7 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 시작일</th>
					</c:when>
					<c:when test="${param.sort=='7 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('7 desc'); goSearch(); "> ▲ 시작일</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goSearch();  ">시작일</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='8 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 종료일</th>
					</c:when>
					<c:when test="${param.sort=='8 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('8 desc'); goSearch(); "> ▲ 종료일</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('8 asc'); goSearch();  ">종료일</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='9 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 상태</th>
					</c:when>
					<c:when test="${param.sort=='9 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('9 desc'); goSearch(); "> ▲ 상태</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('9 asc'); goSearch();  ">상태</th>
					</c:otherwise>
				</c:choose>
				<th>성명</th>
				<th>비고</th>
			</tr>
			
			<c:forEach items="${eventList}" var="eventList" varStatus="loopTagStatus">
				<tr style="cursor:pointer" onClick="viewEventInfoForm(${empList.emp_no});">		
					<td class="delCheckBox" align=center>
						<c:if test="${eventList.evnt_stat eq '대기중'|| eventList.evnt_stat eq '반려' }">
							<input type="checkbox" name="delCheckBox" value="${eventList.evnt_no}">
						</c:if>
					</td>
					<td align=center>${eventAllCnt -eventList.RNUM+1}</td>
					<td align=center>${eventList.evnt_no}</td>	<!-- <input type="hidden" value="${dep_no}">  -->
					<td align=center>${eventList.evnt_category}</td>
					<td align=center>${eventList.evnt_title}</td>
					<td align=center>${eventList.evnt_start_dt}</td>
					<td align=center>${eventList.evnt_end_dt}</td>
					<td align=center>${eventList.evnt_stat}</td>
					<td align=center>${eventList.emp_name}</td>
					<td><c:if test="${eventList.evnt_stat eq '대기중'|| eventList.evnt_stat eq '반려'}">
							<input type="button" name="updateBtn" value="수정" onClick="updateEventInfo(this,'${eventList.evnt_no}', '${eventList.evnt_title}', '${eventList.evnt_start_dt}', '${eventList.evnt_end_dt}', '${eventList.evnt_comment}');">
						</c:if>
					</td>
				</tr>		
				
				<%-- <tr class="updateArea" style="cursor:pointer" onClick="viewEventInfoForm(${empList.emp_no});">	
					<td class="delCheckBox" align=center>
						<c:if test="${eventList.evnt_stat eq '대기중' }">
							<input type="checkbox" name="delCheckBox" value="${eventList.evnt_no}">
						</c:if>
					</td>
					<td align=center>${eventList.evnt_no}</td>	<!-- <input type="hidden" value="${dep_no}">  -->
					<td align=center>${eventList.evnt_category}</td>
					<td align=center>${eventList.evnt_title}</td>
					<td align=center>${eventList.evnt_start_dt}</td>
					<td align=center>${eventList.evnt_end_dt}</td>
					<td align=center>${eventList.evnt_stat}</td>
				</tr> --%>		 
					</c:forEach>
				</table><br>
					<c:if test="${empty eventList}">
						<h5><center>해당 결과가 없습니다.</center></h5>
					</c:if>
	
			</form>
		</td>
		</tr>
	</table>
	<div>&nbsp; <span class="pagingNumber"> </span>&nbsp;</div><br>
	
	<form name="deleteEvntForm" method="post" action="/group4erp/deleteEvntProc.do">
		<input type="hidden" name="evnt_no">
	</form>
	
</center>
</body>
</html>