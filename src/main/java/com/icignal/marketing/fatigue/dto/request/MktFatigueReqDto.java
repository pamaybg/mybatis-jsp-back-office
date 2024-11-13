package com.icignal.marketing.fatigue.dto.request;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.marketing.fatigue.dto.request
 * @date : 2015. 11. 30.
 * @author : 안형욱
 * @description : 피로도 마스터 
 */
public class MktFatigueReqDto extends CommonDataAuthReqDto {
	
	private String accountId;			//회사아이디
	private String rid;
	private String fatigueChnlItemRid;
	private String id;
	private String ridFati;
	private String chnlTypeCd;
	private String fatiItemState;
	private String fatiItemRestrictionDay;
	private String fatiItemMaxRestrictionDayCnt;

	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	@Override
	public String getRid() {
		return rid;
	}

	@Override
	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getFatigueChnlItemRid() {
		return fatigueChnlItemRid;
	}

	public void setFatigueChnlItemRid(String fatigueChnlItemRid) {
		this.fatigueChnlItemRid = fatigueChnlItemRid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRidFati() {
		return ridFati;
	}

	public void setRidFati(String ridFati) {
		this.ridFati = ridFati;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getFatiItemState() {
		return fatiItemState;
	}

	public void setFatiItemState(String fatiItemState) {
		this.fatiItemState = fatiItemState;
	}

	public String getFatiItemRestrictionDay() {
		return fatiItemRestrictionDay;
	}

	public void setFatiItemRestrictionDay(String fatiItemRestrictionDay) {
		this.fatiItemRestrictionDay = fatiItemRestrictionDay;
	}

	public String getFatiItemMaxRestrictionDayCnt() {
		return fatiItemMaxRestrictionDayCnt;
	}

	public void setFatiItemMaxRestrictionDayCnt(String fatiItemMaxRestrictionDayCnt) {
		this.fatiItemMaxRestrictionDayCnt = fatiItemMaxRestrictionDayCnt;
	}

}
