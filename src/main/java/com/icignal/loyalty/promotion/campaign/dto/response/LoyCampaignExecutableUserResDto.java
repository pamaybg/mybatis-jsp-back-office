package com.icignal.loyalty.promotion.campaign.dto.response;

/**
 * @name : infavor.marketing.campaign.dto.response.MKTCampaignExecutableUserResponseDTO
 * @date : 2018. 1. 22.
 * @author : jh.kim
 * @description : 
 */
public class LoyCampaignExecutableUserResDto {
    
    private String authGroupUserYN; //권한을 가진 그룹의 유저인가
    private String createUserYN;    //작성자인가
    private String rqtrUserYN;      //요청자인가
    
    public String getAuthGroupUserYN() {
        return authGroupUserYN;
    }
    public void setAuthGroupUserYN(String authGroupUserYN) {
        this.authGroupUserYN = authGroupUserYN;
    }
    public String getCreateUserYN() {
        return createUserYN;
    }
    public void setCreateUserYN(String createUserYN) {
        this.createUserYN = createUserYN;
    }
    public String getRqtrUserYN() {
        return rqtrUserYN;
    }
    public void setRqtrUserYN(String rqtrUserYN) {
        this.rqtrUserYN = rqtrUserYN;
    }
}
