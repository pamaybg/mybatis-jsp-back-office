package com.icignal.marketing.realtime.api.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class RealSndCampaignApiDTO {
	
	
	public static class Request implements Serializable {
		private String trkNo;
		private String tgNo;
		private String trsDate;
		private String trsTime;
		private String svcCd;
		private String execCd;
		private String campNo;
		
	
		public String getTrkNo() {
			return trkNo;
		}
		public void setTrkNo(String trkNo) {
			this.trkNo = trkNo;
		}
		public String getTgNo() {
			return tgNo;
		}
		public void setTgNo(String tgNo) {
			this.tgNo = tgNo;
		}
		public String getTrsDate() {
			return trsDate;
		}
		public void setTrsDate(String trsDate) {
			this.trsDate = trsDate;
		}
		public String getTrsTime() {
			return trsTime;
		}
		public void setTrsTime(String trsTime) {
			this.trsTime = trsTime;
		}
		public String getSvcCd() {
			return svcCd;
		}
		public void setSvcCd(String svcCd) {
			this.svcCd = svcCd;
		}
		public String getExecCd() {
			return execCd;
		}
		public void setExecCd(String execCd) {
			this.execCd = execCd;
		}
		public String getCampNo() {
			return campNo;
		}
		public void setCampNo(String campNo) {
			this.campNo = campNo;
		}
		
	

		
		
	}
	
	
	
	public static class Response implements Serializable{
		@JsonProperty("rsltCd")
		private String rsltCd;
		@JsonProperty("errCd")
		private String errCd;
		@JsonProperty("errMsg")
		private String errMsg;
		@JsonProperty("rspDate")
		private String rspDate;
		@JsonProperty("rspTime")
		private String rspTime;
		@JsonProperty("trkNo")
		private String trkNo;
		
		public Response() {
		}
		
		public Response(String rsltCd, String errCd, String errMsg) {
			this.rsltCd = rsltCd;
			this.errCd = errCd;
			this.errMsg = errMsg;
		}
		
		public String getRsltCd() {
			return rsltCd;
		}
		public void setRsltCd(String rsltCd) {
			this.rsltCd = rsltCd;
		}
		public String getErrCd() {
			return errCd;
		}
		public void setErrCd(String errCd) {
			this.errCd = errCd;
		}
		public String getErrMsg() {
			return errMsg;
		}
		public void setErrMsg(String errMsg) {
			this.errMsg = errMsg;
		}
		public String getRspDate() {
			return rspDate;
		}
		public void setRspDate(String rspDate) {
			this.rspDate = rspDate;
		}
		public String getRspTime() {
			return rspTime;
		}
		public void setRspTime(String rspTime) {
			this.rspTime = rspTime;
		}
		public String getTrkNo() {
			return trkNo;
		}
		public void setTrkNo(String trkNo) {
			this.trkNo = trkNo;
		}
	}

}
