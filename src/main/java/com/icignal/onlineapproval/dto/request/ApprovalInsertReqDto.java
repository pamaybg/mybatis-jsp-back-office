package com.icignal.onlineapproval.dto.request;

import java.util.Date;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalInsertRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전가 결재 추가
 */
public class ApprovalInsertReqDto extends CommonDataAuthReqDto{
    
	private String id;     			   //아이디
	private String accntId;     	   //어카운트ID
	private String elecAprvNo;         //전자결재 번호
	private String elecAprvTypeCd;     //전자결재 유형 코드
	private String elecAprvDivCd;      //전자결재 구분 코드
	private String camId;              //캠페인 아이디
	private String elecAprvTitle;      //전자결재 제목
	private String elecAprvSbst;       //전자결재 내용
	private String elecAprvStatusCd;   //전자결재 상태 코드
	private String elecAprvRqtrId;     //전자결재 요청자 아이디
	private String elecAprvRqtrOrgId;  //전자결재 요청자 조직 아이디
	private Date elecAprvCmpltRqtDd;   //전자결재 완료 요청 일자
	private String lastApvDd;          //최종 승인 일자
	private String lastApvrId;         //최종 승인자 아이디
	private String elecAprvDesc;       //전자결재 설명
	private String atrib_1;            //속성 1
	private String atrib_2;     	   //속성 2
	private String atrib_3;    		   //속성 3
	private String atrib_4;    		   //속성 4
	private String atrib_5;    		   //속성 5
	private String atrib_6;    		   //속성 6
	private String atrib_7;     	   //속성 7
	private String atrib_8;    		   //속성 8
	private String atrib_9;            //속성 9
	private String atrib_10;           //속성 10
	private String memId;              //접속 ID
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getElecAprvNo() {
		return elecAprvNo;
	}
	public void setElecAprvNo(String elecAprvNo) {
		this.elecAprvNo = elecAprvNo;
	}
	public String getElecAprvTypeCd() {
		return elecAprvTypeCd;
	}
	public void setElecAprvTypeCd(String elecAprvTypeCd) {
		this.elecAprvTypeCd = elecAprvTypeCd;
	}
	public String getElecAprvDivCd() {
		return elecAprvDivCd;
	}
	public void setElecAprvDivCd(String elecAprvDivCd) {
		this.elecAprvDivCd = elecAprvDivCd;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getElecAprvTitle() {
		return elecAprvTitle;
	}
	public void setElecAprvTitle(String elecAprvTitle) {
		this.elecAprvTitle = elecAprvTitle;
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
	public String getLastApvDd() {
		return lastApvDd;
	}
	public void setLastApvDd(String lastApvDd) {
		this.lastApvDd = lastApvDd;
	}
	public String getLastApvrId() {
		return lastApvrId;
	}
	public void setLastApvrId(String lastApvrId) {
		this.lastApvrId = lastApvrId;
	}
	public String getElecAprvDesc() {
		return elecAprvDesc;
	}
	public void setElecAprvDesc(String elecAprvDesc) {
		this.elecAprvDesc = elecAprvDesc;
	}
	public String getAtrib_1() {
		return atrib_1;
	}
	public void setAtrib_1(String atrib_1) {
		this.atrib_1 = atrib_1;
	}
	public String getAtrib_2() {
		return atrib_2;
	}
	public void setAtrib_2(String atrib_2) {
		this.atrib_2 = atrib_2;
	}
	public String getAtrib_3() {
		return atrib_3;
	}
	public void setAtrib_3(String atrib_3) {
		this.atrib_3 = atrib_3;
	}
	public String getAtrib_4() {
		return atrib_4;
	}
	public void setAtrib_4(String atrib_4) {
		this.atrib_4 = atrib_4;
	}
	public String getAtrib_5() {
		return atrib_5;
	}
	public void setAtrib_5(String atrib_5) {
		this.atrib_5 = atrib_5;
	}
	public String getAtrib_6() {
		return atrib_6;
	}
	public void setAtrib_6(String atrib_6) {
		this.atrib_6 = atrib_6;
	}
	public String getAtrib_7() {
		return atrib_7;
	}
	public void setAtrib_7(String atrib_7) {
		this.atrib_7 = atrib_7;
	}
	public String getAtrib_8() {
		return atrib_8;
	}
	public void setAtrib_8(String atrib_8) {
		this.atrib_8 = atrib_8;
	}
	public String getAtrib_9() {
		return atrib_9;
	}
	public void setAtrib_9(String atrib_9) {
		this.atrib_9 = atrib_9;
	}
	public String getAtrib_10() {
		return atrib_10;
	}
	public void setAtrib_10(String atrib_10) {
		this.atrib_10 = atrib_10;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Date getElecAprvCmpltRqtDd() {
		return elecAprvCmpltRqtDd;
	}
	public void setElecAprvCmpltRqtDd(Date elecAprvCmpltRqtDd) {
		this.elecAprvCmpltRqtDd = elecAprvCmpltRqtDd;
	}
	
	
	
}
