package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGetOfferReqDto extends CommonDataAuthReqDto{

	private String offerid;
	private String memId;
	private String rid;
	private String ridMktOfferMst;       //RID_오퍼마스터
	private String validStartdtBasCd;    //유효 시작일 기준 코드
	private String validStartDtnum;      //유효 시작 일수
	private String validEndDtnum;        //유효 종료 일수
	private String rdmSeq;               //차감 순서
	private String usePsblChnlRange;        //사용 가능 채널 범위
	private String usePsblChnlSubRange;     //사용 가능 채널 하위 범위
	private String ridChnl;                 //RID_CHNL
	private String basGrpCd;            //기준 그룹 코드
	private String usePsblProdRange;    //사용 가능 상품 범위
	private String ridProdCat;          //RID_상품카테고리
	private String ridBrdCat;           //LOY_BRD_CATEGORY 테이블 FK
	private String ridProd;             //RID_상품
	private String id;
	private String dataStatus = "N";		//데이터 상태(일부에서만 사용) 기본 N
	
	
	public String getOfferid() {
		return offerid;
	}
	public void setOfferid(String offerid) {
		this.offerid = offerid;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
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
	public String getUsePsblChnlRange() {
		return usePsblChnlRange;
	}
	public void setUsePsblChnlRange(String usePsblChnlRange) {
		this.usePsblChnlRange = usePsblChnlRange;
	}
	public String getUsePsblChnlSubRange() {
		return usePsblChnlSubRange;
	}
	public void setUsePsblChnlSubRange(String usePsblChnlSubRange) {
		this.usePsblChnlSubRange = usePsblChnlSubRange;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getBasGrpCd() {
		return basGrpCd;
	}
	public void setBasGrpCd(String basGrpCd) {
		this.basGrpCd = basGrpCd;
	}
	public String getUsePsblProdRange() {
		return usePsblProdRange;
	}
	public void setUsePsblProdRange(String usePsblProdRange) {
		this.usePsblProdRange = usePsblProdRange;
	}
	public String getRidProdCat() {
		return ridProdCat;
	}
	public void setRidProdCat(String ridProdCat) {
		this.ridProdCat = ridProdCat;
	}
	public String getRidBrdCat() {
		return ridBrdCat;
	}
	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}
	public String getRidProd() {
		return ridProd;
	}
	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDataStatus() {
		return dataStatus;
	}
	public void setDataStatus(String dataStatus) {
		this.dataStatus = dataStatus;
	}
	
	
}
