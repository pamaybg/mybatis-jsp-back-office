package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MktCampaignStatusReqDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 기획/실행 ReqDto
 */
public class MktCampaignStatusReqDto extends CommonDataAuthReqDto {
	
    private String id;           //아이디
    private String createDate;   //생성일시
    private String modifyDate;   //수정일시
    
    private String cam_nm;
    private String cam_type_cd;
    private String cam_start_dd;
    private String cam_end_dd;
    private String cam_status_cd;
    private String approval;
    private String chnl_type_nm;
    private String tgt_tot_cnt;
    private String ctrl_group_cnt;
    private String send_tot_cnt;
    private String offer_nm;
    private String cam_id;
    private String chnl_type_cd;
    
    private String exe_seq;
    private String exe_info_status_cd;
    private String exe_info_status_bat_dtl_cd;
    private String exe_dt;
    
    private String batch_cd;
    private String batch_nm;
    private String batch_modul_cd;
    private String batch_modul_nm;
    private String batch_status_dtl;
    private String err_cd;
    private String err_sbst;
    private String start_dt;
    private String end_dt;
    
    private String mem_id;
    private String con_yn;
    private String chan_send_yn;
    private String user_yn;
    private String bnf_value;
    private String tgt_dtl_id;
    
    private String fati_chk_del_yn;
    private String info_util_yn;
    private String mkt_util_yn;
    private String sms_consent_yn;
    private String email_consent_yn;
    private String hp_yn;
    private String email_yn;
    private String dup_del_yn;
    
    private String min_start_dt;
    private String max_end_dt;
    private String bat_status;
    
    private String chnl_type;
    private String offer_type;
    
    private String sms10;
    private String sms20;
    private String sms30;
    private String email10;
    private String email20;
    private String email30;
    private String email40;
    private String email50;
    private String email60;
    private String coupon10;
    private String coupon20;
    
    private String push10;
    private String push20;
    private String push30;
    
    private String OBCALL10;
    private String OBCALL20;
    private String OBCALL30;
    private String OBCALL40;
    private String OBCALL50;
    private String OBCALL60;
    private String OBCALL70;
    
    private String MGIFT10;
    private String MGIFT20;
    
    private String camRspnsCd;
    
    private String type;
    
	public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCam_nm() {
		return cam_nm;
	}
	public void setCam_nm(String cam_nm) {
		this.cam_nm = cam_nm;
	}
	public String getCam_type_cd() {
		return cam_type_cd;
	}
	public void setCam_type_cd(String cam_type_cd) {
		this.cam_type_cd = cam_type_cd;
	}
	public String getCam_start_dd() {
		return cam_start_dd;
	}
	public void setCam_start_dd(String cam_start_dd) {
		this.cam_start_dd = cam_start_dd;
	}
	public String getCam_end_dd() {
		return cam_end_dd;
	}
	public void setCam_end_dd(String cam_end_dd) {
		this.cam_end_dd = cam_end_dd;
	}
	public String getCam_status_cd() {
		return cam_status_cd;
	}
	public void setCam_status_cd(String cam_status_cd) {
		this.cam_status_cd = cam_status_cd;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public String getChnl_type_nm() {
		return chnl_type_nm;
	}
	public void setChnl_type_nm(String chnl_type_nm) {
		this.chnl_type_nm = chnl_type_nm;
	}
	public String getTgt_tot_cnt() {
		return tgt_tot_cnt;
	}
	public void setTgt_tot_cnt(String tgt_tot_cnt) {
		this.tgt_tot_cnt = tgt_tot_cnt;
	}
	public String getCtrl_group_cnt() {
		return ctrl_group_cnt;
	}
	public void setCtrl_group_cnt(String ctrl_group_cnt) {
		this.ctrl_group_cnt = ctrl_group_cnt;
	}
	public String getSend_tot_cnt() {
		return send_tot_cnt;
	}
	public void setSend_tot_cnt(String send_tot_cnt) {
		this.send_tot_cnt = send_tot_cnt;
	}
	public String getOffer_nm() {
		return offer_nm;
	}
	public void setOffer_nm(String offer_nm) {
		this.offer_nm = offer_nm;
	}
	public String getCam_id() {
		return cam_id;
	}
	public void setCam_id(String cam_id) {
		this.cam_id = cam_id;
	}
	public String getChnl_type_cd() {
		return chnl_type_cd;
	}
	public void setChnl_type_cd(String chnl_type_cd) {
		this.chnl_type_cd = chnl_type_cd;
	}
	public String getExe_seq() {
		return exe_seq;
	}
	public void setExe_seq(String exe_seq) {
		this.exe_seq = exe_seq;
	}
	public String getExe_info_status_cd() {
		return exe_info_status_cd;
	}
	public void setExe_info_status_cd(String exe_info_status_cd) {
		this.exe_info_status_cd = exe_info_status_cd;
	}
	public String getExe_info_status_bat_dtl_cd() {
		return exe_info_status_bat_dtl_cd;
	}
	public void setExe_info_status_bat_dtl_cd(String exe_info_status_bat_dtl_cd) {
		this.exe_info_status_bat_dtl_cd = exe_info_status_bat_dtl_cd;
	}
	public String getExe_dt() {
		return exe_dt;
	}
	public void setExe_dt(String exe_dt) {
		this.exe_dt = exe_dt;
	}
	public String getBatch_cd() {
		return batch_cd;
	}
	public void setBatch_cd(String batch_cd) {
		this.batch_cd = batch_cd;
	}
	public String getBatch_nm() {
		return batch_nm;
	}
	public void setBatch_nm(String batch_nm) {
		this.batch_nm = batch_nm;
	}
	public String getBatch_modul_cd() {
		return batch_modul_cd;
	}
	public void setBatch_modul_cd(String batch_modul_cd) {
		this.batch_modul_cd = batch_modul_cd;
	}
	public String getBatch_modul_nm() {
		return batch_modul_nm;
	}
	public void setBatch_modul_nm(String batch_modul_nm) {
		this.batch_modul_nm = batch_modul_nm;
	}
	public String getBatch_status_dtl() {
		return batch_status_dtl;
	}
	public void setBatch_status_dtl(String batch_status_dtl) {
		this.batch_status_dtl = batch_status_dtl;
	}
	public String getErr_cd() {
		return err_cd;
	}
	public void setErr_cd(String err_cd) {
		this.err_cd = err_cd;
	}
	public String getErr_sbst() {
		return err_sbst;
	}
	public void setErr_sbst(String err_sbst) {
		this.err_sbst = err_sbst;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getCon_yn() {
		return con_yn;
	}
	public void setCon_yn(String con_yn) {
		this.con_yn = con_yn;
	}
	public String getChan_send_yn() {
		return chan_send_yn;
	}
	public void setChan_send_yn(String chan_send_yn) {
		this.chan_send_yn = chan_send_yn;
	}
	public String getUser_yn() {
		return user_yn;
	}
	public void setUser_yn(String user_yn) {
		this.user_yn = user_yn;
	}
	public String getBnf_value() {
		return bnf_value;
	}
	public void setBnf_value(String bnf_value) {
		this.bnf_value = bnf_value;
	}
	public String getTgt_dtl_id() {
		return tgt_dtl_id;
	}
	public void setTgt_dtl_id(String tgt_dtl_id) {
		this.tgt_dtl_id = tgt_dtl_id;
	}
	public String getFati_chk_del_yn() {
		return fati_chk_del_yn;
	}
	public void setFati_chk_del_yn(String fati_chk_del_yn) {
		this.fati_chk_del_yn = fati_chk_del_yn;
	}
	public String getInfo_util_yn() {
		return info_util_yn;
	}
	public void setInfo_util_yn(String info_util_yn) {
		this.info_util_yn = info_util_yn;
	}
	public String getMkt_util_yn() {
		return mkt_util_yn;
	}
	public void setMkt_util_yn(String mkt_util_yn) {
		this.mkt_util_yn = mkt_util_yn;
	}
	public String getSms_consent_yn() {
		return sms_consent_yn;
	}
	public void setSms_consent_yn(String sms_consent_yn) {
		this.sms_consent_yn = sms_consent_yn;
	}
	public String getEmail_consent_yn() {
		return email_consent_yn;
	}
	public void setEmail_consent_yn(String email_consent_yn) {
		this.email_consent_yn = email_consent_yn;
	}
	public String getHp_yn() {
		return hp_yn;
	}
	public void setHp_yn(String hp_yn) {
		this.hp_yn = hp_yn;
	}
	public String getEmail_yn() {
		return email_yn;
	}
	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}
	public String getDup_del_yn() {
		return dup_del_yn;
	}
	public void setDup_del_yn(String dup_del_yn) {
		this.dup_del_yn = dup_del_yn;
	}
	public String getMin_start_dt() {
		return min_start_dt;
	}
	public void setMin_start_dt(String min_start_dt) {
		this.min_start_dt = min_start_dt;
	}
	public String getMax_end_dt() {
		return max_end_dt;
	}
	public void setMax_end_dt(String max_end_dt) {
		this.max_end_dt = max_end_dt;
	}
	public String getBat_status() {
		return bat_status;
	}
	public void setBat_status(String bat_status) {
		this.bat_status = bat_status;
	}
	public String getChnl_type() {
		return chnl_type;
	}
	public void setChnl_type(String chnl_type) {
		this.chnl_type = chnl_type;
	}
	public String getOffer_type() {
		return offer_type;
	}
	public void setOffer_type(String offer_type) {
		this.offer_type = offer_type;
	}
	public String getSms10() {
		return sms10;
	}
	public void setSms10(String sms10) {
		this.sms10 = sms10;
	}
	public String getSms20() {
		return sms20;
	}
	public void setSms20(String sms20) {
		this.sms20 = sms20;
	}
	public String getSms30() {
		return sms30;
	}
	public void setSms30(String sms30) {
		this.sms30 = sms30;
	}
	public String getEmail10() {
		return email10;
	}
	public void setEmail10(String email10) {
		this.email10 = email10;
	}
	public String getEmail20() {
		return email20;
	}
	public void setEmail20(String email20) {
		this.email20 = email20;
	}
	public String getEmail30() {
		return email30;
	}
	public void setEmail30(String email30) {
		this.email30 = email30;
	}
	public String getEmail40() {
		return email40;
	}
	public void setEmail40(String email40) {
		this.email40 = email40;
	}
	public String getEmail50() {
		return email50;
	}
	public void setEmail50(String email50) {
		this.email50 = email50;
	}
	public String getCoupon10() {
		return coupon10;
	}
	public void setCoupon10(String coupon10) {
		this.coupon10 = coupon10;
	}
	public String getCoupon20() {
		return coupon20;
	}
	public void setCoupon20(String coupon20) {
		this.coupon20 = coupon20;
	}
	public String getEmail60() {
		return email60;
	}
	public void setEmail60(String email60) {
		this.email60 = email60;
	}
	public String getPush10() {
		return push10;
	}
	public void setPush10(String push10) {
		this.push10 = push10;
	}
	public String getPush20() {
		return push20;
	}
	public void setPush20(String push20) {
		this.push20 = push20;
	}
	public String getPush30() {
		return push30;
	}
	public void setPush30(String push30) {
		this.push30 = push30;
	}
	public String getOBCALL10() {
		return OBCALL10;
	}
	public void setOBCALL10(String oBCALL10) {
		OBCALL10 = oBCALL10;
	}
	public String getOBCALL20() {
		return OBCALL20;
	}
	public void setOBCALL20(String oBCALL20) {
		OBCALL20 = oBCALL20;
	}
	public String getOBCALL30() {
		return OBCALL30;
	}
	public void setOBCALL30(String oBCALL30) {
		OBCALL30 = oBCALL30;
	}
	public String getOBCALL40() {
		return OBCALL40;
	}
	public void setOBCALL40(String oBCALL40) {
		OBCALL40 = oBCALL40;
	}
	public String getOBCALL50() {
		return OBCALL50;
	}
	public void setOBCALL50(String oBCALL50) {
		OBCALL50 = oBCALL50;
	}
	public String getOBCALL60() {
		return OBCALL60;
	}
	public void setOBCALL60(String oBCALL60) {
		OBCALL60 = oBCALL60;
	}
	public String getOBCALL70() {
		return OBCALL70;
	}
	public void setOBCALL70(String oBCALL70) {
		OBCALL70 = oBCALL70;
	}
	public String getMGIFT10() {
		return MGIFT10;
	}
	public void setMGIFT10(String mGIFT10) {
		MGIFT10 = mGIFT10;
	}
	public String getMGIFT20() {
		return MGIFT20;
	}
	public void setMGIFT20(String mGIFT20) {
		MGIFT20 = mGIFT20;
	}
	public String getCamRspnsCd() {
		return camRspnsCd;
	}
	public void setCamRspnsCd(String camRspnsCd) {
		this.camRspnsCd = camRspnsCd;
	}
	
}
