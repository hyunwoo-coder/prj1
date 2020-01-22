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
<title>YES4조 전사적자원관리 시스템 </title>
<style>
	.line{
			border-collapse: collapse;
			padding:5px;
			border-top:0px;
			border-bottom:5px solid black;
			border-left:0px;
			border-right:0px;
			font-size:11pt;
			font-family: 'Noto Sans KR', sans-serif;
		}
	
	.fileBox .fileName {display:inline-block;width:190px;height:20px;padding-left:10px;margin-right:5px;line-height:30px;border:1px solid #aaa;background-color:#fff;vertical-align:middle}
	.fileBox .btn_file {display:inline-block;border:1px solid #000;width:100px;height:20px;font-size:0.8em;line-height:20px;text-align:center;vertical-align:middle; background-color:black; color:white;}
	.fileBox input[type="file"] {position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);}
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

var basePrice = null;
var basePages = null;
var baseCnt = null;

$(document).ready(function(){
	
	$("#published_dt").datepicker({
		dateFormat: 'yy-mm-dd'
	    ,onSelect: function() { 
	    	//var date = $('#datepicker').datepicker({ dateFormat: 'yyyy-mm-dd' }).val();
	        var dateObject = $(this).datepicker('getDate');

	    }
	});
	
	var basePrice = $('[name=book_price]').val();
	var basePages = $('[name=book_pages]').val();
	var baseCnt = $('[name=isbn_cnt]').val();
	
	inputData("[name=size_name]", "${bookInfo.size_name}");
	inputData("[name=branch_name]", "${bookInfo.branch_name}");
	
});
	function goBack(){
		history.go(-1);
	}
	
	function bookInfoUp(){
		alert( $('[name=bookContentUp]').serialize() );
		//return;
	
		if( is_empty('[name=book_name]') ){
			alert("책 제목을 입력해주세요.");
			$("[name=book_name]").focus();
			return;
		}
		if( is_empty('[name=cat_name]') ){
			alert("카테고리를 입력해주세요.");
			$("[name=cat_name]").focus();
			return;
		}
		if( is_empty('[name=book_price]') ){
			alert("책 가격을 입력해주세요.");
			$("[name=book_price]").focus();
			return;
		}
		if( is_empty('[name=book_pages]') ){
			alert("페이지 수를 입력해주세요.");
			$("[name=book_pages]").focus();
			return;
		}
		if( is_empty('[name=writer]') ){
			alert("저자를 입력해주세요.");
			$("[name=writer]").focus();
			return;
		}
		if( is_empty('[name=publisher]') ){
			alert("출판사를 입력해주세요.");
			$("[name=publisher]").focus();
			return;
		}
		if( is_empty('[name=size_name]') ){
			alert("판형을 선택해주세요.");
			$("[name=size_name]").focus();
			return;
		}
		if( is_empty('[name=is_print]') ){
			alert("판매여부를 선택해주세요.");
			$("[name=is_print]").focus();
			return;
		}
		if( is_empty('[name=emp_name]') ){
			alert("도서 담당직원의 이름을 입력해주세요.");
			$("[name=emp_name]").focus();
			return;
		}
		if( is_empty('[name=published_dt]') ){
			alert("출판일을 입력해주세요.");
			$("[name=published_dt]").focus();
			return;
		}
		if( is_empty('[name=editor]') ){
			alert("출판사 담당직원 이름을 입력해주세요.");
			$("[name=editor]").focus();
			return;
		}
		if( is_empty('[name=branch_name]') ){
			alert("재고 위치를 선택해주세요.");
			$("[name=branch_name]").focus();
			return;
		}
		
		
		var checkPirce = $('[name=book_price]').val();
		if(checkPirce.indexOf(',')>0){
			var num = checkPirce.replace(',','');
			$('[name=book_price]').val(num);
		}
		else if(isNaN(checkPirce)==true){
			alert("책 가격은 숫자만 기입해주세요");
			//$('[name=book_price]').val();
			return;
		}
		var checkPages = $('[name=book_pages]').val();
		if(isNaN(checkPages)==true){
			alert("페이지 수는 숫자만 기입해주세요");
			//$('[name=book_pages]').val(basePages);
			return;
		}
		var checkCnt = $('[name=isbn_cnt]').val();
		if(isNaN(checkCnt)==true){
			alert("재고량은 숫자만 기입해주세요");
			//$('[name=isbn_cnt]').val(baseCnt);
			return;
		}
		
		
		var checkEditor = $('[name=editor]').val();
		if(isFinite(checkEditor)==true){
			alert("출판사 담당 직원은 문자만 기입해주세요");
			//$('[name=isbn_cnt]').val(baseCnt);
			return;
		}
		var checkEmp_name = $('[name=emp_name]').val();
		if(isFinite(checkEmp_name)==true){
			alert("담당직원은 문자만 기입해주세요");
			//$('[name=isbn_cnt]').val(baseCnt);
			return;
		}
		
		
		if(confirm("정말 저장하시겠습니까?")==false){return;}
		
		$.ajax({
			url : "/group4erp/goBookInfoUpProc.do"
			, type : "post"
			, data : $('[name=bookContentUp]').serialize()
			, success : function(upCnt){
				if(upCnt==1){
					alert('책 수정 성공');
					location.replace("/group4erp/goBookList.do");
					return;
				}else if(upCnt==0){
					alert("책 수정 실패");
					return;
				}else if(upCnt==-2){
					alert("지사 수정 실패"); 
				}else alert("DB 오류");
				
			}
			, error : function(){
				alert("서버 접속 실패");
			}
		});
		
	}

</script>

</head>
<body>
<cneter>
<b>서적 상세보기</b>
	<br>
	<table border=0 width=850>
	 	<tr>
	 	<td align=right>
			<a style="font-size:30px; color:black" href="javascript:goBack();">⬅</a>
		</td>
		</tr>
	</table>
		
	<form name="bookContentUp" method="post" enctype="multipart/form-data">
		
		<table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>서적 정보</b></td>
			</tr>
		</table>
		
		<table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
				
			<tr>
				<td rowspan="6" colspan="2" width="20%">
				<%-- <c:if test="${employeeInfoUpDTO.emp_pic='emp0000.jpg'}"> --%>
					<img src="${ctRootImage}/book.png" width="100%" height="150">
				<%-- </c:if> --%>
					<%-- <img src="${ctRootImage}/emp_0003.jpg" width="100%" height="150"> --%>
				<!-- <img src="../image/emp_0002.jpg"> --></td>
				<td bgcolor="#EEEEEE">책 이름</td>
				<td colspan="3"><input type="text" name="book_name" size="83" value="${bookInfo.book_name}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE" width="12%">책번호</td>
				<td width="28%">${bookInfo.isbn13}</td>
				<input type="hidden" name="isbn13" value="${bookInfo.isbn13}">
				<td bgcolor="#EEEEEE" width="12%">카테고리</td>
				<td width="28%"><input type="text" size="27" name="cat_name" value="${bookInfo.cat_name}"></td>
				
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">서적담당자</td>
				<td><input type="text" size="27" name="emp_name" id="emp_name" value="${bookInfo.emp_name}"></td>
				<td bgcolor="#EEEEEE">저자</td>
				<td><input type="text" size="27" name="writer" id="writer" value="${bookInfo.writer}">
				</td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE" rowspan="2">가격</td>
				<td rowspan="2"><input type="text" name="book_price" size="27" value="${bookInfo.book_price.trim()}">원</td>
				<td bgcolor="#EEEEEE" rowspan="2">판매여부</td>
				<td rowspan="2">
					<c:if test="${bookInfo.is_print=='y'}">
						<input type="radio" name="is_print" value="y" checked>판매중
						<input type="radio" name="is_print" value="n">절판
					</c:if>
					<c:if test="${bookInfo.is_print=='n'}">
						<input type="radio" name="is_print" value="y">판매중
						<input type="radio" name="is_print" value="n" checked>절판
					</c:if>
				</td>
			<tr></tr>
			<tr>
				<td bgcolor="#EEEEEE">페이지 수</td>
				<td><input type="text" size="27" name="book_pages" value="${bookInfo.book_pages}">쪽</td>
				<td bgcolor="#EEEEEE">판형</td>
				<td>
					<select name="size_name">
						<option value="신국판">신국판
						<option value="국판">국판
						<option value="46판">46판
						<option value="46배판">46배판
						<option value="크라운판">크라운판
						<option value="국배판">국배판
						<option value="타블로이드">타블로이드
						<option value="기타">기타
				</td>
				<!--
			<tr>
				<td colspan="6">
					<div class="fileBox" align="left">
						<input align="left" type="text" class="fileName" readonly="readonly">
						<label for="uploadBtn" class="btn_file" align="left">프로필pic 수정</label>
						<input type="file" id="uploadBtn" class="uploadBtn" name="uploadBtn">
					</div>
				</td>
			</tr>-->
			<!--<tr>
				 <td colspan="6"><div align="left"><input type="file" name="profilePic" id="profilePic"></div>
			</tr> -->
		</table>
		
		
		<br><br>
		
		
		<table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>서적 외 정보</b></td>
			</tr>
		</table>
		<table table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<td bgcolor="#EEEEEE">재고 위치</td>
				<td colspan="2">
				<select name="branch_name">
					<c:forEach items="${requestScope.inventory_loc}" var="inven" varStatus="loopTagStatus">
             			<option value="${inven.branch_name}">${inven.branch_name}
             		</c:forEach> 
				<td bgcolor="#EEEEEE">재고 량</td>
				<td colspan="2"><input type="text" name="isbn_cnt" value="${bookInfo.isbn_cnt}">권
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">출판사</td>
				<td colspan="2"><input type="text" name="publisher" id="publisher" value="${bookInfo.publisher}"></td>
				<td bgcolor="#EEEEEE">출판일</td>
				<td colspan="2"><input type="text" name="published_dt" id="published_dt" value="${bookInfo.published_dt}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">출판사 담당 직원</td>
				<td colspan="4"><input type="text" name="editor" value="${bookInfo.editor}">
			</tr>
		</table>

		
		<br>
	<!--
		<table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>직속상관정보</b></td>
			</tr>
		</table>
		<table table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<td bgcolor="#EEEEEE" width="10%">이름</td>
				<td width="23%"><input type="text" name="mgr_emp_name" value="${employeeInfoUpDTO.mgr_emp_name}"></td>
				<td bgcolor="#EEEEEE" width="13%">부서</td>
				<td width="20%">
					<%-- <input type="text" name="mgr_emp_dep_name" value="${employeeInfoUpDTO.mgr_emp_dep_name}"> --%>
					<select name="mgr_emp_dep_name">
							<option value="총무부">총무부</option>
							<option value="기획부">기획부</option>
							<option value="영업부">영업부</option>
							<option value="마케팅부">마케팅부</option>
							<option value="사업부">사업부</option>
							<option value="인사부">인사부</option>
					</select>
				</td>
				<td bgcolor="#EEEEEE" width="10%">직급</td>
				<td width="23%">
					<%-- <input type="text" name="mgr_emp_jikup" value="${employeeInfoUpDTO.mgr_emp_jikup}"> --%>
					<select name="mgr_emp_jikup">
						<option value="대표이사">대표이사</option>
						<option value="전무이사">전무이사</option>
						<option value="상무이사">상무이사</option>
						<option value="부장">부장</option>
						<option value="차장">차장</option>
						<option value="과장">과장</option>
						<option value="대리">대리</option>
						<option value="주임">주임</option>
						<option value="사원">사원</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
		</table>
		-->
	</form>
	<br>
		<input type="button" value=" 수정 " onclick="bookInfoUp();">&nbsp;
		<!-- <input type="button" value=" 삭제 " onclick="empInfoDel();">&nbsp; -->
		<!-- <input type="button" value="뒤로가기" onclick="goBack();"> -->
		<form method="post" name="empUpDelForm" action="/group4erp/empUpDelProc.do">
			<input type="hidden" name="emp_no" value="${isbn13}">
		</form>


</body>
</html>