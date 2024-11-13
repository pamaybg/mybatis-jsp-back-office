package com.icignal.auth.dto.response;

import java.io.Serializable;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @name : MKTDataAuthorityResponseDTO.java
 * @date : 2015. 9. 18.
 * @author : 류동균
 * @description : DATA권한
 */
public class DataAuthResDto extends StatusResDto implements Serializable {

    private static final long serialVersionUID = 7328541405947742788L;
    
    private String id;	
    private String authNum;
    private String authGroupName;
    private String authDataGroupType;
	private String underGrpBaseDeptNum;
	
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getAuthNum() {
        return authNum;
    }
    
    public void setAuthNum(String authNum) {
        this.authNum = authNum;
    }
    
    public String getAuthGroupName() {
        return authGroupName;
    }
    
    public void setAuthGroupName(String authGroupName) {
        this.authGroupName = authGroupName;
    }
    
    public String getAuthDataGroupType() {
        return authDataGroupType;
    }
    
    public void setAuthDataGroupType(String authDataGroupType) {
        this.authDataGroupType = authDataGroupType;
    }
    
    public String getUnderGrpBaseDeptNum() {
        return underGrpBaseDeptNum;
    }
    
    public void setUnderGrpBaseDeptNum(String underGrpBaseDeptNum) {
        this.underGrpBaseDeptNum = underGrpBaseDeptNum;
    }
    
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
	
	
}
