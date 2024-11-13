package com.icignal.marketing.realtime.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktRealTimeCampaignReqDto  extends CommonDataAuthReqDto{

	 private String camId;       // 캠페인 ID
	    private String promId;      // 프로모션 ID
	    private String exeInfoItemId; // 실행정보아이템 ID
	    private String exeInfoChnlId; // 실행정보채널 ID
	    private String tgtDtlId;    // 타겟 상세 ID
	    private String chnlTypeCd;  // 채널유형
		private String rid;
		
	    private String type;
	    private String comment;
	    private String processNm;
	    private String processStatus;
	    private String orderby;
	    private String processInt;
	    private Integer processCnt;
	    private String processRef;
	    private String useYn;
	    private String triggerType;
	    private String processCd;
	    private String startDt;
	    private String stopDt;
	    private String hndlMq;
	    private String errMq;
	    private String waitMq;
	    private String minWorker;
	    private String maxWorker;
	    private String threadsCnt;
	    private String execCd;

	    private String svcExeMq;
	    private Integer cachePort;
	    
	    private String campNo;
	
	    
	    
	    public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getComment() {
			return comment;
		}
		public void setComment(String comment) {
			this.comment = comment;
		}
		public String getProcessNm() {
			return processNm;
		}
		public void setProcessNm(String processNm) {
			this.processNm = processNm;
		}
		public String getProcessStatus() {
			return processStatus;
		}
		public void setProcessStatus(String processStatus) {
			this.processStatus = processStatus;
		}
		public String getOrderby() {
			return orderby;
		}
		public void setOrderby(String orderby) {
			this.orderby = orderby;
		}
		public String getProcessInt() {
			return processInt;
		}
		public void setProcessInt(String processInt) {
			this.processInt = processInt;
		}
		public Integer getProcessCnt() {
			return processCnt;
		}
		public void setProcessCnt(Integer processCnt) {
			this.processCnt = processCnt;
		}
		public String getProcessRef() {
			return processRef;
		}
		public void setProcessRef(String processRef) {
			this.processRef = processRef;
		}
		public String getUseYn() {
			return useYn;
		}
		public void setUseYn(String useYn) {
			this.useYn = useYn;
		}
		public String getTriggerType() {
			return triggerType;
		}
		public void setTriggerType(String triggerType) {
			this.triggerType = triggerType;
		}
		public String getProcessCd() {
			return processCd;
		}
		public void setProcessCd(String processCd) {
			this.processCd = processCd;
		}
		public String getStartDt() {
			return startDt;
		}
		public void setStartDt(String startDt) {
			this.startDt = startDt;
		}
		public String getStopDt() {
			return stopDt;
		}
		public void setStopDt(String stopDt) {
			this.stopDt = stopDt;
		}
		public String getHndlMq() {
			return hndlMq;
		}
		public void setHndlMq(String hndlMq) {
			this.hndlMq = hndlMq;
		}
		public String getErrMq() {
			return errMq;
		}
		public void setErrMq(String errMq) {
			this.errMq = errMq;
		}
		public String getWaitMq() {
			return waitMq;
		}
		public void setWaitMq(String waitMq) {
			this.waitMq = waitMq;
		}
		public String getMinWorker() {
			return minWorker;
		}
		public void setMinWorker(String minWorker) {
			this.minWorker = minWorker;
		}
		public String getMaxWorker() {
			return maxWorker;
		}
		public void setMaxWorker(String maxWorker) {
			this.maxWorker = maxWorker;
		}
		public String getThreadsCnt() {
			return threadsCnt;
		}
		public void setThreadsCnt(String threadsCnt) {
			this.threadsCnt = threadsCnt;
		}
		public String getExecCd() {
			return execCd;
		}
		public void setExecCd(String execCd) {
			this.execCd = execCd;
		}
		public String getSvcExeMq() {
			return svcExeMq;
		}
		public void setSvcExeMq(String svcExeMq) {
			this.svcExeMq = svcExeMq;
		}
		public Integer getCachePort() {
			return cachePort;
		}
		public void setCachePort(Integer cachePort) {
			this.cachePort = cachePort;
		}
		public String getCampNo() {
			return campNo;
		}
		public void setCampNo(String campNo) {
			this.campNo = campNo;
		}
		public String getCamId() {
			return camId;
		}
		public void setCamId(String camId) {
			this.camId = camId;
		}
		public String getPromId() {
			return promId;
		}
		public void setPromId(String promId) {
			this.promId = promId;
		}
		public String getExeInfoItemId() {
			return exeInfoItemId;
		}
		public void setExeInfoItemId(String exeInfoItemId) {
			this.exeInfoItemId = exeInfoItemId;
		}
		public String getExeInfoChnlId() {
			return exeInfoChnlId;
		}
		public void setExeInfoChnlId(String exeInfoChnlId) {
			this.exeInfoChnlId = exeInfoChnlId;
		}
		public String getTgtDtlId() {
			return tgtDtlId;
		}
		public void setTgtDtlId(String tgtDtlId) {
			this.tgtDtlId = tgtDtlId;
		}
		public String getChnlTypeCd() {
			return chnlTypeCd;
		}
		public void setChnlTypeCd(String chnlTypeCd) {
			this.chnlTypeCd = chnlTypeCd;
		}
		public String getRid() {
			return rid;
		}
		public void setRid(String rid) {
			this.rid = rid;
		}
	
}
