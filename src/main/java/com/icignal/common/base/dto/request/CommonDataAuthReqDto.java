package com.icignal.common.base.dto.request;

import com.icignal.auth.dto.response.AuthorityResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.AUTH_DATA_TYPE;
import com.icignal.common.util.ObjectUtil;

/**
 * @name : MKTCommonCodeRequestDTO.java
 * @date : 2015. 9. 22.
 * @author : 류동균
 * @description : 데이터권한
 */
public class
CommonDataAuthReqDto extends CommonCondReqDto {

	private String strDataAuthWhere;    //데이터권한 where절
	private String strDataAuthGroupWhere;	//데이터권한그룹 where절
	private String strDataWidthCondWhere;  //MSSQL WITH절 쿼리

	private String strAuthDataInValue;	//권한 데이터 IN 값
	private String strAuthDataInQuery;	//권한 데이터 IN 쿼리

	private String authDataTypeCd;	//데이터유형
	private String authGroupId;		//권한그룹 아이디
	private String userId;	//사용자아이디

	private String inDataAuthTargetColumn;    //in 대상 컬럼
	private String authAlias;	//alias

	private String uri; // request uri. 이경남 추가 사항.
	private String objCode; // 	excelDown objCode 노형래 추가.

	private String rid;


	/**
	 * @name : getStrDataAuthWhere
	 * @date : 2017. 3. 14.
	 * @author : dg.ryu
	 * @description : 데이터 권한 where 추출
	 */

	public String getStrDataAuthWhere() {
		if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
			if (AUTH_DATA_TYPE.ALL.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = "1=1";
			}

			else if (AUTH_DATA_TYPE.MY.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by = '" + this.getCreateBy() + "'";
			}

			else if (AUTH_DATA_TYPE.MY_TEAM.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by in ( select t1.rid from com.crm_user t1 join com.employee t2 on t2.id = t1.id_employee where t2.rid_division = '" + this.getRidDivision() + "')";
			}

			else if (AUTH_DATA_TYPE.TEAM.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by in ( select t1.rid from com.crm_user t1 join com.employee t2 on t2.id = t1.id_employee join (select rid from com.crm_division start with rid = '" + this.getRidDivision() + "' connect by nocycle prior rid = rid_par_div) t3 on t3.rid = t2.rid_division)";
			}

			else {
				strDataAuthWhere = "1=0";
			}
		}  else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
			if (AUTH_DATA_TYPE.ALL.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = "1=1";
			}

			else if (AUTH_DATA_TYPE.MY.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by = '" + this.getCreateBy() + "'";
			}

			else if (AUTH_DATA_TYPE.MY_TEAM.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by in ( select t1.rid from com.crm_user t1 join com.employee t2 on t2.id = t1.id_employee where t2.rid_division = '" + this.getRidDivision() + "')";
			}

			else if (AUTH_DATA_TYPE.TEAM.name().equals(this.authDataTypeCd)) {
				strDataAuthWhere = authAlias + "." + "create_by in ( select t1.rid from com.crm_user t1 join com.EMPLOYEE t2 on t2.id = t1.id_employee join CTE_TABLE t3 on t3.rid = t2.rid_division)";
			}

			else {
				strDataAuthWhere = "1=0";
			}

		}
		return strDataAuthWhere;
	}

	public String getStrDataWidthCondWhere() {
		if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
			strDataWidthCondWhere = "WITH CTE_TABLE AS (select rid,RID_PAR_DIV from com.crm_division A where rid = '"+this.getRidDivision()+"'";
			strDataWidthCondWhere += "UNION ALL select m.rid,m.RID_PAR_DIV from com.crm_division M,CTE_TABLE b where M.RID_PAR_DIV = b.rid)";
		}
		return strDataWidthCondWhere;
	}


	public void setStrDataWidthCondWhere(String strDataWidthCondWhere) {
		this.strDataWidthCondWhere = strDataWidthCondWhere;
	}


	/*
    public String getStrDataAuthWhere() {
        if ((ObjectUtil.isNotEmpty(this.strAuthDataInValue) || ObjectUtil.isNotEmpty(this.strAuthDataInQuery))
        		&& ObjectUtil.isNotEmpty(this.inDataAuthTargetColumn)) {

        	//alias 확인
        	String alias = "";
        	if (ObjectUtil.isNotEmpty(this.authAlias)) {
        		alias = this.authAlias + ".";
        	}

        	//천 단위 구분자(":") 자르기 oracle in query 개수 제한으로 인하여 천단위 자름
            String[] strIn = this.strAuthDataInValue.split(":");

            //(str in ('1','2') or str in ('3','4')) 형식으로 생성
            strDataAuthWhere = " (";

            if (ObjectUtil.isNotEmpty(this.strAuthDataInValue)) {
	            for (int i=0; i < strIn.length; i++) {
	                if (i == 0) {
	                    strDataAuthWhere += alias + this.inDataAuthTargetColumn + " in (" + strIn[i] + ") ";
	                } else {
	                    strDataAuthWhere += " or " + alias + this.inDataAuthTargetColumn + " in (" + strIn[i] + ") ";
	                }
	            }
            }

            if (ObjectUtil.isNotEmpty(this.strAuthDataInQuery)) {
            	if (ObjectUtil.isNotEmpty(strAuthDataInValue)) {
            		strDataAuthWhere += " or " + alias + this.strAuthDataInQuery;
            	} else {
            		strDataAuthWhere += alias + this.strAuthDataInQuery;
            	}
            }
            strDataAuthWhere += ")";
        } else {
            strDataAuthWhere = " 1=0 ";
        }

        return strDataAuthWhere;
    }*/



	/**
	 * @name : getStrDataAuthGroupWhere
	 * @date : 2017. 3. 16.
	 * @author : dg.ryu
	 * @description : 데이터 권한그룹 where 추출
	 */
	public String getStrDataAuthGroupWhere() {

		//alias 확인
		String alias = " ";
		if (ObjectUtil.isNotEmpty(this.authAlias)) {
			alias += this.authAlias + ".";
		}

		//데이터 권한그룹 where 설정
		if (ObjectUtil.isNotEmpty(this.authDataTypeCd)) {
			//ALL
			if (this.authDataTypeCd.equals(AUTH_DATA_TYPE.ALL.name())) {
				strDataAuthGroupWhere = " 1=1";
			}
			//MY_TEAM
			else if (this.authDataTypeCd.equals(AUTH_DATA_TYPE.MY_TEAM.name())) {
				strDataAuthGroupWhere = alias + CommonUtil.AUTH_GROUP_COLUMN + " = '" + this.authGroupId + "'";
			}
			//MY
			else if (this.authDataTypeCd.equals(AUTH_DATA_TYPE.MY.name())) {
				strDataAuthGroupWhere = alias + CommonUtil.CREATE_BY_COLUMN + " = '" + this.userId + "'";
			}
			else {
				strDataAuthGroupWhere = " 1=0";
			}
		} else {
			strDataAuthGroupWhere = " 1=0";
		}

		return strDataAuthGroupWhere;
	}

	/**
	 * @name : setStrAuthDataInValue
	 * @date : 2017. 3. 14.
	 * @author : dg.ryu
	 * @description : 데이터 권한 값 설정
	 */
	public void setStrAuthDataIn(AuthorityResDto authority) {

		//권한그룹아이디
		this.authGroupId = authority.getAuthGroupId();

		//사용자 아이디
		this.userId = authority.getEmpId();

		//데이터권한 In 값
		this.strAuthDataInValue = authority.getAuthDataInValue();

		//데이터권한 In 쿼리
		this.strAuthDataInQuery = authority.getAuthDataInQuery();

		this.authDataTypeCd = authority.getDataTypeCd();
	}

	public void setStrDataAuthWhere(String strDataAuthWhere) {
		this.strDataAuthWhere = strDataAuthWhere;
	}

	public String getInDataAuthTargetColumn() {
		return inDataAuthTargetColumn;
	}

	public void setInDataAuthTargetColumn(String inDataAuthTargetColumn) { this.inDataAuthTargetColumn = inDataAuthTargetColumn; }

	/**
	 * @return the uri
	 */
	public String getUri() {
		return uri;
	}

	/**
	 * @param uri the uri to set
	 */
	public void setUri(String uri) {
		this.uri = uri;
	}

	public String getStrAuthDataInValue() {
		return strAuthDataInValue;
	}

	public void setStrAuthDataInValue(String strAuthDataInValue) {
		this.strAuthDataInValue = strAuthDataInValue;
	}

	public String getStrAuthDataInQuery() {
		return strAuthDataInQuery;
	}

	public void setStrAuthDataInQuery(String strAuthDataInQuery) {
		this.strAuthDataInQuery = strAuthDataInQuery;
	}

	public String getAuthAlias() {
		return authAlias;
	}

	public void setAuthAlias(String authAlias) {
		this.authAlias = authAlias;
	}

	public String getAuthDataTypeCd() {
		return authDataTypeCd;
	}

	public void setAuthDataTypeCd(String authDataTypeCd) {
		this.authDataTypeCd = authDataTypeCd;
	}

	public void setStrDataAuthGroupWhere(String strDataAuthGroupWhere) { this.strDataAuthGroupWhere = strDataAuthGroupWhere; }

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAuthGroupId() {
		return authGroupId;
	}

	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

	public String getObjCode() {
		return objCode;
	}

	public void setObjCode(String objCode) {
		this.objCode = objCode;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}



}