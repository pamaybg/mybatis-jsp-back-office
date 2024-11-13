package com.icignal.loyalty.promotion.ruleset.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyBrdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyChannelListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyTierListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyPromProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetMstReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondChnlListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondTimeListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetMbrDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetMbrReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPaymentStandardListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPromProductListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPrvBnfDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPrvBnfListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPymntPolicyListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSdayDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSdayReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSpecificDayListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetTranDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetTranReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyBrdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyChannelListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyTierListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyPromProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondChnlListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondTimeListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetDtlResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetMbrResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPaymentStandardListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPrvBnfListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPymntPolicyListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetSdayResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetSpecificDayListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetTranResDto;

@Mapper
public interface LoyRuleSetMapper {

	public LoyRulesetDtlResDto selectLoyRulesetDtl(LoyRulesetDtlReqDto rulesetDtlParam);

	public void deleteRuleSet(LoyRulesetDtlReqDto delparam);

	public List<LoyRulesetPrvBnfListResDto> selectRulesetPrvBnfList(LoyRulesetPrvBnfListReqDto prvbnfListReq);

	public LoyRulesetMbrResDto selectLoyRulesetMbr(LoyRulesetMbrReqDto mbrReq);

	public void removeRulesetPrvBnf(LoyRulesetPrvBnfDtlReqDto prvbnfDelReq);

	public void removeRulesetMbr(LoyRulesetMbrDtlReqDto mbrDelReq);

	public LoyRulesetTranResDto selectLoyRulesetTran(LoyRulesetTranReqDto tranReq);

	public void removeRulesetTran(LoyRulesetTranDtlReqDto tranDelReq);

	public LoyRulesetSdayResDto selectLoyRulesetSday(LoyRulesetSdayReqDto sdayReq);

	public void removeRulesetSday(LoyRulesetSdayDtlReqDto sdayDelReq);

	public void insertLoyRuleSetMst(LoyRuleSetMstReqDto loyRuleSetMstRequestDTO);

	public void deleteLoyRulesetPaymentPolicyList(LoyRuleSetMstReqDto rsmr);

	public List<LoyRulesetPymntPolicyListResDto> selectPaymentPolicyList(
			LoyRulesetPymntPolicyListReqDto param);

	public List<LoyRulesetCondProdListResDto> selectCondProdList(LoyRulesetCondProdListReqDto param);

	public List<LoyRulesetCondChnlListResDto> selectCondChnlList(LoyRulesetCondChnlListReqDto param);

	public List<LoyRulesetCondTimeListResDto> selectCondTime(LoyRulesetCondTimeListReqDto param);

	public List<LoyRulesetPaymentStandardListResDto> selectPaymentStandardList(
			LoyRulesetPaymentStandardListReqDto param);

	public List<LoyRulesetSpecificDayListResDto> selectSpecificDayList(LoyRulesetSpecificDayListReqDto param);

	public void updateCampaignMstPromType(LoyRuleSetReqDto rsr);

	public int insertRuleSet(LoyRulesetDtlReqDto rsmr);

	public void updateRuleSet(LoyRulesetDtlReqDto rsmr);

	public void deleteLoyRulesetCondChnlList(LoyRulesetCondChnlListReqDto param);

	public void insertLoyRulesetCondChnlList(List<LoyRulesetCondChnlListReqDto> param);

	public void insertLoyRulesetCondTimeList(List<LoyRulesetCondTimeListReqDto> param);

	public void deleteLoyRulesetSpecificDayList(LoyRulesetSpecificDayListReqDto param);

	public void deleteLoyRulesetPaymentStandardList(LoyRulesetPaymentStandardListReqDto param);

	public void insertLoyRulesetPaymentStandardList(List<LoyRulesetPaymentStandardListReqDto> param);

	public void insertLoyRulesetSpecificDayList(List<LoyRulesetSpecificDayListReqDto> param);

	public void removeLoyAllRulesetCondProd(LoyRulesetDtlReqDto rsmr);

	public void removeProductPromAll(LoyRulesetPromProductListReqDto rsmr);

	public void updateLoyRulesetCondProd(LoyRulesetCondProdListReqDto rsmr);

	public void updatePromNewMember(LoyRuleSetReqDto param);

	public void deletePromNewMember(LoyRuleSetReqDto param);

	public void removeLoyRulesetCondProd(LoyRulesetCondProdListReqDto rsmr);

	public int insertLoyRulesetCondProd(LoyRulesetCondProdListReqDto rslr);

	public void deleteLoyRulesetCondTimeList(LoyRulesetCondTimeListReqDto param);

	public int selectValidPromProdTerm(LoyCampaignStatusCheckReqDto cscr);

	public int selectValidPromProd(LoyCampaignStatusCheckReqDto cscr);
	/////


	public List<LoyProdListResDto> selectLoyProdList(LoyProdListReqDto param);

	public List<LoyProdCategoryListResDto> selectLoyProdCategoryList(LoyProdCategoryListReqDto param);

	public List<LoyBrdCategoryListResDto> selectLoyBrdCategoryList(LoyBrdCategoryListReqDto param);

	public List<LoyChannelListResDto> selectLoyChannelList(LoyChannelListReqDto param);

	public String selectLastModiyDateChannel();

	public List<HashMap<String, Object>> selectAllChannelList();

	public List<LoyTierListResDto> selectAllTierList(LoyTierListReqDto param);

	public List<LoyPromProdListResDto> selectPromProdList(LoyPromProdListReqDto param);

	public List<LoyPromProdListResDto> selectPromProdPopList(LoyPromProdListReqDto param);

	public void insertPromProduct(LoyRuleSetReqDto param);

	public int selectProductPromValid(LoyRulesetPromProductListReqDto promProd);

	public void removeProductPromValid(LoyRulesetPromProductListReqDto removeProd);

	public List<LoyTierListResDto> selectTierList(LoyTierListReqDto param);

	


}
