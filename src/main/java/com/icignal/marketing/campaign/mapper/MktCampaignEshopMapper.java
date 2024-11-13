package com.icignal.marketing.campaign.mapper;

import com.icignal.core.annotation.handler.EshopMapper;
import com.icignal.marketing.campaign.dto.request.*;
import com.icignal.marketing.campaign.dto.response.*;

import java.util.List;


/**
 * @name : IMktCampaign.java
 * @date : 2015. 9. 23.
 * @author : dg.ryu
 * @description : 캠페인 DAO Interface
 */
@EshopMapper
public interface MktCampaignEshopMapper {

    int selectOfferDataIsNull(MktCampaignReqDto param);

    int selectOfferDataCheck(MktCampaignReqDto param);

    int selectSendOfferCount(MktCampaignReqDto param);

}