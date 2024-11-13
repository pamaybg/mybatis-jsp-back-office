package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrPasswordRequestDTO
 * @date : 2017. 7. 18.
 * @author : jh.kim
 * @description : 로얄티 프로그램 회원 비밀번호 관리 Request DTO
 */
public class LoyEmpSearchHelpReqDto extends CommonDataAuthReqDto {
    
    private String rid;
    private String name;
    private String userId;
    private String divNm;
    private String cipherKey;
    private String authNm;
    
    
    public LoyEmpSearchHelpReqDto() {
       /* try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }
    
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String getUserId() {
		return userId;
	}

	@Override
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDivNm() {
		return divNm;
	}

	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}

	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public String getAuthNm() {
		return authNm;
	}

	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
    
    
    
    
    
}
