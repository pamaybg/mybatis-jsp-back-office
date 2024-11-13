package com.icignal.kepler.targetGroup.targetSimple.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListNewSaveDataReqDto extends MKTBaseReqDto {
	private String dbInfo;
	private String lgcFldId;
	private String compOper;
	private String compVal;
	private String targetGroupId;
	private String tblAliasColNm;		 //테이블 alias.컬럼명
	private String lcLogicOper;
	private String dataTypeCd;
	private String sumYn;
	private String id;
	private String mainShopCd;
	
	
	public String getDataTypeCd() {
		return dataTypeCd;
	}
	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}
	public String getLgcFldId() {
		return lgcFldId;
	}
	public void setLgcFldId(String lgcFldId) {
		this.lgcFldId = lgcFldId;
	}
	public String getCompOper() {
		return compOper;
	}
	public void setCompOper(String compOper) {
		this.compOper = compOper;
	}
	public String getCompVal() {
		return compVal;
	}
	public void setCompVal(String compVal) {
		this.compVal = compVal;
	}
	public String getDbInfo() {
		return dbInfo;
	}
	public void setDbInfo(String dbInfo) {
		this.dbInfo = dbInfo;
	}

	public String getTargetGroupId() {
		return targetGroupId;
	}
	public void setTargetGroupId(String targetGroupId) {
		this.targetGroupId = targetGroupId;
	}
	public String getTblAliasColNm() {
		return tblAliasColNm;
	}
	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}
	public String getLcLogicOper() {
		return lcLogicOper;
	}
	public void setLcLogicOper(String lcLogicOper) {
		this.lcLogicOper = lcLogicOper;
	}

	public String getSumYn() {
		return sumYn;
	}

	public void setSumYn(String sumYn) {
		this.sumYn = sumYn;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMainShopCd() {
		return mainShopCd;
	}

	public void setMainShopCd(String mainShopCd) {
		this.mainShopCd = mainShopCd;
	}
}
