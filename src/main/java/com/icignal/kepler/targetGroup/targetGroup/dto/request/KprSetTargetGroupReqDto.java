package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : com.icignal.kepler.targetGroup.targetGroup.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 ResponseDTO
 */
public class KprSetTargetGroupReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;       //타겟그룹 아이디
    private String accountId;           //어카운트 아이디
    private String createByName;        //등록자명
    private String logicalCompId;       //로지컬컴포넌트 아이디
    private String segFilterId;         //필터 아이디
    private String filterSql;           //필터 SQL
    private String filterSqlCount;		//필터 count SQL	
    private String targetGroupName;     //타겟그룹명
    private String targetGroupDesc;     //타겟그룹 설명
    private String comprGroupTypeCode;  //비교군유형코드
    private String comprGroupDtl;       //비교군상세
    private String dpCond;              //조건
    private String segmentId;           //세그먼트 아이디
    private int cnt;
    private String dbInformId;
    private String impFileNm;
    private String storeId;
    private String type;
    private String extrYn; //비회원여부
    
    private String camId;
    private String targetingHadId;

    private String segmentType;

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getTargetGroupName() {
        return targetGroupName;
    }

    public void setTargetGroupName(String targetGroupName) {
        this.targetGroupName = targetGroupName;
    }

    public String getTargetGroupDesc() {
        return targetGroupDesc;
    }

    public void setTargetGroupDesc(String targetGroupDesc) {
        this.targetGroupDesc = targetGroupDesc;
    }

    public String getComprGroupTypeCode() {
        return comprGroupTypeCode;
    }

    public void setComprGroupTypeCode(String comprGroupTypeCode) {
        this.comprGroupTypeCode = comprGroupTypeCode;
    }

    public String getComprGroupDtl() {
        return comprGroupDtl;
    }

    public void setComprGroupDtl(String comprGroupDtl) {
        this.comprGroupDtl = comprGroupDtl;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getDpCond() {
        return dpCond;
    }

    public void setDpCond(String dpCond) {
        this.dpCond = dpCond;
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getImpFileNm() {
		return impFileNm;
	}

	public void setImpFileNm(String impFileNm) {
		this.impFileNm = impFileNm;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getFilterSqlCount() {
		return filterSqlCount;
	}

	public void setFilterSqlCount(String filterSqlCount) {
		this.filterSqlCount = filterSqlCount;
	}

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getSegmentType() {
		return segmentType;
	}

	public void setSegmentType(String segmentType) {
		this.segmentType = segmentType;
	}

	public String getExtrYn() {
		return extrYn;
	}

	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}


}
