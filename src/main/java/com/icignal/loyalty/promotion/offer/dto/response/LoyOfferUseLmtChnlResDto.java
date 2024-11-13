package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : LOYLoyOfferUseLmtChnlResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 제한채널 ResponseDTO
 */
@CommCode
public class LoyOfferUseLmtChnlResDto extends MKTBaseReqDto {

	private String rid;                     //RID
	private String ridMktOfferMst;          //RID_오퍼마스터
	private String usePsblChnlRange;        //사용 가능 채널 범위
	@MarkName(groupCode = "LOY_CHNL_TYPE_CD", codeField = "usePsblChnlRange")
	private String usePsblChnlRangeNm;      //사용 가능 채널 범위명
	private String usePsblChnlSubRange;     //사용 가능 채널 하위 범위
	@MarkName(groupCode = "LOY_CHNL_SUB_TYPE_CD", codeField = "usePsblChnlSubRange")
	private String usePsblChnlSubRangeNm;   //사용 가능 채널 하위 범위명
	private String ridChnl;                 //RID_CHNL
	private String chnlNo;                  //채널번호
	private String chnlNm;                  //채널명
	private String createDate;              //CREATE_DATE
	private String createByNm;              //CREATE_BY
	
	private String dataStatus;              //수정상태
	private String ouTypeCd;                //가맹점유형
	
    private String parChnlNm;               //상위가맹점명      
    private String stnMgmtDiv;              //충전소관할부서
    @MarkName(groupCode = "POINT_CONTRACT", codeField = "pointContTypeCd")
    private String pointContType;           //포인트계약유형
    private String pointContTypeCd;           //포인트계약유형
	
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

	public String getUsePsblChnlRange() {
		return usePsblChnlRange;
	}

	public void setUsePsblChnlRange(String usePsblChnlRange) {
		this.usePsblChnlRange = usePsblChnlRange;
	}

	public String getUsePsblChnlRangeNm() {
		return usePsblChnlRangeNm;
	}

	public void setUsePsblChnlRangeNm(String usePsblChnlRangeNm) {
		this.usePsblChnlRangeNm = usePsblChnlRangeNm;
	}

	public String getUsePsblChnlSubRange() {
		return usePsblChnlSubRange;
	}

	public void setUsePsblChnlSubRange(String usePsblChnlSubRange) {
		this.usePsblChnlSubRange = usePsblChnlSubRange;
	}

	public String getUsePsblChnlSubRangeNm() {
		return usePsblChnlSubRangeNm;
	}

	public void setUsePsblChnlSubRangeNm(String usePsblChnlSubRangeNm) {
		this.usePsblChnlSubRangeNm = usePsblChnlSubRangeNm;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
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

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

    public String getOuTypeCd() {
        return ouTypeCd;
    }

    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }

    public String getParChnlNm() {
        return parChnlNm;
    }

    public void setParChnlNm(String parChnlNm) {
        this.parChnlNm = parChnlNm;
    }

    public String getStnMgmtDiv() {
        return stnMgmtDiv;
    }

    public void setStnMgmtDiv(String stnMgmtDiv) {
        this.stnMgmtDiv = stnMgmtDiv;
    }

    public String getPointContType() {
        return pointContType;
    }

    public void setPointContType(String pointContType) {
        this.pointContType = pointContType;
    }

	public String getPointContTypeCd() {
		return pointContTypeCd;
	}

	public void setPointContTypeCd(String pointContTypeCd) {
		this.pointContTypeCd = pointContTypeCd;
	}

}
