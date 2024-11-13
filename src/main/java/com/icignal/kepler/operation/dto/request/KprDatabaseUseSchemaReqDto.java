package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprDatabaseUseSchemaReqDto extends MKTBaseReqDto {
	private String rId;
	private String databaseId;
	private String schemaName;

	private List<KprDatabaseUseSchemaReqDto> useSchemaList;

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public String getDatabaseId() {
		return databaseId;
	}

	public void setDatabaseId(String databaseId) {
		this.databaseId = databaseId;
	}

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public List<KprDatabaseUseSchemaReqDto> getUseSchemaList() {
		return useSchemaList;
	}

	public void setUseSchemaList(List<KprDatabaseUseSchemaReqDto> useSchemaList) {
		this.useSchemaList = useSchemaList;
	}
}