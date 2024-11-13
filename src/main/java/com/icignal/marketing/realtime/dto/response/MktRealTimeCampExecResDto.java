package com.icignal.marketing.realtime.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktRealTimeCampExecResDto extends GridPagingItemResDto{


	

    private String rid;
    private String processNm;  /*서비스 명*/
    private String processCd;  /*서비스 코드*/
    private String processStatus;  /*처리기 상태*/
    private String serviceStatus; /*서비스 상태*/
    private String serviceStatusName;
    private String triggerType;  /*이벤트 유형*/
    private String hndlMq;  /*핸들MQ*/
    private String waitMq;  /*대기MQ*/
    private String errMq; /*에러MQ*/
    private String svcExeMq;
    private Integer cachePort;
    private String startDt;  /*시작일시*/
    private String stopDt;  /*종료일시*/
    private String minWorker;  /*최저 worker*/
    private String maxWorker;  /*최대 worker*/
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getProcessNm() {
		return processNm;
	}
	public void setProcessNm(String processNm) {
		this.processNm = processNm;
	}
	public String getProcessCd() {
		return processCd;
	}
	public void setProcessCd(String processCd) {
		this.processCd = processCd;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getServiceStatus() {
		return serviceStatus;
	}
	public void setServiceStatus(String serviceStatus) {
		this.serviceStatus = serviceStatus;
	}
	public String getServiceStatusName() {
		return serviceStatusName;
	}
	public void setServiceStatusName(String serviceStatusName) {
		this.serviceStatusName = serviceStatusName;
	}
	public String getTriggerType() {
		return triggerType;
	}
	public void setTriggerType(String triggerType) {
		this.triggerType = triggerType;
	}
	public String getHndlMq() {
		return hndlMq;
	}
	public void setHndlMq(String hndlMq) {
		this.hndlMq = hndlMq;
	}
	public String getWaitMq() {
		return waitMq;
	}
	public void setWaitMq(String waitMq) {
		this.waitMq = waitMq;
	}
	public String getErrMq() {
		return errMq;
	}
	public void setErrMq(String errMq) {
		this.errMq = errMq;
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
    
    
}
