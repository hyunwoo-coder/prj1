package com.group4.erp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.group4.erp.service.HRService;

import java.util.*;

import com.group4.erp.*;
import com.group4.erp.service.HRService;
import com.group4.erp.service.InvenService;
import com.group4.erp.service.MyWorkService;

@Controller
public class MyWorkController {
	
	@Autowired
	MyWorkService myWorkService;
	
	//담당 상품 조회
	@RequestMapping(value="/goMyCareBookList.do")
	public ModelAndView viewEmpListList(
			HttpSession session
			,MyWorkSearchDTO myWorkSearchDTO
			) {
		
		ModelAndView mav = new ModelAndView();
		
		//화면에 나의 상품 관리 페이지 띄우는 코드
		mav.setViewName("main.jsp");
		mav.addObject("subMenu", "viewMyCareBookList");
		mav.addObject("navigator", "[업무관리]-[담당 상품 조회]");
		try {

			//===================================================================================================
			//검색 항목 불러오는 코드
			List<Map<String, String>> categoryList = this.myWorkService.getCategoryList(myWorkSearchDTO);
			mav.addObject("categoryList", categoryList);
			
			List<Map<String, String>> bookSize = this.myWorkService.getBookSizeList(myWorkSearchDTO);
			mav.addObject("bookSize", bookSize);
			
			List<Map<String, String>> branchList = this.myWorkService.getBranchList(myWorkSearchDTO);
			mav.addObject("branchList", branchList);
			
			List<Map<String, String>> publisherList = this.myWorkService.getPublisherList(myWorkSearchDTO);
			mav.addObject("publisherList", publisherList);
			
			//===================================================================================================
			
			if(myWorkSearchDTO.getEmp_no()==null) {
				myWorkSearchDTO.setEmp_no((String)session.getAttribute("emp_id"));
			}
			
			//페이징 처리를 위한 총 검색 개수 불러오는 코드
			int myWorkListAllCnt = this.myWorkService.getMyWorkListAllCnt(myWorkSearchDTO);

			if(myWorkListAllCnt>0) {
				//선택한 페이지 번호 구하기
				int selectPageNo = myWorkSearchDTO.getSelectPageNo();
				// 한 화면에 보여지는 행의 개수 구하기
				int rowCntPerPage = myWorkSearchDTO.getRowCntPerPage();
				// 검색할 시작행 번호 구하기
				int beginRowNo = (selectPageNo*rowCntPerPage-rowCntPerPage+1);
				// 만약 검색 한 총 개수가 검색할 시작행 번호 보다 작으면
				// 선택한 페이지 번호를 1로 세팅하기
				if(myWorkListAllCnt<beginRowNo) {
					myWorkSearchDTO.setSelectPageNo(1);
				}
			}
			
			//===================================================================================================
			//검색된 관리 상품 목록 불러오는 코드
			List<Map<String, String>> MyCareBookList = this.myWorkService.getMyCareBookList(myWorkSearchDTO);
			//===================================================================================================
			
			mav.addObject("publisherList", publisherList);
			mav.addObject("myWorkListAllCnt", myWorkListAllCnt);
			mav.addObject("MyCareBookList", MyCareBookList);
			

		} catch(Exception e) {
			System.out.println("<게시글 불러오기 실패>");
			System.out.println("예외발생"+e);
		}
		return mav;
	}
	
	//근태조회
	@RequestMapping(value="/goMyWorkTime.do")
	public ModelAndView viewMyWorkTime(
			HttpSession session
			,MyWorkSearchDTO myWorkSearchDTO
			) {
		
		ModelAndView mav = new ModelAndView();
		//mav.setViewName("eventScheduleForm.jsp");
		
		//화면에 나의 상품 관리 페이지 띄우는 코드
		mav.setViewName("main.jsp");
		mav.addObject("subMenu", "viewMyWorkTime");
		try {
			//검색 총 개수 리턴(추후 접속 계정을 가져오면 연동시킬 예정)
			int workDaysListAllCnt = this.myWorkService.getWorkDaysListAllCnt(myWorkSearchDTO);
			mav.addObject("workDaysListAllCnt", workDaysListAllCnt);
				if(workDaysListAllCnt>0) {
					//선택한 페이지 번호 구하기
					int selectPageNo = myWorkSearchDTO.getSelectPageNo();
					// 한 화면에 보여지는 행의 개수 구하기
					int rowCntPerPage = myWorkSearchDTO.getRowCntPerPage();
					// 검색할 시작행 번호 구하기
					int beginRowNo = (selectPageNo*rowCntPerPage-rowCntPerPage+1);
					// 만약 검색 한 총 개수가 검색할 시작행 번호 보다 작으면
					// 선택한 페이지 번호를 1로 세팅하기
					if(workDaysListAllCnt<beginRowNo) {
						myWorkSearchDTO.setSelectPageNo(1);
					}
				}
			
			List<Map<String, String>> searchEmpNo = this.myWorkService.getSearchEmpNo(myWorkSearchDTO);
			mav.addObject("searchEmpNo", searchEmpNo);
			//테이블 가져오는 부분
			List<Map<String, String>> getWorkDaysList = this.myWorkService.getWorkDaysList(myWorkSearchDTO);
			mav.addObject("getWorkDaysList", getWorkDaysList);
			//mav.addObject("MyCareBookList", MyCareBookList);
			
		}catch(Exception e) {
			System.out.println("<게시글 불러오기 실패>");
			System.out.println("예외발생"+e);
		}
		return mav;
	}
	
	
	@RequestMapping(value="/myBookWarehousingProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8")
	@ResponseBody
	public int goReleaseUp(
			WareHousingInsertDTO whInsertDTO
			) {
		
		int insertWareHousing = 0;
		
		try {
			
			int insertBeforeCnt = this.myWorkService.getInsertBeforeCnt(whInsertDTO);
			
			insertWareHousing = this.myWorkService.getInsertWareHousing(whInsertDTO);
			
		}catch(Exception e) {
			System.out.println("<발주 신청 실패>");
			System.out.println("예외 발생=>"+e);
			insertWareHousing = -1;
		}
		   
		return insertWareHousing;
	}
}
