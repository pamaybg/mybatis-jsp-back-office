package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class AprvReportRuleResDto extends GridPagingItemResDto {
    
    private String title;
    
    @MarkName(groupCode = "MKT_CAM_NODE_TYPE", codeField = "typeCd")
    private String typeNm;
    private String typeCd;
    private String subInputScrn;
    private String desctxt;
    private String offerNm;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTypeNm() {
        return typeNm;
    }

    public void setTypeNm(String typeNm) {
        this.typeNm = typeNm;
    }

    public String getSubInputScrn() {
        return subInputScrn;
    }

    public void setSubInputScrn(String subInputScrn) {
        this.subInputScrn = subInputScrn;
    }

    public String getDesctxt() {
        return desctxt;
    }

    public void setDesctxt(String desctxt) {
        this.desctxt = desctxt;
    }

    public String getOfferNm() {
        return offerNm;
    }

    public void setOfferNm(String offerNm) {
        this.offerNm = offerNm;
    }

	public String getTypeCd() {
		return typeCd;
	}

	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}

}
