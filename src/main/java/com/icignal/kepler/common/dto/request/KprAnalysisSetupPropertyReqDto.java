package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRAnalysisSetupPropertyRequestDTO
 * 2. 파일명	: KPRAnalysisSetupPropertyRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisSetupPropertyReqDto extends MKTBaseReqDto {
	
	private String rptId;
	private String promptTypeCd;
	private String atribGroupColId;
	private String promptId;
	private String tblPromptNm;
	private String tblRptMstNm;
	private String tblColumnNm;
	private String instFlag;

	public String getRptId() {
		return rptId;
	}

	public void setRptId(String rptId) {
		this.rptId = rptId;
	}

	public String getPromptTypeCd() {
		return promptTypeCd;
	}

	public void setPromptTypeCd(String promptTypeCd) {
		this.promptTypeCd = promptTypeCd;
	}

	public String getAtribGroupColId() {
		return atribGroupColId;
	}

	public void setAtribGroupColId(String atribGroupColId) {
		this.atribGroupColId = atribGroupColId;
	}

	public String getPromptId() {
		return promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getTblPromptNm() {
		return tblPromptNm;
	}

	public void setTblPromptNm(String tblPromptNm) {
		this.tblPromptNm = tblPromptNm;
	}

	public String getTblRptMstNm() {
		return tblRptMstNm;
	}

	public void setTblRptMstNm(String tblRptMstNm) {
		this.tblRptMstNm = tblRptMstNm;
	}

	public String getTblColumnNm() {
		return tblColumnNm;
	}

	public void setTblColumnNm(String tblColumnNm) {
		this.tblColumnNm = tblColumnNm;
	}

	public String getInstFlag() {
		return instFlag;
	}

	public void setInstFlag(String instFlag) {
		this.instFlag = instFlag;
	}
}