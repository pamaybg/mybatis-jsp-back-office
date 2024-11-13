package com.icignal.systemmanagement.responseinfo.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemResponseInfoResDto extends GridPagingItemResDto{
	private String spcfChnlRspnsTypeCd;
	@MarkName(groupCode="MKT_CAM_CHNL_TYPE_CD", codeField="spcfChnlRspnsTypeCd")
	private String spcfChnlRspnsCd;		//적용채널 타입
	private String id;					//아이디
	private String dpSeq;				//노출 순서
	private String parRspnsCd;			//상위 반응코드
	private String parRspnsName;		//상위 반응코드 명
	private String camRspnsCd;			//캠페인 반응 코드
	private String camRspnsNm;			//캠페인 반응명
	
	private String camRspnsDesc;		//설명
	
	private String createBy;    		//등록자
	private String createDate;			//등록일시
	private String modifyBy;			//변경자
	private String modifyDate;			//변경일시
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDpSeq() {
		return dpSeq;
	}
	public void setDpSeq(String dpSeq) {
		this.dpSeq = dpSeq;
	}
	public String getParRspnsCd() {
		return parRspnsCd;
	}
	public void setParRspnsCd(String parRspnsCd) {
		this.parRspnsCd = parRspnsCd;
	}
	public String getCamRspnsCd() {
		return camRspnsCd;
	}
	public void setCamRspnsCd(String camRspnsCd) {
		this.camRspnsCd = camRspnsCd;
	}
	public String getCamRspnsNm() {
		return camRspnsNm;
	}
	public void setCamRspnsNm(String camRspnsNm) {
		this.camRspnsNm = camRspnsNm;
	}
	public String getSpcfChnlRspnsCd() {
		return spcfChnlRspnsCd;
	}
	public void setSpcfChnlRspnsCd(String spcfChnlRspnsCd) {
		this.spcfChnlRspnsCd = spcfChnlRspnsCd;
	}
	public String getCamRspnsDesc() {
		return camRspnsDesc;
	}
	public void setCamRspnsDesc(String camRspnsDesc) {
		this.camRspnsDesc = camRspnsDesc;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getParRspnsName() {
		return parRspnsName;
	}
	public void setParRspnsName(String parRspnsName) {
		this.parRspnsName = parRspnsName;
	}
	public String getSpcfChnlRspnsTypeCd() {
		return spcfChnlRspnsTypeCd;
	}
	public void setSpcfChnlRspnsTypeCd(String spcfChnlRspnsTypeCd) {
		this.spcfChnlRspnsTypeCd = spcfChnlRspnsTypeCd;
	}
	
	
	
}
