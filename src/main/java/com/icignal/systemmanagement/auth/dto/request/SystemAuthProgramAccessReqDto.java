package com.icignal.systemmanagement.auth.dto.request;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemAuthProgramAccessReqDto extends GridPagingReqDto {


	private String authId;					//로그인 rid
	private String empId;					//직원 rid
	private String menuId;					//메뉴 rid
	private List<String> programIdList; //프로그램 접근 제한을 여러개 받아주는 리스트
	private String programId;				//프로그램 rid
	private Integer progNoAccessFlag; //프로그램 접근가능 여부 flag (1 or not)
	private String progNum;				//프로그램 번호
	private String progName;				//프로그램 이름
	private String progTypeCd;			//프로그램 타입코드
	private String progPath;				//프로그램 경로
	private String progTypeCheck;		//프로그램 타입
	private String progType;				//프로그 타입 공통코드로 변환 변수
	private Integer totalCount;
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public List<String> getProgramIdList() {
		return programIdList;
	}
	public void setProgramIdList(List<String> programIdList) {
		List<String> reqDto = programIdList;
		
		if(reqDto == null) {
			reqDto = new ArrayList<String>();
		}
		this.programIdList = reqDto;
	}
	
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public Integer getProgNoAccessFlag() {
		return progNoAccessFlag;
	}
	public void setProgNoAccessFlag(Integer progNoAccessFlag) {
		this.progNoAccessFlag = progNoAccessFlag;
	}
	public String getProgNum() {
		return progNum;
	}
	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgTypeCd() {
		return progTypeCd;
	}
	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getProgTypeCheck() {
		return progTypeCheck;
	}
	public void setProgTypeCheck(String progTypeCheck) {
		this.progTypeCheck = progTypeCheck;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	
}
