/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.member.mbr.dto.request.LOYMbrVocRequestDTO
* @date : 2017. 10. 20.
* @author : 이성원
* @description :
*/
public class LoyMbrStnPntTxnDetailListReqDto  extends CommonDataAuthReqDto {
    
	
	private String rid;
	private String ridChnl;
	private String cipherKey;
	private String apvNo;
	private String apvDt;
	private String dealDtlType;
	private String cardNo;
	private String occPoint;
	private String usePoint;
	private String dealAftrAvlPoint;
	private String pointExchAprgdsNm;
	private String prodNm;
	

	
	   
    public LoyMbrStnPntTxnDetailListReqDto() {
        //try {
            //this.setCipherKey(CryptoManager.getCipherKey());
       // }
       // catch ( Exception e ) {
       //     LogUtil.error(e);
       // }
    }




	public String getRid() {
		return rid;
	}




	public void setRid(String rid) {
		this.rid = rid;
	}




	public String getCipherKey() {
		return cipherKey;
	}




	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}




	public String getApvNo() {
		return apvNo;
	}




	public void setApvNo(String apvNo) {
		this.apvNo = apvNo;
	}




	public String getApvDt() {
		return apvDt;
	}




	public void setApvDt(String apvDt) {
		this.apvDt = apvDt;
	}




	public String getDealDtlType() {
		return dealDtlType;
	}




	public void setDealDtlType(String dealDtlType) {
		this.dealDtlType = dealDtlType;
	}




	public String getCardNo() {
		return cardNo;
	}




	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}




	public String getOccPoint() {
		return occPoint;
	}




	public void setOccPoint(String occPoint) {
		this.occPoint = occPoint;
	}




	public String getUsePoint() {
		return usePoint;
	}




	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}




	public String getDealAftrAvlPoint() {
		return dealAftrAvlPoint;
	}




	public void setDealAftrAvlPoint(String dealAftrAvlPoint) {
		this.dealAftrAvlPoint = dealAftrAvlPoint;
	}




	public String getPointExchAprgdsNm() {
		return pointExchAprgdsNm;
	}




	public void setPointExchAprgdsNm(String pointExchAprgdsNm) {
		this.pointExchAprgdsNm = pointExchAprgdsNm;
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
    
    
	

	



}
