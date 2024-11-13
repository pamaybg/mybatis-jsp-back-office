package com.icignal.loyalty.benefit.point.dto.request;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.icignal.common.base.dto.response.StatusResDto;

public class LoyTransApiReqDto {
	private String REQ_TYPE;
	private String SEND_DT;
	private String SEND_TIME;
	private String TR_NO;
	private String TR_DT;
	private String TR_TIME;
	private String CHNL_CD;
	private String PGM_NO;
	
	private String QUERY_CD;
	private String QUERY_VAL;
	private String O_TR_ACRL_APPR_DT;
	private String O_TR_ACRL_APPR_NO;
	private String O_TR_USE_APPR_DT;
	private String O_TR_USE_APPR_NO;
	private String O_TR_RECEIPT_NO;
	private String RECEIPT_NO;
	public String getREQ_TYPE() {
		return REQ_TYPE;
	}
	public void setREQ_TYPE(String rEQ_TYPE) {
		REQ_TYPE = rEQ_TYPE;
	}
	public String getSEND_DT() {
		return SEND_DT;
	}
	public void setSEND_DT(String sEND_DT) {
		SEND_DT = sEND_DT;
	}
	public String getSEND_TIME() {
		return SEND_TIME;
	}
	public void setSEND_TIME(String sEND_TIME) {
		SEND_TIME = sEND_TIME;
	}
	public String getTR_NO() {
		return TR_NO;
	}
	public void setTR_NO(String tR_NO) {
		TR_NO = tR_NO;
	}
	public String getTR_DT() {
		return TR_DT;
	}
	public void setTR_DT(String tR_DT) {
		TR_DT = tR_DT;
	}
	public String getTR_TIME() {
		return TR_TIME;
	}
	public void setTR_TIME(String tR_TIME) {
		TR_TIME = tR_TIME;
	}
	public String getCHNL_CD() {
		return CHNL_CD;
	}
	public void setCHNL_CD(String cHNL_CD) {
		CHNL_CD = cHNL_CD;
	}
	public String getPGM_NO() {
		return PGM_NO;
	}
	public void setPGM_NO(String pGM_NO) {
		PGM_NO = pGM_NO;
	}
	public String getQUERY_CD() {
		return QUERY_CD;
	}
	public void setQUERY_CD(String qUERY_CD) {
		QUERY_CD = qUERY_CD;
	}
	public String getQUERY_VAL() {
		return QUERY_VAL;
	}
	public void setQUERY_VAL(String qUERY_VAL) {
		QUERY_VAL = qUERY_VAL;
	}
	public String getO_TR_ACRL_APPR_DT() {
		return O_TR_ACRL_APPR_DT;
	}
	public void setO_TR_ACRL_APPR_DT(String o_TR_ACRL_APPR_DT) {
		O_TR_ACRL_APPR_DT = o_TR_ACRL_APPR_DT;
	}
	public String getO_TR_ACRL_APPR_NO() {
		return O_TR_ACRL_APPR_NO;
	}
	public void setO_TR_ACRL_APPR_NO(String o_TR_ACRL_APPR_NO) {
		O_TR_ACRL_APPR_NO = o_TR_ACRL_APPR_NO;
	}
	public String getO_TR_USE_APPR_DT() {
		return O_TR_USE_APPR_DT;
	}
	public void setO_TR_USE_APPR_DT(String o_TR_USE_APPR_DT) {
		O_TR_USE_APPR_DT = o_TR_USE_APPR_DT;
	}
	public String getO_TR_USE_APPR_NO() {
		return O_TR_USE_APPR_NO;
	}
	public void setO_TR_USE_APPR_NO(String o_TR_USE_APPR_NO) {
		O_TR_USE_APPR_NO = o_TR_USE_APPR_NO;
	}
	public String getO_TR_RECEIPT_NO() {
		return O_TR_RECEIPT_NO;
	}
	public void setO_TR_RECEIPT_NO(String o_TR_RECEIPT_NO) {
		O_TR_RECEIPT_NO = o_TR_RECEIPT_NO;
	}
	public String getRECEIPT_NO() {
		return RECEIPT_NO;
	}
	public void setRECEIPT_NO(String rECEIPT_NO) {
		RECEIPT_NO = rECEIPT_NO;
	}
	
	public static class Response extends StatusResDto implements Serializable {
		
		@JsonProperty("HEAD_DATA")
		private ArrayList<RespHeadData> HEAD_DATA;
		
		@JsonProperty("BODY_DATA")
		private ArrayList<RespBodyData> BODY_DATA;
		

		public ArrayList<RespHeadData> getHEAD_DATA() {
			return HEAD_DATA;
		}
		public void setHEAD_DATA(ArrayList<RespHeadData> hEAD_DATA) {
			this.HEAD_DATA = hEAD_DATA;
		}
		public ArrayList<RespBodyData> getBODY_DATA() {
			return BODY_DATA;
		}
		public void setBODY_DATA(ArrayList<RespBodyData> bODY_DATA) {
			BODY_DATA = bODY_DATA;
		}
	}
	
	public static class RespHeadData implements Serializable {
		@JsonProperty("RST")
		private String RST;
		
		@JsonProperty("RST_CD")
		private String RST_CD;
		
		@JsonProperty("RST_MSG")
		private String RST_MSG;
		
		@JsonProperty("RES_TYPE")
		private String RES_TYPE;
		
		@JsonProperty("SEND_DT")
		private String SEND_DT;
		
		@JsonProperty("SEND_TIME")
		private String SEND_TIME;
		
		@JsonProperty("TR_NO")
		private String TR_NO;
		
		@JsonProperty("TR_DT")
		private String TR_DT;
		
		@JsonProperty("TR_TIME")
		private String TR_TIME;
		
		@JsonProperty("BODY_CNT")
		private Integer BODY_CNT;
		
		public String getRST() {
			return RST;
		}
		public void setRST(String rST) {
			RST = rST;
		}
		public String getRST_CD() {
			return RST_CD;
		}
		public void setRST_CD(String rST_CD) {
			RST_CD = rST_CD;
		}
		public String getRST_MSG() {
			return RST_MSG;
		}
		public void setRST_MSG(String rST_MSG) {
			RST_MSG = rST_MSG;
		}
		public String getRES_TYPE() {
			return RES_TYPE;
		}
		public void setRES_TYPE(String rES_TYPE) {
			RES_TYPE = rES_TYPE;
		}
		public String getSEND_DT() {
			return SEND_DT;
		}
		public void setSEND_DT(String sEND_DT) {
			SEND_DT = sEND_DT;
		}
		public String getSEND_TIME() {
			return SEND_TIME;
		}
		public void setSEND_TIME(String sEND_TIME) {
			SEND_TIME = sEND_TIME;
		}
		public String getTR_NO() {
			return TR_NO;
		}
		public void setTR_NO(String tR_NO) {
			TR_NO = tR_NO;
		}
		public String getTR_DT() {
			return TR_DT;
		}
		public void setTR_DT(String tR_DT) {
			TR_DT = tR_DT;
		}
		public String getTR_TIME() {
			return TR_TIME;
		}
		public void setTR_TIME(String tR_TIME) {
			TR_TIME = tR_TIME;
		}
		public Integer getBODY_CNT() {
			return BODY_CNT;
		}
		public void setBODY_CNT(Integer bODY_CNT) {
			BODY_CNT = bODY_CNT;
		}
	}
	
public static class RespBodyData implements Serializable {
		
		@JsonProperty("QUERY_VAL")
		private String QUERY_VAL;
		
		@JsonProperty("ACRL_APPR_DT")
		private String ACRL_APPR_DT;
		
		@JsonProperty("ACRL_APPR_TIME")
		private String ACRL_APPR_TIME;
		
		@JsonProperty("ACRL_APPR_NO")
		private String ACRL_APPR_NO;
		
		@JsonProperty("ACRL_PAY_AMT")
		private BigInteger ACRL_PAY_AMT;
		
		@JsonProperty("APPLY_PNT")
		private BigInteger APPLY_PNT;
		
		@JsonProperty("USABLE_PNT")
		private BigInteger USABLE_PNT;
		
		@JsonProperty("USE_APPR_DT")
		private String USE_APPR_DT;
		
		@JsonProperty("USE_APPR_TIME")
		private String USE_APPR_TIME;
		
		@JsonProperty("USE_APPR_NO")
		private String USE_APPR_NO;

		public String getQUERY_VAL() {
			return QUERY_VAL;
		}

		public void setQUERY_VAL(String qUERY_VAL) {
			QUERY_VAL = qUERY_VAL;
		}

		public String getACRL_APPR_DT() {
			return ACRL_APPR_DT;
		}

		public void setACRL_APPR_DT(String aCRL_APPR_DT) {
			ACRL_APPR_DT = aCRL_APPR_DT;
		}

		public String getACRL_APPR_TIME() {
			return ACRL_APPR_TIME;
		}

		public void setACRL_APPR_TIME(String aCRL_APPR_TIME) {
			ACRL_APPR_TIME = aCRL_APPR_TIME;
		}

		public String getACRL_APPR_NO() {
			return ACRL_APPR_NO;
		}

		public void setACRL_APPR_NO(String aCRL_APPR_NO) {
			ACRL_APPR_NO = aCRL_APPR_NO;
		}

		public BigInteger getACRL_PAY_AMT() {
			return ACRL_PAY_AMT;
		}

		public void setACRL_PAY_AMT(BigInteger aCRL_PAY_AMT) {
			ACRL_PAY_AMT = aCRL_PAY_AMT;
		}

		public BigInteger getAPPLY_PNT() {
			return APPLY_PNT;
		}

		public void setAPPLY_PNT(BigInteger aPPLY_PNT) {
			APPLY_PNT = aPPLY_PNT;
		}

		public BigInteger getUSABLE_PNT() {
			return USABLE_PNT;
		}

		public void setUSABLE_PNT(BigInteger uSABLE_PNT) {
			USABLE_PNT = uSABLE_PNT;
		}
		
	}
}
