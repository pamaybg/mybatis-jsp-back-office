package com.icignal.auth.dto.request;

public class InitPasswordReqDto  {
    private String callbackNo;
    private String receiveMobileNo;
    private String message;
    private String userId;
    private String password;
    private String empName;
    private String plcyCd;
    private String subject;

    public String getReceiveMobileNo() {return receiveMobileNo;}
    public void setReceiveMobileNo(String receiveMobileNo) {this.receiveMobileNo = receiveMobileNo;}
    public String getCallbackNo() {return callbackNo;}
    public void setCallbackNo(String callbackNo) {this.callbackNo = callbackNo;}
    public String getMessage() {return message;}
    public void setMessage(String message) {this.message = message;}
    public String getUserId() {return userId;}
    public void setUserId(String userId) {this.userId = userId;}
    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}
    public String getEmpName() {return empName;}
    public void setEmpName(String empName) {this.empName = empName;}
    public String getPlcyCd() {return plcyCd;}
    public void setPlcyCd(String plcyCd) {this.plcyCd = plcyCd;}
    public String getSubject() {return subject;}
    public void setSubject(String subject) {this.subject = subject;}
}
