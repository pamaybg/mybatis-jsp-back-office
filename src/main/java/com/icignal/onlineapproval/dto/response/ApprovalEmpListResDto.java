package com.icignal.onlineapproval.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : MKTElpprovalEmpListResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결재 승인자 목록 조회
 */

@PersonalData
public class ApprovalEmpListResDto extends GridPagingItemResDto {
    
	private String id;           //아이디
	private String empNm;        //직원 명
	
	@Decrypted(masked = "email")
	private String email;        //이메일
	private String accNm;        //부서명
	private String paraccId;     //상위 부서Id
	private String paraccNM;     //상위 부서명 
	private String acId;         //어카운트 Id

	private String empType;
	private String divRid;
	private String divNo;
	
	public String getParaccId() {
        return paraccId;
    }
    public void setParaccId(String paraccId) {
        this.paraccId = paraccId;
    }
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
	public String getEmpType() {return empType;}
	public void setEmpType(String empType) {this.empType = empType;}
	public String getDivRid() {return divRid;}
	public void setDivRid(String divRid) {this.divRid = divRid;}
	public String getDivNo() {return divNo;}
	public void setDivNo(String divNo) {this.divNo = divNo;}
}
