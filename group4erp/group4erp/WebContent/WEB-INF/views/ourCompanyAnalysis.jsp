<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common.jsp" %>

<script src = "https://www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>회사 현황</title>
<!-- Favicons -->
<link href="${ctRootImg}/favicon.png" rel="icon">
<link href="${ctRootImg}/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="${ctRootlib}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="${ctRootlib}/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css">
<!-- Custom styles for this template -->
<link href="${ctRootcss}/style.css" rel="stylesheet">
<link href="${ctRootcss}/style-responsive.css" rel="stylesheet">
<script type="text/javascript">

   $(document).ready(function() {

      $("[name=category]").change(function() {
         var cnt = $(this).filter(":checked").length;
         var cat_cd ='';

         if(cnt==1) {
            //change 이벤트가 발생한 체크박스의 형제들의 체크를 모두 풀기
            $(this).siblings().prop("checked", false);
            cat_cd = $(this).filter(":checked").val();
            
            goSearch(cat_cd);
         } 
      });
   });
      

   google.charts.load('current', {'packages' : ['corechart'] } );

   google.charts.setOnLoadCallback(drawChart);
   google.charts.setOnLoadCallback(drawBarChart);
   google.charts.setOnLoadCallback(drawEmployeeCntChart);
   google.charts.setOnLoadCallback(drawHireOrResignChart);
   google.charts.setOnLoadCallback(drawCategoryChart);


   function drawHireOrResignChart() {

      var hireOrResign_chart_data = google.visualization.arrayToDataTable(${empHireOrResign_data});
      var hireOrResign_chart_options = {
         title: '직원 변동 현황',
         width :700, 
         height: 300,
         lineWidth: 4,
         colors:['#f0ad4e', '#ed5564', '#4eccc4'],
         /* '#4eccc4','#4eccc4' */
         animation:{
            "startup": true,
              duration: 1000,
              easing: 'out',
            }
      };


      var hireOrResign_chart = new google.visualization.LineChart(document.getElementById('empHireOrResignChart'));
                         
      hireOrResign_chart.draw(hireOrResign_chart_data, hireOrResign_chart_options);

   }

   function drawEmployeeCntChart() {
      var employee_chart_data = google.visualization.arrayToDataTable(${employee_chart_data});
      var employee_chart_options = {
         title: '직원 현황(직급별)',
         width :700, 
         height: 300,
         colors:['#FF6464','#FF6464'],
         opacity: 0.5,
         animation:{
            "startup": true,
              duration: 1000,
              easing: 'out',
            }
      };

      var employee_chart = new google.visualization.ColumnChart(document.getElementById('employeeChart'));

      employee_chart.draw(employee_chart_data, employee_chart_options);
   }

   function drawBarChart() {
      var category_reg_chart_data = google.visualization.arrayToDataTable(${bookCategory_reg_chart_data});
      var category_data_options = {
         title: '분야별 도서 계약 건수',
         width :700, 
         height: 300,
         colors:['#82F9B7','#82F9B7'],
         animation:{
            "startup": true,
              duration: 1000,
              easing: 'out',
            }
      };

      var categoryReg_chart = new google.visualization.ColumnChart(document.getElementById('categoryRegChart'));

      categoryReg_chart.draw(category_reg_chart_data, category_data_options);
   
   }

   function drawCategoryChart() {
      var category_reg_chart_data = google.visualization.arrayToDataTable(${bookCategory_reg_chart_data});
      var category_data_options = {
         title: '분야별 도서 계약 건수',
         width :700, 
         height: 300,
         colors:['#00A5FF','#00A5FF'],
         
         animation:{
            "startup": true,
              duration: 1000,
              easing: 'out',
            }
      };

      var categoryReg_chart = new google.visualization.ColumnChart(document.getElementById('categoryRegChart'));

      categoryReg_chart.draw(category_reg_chart_data, category_data_options);
   }


   function drawChart() {
      var monthlyBookReg_data = google.visualization.arrayToDataTable(${monthlyBook_reg_chart_data});
      //var data2 = google.visualization.arrayToDataTable(${corpOrder_chart_data});
      //var data3 = google.visualization.arrayToDataTable(${dailyOrder_chart_data});

      var monthlyBookReg_data_options = {   
         title: '월별 도서 계약 건수',
         width :700, 
         height: 300,
         colors:['#ac92ec','#ac92ec'],
         lineWidth: 4,
         animation:{
            "startup": true,
              duration: 1000,
              easing: 'out',
            }
      };

      var monthlyBookReg_chart = new google.visualization.LineChart(document.getElementById('monthlyBookRegChart'));

      monthlyBookReg_chart.draw(monthlyBookReg_data, monthlyBookReg_data_options);

   }

   function goSearch(cat_cd) {
      
      $("[name=cat_cd]").val(cat_cd);
      //alert($("[name=category]").filter(":checked").val());
      $.ajax({
         url : "/group4erp/viewCategoryChart.do",            //호출할 서버쪽 URL 주소 설정
         type : "post",                              //전송 방법 설정
         data : $("[name=categoryBookChart]").serialize(),   //서버로 보낼 파라미터명과 파라미터값을 설정         
         success : function(data) {
            alert("성공!");
            if(data != null) {
               alert("성공!");
               google.charts.setOnLoadCallback(drawCateogoryChart);
               //drawBarChart(data);
               
            } else {
               alert("서버쪽 DB 연동 실패!");
            }
         }

         //서버의 응답을 못 받았을 경우 실행할 익명함수 설정
         , error : function() {      //서버의 응답을 못받았을 경우 실행할 익명함수 설정
            alert("서버 접속 실패!");
         }   
      });

   }


/*google.charts.load('current', {'packages' : ['corechart'] } );

google.charts.setOnLoadCallback(drawLineChart);

function drawLineChart() {

   var data3 = google.visualization.arrayToDataTable(${dailyOrder_chart_data});
   var data4 = google.visualization.arrayToDataTable(${dailyCorpOrder_chart_data});

   var options3 = {
         title: '일반고객 주문 건수(일자별)',
         width: 600,
         height:300
   };

   var options4 = {
         title: '사업자고객 주문 건수(일자별)',
         width: 600,
         height:300
   };

   var chart3 = new google.visualization.LineChart(document.getElementById('dailyOrderChart'));
   var chart4 = new google.visualization.LineChart(document.getElementById('dailyCorpOrderChart'));

   chart3.draw(data3, options3);
   chart4.draw(data4, options4);
}*/

</script>
</head>
<body><%-- <center>
   <h1>[회사 현황]</h1>
   
   <form name="categoryBookChart" method="post" action="/group4erp/viewCategoryChart.do">
      <table class="ourCompanyTb" cellpadding="5" cellspacing="5" align="center">
      <tr>
         <td align="center">직원 현황(직급별)<br><!-- <div id="employeeChart" style="width: 700px; height: 300px;"> </div> --></td>
         <td align="center">총원 변동 현황(기간별)<br><div id="empHireOrResignChart" style="width: 700px; height: 300px;"> </div></td>
      </tr>
      
      <tr>
         <td align="center">월별도서계약건수<br><div id="monthlyBookRegChart" style="width: 700px; height: 300px;"> </div></td>
         <td align="center">종류별 도서 계약 건수<br>
            <c:forEach items="${bookCategoryList}" var="bookCategoryList" varStatus="loopTagStatus">
               <c:if test="${bookCategoryList.cat_cd eq 6}">
                  <br>
               </c:if>
               <input type="checkbox" name="category" value='${bookCategoryList.cat_cd}' >${bookCategoryList.cat_name} &nbsp;
               
            </c:forEach>
            
         <div id="categoryRegChart" style="width: 700px; height: 300px;"> </div></td>
      </tr>
   
   </table>
   <input type="hidden" name="cat_cd">
   </form>
   

</center> --%>




























<section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
      <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
      </div>
      <!--logo start-->
      <a href="/group4erp/goMainTest.do" class="logo"><b>BOOKST<span>.ERP</span></b></a>
      <!--logo end-->
      <div class="nav notify-row" id="top_menu">
        <!--  notification start -->
        <ul class="nav top-menu">
          <!-- settings start -->
          <!-- notification dropdown end -->
          <li>
            <table>
               <tr>
                  <td align="left"> <font style="color:#D8E8E4;"><h5><span id="nowTime" align="right"></span> </h5></font></td>
               </tr>
            </table>
          </li>
        </ul>
        <!--  notification end -->
      </div>
      <div class="top-menu">
        <ul class="nav pull-right top-menu">
          <!-- <li>
            <a class="goBackss" href="javascript:goBack();">뒤로 가기</a>
          </li> -->
          <li>
            <a class="logout" href="/group4erp/logout.do">Logout</a>
          </li>
        </ul>
      </div>
    </header>
    <!--header end-->


    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
          <p class="centered">
            <a href="profile.html"><img src="${ctRootImg}/ui-sam.jpg" class="img-circle" width="80"></a>
          </p>
          <h5 class="centered">Sam Soffes</h5>
          <li class="mt">
            <a href="/group4erp/goMainTest.do">
              <i class="fa fa-dashboard"></i>
              <span>메인페이지</span>
              </a>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-desktop"></i>
              <span>업무 관리</span>
              </a>
            <ul class="sub">
              <li>
                <a href="/group4erp/goMyCareBookList.do"><i class="fa fa-book"></i>담당 도서 조회</a>
              </li>
              <li>
                <a href="/group4erp/businessTripList.do"><i class="fa fa-briefcase"></i>출장 신청</a>
              </li>
              <li>
                <a href="/group4erp/goMyWorkTime.do"><i class="fa fa-list"></i>근태 조회</a>
              </li>
              <li>
                <a href="/group4erp/viewApprovalList.do"><i class="fa fa-pencil"></i>문서 결재</a>
              </li>
              <li>
                <a href="/group4erp/goEmpDayOffjoin.do"><i class="fa fa-edit"></i>휴가 신청</a>
              </li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-shopping-cart"></i>
              <span>재고 관리</span>
              </a>
            <ul class="sub">
              <li>
                <a href="/group4erp/goBookList.do"><i class="fa fa-info-circle"></i>도서정보조회</a>
              </li>
              <li>
                <a href="/group4erp/goReleaseList.do"><i class="fa fa-list"></i>출고현황조회</a>
              </li>
              <li>
                <a href="/group4erp/goWarehousingList.do"><i class="fa fa-list"></i>입고현황조회</a>
              </li>
              <li>
                <a href="/group4erp/goReturnOrderList.do"><i class="fa fa-list"></i>반품현황조회</a>
              </li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-calendar"></i>
              <span>마케팅 관리</span>
              </a>
            <ul class="sub">
              <li>
                <a href="/group4erp/viewSalesInfoList.do"><i class="fa fa-money"></i>판매현황</a>
              </li>
              <li>
                <a href="/group4erp/viewEventList.do"><i class="fa fa-gift"></i>이벤트행사 현황</a>
              </li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-users"></i>
              <span>인사 관리</span>
              </a>
            <ul class="sub">
              <li>
                <a href="/group4erp/viewEmpList.do"><i class="fa fa-info-circle"></i>직원정보</a>
              </li>
              <li>
                <a href="/group4erp/viewSalList.do"><i class="fa fa-file"></i>급여명세서 조회</a>
              </li>
              <li>
                <a href="/group4erp/viewEmpWorkStateList.do"><i class="fa fa-list"></i>직원별 근무현황</a>
              </li>
              <li>
                <a href="/group4erp/viewEmpDayOffList.do"><i class="fa fa-list"></i>직원별 휴가 현황</a>
              </li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-krw"></i>
              <span>회계 관리</span>
              </a>
            <ul class="sub">
              <li class="active">
                <a href="/group4erp/viewTranSpecIssueList.do"><i class="fa fa-list"></i>거래명세서 조회</a>
              </li>
              <li>
                <a href="/group4erp/viewTranSpecList.do"><i class="fa fa-file-text"></i>사업자 거래내역 조회</a>
              </li>
              <li>
                <a href="/group4erp/viewCorpList.do"><i class="fa fa-link"></i>거래처 현황 조회</a>
              </li>
            </ul>
          </li>
          <li class="sub-menu">
            <a class="active"  href="javascript:;">
              <i class=" fa fa-bar-chart-o"></i>
              <span>전략 분석</span>
              </a>
            <ul class="sub">
              <li>
                <a href="/group4erp/viewBestKeywdAnalysis.do"><i class="fa fa-search"></i>키워드 검색 자료 조회</a>
              </li>
              <li class="active" >
                <a href="/group4erp/viewOurCompanyReport.do"><i class="fa fa-building-o"></i>회사현황</a>
              </li>
            </ul>
          </li>
        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <h3><i class="fa fa-angle-right"></i> 회사현황</h3>
        <!-- page start-->
        <form name="categoryBookChart" method="post" action="/group4erp/viewCategoryChart.do">
        <div id="morris">
          <div class="row mt">
            <div class="col-lg-6">
              <div class="content-panel">
                <h4><i class="fa fa-angle-right"></i> 직급별 직원현황</h4>
                <div class="panel-body">
                  <div id="employeeChart"> </div>
                  <!-- <div id="hero-graph" class="graph"></div> -->
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="content-panel">
                <h4><i class="fa fa-angle-right"></i> 기간별 총원 변동 현황</h4>
                <div class="panel-body">
                   <div id="empHireOrResignChart"> </div>
                     <!-- <div id="hero-bar" class="graph"></div> -->
                </div>
              </div>
            </div>
          </div>
          <div class="row mt">
            <div class="col-lg-6">
              <div class="content-panel">
                <h4><i class="fa fa-angle-right"></i> 월별 도서 계약 건수</h4>
                <div class="panel-body">
                   <div id="monthlyBookRegChart"></div>
                     <!-- <div id="hero-area" class="graph"></div> -->
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="content-panel">
                <h4><i class="fa fa-angle-right"></i> 분야별 도서 계약 건수</h4>
                <div class="panel-body">
                   <c:forEach items="${bookCategoryList}" var="bookCategoryList" varStatus="loopTagStatus">
                  <c:if test="${bookCategoryList.cat_cd eq 6}">
                     <br>
                  </c:if>
                  <input type="checkbox" name="category" value='${bookCategoryList.cat_cd}' >${bookCategoryList.cat_name} &nbsp;
               </c:forEach>
            
               <div id="categoryRegChart"> </div>
                  <!-- <div id="hero-donut" class="graph"></div> -->
                </div>
              </div>
            </div>
          </div>
        </div>
        <input type="hidden" name="cat_cd">
   </form>
        <!-- page end-->
      </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          <!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="morris.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end-->
  </section>

















<!-- js placed at the end of the document so the pages load faster -->
<script src="${ctRootlib}/jquery/jquery.min.js"></script>
<script src="${ctRootlib}/bootstrap/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${ctRootlib}/jquery.dcjqaccordion.2.7.js"></script>
<script src="${ctRootlib}/jquery.scrollTo.min.js"></script>
<script src="${ctRootlib}/jquery.nicescroll.js" type="text/javascript"></script>
<script src="${ctRootlib}/raphael/raphael.min.js"></script>
<%-- <script src="${ctRootlib}/morris/morris.min.js"></script> --%>
<!--common script for all pages-->
<script src="${ctRootlib}/common-scripts.js"></script>
<!--script for this page-->
<%-- <script src="${ctRootlib}/morris-conf.js"></script> --%>


</body>
</html>