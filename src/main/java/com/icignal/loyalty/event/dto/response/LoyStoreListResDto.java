package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyStoreListResDto extends GridPagingItemResDto{
	@Decrypted(masked="custNm")
	private String custNm;		//회원명
	
	private String storeNm;		//스토어명
	
	private String chnlNm;		//채널명
	
	private String pntAmt;		//포인트금액
	
	private String txnStatus;	//거래상태
	
	private String txnPntType;	//포인트 거래유형
	
	private String txnDt;		//거래일시
	
	private String rid;			//rid
	
	private String acrlAmt;		//총 적립 포인트
	
	private String rdmAmt;		//총 사용 포인트
	private String storeType;
	
	@Decrypted(masked="hhpNo")
	private String hhpNo;
	private String gender;
	private String age;
	private String benefitNm;
	
	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getRdmAmt() {
		return rdmAmt;
	}
	public void setRdmAmt(String rdmAmt) {
		this.rdmAmt = rdmAmt;
	}
	
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getStoreNm() {
		return storeNm;
	}
	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getTxnStatus() {
		return txnStatus;
	}
	public void setTxnStatus(String txnStatus) {
		this.txnStatus = txnStatus;
	}
	public String getTxnPntType() {
		return txnPntType;
	}
	public void setTxnPntType(String txnPntType) {
		this.txnPntType = txnPntType;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBenefitNm() {
		return benefitNm;
	}
	public void setBenefitNm(String benefitNm) {
		this.benefitNm = benefitNm;
	}
	
	
}
