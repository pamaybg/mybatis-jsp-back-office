package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class OfferCpnPoolListCondResDto extends GridPagingItemResDto {

	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	// 릴레이션
	
	// 기본 필드
	private String mTypeTotCnt;			/* 대량(M) Pool 전체건수 */
	private String mTypeIssueCnt;		/* 대량(M) Pool 발급건수 */
	private String mTypeRemainCnt;		/* 대량(M) Pool 잔여건수 */
	private String sTypeTotCnt;			/* 단건(S) Pool 전체건수 */
	private String sTypeIssueCnt;		/* 단건(S) Pool 발급건수 */
	private String sTypeRemainCnt;		/* 단건(S) Pool 진야건수 */
	
	//getter, setter
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getmTypeTotCnt() {
		return mTypeTotCnt;
	}
	public void setmTypeTotCnt(String mTypeTotCnt) {
		this.mTypeTotCnt = mTypeTotCnt;
	}
	public String getmTypeIssueCnt() {
		return mTypeIssueCnt;
	}
	public void setmTypeIssueCnt(String mTypeIssueCnt) {
		this.mTypeIssueCnt = mTypeIssueCnt;
	}
	public String getmTypeRemainCnt() {
		return mTypeRemainCnt;
	}
	public void setmTypeRemainCnt(String mTypeRemainCnt) {
		this.mTypeRemainCnt = mTypeRemainCnt;
	}
	public String getsTypeTotCnt() {
		return sTypeTotCnt;
	}
	public void setsTypeTotCnt(String sTypeTotCnt) {
		this.sTypeTotCnt = sTypeTotCnt;
	}
	public String getsTypeIssueCnt() {
		return sTypeIssueCnt;
	}
	public void setsTypeIssueCnt(String sTypeIssueCnt) {
		this.sTypeIssueCnt = sTypeIssueCnt;
	}
	public String getsTypeRemainCnt() {
		return sTypeRemainCnt;
	}
	public void setsTypeRemainCnt(String sTypeRemainCnt) {
		this.sTypeRemainCnt = sTypeRemainCnt;
	}
}
