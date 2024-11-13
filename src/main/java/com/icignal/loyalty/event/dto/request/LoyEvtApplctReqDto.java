package com.icignal.loyalty.event.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyEvtApplctReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String mbrNo;
	private String eventNo;
	private String rst;
	private String rstCd;
	private String rstmsg;
	private String ridMbr;
	private String uploadValidCheck;
	private String fileName;
	private String eventRid;
	private String bnfYn;
	private String pType;
	private String cipherKey;
	private String eventType;
	private String id;
	private String excelUploadType; // 엑셀 업로드 유형
	private String hhp;
	private String custNm;
	
	private List<LoyEvtApplctReqDto> array;
	
	
	
	
	/*public LoyEvtApplctReqDto() {
		try {
			this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e) {
			LogUtil.error(e);
		}
	}*/
	
	public String getExcelUploadType() {
		return excelUploadType;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public void setExcelUploadType(String excelUploadType) {
		this.excelUploadType = excelUploadType;
	}
	
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getEventNo() {
		return eventNo;
	}

	public void setEventNo(String eventNo) {
		this.eventNo = eventNo;
	}

	public String getRst() {
		return rst;
	}

	public void setRst(String rst) {
		this.rst = rst;
	}

	public String getRstCd() {
		return rstCd;
	}

	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}

	public String getRstmsg() {
		return rstmsg;
	}

	public void setRstmsg(String rstmsg) {
		this.rstmsg = rstmsg;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public List<LoyEvtApplctReqDto> getArray() {
		return array;
	}

	public void setArray(List<LoyEvtApplctReqDto> array) {
		this.array = array;
	}

	public String getEventRid() {
		return eventRid;
	}

	public void setEventRid(String eventRid) {
		this.eventRid = eventRid;
	}

	public String getBnfYn() {
		return bnfYn;
	}

	public void setBnfYn(String bnfYn) {
		this.bnfYn = bnfYn;
	}

	public String getpType() {
		return pType;
	}

	public void setpType(String pType) {
		this.pType = pType;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
}