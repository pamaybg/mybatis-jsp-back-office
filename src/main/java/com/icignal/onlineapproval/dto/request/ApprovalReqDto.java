package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 정보 조회
 */
public class ApprovalReqDto extends CommonDataAuthReqDto{
	private String id;                 //아이디
	private String type;               //유형
	private String elApproveNo;        //전자결재번호
	private String elApproveType;      //전자결제유형
	private String elApproveGbn;       //결제구분
	private String campId;             //캠페인 ID
	private String title;              //결재제목
	private String contents;           //결재내용
	private String elApproveStatus;    //결재상태
	private String requestEmpId;       //결재 상신자 ID
	private String requestEmpDeptId;   //결재상신자 소속부서 ID
	private String requestConfirmDate; //결재완료 요청일자
	private String confirmDate;        //최종 승인일자
	private String confirmEmpId;       //최종 승인자 ID
	private String description;        //설명
	private String attrib1;            //기타필드1
	private String attrib2;            //기타필드2
	private String attrib3;            //기타필드3
	private String attrib4;            //기타필드4
	private String attrib5;            //기타필드5
	private String attrib6;            //기타필드6
	private String attrib7;            //기타필드7
	private String attrib8;            //기타필드8
	private String attrib9;            //기타필드9
	private String attrib10;           //기타필드10
	private String memId;              //접속 ID
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getElApproveNo() {
		return elApproveNo;
	}
	public void setElApproveNo(String elApproveNo) {
		this.elApproveNo = elApproveNo;
	}
	public String getElApproveType() {
		return elApproveType;
	}
	public void setElApproveType(String elApproveType) {
		this.elApproveType = elApproveType;
	}
	public String getElApproveGbn() {
		return elApproveGbn;
	}
	public void setElApproveGbn(String elApproveGbn) {
		this.elApproveGbn = elApproveGbn;
	}
	public String getCampId() {
		return campId;
	}
	public void setCampId(String campId) {
		this.campId = campId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getElApproveStatus() {
		return elApproveStatus;
	}
	public void setElApproveStatus(String elApproveStatus) {
		this.elApproveStatus = elApproveStatus;
	}
	public String getRequestEmpId() {
		return requestEmpId;
	}
	public void setRequestEmpId(String requestEmpId) {
		this.requestEmpId = requestEmpId;
	}
	public String getRequestEmpDeptId() {
		return requestEmpDeptId;
	}
	public void setRequestEmpDeptId(String requestEmpDeptId) {
		this.requestEmpDeptId = requestEmpDeptId;
	}
	public String getRequestConfirmDate() {
		return requestConfirmDate;
	}
	public void setRequestConfirmDate(String requestConfirmDate) {
		this.requestConfirmDate = requestConfirmDate;
	}
	public String getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}
	public String getConfirmEmpId() {
		return confirmEmpId;
	}
	public void setConfirmEmpId(String confirmEmpId) {
		this.confirmEmpId = confirmEmpId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAttrib1() {
		return attrib1;
	}
	public void setAttrib1(String attrib1) {
		this.attrib1 = attrib1;
	}
	public String getAttrib2() {
		return attrib2;
	}
	public void setAttrib2(String attrib2) {
		this.attrib2 = attrib2;
	}
	public String getAttrib3() {
		return attrib3;
	}
	public void setAttrib3(String attrib3) {
		this.attrib3 = attrib3;
	}
	public String getAttrib4() {
		return attrib4;
	}
	public void setAttrib4(String attrib4) {
		this.attrib4 = attrib4;
	}
	public String getAttrib5() {
		return attrib5;
	}
	public void setAttrib5(String attrib5) {
		this.attrib5 = attrib5;
	}
	public String getAttrib6() {
		return attrib6;
	}
	public void setAttrib6(String attrib6) {
		this.attrib6 = attrib6;
	}
	public String getAttrib7() {
		return attrib7;
	}
	public void setAttrib7(String attrib7) {
		this.attrib7 = attrib7;
	}
	public String getAttrib8() {
		return attrib8;
	}
	public void setAttrib8(String attrib8) {
		this.attrib8 = attrib8;
	}
	public String getAttrib9() {
		return attrib9;
	}
	public void setAttrib9(String attrib9) {
		this.attrib9 = attrib9;
	}
	public String getAttrib10() {
		return attrib10;
	}
	public void setAttrib10(String attrib10) {
		this.attrib10 = attrib10;
	}
	
	
	
}
