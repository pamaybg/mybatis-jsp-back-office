package com.icignal.kepler.targetGroup.targetSql.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 타겟 SQL 수정 Request DTO
 *
 * @name : infavor.kepler.targetGroup.dto.request.KPRTargetSqlEditRequestDTO
 * @date : 2018. 4. 18.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlEditReqDto extends CommonDataAuthReqDto {

    private String id;
    private String storeId;
    private String segFilterId;
    private String lgcCompId;
    private String type;
    private String filterSql;
    private String filterSqlCount;
    private String dpCond;
    private String cnt;
    private String comprGroupTypeCd;
    private String comprGroupDtl;
    private String tgtGroupNm;
    private String tgtGroupDesc;
    private String dbInformId;
    private String obj;

    private String targetingHadId;
    private String camId;
    private String extrYn;
    private String cafe24Yn;
    
    
	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public String getTargetingHadId() {
        return targetingHadId;
    }

    public void setTargetingHadId(String targetingHadId) {
        this.targetingHadId = targetingHadId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getLgcCompId() {
        return lgcCompId;
    }

    public void setLgcCompId(String lgcCompId) {
        this.lgcCompId = lgcCompId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getFilterSqlCount() {
        return filterSqlCount;
    }

    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public String getDpCond() {
        return dpCond;
    }

    public void setDpCond(String dpCond) {
        this.dpCond = dpCond;
    }

    public String getCnt() {
        return cnt;
    }

    public void setCnt(String cnt) {
        this.cnt = cnt;
    }

    public String getComprGroupTypeCd() {
        return comprGroupTypeCd;
    }

    public void setComprGroupTypeCd(String comprGroupTypeCd) {
        this.comprGroupTypeCd = comprGroupTypeCd;
    }

    public String getComprGroupDtl() {
        return comprGroupDtl;
    }

    public void setComprGroupDtl(String comprGroupDtl) {
        this.comprGroupDtl = comprGroupDtl;
    }

    public String getDbInformId() {
        return dbInformId;
    }

    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }

    public String getTgtGroupNm() {
        return tgtGroupNm;
    }

    public void setTgtGroupNm(String tgtGroupNm) {
        this.tgtGroupNm = tgtGroupNm;
    }

    public String getTgtGroupDesc() {
        return tgtGroupDesc;
    }

    public void setTgtGroupDesc(String tgtGroupDesc) {
        this.tgtGroupDesc = tgtGroupDesc;
    }

	public String getObj() {
		return obj;
	}

	public void setObj(String obj) {
		this.obj = obj;
	}

	public String getExtrYn() {
		return extrYn;
	}

	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}
	
    public String getCafe24Yn() {
		return cafe24Yn;
	}

	public void setCafe24Yn(String cafe24Yn) {
		this.cafe24Yn = cafe24Yn;
	}

}
