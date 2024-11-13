package com.icignal.common.base.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyChnlListResDto extends GridPagingItemResDto{
	private String rid;       /*채널 rid*/
	private String chnlNm;    /*채널명*/
	private String chnlNo;    /*채널 번호*/
	@MarkName(groupCode = "LOY_CHNL_TYPE_CD", codeField = "chnlTypeCd")	
	private String chnlTypeCdNm; /*채널유형*/
	private String chnlTypeCd;  /*채널 유형 코드*/
	
	private String parChnlNm;  /*상위 채널명*/
	private String topChnlNm;  /*최상위 채널명*/
	private String topChnlYn;  /*최상위여부*/
	private String pgmNm;      /*프로그램명*/
	private String level;
	private String lslf;
	private String path;
	private String parRid;
	private String dept;
	
	
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getLslf() {
		return lslf;
	}
	public void setLslf(String lslf) {
		this.lslf = lslf;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getParChnlNm() {
		return parChnlNm;
	}
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	public String getTopChnlNm() {
		return topChnlNm;
	}
	public void setTopChnlNm(String topChnlNm) {
		this.topChnlNm = topChnlNm;
	}
	public String getTopChnlYn() {
		return topChnlYn;
	}
	public void setTopChnlYn(String topChnlYn) {
		this.topChnlYn = topChnlYn;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

}
