package com.icignal.auth.dto.response;

import java.io.Serializable;
import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
import com.icignal.loyalty.membership.dto.response.LoyMbrPointCancelResDto.RespBodyData;
import com.icignal.loyalty.membership.dto.response.LoyMbrPointCancelResDto.RespHeadData;

@PersonalData
public class LoginCertSmsResDto {
	@Decrypted(masked = "tel")
	private String phoneNumber;
	private String callBack;

	public String getCallBack() {
		return callBack;
	}

	public void setCallBack(String callBack) {
		this.callBack = callBack;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
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
}
