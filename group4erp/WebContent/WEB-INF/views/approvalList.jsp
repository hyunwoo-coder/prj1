<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재할 서류 목록입니다.</title>
<script>

	$(document).ready(function() {
		
		headerSort("approvalResList", 0);
		headerSort("approvalReqList", 0);

		setTableTrBgColor(
				"approvalResList",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
		);

		setTableTrBgColor(
				"approvalReqList",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
		);

		inputData("[name=sort]", "${approvalSerachDTO.sort}");

		$(document).on('click','#reApproval', function () {

		    var document_no = $(this).attr("value");
		    
		    reApprovalProc(document_no);
		    	
		});


		$(document).on('click','#removeApproval', function () {

		    var document_no = $('[name=approvalReqList] [name=test]').find('[name=document_no]').val();
		    
		    deleteApproval(document_no);
		    	
		});

	});


	function viewAppResDoc(document_no) {
		//alert("결재 문서 보기 구현 예정");
		//alert(document_no);
		$("[name=document_no]").val(document_no);

		document.approvalResListForm.submit();
		
	}



	function updateApprovalInfo(idx, e_works_no, document_no, approval_state, e_work_comment) {
		
		var thisTr = $(idx);
		var delTr = $('.approvalReqList [name=test]');

		if(delTr.size()>0){
			delTr.remove();
		}

		var htmlCode = "<tr name='test' align=center> <td colspan=7>"
			//htmlCode += "<form name='updateEventForm'>"
			htmlCode += "<table class='innertable tab' name='innertable' align='center'>"

			if(approval_state=='대기중') {
				 htmlCode += "<tr> <th colspan='2' align='center'>아직 회신이 없습니다. </tr>"
			} else {
				htmlCode += "<tr> <th colspan='2' align='center'>결재받은 내용입니다. </tr>"
			}
			
			htmlCode += "<tr> <th>문서 번호</th> <td><label>'"+document_no+"'</label></td></tr>"
		    htmlCode += "<tr> <th>결과</th> <td><label>'"+approval_state+"'</label></td></tr>"

			if(approval_state=='부서장 승인' || approval_state=='최종 승인') {
				htmlCode += "<tr> <th>메시지</th> <td><label>"+e_work_comment+"</label></td></tr>"
			} else {
				htmlCode += "<tr> <th>메시지</th> <td><label>"+e_work_comment+"</label></td></tr>"
			}
		   	
		    htmlCode += "</table>"
		    htmlCode += "<input type='hidden' name='e_work_no' value="+e_works_no+">"
		    htmlCode += "<input type='hidden' name='document_no' value="+document_no+">"

		    if(approval_state == '반려' || approval_state == '대기중') {

				htmlCode += "<button id ='reApproval' name='reApproval' value='"+document_no+"'>다시 결재요청하기</button>&nbsp;"
				htmlCode += "<button id = 'removeApproval' name='removeApproval' value='"+document_no+"'>삭제</button>&nbsp;"

			} 
			//htmlCode += "<input type='button' value='닫기' name='closeTr' onClick='closeThisTr(this);'>&nbsp;"
			htmlCode += "<button id='closeTr' name='closeTr' onClick='closeThisTr(this);'>닫기"
		    //htmlCode += "</form>"
			htmlCode += "</tr>"
  
		   
	    thisTr.after(htmlCode);
	    
	}

	function closeThisTr(idx) {
		
		$(idx).parent().parent().remove();

	}

	function reApprovalProc(document_no) {
		//alert("다시 결재 요청합니다. "+document_no);
		if(document_no.indexOf('EV') >= 0) {
			//alert("이벤트 행사 재결재");
			location.replace("/group4erp/eventScheduling.do?evnt_no="+document_no);

		} else if(document_no.indexOf('DO') >= 0) {
			location.replace("/group4erp/goEmpDayOffjoin.do");

		} else if(document_no.indexOf('BT') >= 0) {
			location.replace("/group4erp/businessTripForm.do");
		}

	}


	function deleteApproval(document_no) {
		//alert("삭제 로직 시작=="+document_no);

		if(document_no.indexOf("EV") >= 0) {

			//alert("이벤트 행사 결재 삭제");

			$.ajax({
				url : "/group4erp/deleteEventApprovalProc.do?document_no="+document_no,				//호출할 서버쪽 URL 주소 설정
				type : "post",										//전송 방법 설정
				//data : document_no, //$('[name=approvalReqList] [name=test]').find('[name=document_no]').val(),		//서버로 보낼 파라미터명과 파라미터값을 설정
				
				success : function(delCnt) {
					if(delCnt==1) {
						alert("이벤트 결재 삭제 성공!");
						
						location.replace("/group4erp/viewApprovalList.do");
					} else if(delCnt==0) {
						alert("이벤트 결재 삭제 실패");

					} else if(delCnt==-1) {	
						//alert("업체가 이미 삭제되었습니다!");
						
						location.replace("/group4erp/viewApprovalList.do");

					} else {
						alert("서버쪽 DB 연동 실패!");
					}
				}

				//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
					alert("서버 접속 실패!");
				}	
			});
			
		} else if(document_no.indexOf("DO") >= 0) {
			alert("휴가 신청 삭제");

			$.ajax({
				url : "/group4erp/deleteDayOffApprovalProc.do?document_no="+document_no,				//호출할 서버쪽 URL 주소 설정
				type : "post",										//전송 방법 설정
				//data : document_no, //$('[name=approvalReqList] [name=test]').find('[name=document_no]').val(),		//서버로 보낼 파라미터명과 파라미터값을 설정
				
				success : function(delCnt) {
					if(delCnt==1) {
						alert("휴가 신청 & 결재 삭제 성공!");
						
						location.replace("/group4erp/viewApprovalList.do");
					} else if(delCnt==0) {
						alert("휴가 신청 & 결재 삭제 실패");

					} else if(delCnt==-1) {	
						//alert("업체가 이미 삭제되었습니다!");
						
						location.replace("/group4erp/viewApprovalList.do");

					} else {
						alert("서버쪽 DB 연동 실패!");
					}
				}

				//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
					alert("서버 접속 실패!");
				}	
			});
			

		} else if(document_no.indexOf("BT") >= 0) {
			alert("출장 신청 삭제");

			$.ajax({
				url : "/group4erp/deleteBTripApprovalProc.do?document_no="+document_no,				//호출할 서버쪽 URL 주소 설정
				type : "post",										//전송 방법 설정
				//data : document_no, //$('[name=approvalReqList] [name=test]').find('[name=document_no]').val(),		//서버로 보낼 파라미터명과 파라미터값을 설정
				
				success : function(delCnt) {
					if(delCnt==1) {
						alert("출장 신청 & 결재 삭제 성공!");
						
						location.replace("/group4erp/viewApprovalList.do");
					} else if(delCnt==0) {
						alert("출장 신청 & 결재 삭제 실패");

					} else if(delCnt==-1) {	
						//alert("업체가 이미 삭제되었습니다!");
						
						location.replace("/group4erp/viewApprovalList.do");

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

		/* */
		
	}

	function goSearch() {

		document.approvalReqForm.submit();

	}

	function goResSearch() {

		document.approvalResForm.submit();

	}
		
</script>
</head>
<body>
	<center>
		<h3>결재할 서류 목록 [ ${approvalResCnt} ]</h3><br>
		<form name="approvalResListForm" method="post" action="/group4erp/viewApprovalDoc.do" >
		<input type="hidden" name="sort" >
			<table class="approvalResList tab" name="approvalResList" cellpadding="5" cellspacing="5">
			<tr>
				<c:choose>
					<c:when test="${param.sort=='6 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goResSearch();  "> ▼ 직급</th>
					</c:when>
					<c:when test="${param.sort=='6 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('6 desc'); goResSearch(); "> ▲ 직급</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('6 asc'); goResSearch();  ">직급</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='7 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goResSearch();  "> ▼ 사원 성명</th>
					</c:when>
					<c:when test="${param.sort=='7 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('7 desc'); goResSearch(); "> ▲ 사원 성명</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goResSearch();  ">사원 성명</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='3 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goResSearch();  "> ▼ 문서일련번호</th>
					</c:when>
					<c:when test="${param.sort=='3 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 desc'); goResSearch(); "> ▲ 문서일련번호</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('3 asc'); goResSearch();  ">문서일련번호</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='8 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goResSearch();  "> ▼ 결재요청시간</th>
					</c:when>
					<c:when test="${param.sort=='8 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('8 desc'); goResSearch(); "> ▲ 결재요청시간</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('8 asc'); goResSearch();  ">결재요청시간</th>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.sort=='9 desc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goResSearch();  "> ▼ 상태</th>
					</c:when>
					<c:when test="${param.sort=='9 asc'}">
						<th style="cursor:pointer" onClick="$('[name=sort]').val('9 desc'); goResSearch(); "> ▲ 상태</th>
					</c:when>			
					<c:otherwise>
						<th style="cursor:pointer" onClick="$('[name=sort]').val('9 asc'); goResSearch();  ">상태</th>
					</c:otherwise>
				</c:choose>
				
				
			</tr>
			<c:forEach items='${approvalResList}' var="approvalResList" varStatus="loopTagStatus">
				<tr style="cursor:pointer" onClick="viewAppResDoc('${approvalResList.document_no}');" align="center">
					<%--<td>${approvalResList.approval_num}</td> --%>
					<td>${approvalResList.jikup}</td>
					<td>${approvalResList.emp_name}</td>
					<td>${approvalResList.document_no}</td>
					<td>${approvalResList.e_works_req_dt}</td>
					<td>${approvalResList.approval_state}</td>
				</tr>	
			</c:forEach>
		
			</table>
			<input type="hidden" name="document_no" value="${document_no}">
		</form>
		
		<c:if test="${approvalResList.size()==0}">
			<h5>결재할 사항이 없습니다.</h5>
		</c:if>
		
		<br><br><br>
		
		<span id="approvalReq"><h3>결재 요청한 서류 목록 [ ${approvalCnt} ]</h3></span>
		
		<!-- 결재를 요청한 내역을 보여주는 테이블 -->
		<form name="approvalReqForm" method="post" action="/group4erp/viewApprovalList.do">		
			<input type="hidden" name="sort" >
		
			<table class="approvalReqList tab" name="approvalReqList" cellpadding="5" cellspacing="5">
				<tr>
					<th>순서</th>
					
					<c:choose>
						<c:when test="${param.sort=='2 desc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 문서 일련번호</th>
						</c:when>
						<c:when test="${param.sort=='2 asc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val('2 desc'); goSearch(); "> ▲ 문서 일련번호</th>
						</c:when>			
						<c:otherwise>
							<th style="cursor:pointer" onClick="$('[name=sort]').val('2 asc'); goSearch();  ">문서 일련번호</th>
						</c:otherwise>
					</c:choose>
				
					<c:choose>
						<c:when test="${param.sort=='7 desc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 결재요청시간</th>
						</c:when>
						<c:when test="${param.sort=='7 asc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val('7 desc'); goSearch(); "> ▲ 결재요청시간</th>
						</c:when>			
						<c:otherwise>
							<th style="cursor:pointer" onClick="$('[name=sort]').val('7 asc'); goSearch();  ">결재요청시간</th>
						</c:otherwise>
					</c:choose>
				
					<c:choose>
						<c:when test="${param.sort=='8 desc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▼ 상태</th>
						</c:when>
						<c:when test="${param.sort=='8 asc'}">
							<th style="cursor:pointer" onClick="$('[name=sort]').val('8 desc'); goSearch(); "> ▲ 상태</th>
						</c:when>			
						<c:otherwise>
							<th style="cursor:pointer" onClick="$('[name=sort]').val('8 asc'); goSearch();  ">상태</th>
						</c:otherwise>
					</c:choose>
					
					<th>비고</th>
					
				</tr>
				<c:forEach items='${approvalReqList}' var="approvalReqList" varStatus="loopTagStatus">			
					<c:choose>
						<c:when test="${approvalReqList.approval_state eq '심사중'}">
							<tr> </tr>
						</c:when>	
						<c:otherwise>
							<tr style="cursor:pointer" onClick="updateApprovalInfo(this, '${approvalReqList.e_works_no}', '${approvalReqList.document_no}', '${approvalReqList.approval_state}', '${approvalReqList.e_work_comment}');">
						</c:otherwise>
					</c:choose>
						<td align="center">${approvalCnt - (loopTagStatus.index)}</td>
					
						<td>${approvalReqList.document_no}<input type="hidden" name="document_no" value="${approvalReqList.document_no}"></td>
						<td>${approvalReqList.e_works_req_dt}</td> 
						<td align="center">${approvalReqList.approval_state}</td> 
						<td>
							<c:if test="${approvalReqList.approval_state eq '대기중' || approvalReqList.approval_state eq '반려'}">
								삭제 가능
							</c:if>					
						</td> 
					</tr>	
				</c:forEach>		
			</table>
		
			<c:if test="${approvalReqList.size()==0}">
				<h5>결재를 요청한 내역이 없습니다.</h5>
			</c:if>
		</form>
			<h5>'대기중'인 결재 문서는 수정 & 삭제가 가능합니다.<br>
			'심사중'인 결재 문건은 수정과 삭제가 불가하며, 부득이하게 취소하고자 할 경우에는 담당 부서장과 상의하시기 바랍니다.</h5>
		</center>
	
</body>
</html>