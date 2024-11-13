package com.icignal.systemmanagement.storeReport.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class StoreReportHistoryResDto extends GridPagingItemResDto {
	private String rid;
	private String createDate;
	private String pgmNm;
	private String name;
	private String userId;

	public String getRid() {return rid;}
	public void setRid(String rid) {this.rid = rid;}
	public String getCreateDate() {return createDate;}
	public void setCreateDate(String createDate) {this.createDate = createDate;}
	public String getUserId() {return userId;}
	public void setUserId(String userId) {this.userId = userId;}
	public String getPgmNm() {return pgmNm;}
	public void setPgmNm(String pgmNm) {this.pgmNm = pgmNm;}
	public String getName() {return name;}
	public void setName(String name) {this.name = name;}



}
