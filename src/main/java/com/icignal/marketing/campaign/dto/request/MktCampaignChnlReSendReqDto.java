package com.icignal.marketing.campaign.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignChnlReSendReqDto extends MKTBaseReqDto {
	
	private String id;		//회원 상세 아이디
    private String empId;    //직원 아이디
    private String tgtDtlId; //대상 상세 아이디
    private String camId;
    
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getTgtDtlId() {
		return tgtDtlId;
	}
	public void setTgtDtlId(String tgtDtlId) {
		this.tgtDtlId = tgtDtlId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
    
	


}
