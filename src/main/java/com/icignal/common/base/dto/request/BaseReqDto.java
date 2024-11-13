package com.icignal.common.base.dto.request;

import java.util.HashMap;

import com.icignal.common.util.BeansUtil;


/**
 * 최상위 요청 클래스
 *
 * @author jskim
 *
 */
public class BaseReqDto {

	private String lang;
	private String strSVCType = "";
	
	private String createBy;
	private String modifyBy;
	private String ridDivision;
	private String loyProgramId;	
	private String cipherKey;
	private boolean isEncrypted;  // 암호화 처리 여부
	
 	
	public BaseReqDto() {
		this.lang = BeansUtil.getApplicationProperty("icignal.context.server.lang");		
		this.cipherKey = BeansUtil.getDBEncryptKey();		
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
		map.put("ridDivision", 		this.ridDivision);
		map.put("loyProgramId", 	this.loyProgramId);
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
		if (map.containsKey("ridDivision")) this.setModifyBy(map.get("ridDivision"));
		if (map.containsKey("loyProgramId")) this.setLoyProgramId(map.get("loyProgramId"));
		if (map.containsKey("lang")) this.setLang(map.get("lang"));
	}
	
	private void setLoyProgramId(String string) {
		this.loyProgramId = string;
	}

	private void setModifyBy(String string) {
		this.modifyBy = string;		
	}

	private void setCreateBy(String string) {
		this.createBy = string;
	}
	
	public void setSVCAlias(String pAlias){
		
		strSVCType = " 1=1 ";
		String alias = pAlias;

		if(pAlias == null)
			alias = "";
		else if(pAlias.length() == 0)
			alias = "";
		else
			alias = alias + ".";
		/*strSVCType += " " + alias + "app_service_type = '" + appServiceId   + "'";
		strSVCType += "and " + alias + "country = '" + country  + "'";*/
		
		this.setStrSVCType(strSVCType);
	}

	public String getLang() {		
		return lang;
	}
	
	public void setLang(String lang) {
		this.lang = lang;
	}
	
	public String getStrSVCType() {
		if(this.strSVCType == null || this.strSVCType.length() == 0){
//			this.strSVCType += " app_service_type = '"+appServiceId+"'";
//			this.strSVCType += "and country = '"+ country +"'";
			this.strSVCType += " app_service_type = ''";
			this.strSVCType += "and country = ''";
		}
		
		this.strSVCType = "1=1";
		
		return strSVCType;
	}
	
	public void setStrSVCType(String strSVCType) {
		this.strSVCType = strSVCType;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public boolean isEncrypted() {
		return isEncrypted;
	}

	public void setEncrypted(boolean isEncrypted) {
		this.isEncrypted = isEncrypted;
	}

	public void setRidDivision(String ridDivision) {
	}
}