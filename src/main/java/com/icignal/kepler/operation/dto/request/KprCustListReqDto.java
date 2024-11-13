package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprCustListReqDto extends StatusResDto {

	
	private String accntId;
	private String id;
	private String mbrId;
	private String mbrNm;
	private String mbrYn;
	private String age;
	private String gndrCd;
	private String birthDt;
	private String zipcd;
	private String addr1;
	private String addr2;
	private String fstJoinDt;
	private String fstJoinStoreId;
	private String rfmGrdCd;
	private String dmRecvYn;
	private String smsRecvYn;
	private String tmRecvYn;
	private String emailRecvYn;
	private String hpNum;
	private String email;
	private String informMdfDt;
	private String withdrawDt;
	private String empYn;
	private String fstPurDt;
	private String emailPublicYn;
	private String alarmFavSiteYn;
	private String alarmMySiteYn;
	private String alarmJoinSiteYn;
	private String alarmPostReplyYn;
	private String alarmSiteNoticeYn;
	private String mbrSts;
	private String mbrValue;
	private String mbrLc;
	private String mbrGrd;
	private String mbrGrwType;
	private String mbrStsChgDt;
	private Integer mileage;
	private String lstPurDt;
	
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getMbrNm() {
		return mbrNm;
	}
	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}
	public String getMbrYn() {
		return mbrYn;
	}
	public void setMbrYn(String mbrYn) {
		this.mbrYn = mbrYn;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGndrCd() {
		return gndrCd;
	}
	public void setGndrCd(String gndrCd) {
		this.gndrCd = gndrCd;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getZipcd() {
		return zipcd;
	}
	public void setZipcd(String zipcd) {
		this.zipcd = zipcd;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getFstJoinDt() {
		return fstJoinDt;
	}
	public void setFstJoinDt(String fstJoinDt) {
		this.fstJoinDt = fstJoinDt;
	}
	public String getFstJoinStoreId() {
		return fstJoinStoreId;
	}
	public void setFstJoinStoreId(String fstJoinStoreId) {
		this.fstJoinStoreId = fstJoinStoreId;
	}
	public String getRfmGrdCd() {
		return rfmGrdCd;
	}
	public void setRfmGrdCd(String rfmGrdCd) {
		this.rfmGrdCd = rfmGrdCd;
	}
	public String getDmRecvYn() {
		return dmRecvYn;
	}
	public void setDmRecvYn(String dmRecvYn) {
		this.dmRecvYn = dmRecvYn;
	}
	public String getSmsRecvYn() {
		return smsRecvYn;
	}
	public void setSmsRecvYn(String smsRecvYn) {
		this.smsRecvYn = smsRecvYn;
	}
	public String getTmRecvYn() {
		return tmRecvYn;
	}
	public void setTmRecvYn(String tmRecvYn) {
		this.tmRecvYn = tmRecvYn;
	}
	public String getEmailRecvYn() {
		return emailRecvYn;
	}
	public void setEmailRecvYn(String emailRecvYn) {
		this.emailRecvYn = emailRecvYn;
	}
	public String getHpNum() {
		return hpNum;
	}
	public void setHpNum(String hpNum) {
		this.hpNum = hpNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getInformMdfDt() {
		return informMdfDt;
	}
	public void setInformMdfDt(String informMdfDt) {
		this.informMdfDt = informMdfDt;
	}
	public String getWithdrawDt() {
		return withdrawDt;
	}
	public void setWithdrawDt(String withdrawDt) {
		this.withdrawDt = withdrawDt;
	}
	public String getEmpYn() {
		return empYn;
	}
	public void setEmpYn(String empYn) {
		this.empYn = empYn;
	}
	public String getFstPurDt() {
		return fstPurDt;
	}
	public void setFstPurDt(String fstPurDt) {
		this.fstPurDt = fstPurDt;
	}
	public String getEmailPublicYn() {
		return emailPublicYn;
	}
	public void setEmailPublicYn(String emailPublicYn) {
		this.emailPublicYn = emailPublicYn;
	}
	public String getAlarmFavSiteYn() {
		return alarmFavSiteYn;
	}
	public void setAlarmFavSiteYn(String alarmFavSiteYn) {
		this.alarmFavSiteYn = alarmFavSiteYn;
	}
	public String getAlarmMySiteYn() {
		return alarmMySiteYn;
	}
	public void setAlarmMySiteYn(String alarmMySiteYn) {
		this.alarmMySiteYn = alarmMySiteYn;
	}
	public String getAlarmJoinSiteYn() {
		return alarmJoinSiteYn;
	}
	public void setAlarmJoinSiteYn(String alarmJoinSiteYn) {
		this.alarmJoinSiteYn = alarmJoinSiteYn;
	}
	public String getAlarmPostReplyYn() {
		return alarmPostReplyYn;
	}
	public void setAlarmPostReplyYn(String alarmPostReplyYn) {
		this.alarmPostReplyYn = alarmPostReplyYn;
	}
	public String getAlarmSiteNoticeYn() {
		return alarmSiteNoticeYn;
	}
	public void setAlarmSiteNoticeYn(String alarmSiteNoticeYn) {
		this.alarmSiteNoticeYn = alarmSiteNoticeYn;
	}
	public String getMbrSts() {
		return mbrSts;
	}
	public void setMbrSts(String mbrSts) {
		this.mbrSts = mbrSts;
	}
	public String getMbrValue() {
		return mbrValue;
	}
	public void setMbrValue(String mbrValue) {
		this.mbrValue = mbrValue;
	}
	public String getMbrLc() {
		return mbrLc;
	}
	public void setMbrLc(String mbrLc) {
		this.mbrLc = mbrLc;
	}
	public String getMbrGrd() {
		return mbrGrd;
	}
	public void setMbrGrd(String mbrGrd) {
		this.mbrGrd = mbrGrd;
	}
	public String getMbrGrwType() {
		return mbrGrwType;
	}
	public void setMbrGrwType(String mbrGrwType) {
		this.mbrGrwType = mbrGrwType;
	}
	public String getMbrStsChgDt() {
		return mbrStsChgDt;
	}
	public void setMbrStsChgDt(String mbrStsChgDt) {
		this.mbrStsChgDt = mbrStsChgDt;
	}
	public Integer getMileage() {
		return mileage;
	}
	public void setMileage(Integer mileage) {
		this.mileage = mileage;
	}
	public String getLstPurDt() {
		return lstPurDt;
	}
	public void setLstPurDt(String lstPurDt) {
		this.lstPurDt = lstPurDt;
	}
	

}
