package com.icignal.common.channelsend.dto.request;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ObjectUtil;

/**
* @name : infavor.Loyalty.common.dto.request.LoyChnlTransPushRequestDTO
* @date : 2018. 12. 11.
* @author : hy.jun
* @description : 유라클 push api 발송 객체
*/
public class PushReqDto extends CommonDataAuthReqDto {
	private String authkey;
	private String psid;
	private String cuid;
	private String message;
	private String sub_title;
	private String priority;
	private String badgeno;
	private String reservedate;
	private String servicecode;
	private String soundfile;
	private String ext;
	private String sendercode;
	private String app_id;
	private String type;
	private String db_in;
	private String split_msg_cnt;
	private String delay_second;
	private String send_time_limit;
	private String doz_gcm_send;
	private String push_fail_sms_send;
	private String sms_read_wait_minute;
	
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public String getPsid() {
		return psid;
	}
	public void setPsid(String psid) {
		this.psid = psid;
	}
	public String getCuid() {
		return cuid;
	}
	public void setCuid(String cuid) {
		this.cuid = cuid;
	}
	public String getMessage() {
		if(message == null) {
			message = "▶ 자세한 내용은 포인트 적립/사용 내역 확인 (클릭시 이동)";
		}
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getSub_title() {
		return sub_title;
	}
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
	}
	public String getPriority() {
		if(ObjectUtil.isEmpty(priority)) {
			priority = CommonUtil.getInstance().getServletProp("push.uracle.priority");
		}
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getBadgeno() {
		if(ObjectUtil.isEmpty(badgeno)) {
			badgeno = CommonUtil.getInstance().getServletProp("push.uracle.badgeno");
		}
		return badgeno;
	}
	public void setBadgeno(String badgeno) {
		this.badgeno = badgeno;
	}
	public String getReservedate() {
		return reservedate;
	}
	public void setReservedate(String reservedate) {
		this.reservedate = reservedate;
	}
	public String getSoundfile() {
		if(ObjectUtil.isEmpty(soundfile)) {
			soundfile = CommonUtil.getInstance().getServletProp("push.uracle.soundfile");
		}
		return soundfile;
	}
	public void setSoundfile(String soundfile) {
		this.soundfile = soundfile;
	}
	public String getExt() throws JsonProcessingException {
		if(ObjectUtil.isEmpty(ext)) {
			ObjectMapper mapper = new ObjectMapper();
			Map<String,String> extMap = new HashMap<String,String>();
			extMap.put("TYPE", "PNT");
			ext = mapper.writeValueAsString(extMap);
		}
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	public String getSendercode() {
		if(ObjectUtil.isEmpty(sendercode)) {
			sendercode = CommonUtil.getInstance().getServletProp("push.uracle.sendercode");
		}
		return sendercode;
	}
	public void setSendercode(String sendercode) {
		this.sendercode = sendercode;
	}
	public String getApp_id() {
		if(ObjectUtil.isEmpty(app_id)) {
			app_id = CommonUtil.getInstance().getServletProp("push.uracle.app_id");
		}
		return app_id;
	}
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDb_in() {
		return db_in;
	}
	public void setDb_in(String db_in) {
		this.db_in = db_in;
	}
	public String getSplit_msg_cnt() {
		return split_msg_cnt;
	}
	public void setSplit_msg_cnt(String split_msg_cnt) {
		this.split_msg_cnt = split_msg_cnt;
	}
	public String getDelay_second() {
		return delay_second;
	}
	public void setDelay_second(String delay_second) {
		this.delay_second = delay_second;
	}
	public String getSend_time_limit() {
		return send_time_limit;
	}
	public void setSend_time_limit(String send_time_limit) {
		this.send_time_limit = send_time_limit;
	}
	public String getDoz_gcm_send() {
		return doz_gcm_send;
	}
	public void setDoz_gcm_send(String doz_gcm_send) {
		this.doz_gcm_send = doz_gcm_send;
	}
	public String getPush_fail_sms_send() {
		return push_fail_sms_send;
	}
	public void setPush_fail_sms_send(String push_fail_sms_send) {
		this.push_fail_sms_send = push_fail_sms_send;
	}
	public String getSms_read_wait_minute() {
		return sms_read_wait_minute;
	}
	public void setSms_read_wait_minute(String sms_read_wait_minute) {
		this.sms_read_wait_minute = sms_read_wait_minute;
	}
	public String getServicecode() {
		if(ObjectUtil.isEmpty(servicecode)) {
			servicecode = CommonUtil.getInstance().getServletProp("push.uracle.servicecode");
		}
		return servicecode;
	}
	public void setServicecode(String servicecode) {
		this.servicecode = servicecode;
	}
}
