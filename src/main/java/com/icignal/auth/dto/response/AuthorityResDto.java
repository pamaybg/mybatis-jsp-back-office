package com.icignal.auth.dto.response;

import java.io.Serializable;
import java.util.List;

import com.icignal.auth.dto.request.AuthorityReqDto;

public class AuthorityResDto  implements Serializable {
	
	private static final long serialVersionUID = -5884709290723078056L;
	
	private String ridUser;			//사용자 아이디
	private String empId;			//직원 아이디
	private String authGroupId;		//권한그룹 아이디
	private String accountOrgId;	//어카운트 ORG 아이디
	private String dataTypeCd;		//데이터 유형 코드
	private String authDataInValue;	//권한 데이터 IN 값
	private String authDataInQuery;	//권한 데이터 IN 쿼리
	private String ridDivision;		//부서 아이디
	
	private List<AuthorityGroupListResDto> authGroupList;	//권한그룹 목록
	private List<AuthorityListResDto> authList;				//권한 목록
	private List<AuthorityDataListResDto> authDataList;		//권한데이터 목록
	private List<AuthorityMenuListResDto> authMenuList;		//권한메뉴 목록
	private List<AuthorityProgramListResDto> authProgList;	//권한프로그램 목록
	private List<AuthorityObjectListResDto> authObjList;		//권한오브젝트 목록
	
	public String getEmpId() {
		return this.empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getAuthGroupId() {
		return authGroupId;
	}

	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

	public List<AuthorityGroupListResDto> getAuthGroupList() {
		return authGroupList;
	}

	public void setAuthGroupList(List<AuthorityGroupListResDto> authGroupList) {
		this.authGroupList = authGroupList;
	}

	public List<AuthorityListResDto> getAuthList() {
		return authList;
	}

	public void setAuthList(List<AuthorityListResDto> authList) {
		this.authList = authList;
	}

	public List<AuthorityDataListResDto> getAuthDataList() {
		return authDataList;
	}

	public void setAuthDataList(List<AuthorityDataListResDto> authDataList) {
		this.authDataList = authDataList;
	}

	public List<AuthorityMenuListResDto> getAuthMenuList() {
		return authMenuList;
	}

	public void setAuthMenuList(List<AuthorityMenuListResDto> authMenuList) {
		this.authMenuList = authMenuList;
	}

	public List<AuthorityProgramListResDto> getAuthProgList() {
		return authProgList;
	}

	public void setAuthProgList(List<AuthorityProgramListResDto> authProgList) {
		this.authProgList = authProgList;
	}

	public List<AuthorityObjectListResDto> getAuthObjList() {
		return authObjList;
	}

	public void setAuthObjList(List<AuthorityObjectListResDto> authObjList) {
		this.authObjList = authObjList;
	}

	public String getAccountOrgId() {
		return accountOrgId;
	}

	public void setAccountOrgId(String accountOrgId) {
		this.accountOrgId = accountOrgId;
	}

	public String getDataTypeCd() {
		return dataTypeCd;
	}

	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}

	public String getAuthDataInValue() {
		return authDataInValue;
	}

	public void setAuthDataInValue(String authDataInValue) {
		this.authDataInValue = authDataInValue;
	}
	
	public void setDefaultValue(AuthorityReqDto req) {
		this.ridUser = req.getRidUser();			//사용자 아이디
		this.empId = req.getEmpId();				//직원 아이디
		this.authGroupId = req.getAuthGroupId();	//권한그룹아이디
		this.accountOrgId = req.getAccountOrgId();	//어카운트ORG아이디
		this.dataTypeCd = req.getDataTypeCd();		//데이터유형코드
		this.ridDivision = req.getRidDivision();	//부서아이디
	}

	public String getAuthDataInQuery() {
		return authDataInQuery;
	}

	public void setAuthDataInQuery(String authDataInQuery) {
		this.authDataInQuery = authDataInQuery;
	}

	public String getRidUser() {
		return ridUser;
	}

	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
	
}
