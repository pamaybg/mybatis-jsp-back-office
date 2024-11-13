package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : 테이블 고급설정 수정 RequestDTO
 */
public class KprEditTableAdvanceReqDto extends CommonDataAuthReqDto {
	
    private String tableId;    		//테이블 아이디
    private String modifyBy;     	//수정자
    
	private Integer pctfree; 		//PCTFREE
	private Integer initrans; 		//INITRANS
	private Integer maxtrans; 		//MAXTRANS
	private Integer initial; 			//INITIAL
	private Integer next; 			//NEXT
	private Integer minextents; 	//MINEXTENTS
	
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public Integer getPctfree() {
		return pctfree;
	}
	public void setPctfree(Integer pctfree) {
		this.pctfree = pctfree;
	}
	public Integer getInitrans() {
		return initrans;
	}
	public void setInitrans(Integer initrans) {
		this.initrans = initrans;
	}
	public Integer getMaxtrans() {
		return maxtrans;
	}
	public void setMaxtrans(Integer maxtrans) {
		this.maxtrans = maxtrans;
	}
	public Integer getInitial() {
		return initial;
	}
	public void setInitial(Integer initial) {
		this.initial = initial;
	}
	public Integer getNext() {
		return next;
	}
	public void setNext(Integer next) {
		this.next = next;
	}
	public Integer getMinextents() {
		return minextents;
	}
	public void setMinextents(Integer minextents) {
		this.minextents = minextents;
	}
	
	
}
