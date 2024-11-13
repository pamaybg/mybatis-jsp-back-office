/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;




/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrRenameResponseDTO
* @date : 2017. 10. 16.
* @author : 이성원
* @description :
*/
/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrRenameResponseDTO
* @date : 2017. 10. 16.
* @author : 이성원
* @description :
*/
public class LoyMbrRenameResDto  extends GridPagingItemResDto {
 
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
	




}
