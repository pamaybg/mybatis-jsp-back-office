package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.response;
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : et 인터랙션 유형 목록
 */
public class MktETIntactTypeListResDto extends GridPagingItemResDto {
	
	private String rid;                  //RID
	private String ridPgm;               //RID_PGM
	private String intactType_1Cd;       //인터랙션 유형 1 코드
	private String intactType_1CdNm;     //인터랙션 유형 1 코드명
	private String intactType_2Cd;       //인터랙션 유형 2 코드
	private String intactType_2CdNm;     //인터랙션 유형 2 코드명
	private String saveTblNm;            //저장 테이블 명
	private String lgclCmpntIdIntact;    //로지컬 컴포넌트 ID_인터랙션
	private String lgclCmpntIdMbr;       //로지컬 컴포넌트 ID_회원
	private String lgclCmpntIdCam;       //로지컬 컴포넌트 ID_캠페인
	private String createDate;           //등록일자
	private String createByNm;           //등록자명

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidPgm() {
		return ridPgm;
	}

	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	public String getIntactType_1Cd() {
		return intactType_1Cd;
	}

	public void setIntactType_1Cd(String intactType_1Cd) {
		this.intactType_1Cd = intactType_1Cd;
	}

	public String getIntactType_1CdNm() {
		return intactType_1CdNm;
	}

	public void setIntactType_1CdNm(String intactType_1CdNm) {
		this.intactType_1CdNm = intactType_1CdNm;
	}

	public String getIntactType_2Cd() {
		return intactType_2Cd;
	}

	public void setIntactType_2Cd(String intactType_2Cd) {
		this.intactType_2Cd = intactType_2Cd;
	}

	public String getIntactType_2CdNm() {
		return intactType_2CdNm;
	}

	public void setIntactType_2CdNm(String intactType_2CdNm) {
		this.intactType_2CdNm = intactType_2CdNm;
	}

	public String getSaveTblNm() {
		return saveTblNm;
	}

	public void setSaveTblNm(String saveTblNm) {
		this.saveTblNm = saveTblNm;
	}

	public String getLgclCmpntIdIntact() {
		return lgclCmpntIdIntact;
	}

	public void setLgclCmpntIdIntact(String lgclCmpntIdIntact) {
		this.lgclCmpntIdIntact = lgclCmpntIdIntact;
	}

	public String getLgclCmpntIdMbr() {
		return lgclCmpntIdMbr;
	}

	public void setLgclCmpntIdMbr(String lgclCmpntIdMbr) {
		this.lgclCmpntIdMbr = lgclCmpntIdMbr;
	}

	public String getLgclCmpntIdCam() {
		return lgclCmpntIdCam;
	}

	public void setLgclCmpntIdCam(String lgclCmpntIdCam) {
		this.lgclCmpntIdCam = lgclCmpntIdCam;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}
	
}
