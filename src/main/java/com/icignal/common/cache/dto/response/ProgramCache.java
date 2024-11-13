/**
 * 
 */
package com.icignal.common.cache.dto.response;

import java.io.Serializable;
import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : com.icignal.common.cache.dto.response.ProgramCacheResponseDTO
 * @date : 2020. 1. 29.
 * @author : jh.seo
 * @history : 2018.11.13
 * @since : JDK1.8
 * @see : 
 * @description : 
*/
public class ProgramCache extends StatusResDto implements Serializable{
	private static final long serialVersionUID = 7077013092586721807L;
	
	private String pgmRid;
	private String url;
	
	private List<ProgramObject> objectCache;
	private List<ProgramChildResDto> programChild;

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<ProgramObject> getObjectCache() {
		return objectCache;
	}

	public void setObjectCache(List<ProgramObject> objectCache) {
		this.objectCache = objectCache;
	}

	public List<ProgramChildResDto> getProgramChild() {
		return programChild;
	}

	public void setProgramChild(List<ProgramChildResDto> programChild) {
		this.programChild = programChild;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
	
	
	
	
	
}
