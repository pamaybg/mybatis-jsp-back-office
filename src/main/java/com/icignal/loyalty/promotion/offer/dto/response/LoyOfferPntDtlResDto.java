package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : LOYLoyOfferPntDtlResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 포인트 ResponseDTO
 */
@CommCode
public class LoyOfferPntDtlResDto extends MKTBaseReqDto {

	private String rid;                  //RID
	private String ridMktOfferMst;       //RID_오퍼마스터
	private String validStartdtBasCd;    //유효 시작일 기준 코드
	@MarkName(groupCode = "LOY_VALID_STARTDT_BAS_CD", codeField = "validStartdtBasCd")
	private String validStartdtBasNm;    //유효 시작일 기준 코드명
	private String validStartDtnum;      //유효 시작 일수
	private String validEndDtnum;        //유효 종료 일수
	private String rdmSeq;               //차감 순서
	private String createDate;           //CREATE_DATE
	private String createByNm;             //CREATE_BY
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidMktOfferMst() {
		return ridMktOfferMst;
	}

	public void setRidMktOfferMst(String ridMktOfferMst) {
		this.ridMktOfferMst = ridMktOfferMst;
	}

	public String getValidStartdtBasCd() {
		return validStartdtBasCd;
	}

	public void setValidStartdtBasCd(String validStartdtBasCd) {
		this.validStartdtBasCd = validStartdtBasCd;
	}

	public String getValidStartdtBasNm() {
		return validStartdtBasNm;
	}

	public void setValidStartdtBasNm(String validStartdtBasNm) {
		this.validStartdtBasNm = validStartdtBasNm;
	}

	public String getValidStartDtnum() {
		return validStartDtnum;
	}

	public void setValidStartDtnum(String validStartDtnum) {
		this.validStartDtnum = validStartDtnum;
	}

	public String getValidEndDtnum() {
		return validEndDtnum;
	}

	public void setValidEndDtnum(String validEndDtnum) {
		this.validEndDtnum = validEndDtnum;
	}

	public String getRdmSeq() {
		return rdmSeq;
	}

	public void setRdmSeq(String rdmSeq) {
		this.rdmSeq = rdmSeq;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

}
