/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
  * @fileName : LoyMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 요청 DTO
  */
/**
 * @author 이성원
 *
 */
public class LoyDropMbrReqDto  extends CommonDataAuthReqDto {
    
	private String rid;
	private String mbrNo;
	private String ecommMbrNo;
	private String memDiv;
	private String tierNm;
	private String rtmmbDd;
	private String e1MemYn;
	private String webMemYn;
	private String cipherKey;
	
	   public LoyDropMbrReqDto() {
	     /*   try {
	            this.setCipherKey(CryptoManager.getCipherKey());
	        }
	        catch ( Exception e ) {
	            LogUtil.error(e);
	        }*/
	    }
	   
	 public String getCipherKey() {
			return cipherKey;
		}

	 public void setCipherKey(String cipherKey) {
			this.cipherKey = cipherKey;
		}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getRtmmbDd() {
		return rtmmbDd;
	}
	public void setRtmmbDd(String rtmmbDd) {
		this.rtmmbDd = rtmmbDd;
	}
	public String getE1MemYn() {
		return e1MemYn;
	}
	public void setE1MemYn(String e1MemYn) {
		this.e1MemYn = e1MemYn;
	}
	public String getWebMemYn() {
		return webMemYn;
	}
	public void setWebMemYn(String webMemYn) {
		this.webMemYn = webMemYn;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getEcommMbrNo() {
		return ecommMbrNo;
	}

	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}

	
	
	



}
