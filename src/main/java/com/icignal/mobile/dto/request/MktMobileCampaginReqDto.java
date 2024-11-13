package com.icignal.mobile.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktMobileCampaginReqDto extends CommonDataAuthReqDto {
	
	private String memId;			//결제자아이디
	private String elecAprvId;		//전자결제아이디
	private String rejectDesc;		//반려사유
	private String seq;				//전자결제순서
	private String apvrTypeCd;		//결재순서 타입
	private String recordRid;		//캠페인ID
	private String itemId;          //선택한 RowId
	private String camNm;			//캠페인 이름
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getElecAprvId() {
		return elecAprvId;
	}

	public void setElecAprvId(String elecAprvId) {
		this.elecAprvId = elecAprvId;
	}

	public String getRejectDesc() {
		return rejectDesc;
	}

	public void setRejectDesc(String rejectDesc) {
		this.rejectDesc = rejectDesc;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getApvrTypeCd() {
		return apvrTypeCd;
	}

	public void setApvrTypeCd(String apvrTypeCd) {
		this.apvrTypeCd = apvrTypeCd;
	}

	public String getRecordRid() {
		return recordRid;
	}

	public void setRecordRid(String recordRid) {
		this.recordRid = recordRid;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getCamNm() {
		return camNm;
	}

	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
}
