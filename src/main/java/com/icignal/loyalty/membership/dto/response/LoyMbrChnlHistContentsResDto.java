/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
  * @fileName : LoyMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 응답 DTO
  */
public class LoyMbrChnlHistContentsResDto  extends GridPagingItemResDto {

    private String rid;
    private String contents;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
    
    
    






}
