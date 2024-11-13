package com.icignal.marketing.campaign.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2015. 10. 19.
 * @author : 류동균
 * @description : 
 */
public class MktCampaignWorkflowResDto extends StatusResDto {
	
    private String id;    //아이디
    private String stautsCd;    //상태
    private String createBy;    //생성자
    private String modifyBy;    //수정자
  
    private List<MktCampaignWorkflowNodeDataResDto> nodeList;    //node 목록
    
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public List<MktCampaignWorkflowNodeDataResDto> getNodeList() {
        return nodeList;
    }

    public void setNodeList(List<MktCampaignWorkflowNodeDataResDto> nodeList) {
        this.nodeList = nodeList;
    }

    public String getStautsCd() {
        return stautsCd;
    }

    public void setStautsCd(String stautsCd) {
        this.stautsCd = stautsCd;
    }



	
}
