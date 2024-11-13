/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;




/**
  * @fileName : LoyMbrChnlRelRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 6.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원  채널관계 요청 DTO
  */
public class LoyMbrChangeHistListReqDto  extends CommonDataAuthReqDto {


		private String rid;
	    private String mbrRid;
	    private String createDate;
	    private String createBy;
	    private String chgCol;
	    private String bchngData;
	    private String achngData;
	    private String chgPstn;
	    private String rmark;
	    private String cipherKey;
	    private String ridPgm;
	    private String pgmNo;
	    private String custTypeCd;

	    public LoyMbrChangeHistListReqDto() {
	      /*  try {
	            this.setCipherKey(CryptoManager.getCipherKey());
	        }
	        catch ( Exception e ) {
	            LogUtil.error(e);
	        }*/
	    }
	    
		public String getCustTypeCd() {
			return custTypeCd;
		}

		public void setCustTypeCd(String custTypeCd) {
			this.custTypeCd = custTypeCd;
		}

		public String getPgmNo() {
			return pgmNo;
		}

		public void setPgmNo(String pgmNo) {
			this.pgmNo = pgmNo;
		}

		public String getRidPgm() {
			return ridPgm;
		}

		public void setRidPgm(String ridPgm) {
			this.ridPgm = ridPgm;
		}

		public String getRid() {
			return rid;
		}
		public void setRid(String rid) {
			this.rid = rid;
		}
		public String getMbrRid() {
			return mbrRid;
		}
		public void setMbrRid(String mbrRid) {
			this.mbrRid = mbrRid;
		}
		public String getCreateDate() {
			return createDate;
		}
		public void setCreateDate(String createDate) {
			this.createDate = createDate;
		}
		@Override
		public String getCreateBy() {
			return createBy;
		}
		@Override
		public void setCreateBy(String createBy) {
			this.createBy = createBy;
		}
		public String getChgCol() {
			return chgCol;
		}
		public void setChgCol(String chgCol) {
			this.chgCol = chgCol;
		}
		public String getBchngData() {
			return bchngData;
		}
		public void setBchngData(String bchngData) {
			this.bchngData = bchngData;
		}
		public String getAchngData() {
			return achngData;
		}
		public void setAchngData(String achngData) {
			this.achngData = achngData;
		}
		public String getChgPstn() {
			return chgPstn;
		}
		public void setChgPstn(String chgPstn) {
			this.chgPstn = chgPstn;
		}
		public String getRmark() {
			return rmark;
		}
		public void setRmark(String rmark) {
			this.rmark = rmark;
		}
		/**
		* @return the cipherKey
		*/
		public String getCipherKey() {
			return cipherKey;
		}
		/**
		* @param cipherKey the cipherKey to set
		*/
		public void setCipherKey(String cipherKey) {
			this.cipherKey = cipherKey;
		}









}
