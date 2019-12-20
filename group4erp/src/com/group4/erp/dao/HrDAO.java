package com.group4.erp.dao;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

import com.group4.erp.EmployeeDTO;
import com.group4.erp.SalaryDTO;

import com.group4.erp.HrListSearchDTO;

public interface HrDAO {

	int getEmpListAllCnt(HrListSearchDTO hrListSearchDTO);
	List<SalaryDTO> getEmpSalList();
	List<Map<String, String>> getEmpList(HrListSearchDTO hrListSearchDTO);
	int getDayOffListCnt(HrListSearchDTO hrListSearchDTO);
	List<Map<String, String>> getDayOffList(HrListSearchDTO hrListSearchDTO);
	
	int getEmpInoutListCnt(HrListSearchDTO hrListSearchDTO);
	
	List<Map<String, String>> getEmpInoutList(HrListSearchDTO hrListSearchDTO);


}
