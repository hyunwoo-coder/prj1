<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 관리</title>
<script>

	$(document).ready(function(){

		//$(".updateArea").hide();
	
		headerSort("corpListTable", 0);

		setTableTrBgColor(
				"corpListTable",	//테이블 class 값
				"${headerColor}",			//헤더 tr 배경색
				"${oddTrColor}",		//홀수행 배경색
				"${evenTrColor}",	//짝수행 배경색
				"${mouseOverColor}"			//마우스 온 시 배경색
			);


		$("[name=rowCntPerPage]").change(function() {
			goSearch();
			//document.corpSearchRowPageForm.submit();
		});
	
		$(".pagingNumber").html(
				getPagingNumber(
					"${corpListCnt}"						//검색 결과 총 행 개수
					,"${corpSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
					,"${corpSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
					,"10"										//페이지 당 보여줄 페이지번호 개수
					,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
				)
			);

		inputData('[name=rowCntPerPage]',"${corpSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${corpSearchDTO.selectPageNo}");
		inputData('[name=sort]').val("${corpSearchDTO.sort}");
		inputData('[name=searchKeyword]').val("${corpSearchDTO.searchKeyword}");
		<c:forEach items="${corpSearchDTO.corp_business_area}" var="corp_business_area">
			inputData("[name=corpSearchForm] [name=corp_business_area]", "${corpSearchDTO.corp_business_area}");		
		</c:forEach>

		/* <c:forEach items="${corpSearchDTO.corp_business_area}" var="corp_business_area">
			$("[name=corpSearchForm] [name=corp_business_area]").filter("[value = ${corpSearchDTO.corp_business_area} ]").prop("checked", true);
		</c:forEach> */

	});


	function goSearch() {	
		var keyword =$('[name=searchKeyword]').val();
		 alert(keyword)
		$('[name=searchKeyword]').val(keyword);	
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
	function insertCorp() {
		//alert("거래처 추가");
		location.replace("/group4erp/goInsertCorpPage.do");
	}

	var closeFlag = "close";
	
	
	function updateCorpInfo(idx, flag, corp_no, corp_name, ceo_name, business_area, corp_addr, corp_tel, corp_fax) {
		
		if(closeFlag!=flag) {
			$(idx).val("닫기");
			closeFlag = flag;

		} 

		var thisTr = $(idx).parent().parent();
		var delTr = $(".corpListMain .corpListTable [name=updateCorpInfo]");
		
		if(delTr.size() > 0) {
			delTr.remove();
		}		
		
		//$('.corpListTable tr:eq('+idx+')').append(" <tr> <td>");
		      //$('.mycarebookTable tbody tr:eq('+idx+')').after(" <tr align=center> <td colspan=7> </td> </tr>");
		      
		      //var str = $('.qqq').html();
		      
		var htmlCode = "<tr name='updateCorpInfo' align='center'>" 
		htmlCode +=	"<td colspan=7>"
		htmlCode += 	"<form name='updateCorpForm' method='post' action='/group4erp/updateCorpInfoProc.do'>"
		htmlCode += 		"<table class='innertable tab' align='center'>"
		htmlCode += 			"<tr> <td>사업자번호</td> <td><input type='text' name='new_corp_no' value="+corp_no+"> </td> </tr>"
		htmlCode += 			"<tr> <td>상호명 </td> <td><input type='text' name='corp_name' value='"+corp_name+"'> </td> </tr>"
		htmlCode += 			"<tr> <td>사업자명</td> <td><input type='text' name='ceo_name' value='"+ceo_name+"'></td> </tr>"
		htmlCode += 			"<tr> <td>사업분야</td> <td><input type='text' name='corp_business_area' value='"+business_area+"'></td> </tr>"
		htmlCode += 			"<tr> <td>소재지</td> <td><input type='text' name='corp_addr' value='"+corp_addr+"'></td> </tr>"
		htmlCode += 			"<tr> <td>연락처</td> <td><input type='text' name='corp_tel' value='"+corp_tel+"'></td> </tr>"
		htmlCode += 			"<tr> <td>FAX</td> <td><input type='text' name='corp_fax' value='"+corp_fax+"'></td> </tr>"
		htmlCode += 		"</table><br>"
		//htmlCode += 		"<input type='button' value='저장' name='updateCorp' onClick='updateCorpInfoProc("+corp_no+");'>&nbsp;"
		//htmlCode += 		"<input type='button' value='닫기' name='closeTr' onClick='closeThisTr(this);'>&nbsp;"
		htmlCode +=			"<button id= 'button' value='저장' name='updateCorp' onClick='updateCorpInfoProc('"+corp_no+"');'>저장</button> &nbsp;"
		htmlCode += 		"<button id='closeTr' name='closeTr' onClick='closeThisTr(this);'>닫기</button>"
		htmlCode +=         "<input type='hidden' name='corp_no' value="+corp_no+">"
		htmlCode +=  	"</form>"
		htmlCode += "</td>"
		htmlCode += "</tr>"
		      
		thisTr.after(htmlCode);

	}

	function closeThisTr(idx) {
				
		$(idx).parent().parent().remove();
		$("[name=updateCorpBtn]").val("수정");
		
	}
	
	function updateCorpInfoProc(corp_no) {

		$.ajax({
			url : "/group4erp/updateCorpInfoProc.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			data : $('[name=updateCorpForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정			
			success : function(upCnt) {
				if(upCnt==1) {
					alert("수정 성공!");
					location.replace("/group4erp/viewCorpList.do");
					
				} else if(delCnt==-1) {	
					alert("업체가 이미 삭제되었습니다!");
					
					location.replace("/group4erp/viewCorpList.do");

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

	function deleteCorp() {
		//alert("거래처 삭제 기능 구현 예정")
		//체크된 checkbox의 value 값을 Array 객체에 저장하기
		var corp_no = [];
		var cnt=0;

		$("[name=delCheckBox]").each(function() {
		
			var thisObj = $(this);

			if(thisObj.is(":checked")) {
				//alert(thisObj.val());
				corp_no.push(thisObj.val());
			}
		});
					//Array 객체안의 배열변수가 0개면, 즉 체크된 학점이 없으면 함수 중단
		if(corp_no.length==0) {
			alert("선택된 업체가 없습니다.");

			return;
		}

		$("[name=corp_no]").val(corp_no);

		//alert($('[name=deleteCorpForm]').serialize());
		$.ajax({
			url : "/group4erp/deleteCorpProc.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			data : $('[name=deleteCorpForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정
			
			success : function(delCnt) {
				if(delCnt>=1) {
					alert("삭제 성공!");
					
					location.replace("/group4erp/viewCorpList.do");
				} else if(delCnt==-1) {	
					alert("업체가 이미 삭제되었습니다!");
					
					location.replace("/group4erp/viewCorpList.do");

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
	<h1>[거래처 현황]</h1>
	<form name="corpSearchForm" method="post" action="/group4erp/viewCorpList.do">
		<!-- 검색 테스트중 -->
			
     	<input type="hidden" name="selectPageNo">
     	<input type="hidden" name="sort">
		
		<table border="0" cellpadding="5" cellspacing="5">
			<tr valign="top">
				<td align="right">[사업분야별]&nbsp;</td><td>
				
					<input type="checkbox" name="corp_business_area" value="IT">IT &nbsp;
					<input type="checkbox" name="corp_business_area" value="통신">통신 &nbsp;
					<input type="checkbox" name="corp_business_area" value="금융">금융 &nbsp;
					<input type="checkbox" name="corp_business_area" value="출판&미디어">출판&미디어&nbsp;
					<input type="checkbox" name="corp_business_area" value="교육&학원">교육&학원 &nbsp;<br>
					<input type="checkbox" name="corp_business_area" value="운송&물류">운송&물류 &nbsp;
					<input type="checkbox" name="corp_business_area" value="학교">학교 &nbsp;
					<input type="checkbox" name="corp_business_area" value="기타">기타 &nbsp;		
				<%--<c:forEach items="${corp_business_area}" var="corp_business_area" varStatus="loopTagStatus">
					<c:if test="${corp_business_area.bus_area_code eq '6'}">
						<br>
					</c:if>
					<input type="checkbox" name="corp_business_area" value="${corp_business_area.bus_area_code}">${corp_business_area.bus_area_name} &nbsp;
																								
				</c:forEach> --%>
				</td>
			</tr>
			<tr>
			<td align="right">[검색어]&nbsp;</td><td><input type="text" name="searchKeyword">&nbsp;&nbsp; <input type="button" value="검색" onClick="goSearch();">
														&nbsp;&nbsp;<input type="button" value="모두검색" onClick="goSearchAll();">
														&nbsp;&nbsp;<input type="button" value="초기화" onClick="goReset();">
														 </td>
		</tr>
	</table>

</form> 

<table class="corpListMain" border="0" cellpadding="5" cellspacing="5">
	<tr>
		<td align="center"><div>&nbsp; <span class="pagingNumber"></span>&nbsp;</div>
	
	</tr>
	<tr>
	<form name="corpSearchRowPageForm" method="post" action="/group4erp/viewCorpList.do">
		<td align="right">[전체] : ${corpListCnt}개&nbsp;&nbsp;&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value="10">10</option>
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	               <option value="30">30</option>
	            </select> 행보기 </td>
	</form>
	</tr>
	<tr>
		<td> 
			<table class="corpListTable tab" name="corpListTable" cellpadding="5" cellspacing="5">
	<tr>
		<th></th>
		<th>번호</th>
		<c:choose>
			<c:when test="${param.sort=='corp_no desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch();  "> ▲ 사업자번호</th>
			</c:when>
			<c:when test="${param.sort=='corp_no asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_no desc'); goSearch(); "> ▼ 사업자번호</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_no asc'); goSearch();  ">사업자번호</th>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='corp_name desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ 거래처명</th>
			</c:when>
			<c:when test="${param.sort=='corp_name asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_name desc'); goSearch(); "> ▼ 거래처명</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_name asc'); goSearch(); ">거래처명</th>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='ceo_name desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ 사업자명</th>
			</c:when>
			<c:when test="${param.sort=='ceo_name asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('ceo_name desc'); goSearch(); "> ▼ 사업자명</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('ceo_name asc'); goSearch(); ">사업자명</th>
			</c:otherwise>
		
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='corp_business_area desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ 사업분야</th>
			</c:when>
			<c:when test="${param.sort=='corp_business_area asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_business_area desc'); goSearch(); "> ▼ 사업분야</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_business_area asc'); goSearch(); ">사업분야</th>
			</c:otherwise>
		
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='corp_addr desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ 소재지</th>
			</c:when>
			<c:when test="${param.sort=='corp_addr asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_addr desc'); goSearch(); "> ▼ 소재지</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_addr asc'); goSearch(); ">소재지</th>
			</c:otherwise>
		
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='corp_tel desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ 연락처</th>
			</c:when>
			<c:when test="${param.sort=='corp_tel asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_tel desc'); goSearch(); "> ▼ 연락처</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_tel asc'); goSearch(); ">연락처</th>
			</c:otherwise>
		
		</c:choose>
		
		<c:choose>
			<c:when test="${param.sort=='corp_fax desc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val(''); goSearch(); "> ▲ FAX</th>
			</c:when>
			<c:when test="${param.sort=='corp_fax asc'}">
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_fax desc'); goSearch(); "> ▼ FAX</th>
			</c:when>			
			<c:otherwise>
				<th style="cursor:pointer" onClick="$('[name=sort]').val('corp_fax asc'); goSearch(); ">FAX</th>
			</c:otherwise>
		
		</c:choose>
		<th>비고</th>
	</tr>
	<c:forEach items='${corpList}' var="corpList" varStatus="loopTagStatus">
				<tr style="cursor:pointer" onClick="viewCorpInfo(${empSal.emp_no});">
					<td class="delCheckBox"><input type="checkbox" name="delCheckBox" value="${corpList.corp_no}"></td>
					<td>${corpListCnt-corpList.RNUM+1}</td>
					<td>${corpList.corp_no}</td>
					<td>${corpList.corp_name}</td>
					<td>${corpList.ceo_name}</td>
					<td>${corpList.corp_business_area}</td> 
					<td>${corpList.corp_addr}</td> 
					<td>${corpList.corp_tel} </td> 
					<td>${corpList.corp_fax} </td> 
					<td><input type="button" name="updateCorpBtn" value="수정" onClick="updateCorpInfo(this, 'update', '${corpList.corp_no}', '${corpList.corp_name}', '${corpList.ceo_name}', '${corpList.corp_business_area}', '${corpList.corp_addr}', '${corpList.corp_tel}', '${corpList.corp_fax}');"> </td> 
				</tr>
				
			</c:forEach>
		</table>
		
		</td>
	</tr>

</table>
<c:if test="${corpListCnt==0}">
	<h4>해당 결과가 없습니다.</h4>
</c:if>


<br>
<input type="button" value="거래처 추가" onClick="insertCorp();">
<input type="button" value="거래처 삭제" onClick="deleteCorp();">

<form name="deleteCorpForm" method="post" action="/group4erp/deleteCorpProc.do">
	<input type="hidden" name="corp_no">
</form>

</center>


</body>
</html>