package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : LOYLoyOfferRelCampaignResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 관계 캠페인 ResponseDTO
 */

@CommCode
public class LoyOfferRelCampaignResDto extends MKTBaseReqDto {

	private String id;               //아이디
	private String dispNo;           //표시 번호
	private String camStatusCd;      //캠페인상태 코드
	@MarkName(groupCode = "MKT_CAM_STAT", codeField = "camStatusCd")
	private String camStatusNm;      //캠페인상태 코드명
	private String camTypeCd;		  //캠페인유형
	@MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "camTypeCd")
	private String camTypeNm;		  //캠페인유형명
	private String camNm;            //캠페인명
	private String camDesc;          //캠페인설명
	private String camStartDd;       //캠페인시작일
	private String camEndDd;         //캠페인종료일
	private String divNm;			  //부서명
	private String createByNm;		  //등록자명
	private String createDate;		  //등록일
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDispNo() {
		return dispNo;
	}

	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}

	public String getCamStatusCd() {
		return camStatusCd;
	}

	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}

	public String getCamStatusNm() {
		return camStatusNm;
	}

	public void setCamStatusNm(String camStatusNm) {
		this.camStatusNm = camStatusNm;
	}

	public String getCamNm() {
		return camNm;
	}

	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}

	public String getCamDesc() {
		return camDesc;
	}

	public void setCamDesc(String camDesc) {
		this.camDesc = camDesc;
	}

	public String getCamStartDd() {
		return camStartDd;
	}

	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}

	public String getCamEndDd() {
		return camEndDd;
	}

	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}

	public String getDivNm() {
		return divNm;
	}

	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCamTypeCd() {
		return camTypeCd;
	}

	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}

	public String getCamTypeNm() {
		return camTypeNm;
	}

	public void setCamTypeNm(String camTypeNm) {
		this.camTypeNm = camTypeNm;
	}

}
