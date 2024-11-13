package com.icignal.systemmanagement.job.dto.request;

import java.util.Date;
import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemTrgrListReqDto extends MKTGridPagingReqDto {

	private String ridJobMst;
	private String rid;
	private String trgrNm;
	private Date startDttm;
	private Date endDttm;
	private String cronExpr;
	private List<String> rids;


	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTrgrNm() {
		return trgrNm;
	}
	public void setTrgrNm(String trgrNm) {
		this.trgrNm = trgrNm;
	}
	public Date getStartDttm() {
		return startDttm;
	}
	public void setStartDttm(Date startDttm) {
		this.startDttm = startDttm;
	}
	public Date getEndDttm() {
		return endDttm;
	}
	public void setEndDttm(Date endDttm) {
		this.endDttm = endDttm;
	}
	public String getCronExpr() {
		return cronExpr;
	}
	public void setCronExpr(String cronExpr) {
		this.cronExpr = cronExpr;
	}
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	
}
