/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrRenameRequestDTO
* @date : 2017. 10. 16.
* @author : 이성원
* @description :
*/
public class LoyMbrRenameReqDto  extends CommonDataAuthReqDto {
	/** RID */
	private String rid;
	private String createDate;
	private String mbrNo;
	private String oldName;
	private String remark;
	private String newName;
	private String pinNo;
	private String renmYn;
	private String modifyDate;
	private String empName;
	private String ridMbr;


	private String mypinNum;
	private String name;
	private String birthDay;
	private String sex;
	private String serviceNo;
	private String tranSerialNum;
	private String mobileCertiSeq;
	private String certiSeq;
	private String certiNo;
	private String smsendSeq;
	private String foreignFlg;
	private String telecomCode;
	private String mobile;

	private String prevCustNm;
	private String rmark;



	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public String getPinNo() {
		return pinNo;
	}
	public void setPinNo(String pinNo) {
		this.pinNo = pinNo;
	}
	public String getRenmYn() {
		return renmYn;
	}
	public void setRenmYn(String renmYn) {
		this.renmYn = renmYn;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	/**
	* @return the mypinNum
	*/
	public String getMypinNum() {
		return mypinNum;
	}
	/**
	* @param mypinNum the mypinNum to set
	*/
	public void setMypinNum(String mypinNum) {
		this.mypinNum = mypinNum;
	}
	/**
	* @return the name
	*/
	public String getName() {
		return name;
	}
	/**
	* @param name the name to set
	*/
	public void setName(String name) {
		this.name = name;
	}
	/**
	* @return the birthDay
	*/
	public String getBirthDay() {
		return birthDay;
	}
	/**
	* @param birthDay the birthDay to set
	*/
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	/**
	* @return the sex
	*/
	public String getSex() {
		return sex;
	}
	/**
	* @param sex the sex to set
	*/
	public void setSex(String sex) {
		this.sex = sex;
	}
	/**
	* @return the serviceNo
	*/
	public String getServiceNo() {
		return serviceNo;
	}
	/**
	* @param serviceNo the serviceNo to set
	*/
	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}
	/**
	* @return the tranSerialNum
	*/
	public String getTranSerialNum() {
		return tranSerialNum;
	}
	/**
	* @param tranSerialNum the tranSerialNum to set
	*/
	public void setTranSerialNum(String tranSerialNum) {
		this.tranSerialNum = tranSerialNum;
	}
	/**
	* @return the mobileCertiSeq
	*/
	public String getMobileCertiSeq() {
		return mobileCertiSeq;
	}
	/**
	* @param mobileCertiSeq the mobileCertiSeq to set
	*/
	public void setMobileCertiSeq(String mobileCertiSeq) {
		this.mobileCertiSeq = mobileCertiSeq;
	}
	/**
	* @return the certiSeq
	*/
	public String getCertiSeq() {
		return certiSeq;
	}
	/**
	* @param certiSeq the certiSeq to set
	*/
	public void setCertiSeq(String certiSeq) {
		this.certiSeq = certiSeq;
	}
	/**
	* @return the certiNo
	*/
	public String getCertiNo() {
		return certiNo;
	}
	/**
	* @param certiNo the certiNo to set
	*/
	public void setCertiNo(String certiNo) {
		this.certiNo = certiNo;
	}
	/**
	* @return the smsendSeq
	*/
	public String getSmsendSeq() {
		return smsendSeq;
	}
	/**
	* @param smsendSeq the smsendSeq to set
	*/
	public void setSmsendSeq(String smsendSeq) {
		this.smsendSeq = smsendSeq;
	}
	/**
	* @return the foreignFlg
	*/
	public String getForeignFlg() {
		return foreignFlg;
	}
	/**
	* @param foreignFlg the foreignFlg to set
	*/
	public void setForeignFlg(String foreignFlg) {
		this.foreignFlg = foreignFlg;
	}
	/**
	* @return the telecomCode
	*/
	public String getTelecomCode() {
		return telecomCode;
	}
	/**
	* @param telecomCode the telecomCode to set
	*/
	public void setTelecomCode(String telecomCode) {
		this.telecomCode = telecomCode;
	}
	/**
	* @return the mobile
	*/
	public String getMobile() {
		return mobile;
	}
	/**
	* @param mobile the mobile to set
	*/
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPrevCustNm() {
		return prevCustNm;
	}
	public void setPrevCustNm(String prevCustNm) {
		this.prevCustNm = prevCustNm;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}









}
