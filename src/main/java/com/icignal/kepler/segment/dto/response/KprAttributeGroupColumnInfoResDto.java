package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 속성그룹 컬럼 정보 ResponseDTO
 */
public class KprAttributeGroupColumnInfoResDto extends GridPagingItemResDto {
	
	private String atribGroupColId;    //어트리뷰트 컬럼 아이디
	private String valueSql;           //값 SQL
	private String logicalCompId;      //로지컬컴포넌트 아이디 
	private String selValueSql;
	private String colValue;

    public String getSelValueSql() {
		return selValueSql;
	}

	public void setSelValueSql(String selValueSql) {
		this.selValueSql = selValueSql;
	}

	public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
    }

    public String getValueSql() {
        return valueSql;
    }

    public void setValueSql(String valueSql) {
        this.valueSql = valueSql;
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

	public String getColValue() {
		return colValue;
	}
	public void setColValue(String colValue) {
		this.colValue = colValue;
	}
	


}
