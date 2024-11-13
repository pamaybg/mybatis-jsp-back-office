package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class GuideMsgListReqDto extends GridPagingItemResDto {
		private String msgText;
		private String lineNo;
		
		public String getMsgText() {
			return msgText;
		}
		public void setMsgText(String msgText) {
			this.msgText = msgText;
		}
		public String getLineNo() {
			return lineNo;
		}
		public void setLineNo(String lineNo) {
			this.lineNo = lineNo;
		}
}
