package com.icignal.common.channelsend.dto.request;

import java.sql.Timestamp;

public class SendMsgReqDto {

	private String create_by;
	private String mbr_no;
	private String rcv_cell_no;
	private String send_tel_no;
	private String msg_type_cd;
	private String msg;
	private String lms_sbjt;
	private String chnl_no;
	private Timestamp msg_send_dttm;

	public String getCreate_by() {
		return create_by;
	}
	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}
	public String getMbr_no() {
		return mbr_no;
	}
	public void setMbr_no(String mbr_no) {
		this.mbr_no = mbr_no;
	}
	public String getRcv_cell_no() {
		return rcv_cell_no;
	}
	public void setRcv_cell_no(String rcv_cell_no) {
		this.rcv_cell_no = rcv_cell_no;
	}
	public String getSend_tel_no() {
		return send_tel_no;
	}
	public void setSend_tel_no(String send_tel_no) {
		this.send_tel_no = send_tel_no;
	}
	public String getMsg_type_cd() {
		return msg_type_cd;
	}
	public void setMsg_type_cd(String msg_type_cd) {
		this.msg_type_cd = msg_type_cd;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getLms_sbjt() {
		return lms_sbjt;
	}
	public void setLms_sbjt(String lms_sbjt) {
		this.lms_sbjt = lms_sbjt;
	}
	public String getChnl_no() {
		return chnl_no;
	}
	public void setChnl_no(String chnl_no) {
		this.chnl_no = chnl_no;
	}
	public Timestamp getMsg_send_dttm() {
		return msg_send_dttm;
	}
	public void setMsg_send_dttm(Timestamp msg_send_dttm) {
		this.msg_send_dttm = msg_send_dttm;
	}

}
