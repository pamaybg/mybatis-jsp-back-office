/**
 * 
 */
package com.icignal.common.cache.dto.response;

import java.io.Serializable;

/**
 * @name : com.icignal.common.cache.dto.response.ProgramObject
 * @date : 2020. 2. 5.
 * @author : jh.seo
 * @history : 2018.11.13
 * @since : JDK1.8
 * @see : 
 * @description : 
*/
public class ProgramObject implements Serializable{
	private static final long serialVersionUID = 7077013092586721807L;
	
	private String progRid;
	private String objCd;		//오브젝트 코드
	private String progPath;	//프로그램 path
	
	
	public String getObjCd() {
		return objCd;
	}
	public void setObjCd(String objCd) {
		this.objCd = objCd;
	}
	
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getProgRid() {
		return progRid;
	}
	public void setProgRid(String progRid) {
		this.progRid = progRid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
