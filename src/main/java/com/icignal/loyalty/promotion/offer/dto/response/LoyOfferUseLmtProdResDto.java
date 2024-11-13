package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : LOYLoyOfferUseLmtProdResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 제한모델 ResponseDTO
 */
@CommCode
public class LoyOfferUseLmtProdResDto extends MKTBaseReqDto {

    private String rid;                 //RID
    private String ridMktOfferMst;      //RID_오퍼마스터
    private String basGrpCd;            //기준 그룹 코드
    @MarkName(groupCode = "LOY_BAS_GRP_CD", codeField = "basGrpCd")
    private String basGrpNm;            //기준 그룹 코드명
    private String usePsblProdRange;    //사용 가능 상품 범위
    private String ridBrdCat;           //RID 브랜드 카테고리
    private String brdId;               //브랜드 카테고리아이디
    private String brdNm;               //브랜드 카테고리명
    private String ridProdCat;          //RID_상품카테고리
    private String catId;               //상품카테고리 아이디
    private String catNm;               //상품카테고리명
    private String ridProd;             //RID_상품
    private String prodId;              //상품아이디
    private String prodNm;              //상품명
    private String createDate;          //CREATE_DATE
    private String createByNm;          //CREATE_BY

    private String posProdCnt;          //POS상품수량
    private String posProdCd;           //POS상품코드
    private String posBcodeNo;          //POS바코드번호
    private String posChnlCd;			//POS공급업체코드
    private String posProdAmt;			//POS원가
    
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

	public String getBasGrpCd() {
		return basGrpCd;
	}

	public void setBasGrpCd(String basGrpCd) {
		this.basGrpCd = basGrpCd;
	}

	public String getBasGrpNm() {
		return basGrpNm;
	}

	public void setBasGrpNm(String basGrpNm) {
		this.basGrpNm = basGrpNm;
	}

	public String getUsePsblProdRange() {
		return usePsblProdRange;
	}

	public void setUsePsblProdRange(String usePsblProdRange) {
		this.usePsblProdRange = usePsblProdRange;
	}

	public String getRidBrdCat() {
		return ridBrdCat;
	}

	public void setRidBrdCat(String ridBrdCat) {
		this.ridBrdCat = ridBrdCat;
	}

	public String getBrdId() {
		return brdId;
	}

	public void setBrdId(String brdId) {
		this.brdId = brdId;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getRidProdCat() {
		return ridProdCat;
	}

	public void setRidProdCat(String ridProdCat) {
		this.ridProdCat = ridProdCat;
	}

	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

	public String getCatNm() {
		return catNm;
	}

	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}

	public String getRidProd() {
		return ridProd;
	}

	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getProdNm() {
		return prodNm;
	}

	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
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

    public String getPosProdCnt() {
        return posProdCnt;
    }

    public void setPosProdCnt(String posProdCnt) {
        this.posProdCnt = posProdCnt;
    }

    public String getPosProdCd() {
        return posProdCd;
    }

    public void setPosProdCd(String posProdCd) {
        this.posProdCd = posProdCd;
    }

    public String getPosBcodeNo() {
        return posBcodeNo;
    }

    public void setPosBcodeNo(String posBcodeNo) {
        this.posBcodeNo = posBcodeNo;
    }

	public String getPosChnlCd() {
		return posChnlCd;
	}

	public void setPosChnlCd(String posChnlCd) {
		this.posChnlCd = posChnlCd;
	}

	public String getPosProdAmt() {
		return posProdAmt;
	}

	public void setPosProdAmt(String posProdAmt) {
		this.posProdAmt = posProdAmt;
	}
}
