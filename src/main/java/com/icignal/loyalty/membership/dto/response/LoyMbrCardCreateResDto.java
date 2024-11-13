
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;





public class LoyMbrCardCreateResDto  extends GridPagingItemResDto {

	 private String ridCard;

		/** 회원번호 */
		private String mbrNo;

		/** 카드번호*/
		private String cardNo;

		/**발급일자 */
		private String IssueDt;

		/**카드 발급 상태 */
		private String cardStat;

		/**카드 발급 채널명*/
		private String cardIssueChnlNm;

		

		/**
		 * @return the mbrNo
		 */
		public String getMbrNo() {
			return mbrNo;
		}

		/**
		 * @param mbrNo the mbrNo to set
		 */
		public void setMbrNo(String mbrNo) {
			this.mbrNo = mbrNo;
		}

		/**
		 * @return the cardNo
		 */
		public String getCardNo() {
			return cardNo;
		}

		/**
		 * @param cardNo the cardNo to set
		 */
		public void setCardNo(String cardNo) {
			this.cardNo = cardNo;
		}

		/**
		 * @return the issueDt
		 */
		public String getIssueDt() {
			return IssueDt;
		}

		/**
		 * @param issueDt the issueDt to set
		 */
		public void setIssueDt(String issueDt) {
			IssueDt = issueDt;
		}

		/**
		 * @return the cardStat
		 */
		public String getCardStat() {
			return cardStat;
		}

		/**
		 * @param cardStat the cardStat to set
		 */
		public void setCardStat(String cardStat) {
			this.cardStat = cardStat;
		}

		/**
		 * @return the cardIssueChnlNm
		 */
		public String getCardIssueChnlNm() {
			return cardIssueChnlNm;
		}

		/**
		 * @param cardIssueChnlNm the cardIssueChnlNm to set
		 */
		public void setCardIssueChnlNm(String cardIssueChnlNm) {
			this.cardIssueChnlNm = cardIssueChnlNm;
		}

		/**
		 * @return the ridCard
		 */
		public String getRidCard() {
			return ridCard;
		}

		/**
		 * @param ridCard the ridCard to set
		 */
		public void setRidCard(String ridCard) {
			this.ridCard = ridCard;
		}







}
