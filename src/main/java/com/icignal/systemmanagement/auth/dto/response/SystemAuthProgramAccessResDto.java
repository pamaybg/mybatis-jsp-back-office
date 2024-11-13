package com.icignal.systemmanagement.auth.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
/*
 * 1. 클래스명	: SystemAuthProgramAccessResDto
 * 2. 파일명	: SystemAuthProgramAccessResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.auth.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 4. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		
 * </PRE>
 */ 
@CommCode
public class SystemAuthProgramAccessResDto extends GridPagingItemResDto{
	private String authId;					//로그인 rid
	private String empId;					//직원 rid
	private String menuId;					//메뉴 rid
	private List<String> programIdList;
	private String programId;				//프로그램 rid
	private String progNum;				//프로그램 번호
	private String progName;				//프로그램 이름
	private String progTypeCd;			//프로그램 타입코드
	private String progPath;				//프로그램 경로
	private String progTypeCheck;		//프로그램 타입
	
	@MarkName(groupCode = "ADMIN_PROG_TYPE", codeField = "progTypeCd")
	private String progType;				//프로그 타입 공통코드로 변환 변수
	
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
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	
	
}
