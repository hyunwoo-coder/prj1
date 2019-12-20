package com.group4.erp.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group4.erp.EmployeeDTO;
import com.group4.erp.SalaryDTO;
import com.group4.erp.dao.HrDAO;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group4.erp.HrListSearchDTO;
import com.group4.erp.dao.HrDAO;
import com.group4.erp.dao.InvenDAO;

@Service
public class HRServiceImpl implements HRService {

	

	@Autowired
	HrDAO hrDAO;

	@Override
	public List<SalaryDTO> getEmpSalList() {
		// TODO Auto-generated method stub
		
		List<SalaryDTO> empSalList = this.hrDAO.getEmpSalList();
		
		return empSalList;
	}
	
	public int getEmpListAllCnt(HrListSearchDTO hrListSearchDTO) {
		
		int getEmpBoardListCnt = this.hrDAO.getEmpListAllCnt(hrListSearchDTO);
		
		return getEmpBoardListCnt;
	}
	
	public List<Map<String, String>> getEmpList(HrListSearchDTO hrListSearchDTO){
		
		List<Map<String, String>> getEmpBoardList = this.hrDAO.getEmpList(hrListSearchDTO);
		
		return getEmpBoardList;

	}
	
	
	
	@Override
	public int getDayOffListCnt(HrListSearchDTO hrListSearchDTO) {
		int getDayOffListCnt = this.hrDAO.getDayOffListCnt(hrListSearchDTO);
		return getDayOffListCnt;
	}

	@Override
	public List<Map<String, String>> getDayOffList(HrListSearchDTO hrListSearchDTO) {
		List<Map<String, String>> getDayOffList = this.hrDAO.getDayOffList(hrListSearchDTO);
		return getDayOffList;
	}

	@Override
	public int getEmpInoutListCnt(HrListSearchDTO hrListSearchDTO) {
		int getEmpInoutListCnt = this.hrDAO.getEmpInoutListCnt(hrListSearchDTO);
		return getEmpInoutListCnt;
	}

	@Override
	public List<Map<String, String>> getEmpInoutList(HrListSearchDTO hrListSearchDTO) {
		List<Map<String, String>> getEmpInoutList = this.hrDAO.getEmpInoutList(hrListSearchDTO);
		return getEmpInoutList;
	}
	
	
	
	
	

}
