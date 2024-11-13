package com.icignal.onlineapproval.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTElpprovalEmpResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결재 승인자 정보 조회
 */
public class ApprovalEmpResDto extends GridPagingItemResDto{
	private String id;           //아이디
	private String empNm;        //직원 명
	private String email;        //이메일
	private String accNm;        //부서명
	private String paraccNM;     //상위 부서명 
	private String acId;         //어카운트 Id
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAccNm() {
		return accNm;
	}
	public void setAccNm(String accNm) {
		this.accNm = accNm;
	}
	public String getParaccNM() {
		return paraccNM;
	}
	public void setParaccNM(String paraccNM) {
		this.paraccNM = paraccNM;
	}
	public String getAcId() {
		return acId;
	}
	public void setAcId(String acId) {
		this.acId = acId;
	}
	
	

	
}
