package com.group4.erp;

public class EmpApprovalCheckDTO {
	
	private int emp_no;
	private String emp_pwd;
	private String checkApproval;
	
	
	public String getCheckApproval() {
		return checkApproval;
	}
	public void setCheckApproval(String checkApproval) {
		this.checkApproval = checkApproval;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_pwd() {
		return emp_pwd;
	}
	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}
	
}
