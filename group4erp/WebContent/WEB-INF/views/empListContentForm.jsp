<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP페이지 처리 방식 선언하기 -->

<!-- 현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서는 UTF-8 방식으로 인코딩한다 라고 설정함 / 현재 이 JSP페이지는 UTF-8방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할수 있는 방법이다. -->
<!DOCTYPE html>
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<!-- 유일하게 WEB-INF 루트 경로를 쓸수 있다. -->
<%@ include file="/WEB-INF/views/common.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>Insert title here</title>
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

	
	
</style>

<script>
	var hire_default = "${employeeInfoDTO.hire_dt}"
	$(document).ready(function(){
		
		inputData("[name=dep_name]", "${employeeInfoUpDTO.dep_name}");
		inputData("[name=jikup]", "${employeeInfoUpDTO.jikup}");
		inputData("[name=worktime_name]", "${employeeInfoUpDTO.worktime_name}");
//		inputData("[name=mgr_emp_dep_name]", "${employeeInfoUpDTO.mgr_emp_dep_name}");
//		inputData("[name=mgr_emp_jikup]", "${employeeInfoUpDTO.mgr_emp_jikup}");
		
		
		$("#hire_dt").datepicker({ 
		    dateFormat: 'yy-mm-dd'
		    ,defaultDate : hire_default
			,onSelect: function() { 
				var dateObject = $(this).datepicker('getDate');
		    }
		    ,beforeShowDay:$.datepicker.noWeekends 
		});

		$("#resign_date").datepicker({ 
		    dateFormat: 'yy-mm-dd'
		    ,defaultDate : 'today'
			,onSelect: function() { 
				var dateObject = $(this).datepicker('getDate');
		    }
		    ,beforeShowDay:$.datepicker.noWeekends 
		});



		var uploadFile = $('.fileBox .uploadBtn');
		uploadFile.on('change', function(){
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
			} else {
				var filename = $(this).val().split('/').pop().split('\\').pop();
			}
			$(this).siblings('.fileName').val(filename);
		});

		

	});

	function goBack(){
		history.go(-1);
	}



	/*파일 업로드 테스트 스크립트
	function uploadFile(){
        var form = $('[name=empContentUp]')[0];
        var formData = new FormData(form);
        formData.append("profilePic", $("#profilePic")[0].files[0]);
        formData.append("emp_no", $("#emp_no").val());

        console.log(formData);
        $.ajax({
            url: '/group4erp/empInfoUpProc.do',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    success: function(result){
                        alert("업로드 성공!!");
                    }
            });
    } */

	function empInfoUp(){
		var form = $('[name=empContentUp]')[0];
        var formData = new FormData(form);
        formData.append("uploadBtn", $("#uploadBtn")[0].files[0]);
        //formData.append("emp_no", $("#emp_no").val());
	   	//console.log(formData);
        
        if( is_empty('[name=emp_name]') ){
		       alert("이름을 입력해주세요.");
		       $("[name=emp_name]").focus();
		       return;
		    }
		    if( is_empty('[name=emp_eng_name]') ){
		       alert("영문이름을 입력해주세요.");
		       $("[name=emp_eng_name]").focus();
		       return;
		    }
		    if( is_empty('[name=emp_gender]') ){
			       alert("성별을 선택해주세요.");
			       $("[name=emp_gender]").focus();
			       return;
			}
		    if( is_empty('[name=jumin_num]') ){
			       alert("주민번호를 입력해주세요.");
			       $("[name=jumin_num_f]").focus();
			       return;
			}
		    if( is_empty('[name=phone]') ){
			       alert("휴대전화번호를 입력해주세요.");
			       $("[name=phone]").focus();
			       return;
			}
		    /* if( is_empty('[name=emp_email_office]') ){
			       alert("회사 이메일을 입력해주세요.");
			       $("[name=emp_email_office]").focus();
			       return;
			} */
		    if( is_empty('[name=emp_email]') ){
			       alert("이메일을 입력해주세요.");
			       $("[name=emp_email]").focus();
			       return;
			}
		    if( is_empty('[name=emp_addr]') ){
			       alert("주소를 입력해주세요.");
			       $("[name=emp_addr]").focus();
			       return;
			}    
			
			
		    if( is_empty('[name=dep_name]') ){
		       alert("부서를 선택해주세요.");
		       $("[name=dep_name]").focus();
		       return;
		    }
		    if( is_empty('[name=worktime_name]') ){
			       alert("근무 형태를 선택해주세요.");
			       $("[name=worktime_name]").focus();
			       return;
			}
		    if( is_empty('[name=jikup]') ){
		       alert("직급을 선택해주세요.");
		       $("[name=jikup]").focus();
		       return;
		    }
		    if( is_empty('[name=salary]') ){
		       alert("연봉을 입력해주세요.");
		       $("[name=salary]").focus();
		       return;
		    }

		    
		    /* if( is_empty('[name=mgr_emp_name]') ){
		       alert("직속상관 이름을 입력해주세요.");
		       $("[name=conmgr_emp_nametent]").focus();
		       return;
		    } */
		    
		    
		    var juminb = $('[name=jumin_num]').val();
		    var gender = 0;
		    $("[name=emp_gender]").each(function(){
		       var thisGender = $(this);
		       if(thisGender.is(":checked")){
		          gender = thisGender;   
		       }
		    });
		    if(juminb.substr(6,1)=='1' || juminb.substr(6,1)=='3'){
		       if(gender.val()=='여'){
		          alert("주민등록번호 뒷자리 와 성별이 다릅니다.");
		          return;
		       }
		    }else if(juminb.substr(6,1)=='2' || juminb.substr(6,1)=='4'){
		       if(gender.val()=='남'){
		          alert("주민등록번호 뒷자리 와 성별이 다릅니다.");
		          return;
		       }
		    }
		    else if(juminb.substr(6,1)=='5' || juminb.substr(6,1)=='6' || juminb.substr(6,1)=='7' || juminb.substr(6,1)=='8' || juminb.substr(6,1)=='9'){
		       alert("일치하지 않는 주민등록번호 입니다.");
		       return;
		    }
		    
		    var phone = $('[name=phone]').val();
		    
		    if(phone.indexOf('-')>0){
		       phone = phone.split('-').join('');
		    }
		    
		    
		    if( is_valid_pattern("[name=phone]", /^[0-9]{10,11}$/)==false ){
		       alert("전화번호 형식이 틀렸습니다. 다시 입력해주세요");
		       return;
		    }
		    if( is_valid_email("[name=emp_email]")==false ){
		       alert("이메일 형식을 벗어납니다.");
		       return;
		    }
		    
		    if(confirm("정말 저장하시겠습니까?")==false){return;}

			//alert(formData.serialize());
			//return;
	        var emp_no = $("[name=emp_no]").val();


	       	//alert(formData);
	       	//return;
        $.ajax({
            url: '/group4erp/empInfoUpProc.do',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    success: function(result){
                        alert("수정이 완료되었습니다.");
                        $("img").remove();
                        location.href="/group4erp/viewEmpContentForm.do?emp_no="+emp_no;
                    }
        });
		
		/* alert( $("[name=empContentUp]").serialize() );

		$.ajax({
			url : "/group4erp/empInfoUpProc.do"
			, type : "post"
			, data : $("[name=empContentUp]").serialize()
			, success : function(data){
				alert("수정성공");
			}
			, error : function(){
				alert("서버 접속 실패");
			}
		});
 		*/	
	}


	
	function empInfoDel(emp_no){
		alert("삭제 기능 구현중");
		/*
		$.ajax({
			url : "/group4erp/empInfoDelProc.do"
			, type : "post"
			, data : "emp_no="+emp_no
			, success : function(DelCnt){
				alert(999);
				return;
				location.replace("/group4erp/???????.do");
			}
			, error : function(){
				alert("서버 접속 실패");
			}
		});
		*/
	}



</script>
</head>
<body><center>
	<b>직원 상세보기</b>
	<table border=0 width=850>
	 	<tr>
	 	<td align=right>
			<a style="font-size:30px; color:black" href="javascript:goBack();">⬅</a>
		</td>
		</tr>
	</table>
		
	<form name="empContentUp" method="post" enctype="multipart/form-data">
		
		<table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>직원정보</b></td>
			</tr>
		</table>
		
		<table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<td rowspan="6" colspan="2" width="20%">
					<c:choose>
                    	<c:when test="${empty employeeInfoUpDTO.emp_pic || employeeInfoUpDTO.emp_pic=='newWithoutPic'}">
                    		<img src="${ctRootImage}/default.jpg" width="100%" height="30%">
                        </c:when>
                    	<c:otherwise>
                            <img src="${ctRootImage}/${employeeInfoUpDTO.emp_pic}" width="100%" height="189">
                        </c:otherwise>
                    </c:choose>
					<%-- <img src="${ctRootImage}/emp_0003.jpg" width="100%" height="150"> --%>
				<!-- <img src="../image/emp_0002.jpg"> --></td>
				<td bgcolor="#EEEEEE" width="12%">성명</td>
				<td width="28%"><input type="text" size="27" name="emp_name" value="${employeeInfoUpDTO.emp_name}"></td>
				<td bgcolor="#EEEEEE" width="12%">영어명</td>
				<td width="28%"><input type="text" size="27" name="emp_eng_name" value="${employeeInfoUpDTO.emp_eng_name}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">사번</td>
				<td><input type="text" size="27" name="emp_no" id="emp_no" value="${employeeInfoUpDTO.emp_no}"></td>
				<%-- <td><input type="text" style="background-color:#EBEBE4; box-shadow:none; border: 1px solid lightgray" size="27" name="emp_no" id="emp_no" value="${employeeInfoUpDTO.emp_no}"></td> --%>
				<td bgcolor="#EEEEEE">비밀번호</td>
				<td><input type="text" size="27" name="emp_pwd" id="emp_pwd" value="${employeeInfoUpDTO.emp_pwd}"></td>
				
				
			</tr>
			<tr>			
				<td bgcolor="#EEEEEE">주민번호</td>
				<td><input type="text" size="27" name="jumin_num" value="${employeeInfoUpDTO.jumin_num}"></td>
				<td bgcolor="#EEEEEE">성별</td>
				<td>
					<c:if test="${employeeInfoUpDTO.emp_gender=='여'}">
						<input type="radio" name="emp_gender" value="여" checked>여
						<input type="radio" name="emp_gender" value="남">남
					</c:if>
					<c:if test="${employeeInfoUpDTO.emp_gender=='남'}">
						<input type="radio" name="emp_gender" value="여">여
						<input type="radio" name="emp_gender" value="남" checked>남
					</c:if>
				</td>
				
				
				
				
				
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">전화번호</td>
				<td><input type="text" size="27" name="phone" value="${employeeInfoUpDTO.phone}"></td>
				
				<td bgcolor="#EEEEEE">이메일</td>
				<td><input type="text" size="27" name="emp_email" size="25" value="${employeeInfoUpDTO.emp_email}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">주소</td>
				<td colspan="3"><input type="text" name="emp_addr" size="76" value="${employeeInfoUpDTO.emp_addr}"></td>
			<tr>
				<td colspan="6">
					<div class="fileBox" align="left">	<!-- style="position:absolute;left:22%; -->
						<input align="left" type="text" class="fileName" readonly="readonly">
						<label style="cursor:pointer" for="uploadBtn" class="btn_file" align="left">프로필pic 수정</label>
						<input type="file" id="uploadBtn" class="uploadBtn" name="uploadBtn">
					</div>
				</td>
			</tr>
			<tr>
				<!-- <td colspan="6"><div align="left"><input type="file" name="profilePic" id="profilePic"></div> -->
			</tr>
		</table>
		
		
		<br><br>
		
		
		<table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>채용정보</b></td>
			</tr>
		</table>
		<table table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<td bgcolor="#EEEEEE">부서</td>
				<td colspan="2">
					<select name="dep_name">
							<option value="총무부">총무부</option>
							<option value="기획부">기획부</option>
							<option value="영업부">영업부</option>
							<option value="마케팅부">마케팅부</option>
							<option value="사업부">사업부</option>
							<option value="인사부">인사부</option>
					</select>
				</td>
				<td bgcolor="#EEEEEE">채용형태</td>
				<td colspan="2">
					<select name="worktime_name">
						<option value="정규직">정규직</option>
						<option value="파견직">파견직</option>
						<option value="기간제 근로자">기간제 근로자</option>
						<option value="파트타임">파트타임</option>
						<option value="인턴">인턴</option>
					</select>
				</td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">직급</td>
				<td colspan="2">
					<select name="jikup">
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
				<td bgcolor="#EEEEEE">연봉</td>
				<td colspan="2"><input type="text" name="salary" value="${employeeInfoUpDTO.salary}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">입사일</td>
				<td colspan="2"><input type="text" name="hire_dt" id="hire_dt" value="${employeeInfoUpDTO.hire_dt}"></td>
				<td bgcolor="#EEEEEE">퇴사일</td>
				<td colspan="2"><input type="text" name="resign_date" id="resign_date" value="${employeeInfoUpDTO.resign_date}"></td>
			</tr>
			<tr>
				<td bgcolor="#EEEEEE">휴직상태</td>
				<td colspan="2">
					<c:if test="${employeeInfoUpDTO.is_on_leave=='F'}">
						재직중
					</c:if>
					<c:if test="${employeeInfoUpDTO.is_on_leave=='T'}">
						휴직중
					</c:if>
				<%-- <input type="text" name="is_on_leave" value="${employeeInfoDTO.is_on_leave}"></td> --%>
				<td bgcolor="#EEEEEE" rowspan="2">회사이메일</td>
				<td colspan="2">
					<c:if test="${employeeInfoUpDTO.salary!=0}">
						<input type="text" name="emp_email_office" size="27" value="${employeeInfoUpDTO.emp_email_office}">
					</c:if>
					<c:if test="${employeeInfoUpDTO.salary==0}">
						<input type="hidden" style='background-color:#EBEBE4; box-shadow:none; border: 1px solid lightgray; text-align:center;' name="emp_email_office" size="27" value="${employeeInfoUpDTO.emp_email_office}" readonly> 
						<font size='2px' color='orange'> *승인 시 자동으로 부여</font>
					</c:if>
				</td>
					
					
					
					
			</tr>
		</table>
	
		<%-- <table class="line" width="850">
			<tr>
				<td>&nbsp;&nbsp;<b>결재자</b></td>
			</tr>
		</table>
		<table table class="empContentInfo tab2" width="850" border=1 bordercolor="#000000" cellpadding=5 align=center>
			<tr>
				<td bgcolor="#EEEEEE" width="10%">이름</td>
				<td width="23%"><input type="text" name="mgr_emp_name" value="${employeeInfoUpDTO.mgr_emp_name}"></td>
				<td bgcolor="#EEEEEE" width="13%">부서</td>
				<td width="20%">
					<input type="text" name="mgr_emp_dep_name" value="${employeeInfoUpDTO.mgr_emp_dep_name}">
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
					<input type="text" name="mgr_emp_jikup" value="${employeeInfoUpDTO.mgr_emp_jikup}">
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
		</table> --%>
	</form>
		<c:if test="${employeeInfoUpDTO.salary==0}">
			<input type="button" value=" 승인 " onclick="empInfoUp();">&nbsp;
		</c:if>
		<c:if test="${employeeInfoUpDTO.salary!=0}">
			<input type="button" value=" 수정" onclick="empInfoUp();">&nbsp;
		</c:if>
		<%-- <input type="button" value=" 삭제 " onclick="empInfoDel(${emp_no});">&nbsp; --%>
		<!-- <input type="button" value="뒤로가기" onclick="goBack();"> -->
		<form method="post" name="empUpDelForm" action="/group4erp/empUpDelProc.do">
			<input type="hidden" name="emp_no" value="${emp_no}">
		</form>
</center>
</body>
</html>