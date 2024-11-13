package com.icignal.loyalty.promotion.ruleset.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : LOYLoyProdListResponseDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 상품 목록 ResponseDTO
 */
public class LoyProdListResDto extends GridPagingItemResDto {
	private String rid;          //RID
	private String prodId;       //상품 ID
	private String prodNm;       //상품 명
	private String ridChnl;      //RID_CHNL
	private String ridPgm;       //RID_PGM
	private String prodAmt;      //상품금액
	private String ridProdCat;   //RID_PROD_CAT
	private String ridBrdCat;    //RID_BRD_CAT
	private String catId;	     //카테고리 ID
	private String catNm;	     //카테고리명
	private String catDesctxt;   //카테고리 설명

	private String brdRid;     //브랜드 RID
	private String brdId;      //브랜드 ID
	private String brdNm;      //브랜드 명

	private String price;
	private String prodType;
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getBrdRid() {
        return brdRid;
    }

    public void setBrdRid(String brdRid) {
        this.brdRid = brdRid;
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

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
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

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getRidPgm() {
		return ridPgm;
	}

	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	public String getProdAmt() {
		return prodAmt;
	}

	public void setProdAmt(String prodAmt) {
		this.prodAmt = prodAmt;
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

	public String getCatDesctxt() {
		return catDesctxt;
	}

	public void setCatDesctxt(String catDesctxt) {
		this.catDesctxt = catDesctxt;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}


}
