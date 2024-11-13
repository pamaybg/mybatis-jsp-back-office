package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : MKTElapprovalResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 정보 조회
 */
public class ApprovalResDto extends GridPagingItemResDto{

	private String createDate;     		   //생성일시
	private String elecAprvCmpltRqtDd;     //전자결재 완료 요청 일자
	private String lastApvDd;    		   //최종 승인 일자
	private String accntId;     		   //어카운트ID
	private String appServiceType;         //APP 서비스 ID
	private String camId;                  //캠페인 아이디
	private String elecAprvDivCd;    	   //전자결재 구분 코드
	private String elecAprvNo;    		   //전자결재 번호
	private String elecAprvRqtrId;    	   //전자결재 요청자 아이디
	private String elecAprvRqtrOrgId;      //전자결재 요청자 조직 아이디
	private String elecAprvSbst;    	   //전자결재 내용
	private String elecAprvStatusCd;       //전자결재 상태 코드
	private String elecAprvTitle;          //전자결재 제목
	private String elecAprvTypeCd;         //전자결재 유형 코드
	private String id;     				   //아이디
	private String lastApvrId;     		   //최종 승인자 아이디
	private String modifyBy;     		   //수정자
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getElecAprvCmpltRqtDd() {
		return elecAprvCmpltRqtDd;
	}
	public void setElecAprvCmpltRqtDd(String elecAprvCmpltRqtDd) {
		this.elecAprvCmpltRqtDd = elecAprvCmpltRqtDd;
	}
	public String getLastApvDd() {
		return lastApvDd;
	}
	public void setLastApvDd(String lastApvDd) {
		this.lastApvDd = lastApvDd;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getAppServiceType() {
		return appServiceType;
	}
	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getElecAprvDivCd() {
		return elecAprvDivCd;
	}
	public void setElecAprvDivCd(String elecAprvDivCd) {
		this.elecAprvDivCd = elecAprvDivCd;
	}
	public String getElecAprvNo() {
		return elecAprvNo;
	}
	public void setElecAprvNo(String elecAprvNo) {
		this.elecAprvNo = elecAprvNo;
	}
	public String getElecAprvRqtrId() {
		return elecAprvRqtrId;
	}
	public void setElecAprvRqtrId(String elecAprvRqtrId) {
		this.elecAprvRqtrId = elecAprvRqtrId;
	}
	public String getElecAprvRqtrOrgId() {
		return elecAprvRqtrOrgId;
	}
	public void setElecAprvRqtrOrgId(String elecAprvRqtrOrgId) {
		this.elecAprvRqtrOrgId = elecAprvRqtrOrgId;
	}
	public String getElecAprvSbst() {
		return elecAprvSbst;
	}
	public void setElecAprvSbst(String elecAprvSbst) {
		this.elecAprvSbst = elecAprvSbst;
	}
	public String getElecAprvStatusCd() {
		return elecAprvStatusCd;
	}
	public void setElecAprvStatusCd(String elecAprvStatusCd) {
		this.elecAprvStatusCd = elecAprvStatusCd;
	}
	public String getElecAprvTitle() {
		return elecAprvTitle;
	}
	public void setElecAprvTitle(String elecAprvTitle) {
		this.elecAprvTitle = elecAprvTitle;
	}
	public String getElecAprvTypeCd() {
		return elecAprvTypeCd;
	}
	public void setElecAprvTypeCd(String elecAprvTypeCd) {
		this.elecAprvTypeCd = elecAprvTypeCd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLastApvrId() {
		return lastApvrId;
	}
	public void setLastApvrId(String lastApvrId) {
		this.lastApvrId = lastApvrId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	
	
	
}
