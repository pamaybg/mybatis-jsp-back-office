package com.icignal.loyalty.promotion.offer.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.promotion.offer.dto.request.LoyGetOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferChildOfferDtlReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferDeleteRequestDTO;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferExpDividReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferInsertReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferMstReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferProdReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferChnlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferProdResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferExpDividResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstListResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferPntDtlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferRelCampaignResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferUseLmtChnlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferUseLmtProdResDto;

@Mapper
public interface LoyOfferMapper {

	public List<LoyOfferMstListResDto> selectLoyOfferMstList(LoyOfferMstReqDto param);

	public String createOfferNum();

	public Integer insertLoyOfferMst(LoyOfferMstReqDto lomr);

	public void updateLoyOfferMst(LoyOfferMstReqDto lomr);

	public void deleteLoyOfferMst(LoyOfferMstReqDto lomr);

	public LoyOfferMstResDto selectLoyOfferMst(LoyOfferMstReqDto lomr);

	public List<LoyOfferExpDividResDto> selectLoyOfferExpDividList(LoyOfferExpDividReqDto loedr);

	public Integer insertLoyOfferExpDivid(LoyOfferExpDividReqDto loedr);

	public void updateLoyOfferExpDivid(LoyOfferExpDividReqDto loedr);

	public void deleteLoyOfferExpDivid(LoyOfferExpDividReqDto loedr);

	public List<LoyOfferRelCampaignResDto> selectLoyOfferRelCampaignList(
			LoyGetOfferReqDto lorcr);

	public List<LoyOfferUseLmtChnlResDto> selectLoyOfferUseLmtChnlList(LoyGetOfferReqDto loulcr);

	public Integer insertLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr);

	public void updateLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr);

	public void deleteLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr);

	public List<LoyOfferUseLmtProdResDto> selectLoyOfferUseLmtProdList(LoyGetOfferReqDto loulpr);

	public Integer insertLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr);

	public void updateLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr);

	public void deleteLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr);

	public List<LoyOfferPntDtlResDto> selectLoyOfferPntDtlList(LoyGetOfferReqDto lopdr);

	public Integer insertLoyOfferPntDtl(LoyGetOfferReqDto param);

	public void updateLoyOfferPntDtl(LoyGetOfferReqDto param);

	public void deleteLoyOfferPntDtl(LoyGetOfferReqDto param);

	public Integer checkActCamUsingOffer(LoyOfferMstReqDto lomr);

	public List<LOYGetOfferChnlResDto> selectOfferChnlList(LoyGetOfferReqDto param);

	public Integer checkOfferChnlExist(LoyGetOfferReqDto param);

	public void insertOfferChnl(LoyGetOfferReqDto param);

	public void deleteOfferChnl(LoyGetOfferReqDto param);

	public List<LOYGetOfferProdResDto> selectOfferProdList(LoyGetOfferReqDto param);

	public Integer checkOfferProdExist(LoyOfferProdReqDto param);

	public void insertOfferProd(LoyOfferProdReqDto param);

	public void deleteOfferProd(LoyOfferProdReqDto param);

	public void createOfferCoupon(LoyOfferMstReqDto lomr);

	public void editLoyOfferCouponMst(LoyOfferMstReqDto lomr);

	public LoyOfferMstResDto getCamMstInfo(LoyOfferMstReqDto lomr);

	public void deleteLoyOfferCouponMst(LoyOfferMstReqDto lomr);

	public List<LoyOfferResDto> selectListOffer(LoyOfferReqDto mor);

	public void insertOffer(LoyOfferInsertReqDto met);

	public void removeExpDividList(LoyOfferExpDividReqDto expDividInfo);

	public void insertExpDividList(LoyOfferExpDividReqDto expDividInfo);

	public void updateExpDividList(LoyOfferExpDividReqDto expDividInfo);

	public void removeChildOfferList(LoyOfferChildOfferDtlReqDto childOfferInfo);


	public void updateChildOfferList(LoyOfferChildOfferDtlReqDto childOfferInfo);

	public void insertChildOfferList(LoyOfferChildOfferDtlReqDto childOfferInfo);

	public void deleteOffer(LoyOfferDeleteRequestDTO mor);




}
