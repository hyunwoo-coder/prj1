<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/common.jsp" %>

<script src = "/www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매현황</title>

<script type="text/javascript">

	$(document).ready(function() {
	
		$("#orderListTable").hide();

		headerSort("onLineSaleTable", 0);

		setTableTrBgColor(
			"onLineSaleTable",	//테이블 class 값
			"${headerColor}",			//헤더 tr 배경색
			"${oddTrColor}",		//홀수행 배경색
			"${evenTrColor}",	//짝수행 배경색
			"${mouseOverColor}"			//마우스 온 시 배경색
		);
	
		$('[name=rowSearch] [name=rowCntPerPage]').change(function(){
			goSearch();
		});

		$(".pagingNumber").html(
			getPagingNumber(
				"${onlineOrderCnt}"						//검색 결과 총 행 개수
				,"${salesSearchDTO.selectPageNo}"			//선택된 현재 페이지 번호
				,"${salesSearchDTO.rowCntPerPage}"		//페이지 당 출력행의 개수
				,"10"										//페이지 당 보여줄 페이지번호 개수
				,"goSearch();"						//페이지 번호 클릭 후 실행할 자스코드
			)
		);

		inputData('[name=rowCntPerPage]',"${salesSearchDTO.rowCntPerPage}");
		inputData('[name=selectPageNo]',"${salesSearchDTO.selectPageNo}");
		inputData('[name=sort]').val("${salesSearchDTO.sort}");

		//$('[name=sort]').val("${corpSearchDTO.sort}");
	});

	google.charts.load('current', {'packages' : ['bar'] } );

	google.charts.setOnLoadCallback(drawChart);
	

	function drawChart() {
		var data1 = google.visualization.arrayToDataTable(${sales_chart_data});
		var data2 = google.visualization.arrayToDataTable(${corpOrder_chart_data});
		//var data3 = google.visualization.arrayToDataTable(${dailyOrder_chart_data});
	
		var options1 = {
				title: '일반 고객 주문 건수(분야별)',
				width :700, 
				height: 300
		};

		var options2 = {
				title: '기업고객 주문 건수(분야별)',
				width: 700,
				height:300
		};
	
		var chart1 = new google.charts.Bar(document.getElementById('orderInfoChart'));
		var chart2 = new google.charts.Bar(document.getElementById('corpOrderInfoChart'));
		//var chart3 = new google.visualization.LineChart(document.getElementById('dailyOrderChart'));
		
		//var chart1 = new google.visualization.BarChart(document.getElementById('orderInfoChart'));
		//var chart2 = new google.visualization.ColumnChart(document.getElementById('corpOrderInfoChart'));
	
		chart1.draw(data1, options1);
		chart2.draw(data2, options2);
		//chart3.draw(data3, options3);
	}


	google.charts.load('current', {'packages' : ['corechart'] } );

	google.charts.setOnLoadCallback(drawLineChart);

	function drawLineChart() {
	
		var data3 = google.visualization.arrayToDataTable(${dailyOrder_chart_data});
		var data4 = google.visualization.arrayToDataTable(${dailyCorpOrder_chart_data});
		var offline_data = google.visualization.arrayToDataTable(${offline_chart_data});
	
		var options3 = {
				title: '일반고객 주문 건수(일자별)',
				width: 700,
				height:300
		};

		var options4 = {
				title: '사업자고객 주문 건수(일자별)',
				width: 700,
				height:300
		};

		var offline_option = {
				title: '오프라인매장 판매 건수(일자별)',
				width: 700,
				height:300
		};
	
		var chart3 = new google.visualization.LineChart(document.getElementById('dailyOrderChart'));
		var chart4 = new google.visualization.LineChart(document.getElementById('dailyCorpOrderChart'));
		var offline_chart = new google.visualization.LineChart(document.getElementById('dailyOfflineChart'));
		
		//var chart1 = new google.visualization.BarChart(document.getElementById('orderInfoChart'));
		//var chart2 = new google.visualization.ColumnChart(document.getElementById('corpOrderInfoChart'));
	
		chart3.draw(data3, options3);
		chart4.draw(data4, options4);
		offline_chart.draw(offline_data, offline_option);
	}
	
	
	function goSearch() {

		var keyword = $("[name=saleSearchForm] [name=searchKeyword]").val();
		keyword = $.trim(keyword);
		$("[name=saleSearchForm] [name=searchKeyword]").val(keyword);
		
		document.saleSearchForm.submit();
		//alert($('[name=saleSearchForm]').serialize());
		/*$.ajax({
			url : "/group4erp/viewSalesInfoList.do",				//호출할 서버쪽 URL 주소 설정
			type : "post",										//전송 방법 설정
			//dataType :"json",
			data : $('[name=saleSearchForm]').serialize(),		//서버로 보낼 파라미터명과 파라미터값을 설정
			
			success : function(data) {
				
				//console.log("data==="+data.onlineOrderCnt);
					
					var salesSearchDTO = data.salesSearchDTO;
					var onlineOrderCnt = data.onlineOrderCnt;
					var onlineOrderList = data.onlineOrderList;
					var corpOrderCnt = data.corpOrderCnt;
					var corpTotRevenue = data.corpTotRevenue;
					var tot_revenue = data.tot_revenue;
					var sales_chart_data = data.sales_chart_data;
					//alert("onlineOrderCnt=="+onlineOrderCnt);
					
					//location.replace("/group4erp/viewSalesInfoList.do");
			}

			//서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			, error : function() {		//서버의 응답을 못받았을 경우 실행할 익명함수 설정
				alert("서버 접속 실패!");
			}	
		}); */
	}

	function goSearchAll() {
		document.saleSearchForm.reset();

		$('[name=saleSearchForm] [name=selectPageNo]').val("1");
		$('[name=saleSearchForm] [name=rowCntPerPage]').val("15");
		
		goSearch();
	}
	
	
	function showOrderList() {
		$("#orderListTable").show();
	}

	function hideOrderList() {
		$("#orderListTable").hide();
	}

</script>
</head>
<body><center>
	<h1>[주문 & 판매현황]</h1>
	<table border="0" cellpadding="5" cellspacing="5" align="center">
		<tr>
			<td>
				<table border="0" cellpadding="5" cellspacing="5" align="center">
					<tr>
						<td colspan="4" align="center"><h5>일반 고객 주문 현황</h5></td>
					</tr>
					<tr>
						<td>[오프라인 판매량]</td><td> ${dailyOfflineSalesTotCnt}건</td> <td>총 예상 수입액 </td><td> 원 </td>
					</tr>
					<tr>
						<td>[온라인 주문량]</td><td> ${onlineOrderCnt}건</td> <td>총 예상 수입액 </td><td> ${tot_revenue}원 </td>
					</tr>
		
				</table>
			</td>
			
			<td>
				<table border="0" cellpadding="5" cellspacing="5" align="center">
					<tr>
						<td colspan="4" align="center"><h5>기업 고객 주문 현황</h5></td>
					</tr>
					<tr>
						<td>[오프라인 판매량]</td><td> ${dailyOfflineSalesTotCnt}건</td> <td>총 예상 수입액 </td><td> 원 </td>
					</tr>
					<tr>
						<td>[온라인 주문량]</td><td> ${corpOrderCnt}건 </td> <td>총 예상 수입액 </td><td> ${corpTotRevenue}원 </td>
					</tr>
		
				</table>
			</td>
		</tr>
		
		<tr>
			<td align="center">오프라인 매장 판매 현황
				<div id="dailyOfflineChart" style="width: 700px; height: 300px;"> </div>
			</td>
			<td>
			
			</td>
			
		</tr>
		<tr>
			<td align="center">분야별 누적 주문
				<div id="orderInfoChart" style="width: 700px; height: 300px;"> </div>
			</td>
			<td align="center">분야별 누적 주문
				<div id="corpOrderInfoChart" style="width: 700px; height: 300px;"> </div>
			</td>
		</tr>
		
		<tr>
			<td align="center">일자별 누적 주문
				<div id="dailyOrderChart" style="width: 700px; height: 300px;"> </div>
			</td>
			
			<td align="center">일자별 누적 주문
				<div id="dailyCorpOrderChart" style="width: 700px; height: 300px;"> </div>
			</td>
		</tr>
		<tr>
			<td align="center">
				<!-- <input type="button" value="세부내역보기" onClick="showOrderList();">&nbsp;
				<input type="button" value="세부내역숨기기" onClick="hideOrderList();"><br> --> 
			</td>
			<td align="center">
				<!-- <input type="button" value="세부내역보기" onClick="showOrderList();">&nbsp;
				<input type="button" value="세부내역숨기기" onClick="hideOrderList();"><br> -->
			</td>
		</tr>
	</table>

	<br>
	
	<div id="orderListTable">
	
	<form name="saleSearchForm" method="post" action="/group4erp/viewSalesInfoList.do">
		<table border="0" cellpadding="5" cellspacing="5">
			<%--<tr>
				<td>[기간별]</td><td><input type="checkbox" name="date">1주일전
					<input type="checkbox" name="date">1달전
					<input type="checkbox" name="date">3달전
					<input type="checkbox" name="date">6달전
				</td>
			</tr> --%>
			<tr>
				<td>[검색어]</td><td><input type="text" name="searchKeyword">&nbsp;&nbsp;<input type="button" value="검색" onClick="goSearch();">&nbsp;&nbsp;
									<input type="button" value="모두검색" onClick="goSearchAll();"> </td>
			</tr>
		</table>
		
		 
     <input type="hidden" name="selectPageNo">
     <input type="hidden" name="sort">
		
	<div>&nbsp; <span class="pagingNumber"></span>&nbsp;</div>
	<table>
		<tr height=10>
			<td></td>
		</tr>
	</table>
</form> 

	<table name="rowSearch" border="0" cellpadding="5" cellspacing="5">
		<tr>
	    	<td align=right>
	        [전체] : ${onlineOrderCnt}개&nbsp;&nbsp;&nbsp;&nbsp;
	            <select name="rowCntPerPage">
	               <option value="10">10</option>
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	               <option value="30">30</option>
	            </select> 행보기
	            </td>
	    </tr>
	    <tr>
	    	<td>
	    		<div id="orderListTable">
					<table class="onLineSaleTable tab" name="onLineSaleTable" cellpadding="5" cellspacing="5">
						<tr>
							<th>주문번호</th><th>ID</th><th>배송 주소</th><th>ISBN</th><th>가격</th><th>주문수량</th><th>총액</th><th>고객 요구사항</th><th>회원 여부</th><th>주문일</th>
						</tr>
						<c:forEach items='${onlineOrderList}' var="onlineOrderList" varStatus="loopTagStatus">
						<tr align="center">
							<td>${onlineOrderList.order_no}</td>
							<td>${onlineOrderList.order_id}</td>
							<td>${onlineOrderList.order_delivery_addr}</td>
							<td>${onlineOrderList.isbn13}</td>
							<td>${onlineOrderList.book_price}원</td>
							<td>${onlineOrderList.book_qty}</td>
							<td>${onlineOrderList.tot_cost}원</td>
							<td>${onlineOrderList.cus_requirement}</td>
							<td>${onlineOrderList.is_member}</td>
							<td>${onlineOrderList.order_dt}</td>
						</tr>		
						</c:forEach>
						<tr>
							<td colspan="7" align="right">총 예상 수입 : ${tot_revenue}원</td>
						</tr>
					</table>
				</div>
	    	</td>
	    </tr>
	</table>
	
	<br><br>

	[사업자 고객 주문 현황]<br>
	<table border="0" cellpadding="5" cellspacing="5">
		<tr>
			<td>[건수]</td><td>${corpOrderCnt}건 </td> <td>총 예상 수입액</td><td> ${corpTotRevenue}원 </td>
		</tr>
		
	</table>
</center>

</body>
</html>