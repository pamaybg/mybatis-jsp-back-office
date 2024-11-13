package com.icignal.loyalty.promotion.campaign.dto.response;


import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.loyalty.promotion.campaign.dto.request.CheckerListResDto;

public class CampaignSegmentListResponseDTO extends GridPagingItemResDto{
	
	private String empId;
	
	private String camId;
	private String camTgtHadId;
	private String segId;
	private String tempId;
	private String sqlContent;
	
    private String dbCode;
    private String driverClassName;
    private String url;
    private String userName;
    private String password;
    
    private String exeInfoItemId;
    private String fatiExceptYn;
    
    private List<String> memberList;
    
    private List<CheckerListResDto> chkedMemList;
    
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
    public String getSegId() {
        return segId;
    }
    public void setSegId(String segId) {
        this.segId = segId;
    }
    public String getTempId() {
        return tempId;
    }
    public void setTempId(String tempId) {
        this.tempId = tempId;
    }
    public String getDbCode() {
        return dbCode;
    }
    public void setDbCode(String dbCode) {
        this.dbCode = dbCode;
    }
    public String getDriverClassName() {
        return driverClassName;
    }
    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getSqlContent() {
        return sqlContent;
    }
    public void setSqlContent(String sqlContent) {
        this.sqlContent = sqlContent;
    }
    public String getCamTgtHadId() {
        return camTgtHadId;
    }
    public void setCamTgtHadId(String camTgtHadId) {
        this.camTgtHadId = camTgtHadId;
    }
    public List<String> getMemberList() {
        return memberList;
    }
    public void setMemberList(List<String> memberList) {
        this.memberList = memberList;
    }
    public String getExeInfoItemId() {
        return exeInfoItemId;
    }
    public void setExeInfoItemId(String exeInfoItemId) {
        this.exeInfoItemId = exeInfoItemId;
    }
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public List<CheckerListResDto> getChkedMemList() {
		return chkedMemList;
	}
	public void setChkedMemList(List<CheckerListResDto> chkedMemList) {
		this.chkedMemList = chkedMemList;
	}
	public String getFatiExceptYn() {
		return fatiExceptYn;
	}
	public void setFatiExceptYn(String fatiExceptYn) {
		this.fatiExceptYn = fatiExceptYn;
	}
}


