/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoySurveyMapper.java
 * 2. Package	: com.icignal.loyalty.survey.mapper
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오전 10:47:48
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------
 */
package com.icignal.loyalty.survey.mapper;

import java.util.List;

import com.icignal.loyalty.survey.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.survey.dto.request.LoySurveyDetailReqDto;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.vo.LoySurveyCopyVo;
import com.icignal.loyalty.survey.dto.vo.LoySurveyResultDetailHeaderVo;
import com.icignal.systemmanagement.apispec.dto.vo.LoySurveyEnterApiVo;
import com.icignal.systemmanagement.apispec.dto.vo.LoySurveyEnterYnApiVo;
import com.icignal.systemmanagement.apispec.dto.vo.LoySurveyInfoApiVo;

/*
 * 1. 클래스명	: LoySurveyMapper
 * 2. 파일명	: LoySurveyMapper.java
 * 3. 패키지명	: com.icignal.loyalty.survey.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoySurveyMapper {

    /*
     * 1. 메소드명: selectSurveyList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    List<LoySurveyListResDto> selectSurveyList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    LoySurveyDetailResDto selectSurveyDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyDetailForImages
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: 윤법공
     * 4. 작성일자: 2022. 1. 28.
     */
    LoySurveyDetailResDto selectSurveyDetailForImages(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveyDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void insertSurveyDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: updateSurveyDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void updateSurveyDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    void deleteSurveyDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveySectionList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    List<LoySurveySectionListResDto> selectSurveySectionList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveySectionDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    LoySurveySectionListResDto selectSurveySectionDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveySectionDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void insertSurveySectionDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: updateSurveySectionDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void updateSurveySectionDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveySectionDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void deleteSurveySectionDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    List<LoySurveyItemListResDto> selectSurveyItemList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    LoySurveyItemListResDto selectSurveyItemDetail(LoySurveyDetailReqDto reqDto);

    Integer selectExistsGiveOfferFlagItem(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveyItemDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void insertSurveyItemDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: updateSurveyItemDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void updateSurveyItemDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyItemDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void deleteSurveyItemDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyItemDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    void deleteSurveyItemAll(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemAttrList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    List<LoySurveyItemAttrListResDto> selectSurveyItemAttrList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    LoySurveyItemAttrListResDto selectSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto);

    Integer selectExistsNaItemAttr(LoySurveyDetailReqDto reqDto);

    Integer selectExistsGiveOfferFlagItemAttr(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void insertSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveyItemAttrAll
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void insertSurveyItemAttrAll(List<LoySurveyDetailReqDto> reqList);

    /*
     * 1. 메소드명: updateSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void updateSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void deleteSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void deleteSurveyItemAttrAll(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyOfferList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    List<LoySurveyOfferListResDto> selectSurveyOfferList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyOfferDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    LoySurveyOfferListResDto selectSurveyOfferDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: insertSurveyOfferDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void insertSurveyOfferDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: updateSurveyOfferDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void updateSurveyOfferDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyOfferDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void deleteSurveyOfferDetail(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyOfferAll
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void deleteSurveyOfferAll(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyMemberList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    List<LoySurveyMemberListResDto> selectSurveyMemberList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: clearSurveyMemberMaskingDetail
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    LoySurveyMemberListResDto clearSurveyMemberMaskingDetail(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: deleteSurveyMemberAll
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    void deleteSurveyMemberAll(LoySurveyDetailReqDto reqDto);

    LoySurveyResultSummaryResDto selectSurveyResultSummary(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyResultList
     * 2. 클래스명: LoySurveyMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    List<LoySurveyResultListResDto> selectSurveyResultList(LoySurveyListReqDto reqDto);

    String selectSurveyOfferType(LoySurveyListReqDto reqDto);

    List<LoySurveyResultDetailHeaderVo> selectSurveyResultDetailHeaderList(LoySurveyListReqDto reqDto);

    List<LoySurveyResultListResDto> selectSurveyResultDtlList(LoySurveyListReqDto reqDto);

    List<LoySurvRsltExcelDnResDto> selectSurveyResultDetailList(LoySurveyListReqDto reqDto);

    void insertSurveyDetailCopy(LoySurveyDetailReqDto reqDto);

    List<LoySurveyCopyVo> selectSurveySectionCopyRidList(LoySurveyDetailReqDto reqDto);

    void insertSurveySectionCopy(LoySurveyDetailReqDto reqDto);

    List<LoySurveyCopyVo> selectSurveyItemCopyRidList(LoySurveyDetailReqDto reqDto);

    void insertSurveyItemCopy(LoySurveyDetailReqDto reqDto);

    void insertSurveyItemAttrCopy(LoySurveyDetailReqDto reqDto);

    /*
     * 1. 메소드명: getContentSurveyList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: gy.lee
     */
    List<LoySurveyListResDto> selectContentSurveyList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: getSurveyAnalysis
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: ps.lee
     */
	List<LoySurveyAnalysisResDto> selectSurveyAnalysis(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectTextItemList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     */
    List<LoySurveyTextItemListResDto> selectTextItemList(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveySectionRid
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: bg.yoon
     */
    String selectSurveySectionRidForAttr(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemRid
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: bg.yoon
     */
    String selectSurveyItemRidControlled(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: initSurveyItemControlled
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: bg.yoon
     */
    void initSurveyItemControlled(LoySurveyListReqDto reqDto);

    /*
     * 1. 메소드명: selectSurveyItemListPop
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     */
    List<LoySurveyItemListResDto> selectSurveyItemListPop(LoySurveyListReqDto reqDto);
}