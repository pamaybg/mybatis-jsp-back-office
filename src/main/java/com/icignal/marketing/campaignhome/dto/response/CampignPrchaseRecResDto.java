package com.icignal.marketing.campaignhome.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
* <pre>
* infavor.marketing.campaignHome.dto.response
*  |_ MKTCampignPrchasRecResponseDTO.java
* </pre>
* @작성일		: 2016. 11. 24. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CampignPrchaseRecResDto extends GridPagingItemResDto {
	
    private String camId;   
    private String camNm;   
    private String camStartDd;   
    private String camEndDd;   
    private Integer testGrp;   
    private Integer ctrlGrp;
    private String camTypeCd;
    
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamStartDd() {
		return camStartDd;
	}
	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}
	public String getCamEndDd() {
		return camEndDd;
	}
	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}
	public Integer getTestGrp() {
		return testGrp;
	}
	public void setTestGrp(Integer testGrp) {
		this.testGrp = testGrp;
	}
	public Integer getCtrlGrp() {
		return ctrlGrp;
	}
	public void setCtrlGrp(Integer ctrlGrp) {
		this.ctrlGrp = ctrlGrp;
	}
	public String getCamTypeCd() {
		return camTypeCd;
	}
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}

}
