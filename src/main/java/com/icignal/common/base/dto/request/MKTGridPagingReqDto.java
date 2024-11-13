package com.icignal.common.base.dto.request;

import java.util.HashMap;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.ObjectUtil;

/**
 * @file MKTBaseRequestDTO.java
 * @date 2016.02.03
 * @author 류동균
 */
public class MKTGridPagingReqDto extends GridPagingReqDto {
	private String comSchemas;

	private String createBy;		//등록자
	private String modifyBy;		//수정자
	private String loyProgramId;	//로얄티 프로그램 아이디
	private String strPagingColumn;		//페이징 컬럼
	private String strPagingWhere;
	private String loginId;
	private String url; // 화면 url
	private String urlInclude; // 화면 url
	private String ridDivision;

	public void setLoginInfo(LoginResDto loginInfo) {
		if (ObjectUtil.isNotEmpty(loginInfo)) {
			this.createBy = loginInfo.getId();
			this.modifyBy = loginInfo.getId();
			this.loginId = loginInfo.getId();
			this.loyProgramId = loginInfo.getLoyProgramId();
			this.url = loginInfo.getUrl();
			this.urlInclude = loginInfo.getUrlInclude();
			this.setLang(loginInfo.getLang());
			this.ridDivision = loginInfo.getRidDivision();
		}
		
//		if (this.getLang() != null) {
//			
//		}

//		if (this.getSearchWord() != null && this.getSearchWord().length() > 0) {
//			/*try {
//				this.setEncFnName("secu.fn_getEncrypt");
//				this.setEncKey(CryptoManager.getCipherKey());
//			} catch (Exception e) {
//				LogUtil.error(e);
//			}*/
//		}
	}

	public String getComSchemas() {
		comSchemas = "com";
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
		return loyProgramId;
	}

	public void setLoyProgramId(String loyProgramId) {
		this.loyProgramId = loyProgramId;
	}

	public String getStrPagingColumn() {


        if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
            strPagingColumn = "ROW_NUMBER() OVER(ORDER BY " + this.getStrOrderby() + ") as ROW_NUM, CEIL(COUNT(1) OVER()) as totalCount, ";
        }

        return strPagingColumn;
    }

	public void setStrPagingColumn(String strPagingColumn) {
		this.strPagingColumn = strPagingColumn;
	}

	public String getStrPagingWhere() {

		//오라클일 경우
		if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
			//페이징
			int startNum = this.getSkipCount() + 1;
			int endNum = startNum + this.getPageSize();

			strPagingWhere = "AND ROW_NUM BETWEEN " + Integer.toString(startNum) + " AND " + Integer.toString(endNum) + " ORDER BY ROW_NUM";
		}

		return strPagingWhere;
	}

	public void setStrPagingWhere(String strPagingWhere) {
		this.strPagingWhere = strPagingWhere;
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
		map.put("LoyProgramId", 	this.loyProgramId);
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
		if (map.containsKey("LoyProgramId")) this.setLoyProgramId(map.get("LoyProgramId"));
		if (map.containsKey("lang")) this.setLang(map.get("lang"));
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUrlInclude() {
		return urlInclude;
	}

	public void setUrlInclude(String urlInclude) {
		this.urlInclude = urlInclude;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
}
