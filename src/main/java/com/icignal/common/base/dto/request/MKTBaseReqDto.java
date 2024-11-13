package com.icignal.common.base.dto.request;

import java.util.HashMap;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.util.ObjectUtil;

/**
 * @file MKTBaseRequestDTO.java
 * @date 2016.06.19
 * @author 류동균
 */
public class MKTBaseReqDto extends BaseReqDto {
	
	private String comSchemas;

	private String createBy;		//등록자
	private String modifyBy;		//수정자
	private String LoyProgramId;	//로얄티 프로그램 아디디
	private String LoyProgramNo;	//로얄티 프로그램 번호
	private String loginMethod;
	private String sendchnl;
	private String authEmailCheck;

    /**
     * 데이터 상태
     * N : Normal
     * I : Insert
     * U : Update
     * D : Delete
     */
	private String dataStatus = "N";		//데이터 상태(일부에서만 사용) 기본 N

	private String tokenId;


	public void setLoginInfo(LoginResDto loginInfo) {
		if (ObjectUtil.isNotEmpty(loginInfo)) {
			this.createBy = loginInfo.getId();
			this.modifyBy = loginInfo.getId();
			this.LoyProgramId = loginInfo.getLoyProgramId();
			this.LoyProgramNo = loginInfo.getLoyProgramNo();
		}
	}

	public String getComSchemas() {
		comSchemas =  "com";
		return comSchemas;
	}

	public void setComSchemas(String comSchemas) {
		this.comSchemas = comSchemas;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getLoyProgramId() {
		return LoyProgramId;
	}

	public void setLoyProgramId(String LoyProgramId) {
		this.LoyProgramId = LoyProgramId;
	}

	/**
	 * @name : getSystemColumn
	 * @date : 2016. 11. 17.
	 * @author : dg.ryu
	 * @return : HashMap<String, String>
	 * @description : BaseDTO의 시스템컬럼 추출
	 */
	public HashMap<String, String> getSystemColumn() {
		HashMap<String, String> map = new HashMap<>();
		map.put("createBy", 		this.createBy);
		map.put("modifyBy", 		this.modifyBy);
		map.put("LoyProgramId", 	this.LoyProgramId);
		map.put("lang", 			this.getLang());

		return map;
	}

	/**
	 * @name : setSystemColumn
	 * @date : 2016. 11. 17.
	 * @author : dg.ryu
	 * @description : BaseDTO 시스템 컬럼 설정
	 */
	public void setSystemColumn(HashMap<String, String> map) {
		if (map.containsKey("createBy")) this.setCreateBy(map.get("createBy"));
		if (map.containsKey("modifyBy")) this.setModifyBy(map.get("modifyBy"));
		if (map.containsKey("LoyProgramId")) this.setLoyProgramId(map.get("LoyProgramId"));
		if (map.containsKey("lang")) this.setLang(map.get("lang"));
	}

	public String getDataStatus() {
		return dataStatus;
	}

	public void setDataStatus(String dataStatus) {
		this.dataStatus = dataStatus;
	}

	public String getLoyProgramNo() {
		return LoyProgramNo;
	}

	public void setLoyProgramNo(String LoyProgramNo) {
		this.LoyProgramNo = LoyProgramNo;
	}

	public String getTokenId() {
		return tokenId;
	}

	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}

	public String getLoginMethod() {
		return loginMethod;
	}

	public void setLoginMethod(String loginMethod) {
		this.loginMethod = loginMethod;
	}

	public String getSendchnl() {
		return sendchnl;
	}

	public void setSendchnl(String sendchnl) {
		this.sendchnl = sendchnl;
	}

	public String getAuthEmailCheck() {
		return authEmailCheck;
	}

	public void setAuthEmailCheck(String authEmailCheck) {
		this.authEmailCheck = authEmailCheck;
	}

}
