package com.icignal.systemmanagement.job.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemJobStepMapperItemResDto extends GridPagingItemResDto {

    private String rid;
    private String itemType;
    private String mapperId;
    private String mapperParam;
    private String mapperDesc;
    private String condExtrApplyYn;
    private Integer condExtrBaseDt;
    private String condExtrStartdt;
    private String condExtrEnddt;
    private String condExtrStartdtBefore;
    private String condExtrEnddtBefore;
    private String condExtrUnit;
    private String modifyBy;
    private String modifyDate;
    private String ridStep;
    private Integer condExtrTerm;
    private List<String> rids;

    public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getMapperId() {
		return mapperId;
	}
	public void setMapperId(String mapperId) {
		this.mapperId = mapperId;
	}
	public String getMapperParam() {
		return mapperParam;
	}
	public void setMapperParam(String mapperParam) {
		this.mapperParam = mapperParam;
	}
	public String getMapperDesc() {
		return mapperDesc;
	}
	public void setMapperDesc(String mapperDesc) {
		this.mapperDesc = mapperDesc;
	}
	public String getCondExtrApplyYn() {
		return condExtrApplyYn;
	}
	public void setCondExtrApplyYn(String condExtrApplyYn) {
		this.condExtrApplyYn = condExtrApplyYn;
	}
	public String getCondExtrStartdt() {
		return condExtrStartdt;
	}
	public void setCondExtrStartdt(String condExtrStartdt) {
		this.condExtrStartdt = condExtrStartdt;
	}
	public String getCondExtrEnddt() {
		return condExtrEnddt;
	}
	public void setCondExtrEnddt(String condExtrEnddt) {
		this.condExtrEnddt = condExtrEnddt;
	}
	public String getCondExtrStartdtBefore() {
		return condExtrStartdtBefore;
	}
	public void setCondExtrStartdtBefore(String condExtrStartdtBefore) {
		this.condExtrStartdtBefore = condExtrStartdtBefore;
	}
	public String getCondExtrEnddtBefore() {
		return condExtrEnddtBefore;
	}
	public void setCondExtrEnddtBefore(String condExtrEnddtBefore) {
		this.condExtrEnddtBefore = condExtrEnddtBefore;
	}
	public String getCondExtrUnit() {
		return condExtrUnit;
	}
	public void setCondExtrUnit(String condExtrUnit) {
		this.condExtrUnit = condExtrUnit;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRidStep() {
		return ridStep;
	}
	public void setRidStep(String ridStep) {
		this.ridStep = ridStep;
	}
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	public Integer getCondExtrBaseDt() {
		return condExtrBaseDt;
	}
	public void setCondExtrBaseDt(Integer condExtrBaseDt) {
		this.condExtrBaseDt = condExtrBaseDt;
	}
	public Integer getCondExtrTerm() {
		return condExtrTerm;
	}
	public void setCondExtrTerm(Integer condExtrTerm) {
		this.condExtrTerm = condExtrTerm;
	}


}

