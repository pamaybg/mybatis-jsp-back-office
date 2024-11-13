package com.icignal.loyalty.survey.service;

import java.io.File;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;

import com.icignal.common.util.ObjectUtil;
import com.icignal.loyalty.survey.dto.response.*;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.request.UploadImageReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.mapper.CommonMapper;
import com.icignal.common.excel.service.ExcelService;
import com.icignal.common.excel.vo.ExcelCustomDataVo;
import com.icignal.common.excel.vo.ExcelDownloadDto;
import com.icignal.common.excel.writer.ExcelSheetWriter;
import com.icignal.common.excel.writer.ExcelWriter;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.ListResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.FTPUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.exception.DataFailException;
import com.icignal.loyalty.survey.dto.request.LoySurveyDetailReqDto;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.vo.LoySurveyCopyVo;
import com.icignal.loyalty.survey.mapper.LoySurveyMapper;

/*
 * 1. 클래스명	: LoySurveyService
 * 2. 파일명	: LoySurveyService.java
 * 3. 패키지명	: com.icignal.loyalty.survey.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */
@Service
public class LoySurveyService {

    final static private Logger log = LoggerFactory.getLogger(LoySurveyService.class);

    final static private String SURVEY_UPLOAD_PATH = "survey_images";

    @Autowired
    private CommonMapper commonMapper;
    @Autowired
    private ExcelService excelService;
    @Autowired
    private LoySurveyMapper loySurveyMapper;
    @Autowired
    private LoggingHelper loggingHelper;
    @Autowired
    private ServletContext servletContext;

    /*
     * 1. 메소드명: getSurveyList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    public GridPagingResDto<LoySurveyListResDto> getSurveyList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                loySurveyMapper.selectSurveyList(reqDto),
                AnnotationType.CommCode);
    }

    /*
     * 1. 메소드명: getSurveyDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    public LoySurveyDetailResDto getSurveyDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        //LoySurveyDetailResDto res = loySurveyMapper.selectSurveyDetail(reqDto);
        LoySurveyDetailResDto res = loySurveyMapper.selectSurveyDetailForImages(reqDto);
        return new AnnotationHelper<>(AnnotationType.Nothing, res).getItem();
    }

    /*
     * 1. 메소드명: addSurveyDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    @Transactional
    public LoySurveyResDto addSurveyDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setRidSurvey(CommonUtil.newRid());

        if (reqDto.getStartImageData() != null) {
            reqDto.setRidSurveyItem(reqDto.getRidSurvey());
            this.addSurveyItemImage(reqDto, reqDto.getStartImageData(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.START.name());
        }
        if (reqDto.getEndImageData() != null) {
            reqDto.setRidSurveyItem(reqDto.getRidSurvey());
            this.addSurveyItemImage(reqDto, reqDto.getEndImageData(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.END.name());
        }

        this.loySurveyMapper.insertSurveyDetail(reqDto);
        return new LoySurveyResDto(true, reqDto.getRidSurvey());
    }

    /*
     * 1. 메소드명: modifySurveyDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public LoySurveyResDto modifySurveyDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        // 시작이미지 저장
        if (reqDto.getRidStartImage() == null) {
            reqDto.setRidSurveyItem(reqDto.getRidSurvey());
            this.removeSurveyImage(reqDto.getRidSurvey(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.START.name());
            if (reqDto.getStartImageData() != null) {
                reqDto.setRidSurveyItem(reqDto.getRidSurvey());
                this.addSurveyItemImage(reqDto, reqDto.getStartImageData(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.START.name());
            }
        }

        // 종료이미지 저장
        if (reqDto.getRidEndImage() == null) {
            reqDto.setRidSurveyItem(reqDto.getRidSurvey());
            this.removeSurveyImage(reqDto.getRidSurvey(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.END.name());

            if (reqDto.getEndImageData() != null) {
                reqDto.setRidSurveyItem(reqDto.getRidSurvey());
                this.addSurveyItemImage(reqDto, reqDto.getEndImageData(), CommonUtil.SURVEY_DETAIL_IMAGE_TYPE.END.name());
            }
        }

        //LoySurveyDetailResDto res = loySurveyMapper.selectSurveyDetail(reqDto);
        LoySurveyDetailResDto detailResDto = this.loySurveyMapper.selectSurveyDetailForImages(reqDto);
        if (detailResDto == null) {
            return new LoySurveyResDto(false, "존재 하지 않는 설문 입니다.", null);
        }

        // 요청 상태 가 작성 중인데, 조회 결과 상태는 활성화라면 저장 불가
        if ("W".equals(reqDto.getStatusCode()) && "A".equals(detailResDto.getStatusCode())) {
            return new LoySurveyResDto(false, "작성 중으로 돌아갈 수 없습니다.", null);
        }

        if ("A".equals(reqDto.getStatusCode())) {
            String mobileBaseUri = BeansUtil.getApplicationProperty("common.base-uri");
            String surveyUrl = BeansUtil.getApplicationProperty("common.survey-uri");

            //String url = String.format("%s%s?ridSurv=%s&previewFlag=Y", mobileBaseUri, surveyUrl, reqDto.getRidSurvey());
            String url = String.format("%s%s?ridSurv=%s&usrTypeCd=%s&mbrNo=", mobileBaseUri, surveyUrl, reqDto.getRidSurvey(), reqDto.getUsrTypeCd());
            reqDto.setUrlWeb(url);
        }

        this.loySurveyMapper.updateSurveyDetail(reqDto);

        return new LoySurveyResDto(true, reqDto.getRidSurvey());
    }

    /*
     * 1. 메소드명: removeSurveyDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 6. 23.
     */
    @Transactional
    public StatusResDto removeSurveyDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        this.loySurveyMapper.deleteSurveyMemberAll(reqDto);
        this.loySurveyMapper.deleteSurveyOfferAll(reqDto);
        this.loySurveyMapper.deleteSurveyItemAttrAll(reqDto);
        this.loySurveyMapper.deleteSurveyItemAll(reqDto);
        this.loySurveyMapper.deleteSurveySectionDetail(reqDto);
        this.loySurveyMapper.deleteSurveyDetail(reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);
        return rtnValue;
    }


    /*
     * 1. 메소드명: getSurveySectionList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    public GridPagingResDto<LoySurveySectionListResDto> getSurveySectionList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveySectionListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveySectionList(reqDto),
                AnnotationType.CommCode);
    }

    /*
     * 1. 메소드명: getSurveySectionDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    public LoySurveySectionListResDto getSurveySectionDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        return loySurveyMapper.selectSurveySectionDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveySectionDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto addSurveySectionDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 신규 작성 할 수 없습니다.");
        }

        this.loySurveyMapper.insertSurveySectionDetail(reqDto);

        return new StatusResDto(true, reqDto.getRidSurveySection());
    }

    /*
     * 1. 메소드명: modifySurveySectionDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto modifySurveySectionDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 수정할 수 없습니다.");
        }

        LoySurveySectionListResDto itemResDto = this.loySurveyMapper.selectSurveySectionDetail(reqDto);
        if (itemResDto == null) {
            return new StatusResDto(false, "존재 하지 않는 구간 입니다.");
        }

        this.loySurveyMapper.updateSurveySectionDetail(reqDto);

        return new StatusResDto(true, reqDto.getRidSurveySection());
    }

    /*
     * 1. 메소드명: removeSurveySectionDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto removeSurveySectionDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 삭제할 수 없습니다.");
        }

        LoySurveyDetailReqDto deleteReqDto = new LoySurveyDetailReqDto();
        deleteReqDto.setEmpId(reqDto.getEmpId());
        deleteReqDto.setRidSurveySection(reqDto.getRidSurveySection());

        this.loySurveyMapper.deleteSurveyItemAttrAll(deleteReqDto);
        this.loySurveyMapper.deleteSurveyItemAll(deleteReqDto);
        this.loySurveyMapper.deleteSurveySectionDetail(deleteReqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: getSurveyItemList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    public GridPagingResDto<LoySurveyItemListResDto> getSurveyItemList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyItemListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyItemList(reqDto),
                AnnotationType.CommCode);
    }

    /*
     * 1. 메소드명: getSurveyItemDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    public LoySurveyItemListResDto getSurveyItemDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        return loySurveyMapper.selectSurveyItemDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyItemDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto addSurveyItemDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 신규 작성 할 수 없습니다.");
        }

        this.loySurveyMapper.insertSurveyItemDetail(reqDto);
        this.addDefaultSurveyItemAttr(reqDto);

        if (reqDto.getImageData() != null) {
            this.addSurveyItemImage(reqDto);
        }

        return new StatusResDto(true, reqDto.getRidSurveyItem());
    }

    /*
     * 1. 메소드명: modifySurveyItemDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto modifySurveyItemDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 수정할 수 없습니다.");
        }

        LoySurveyItemListResDto itemResDto = this.loySurveyMapper.selectSurveyItemDetail(reqDto);
        if (itemResDto == null) {
            return new StatusResDto(false, "존재 하지 않는 문항 입니다.");
        }

        // giveOfferFlag 체크박스 삭제 sy.cha 06.03
        /*Integer checkGiveOfferFlag = this.loySurveyMapper.selectExistsGiveOfferFlagItemAttr(reqDto);
        if ("Y".equals(reqDto.getGiveOfferFlag()) && checkGiveOfferFlag > 0) {
            return new StatusResDto(false, "오퍼 제공 체크 항목은 문항 정보, 항목 아이템 중 한 곳에서만 설정 가능합니다.");
        }*/

        this.loySurveyMapper.updateSurveyItemDetail(reqDto);

        String originFieldTypeCode = itemResDto.getFieldTypeCode();
        String fieldTypeCode = reqDto.getFieldTypeCode();
        if (!originFieldTypeCode.equals(fieldTypeCode)) {
            LoySurveyDetailReqDto itemAttrReqDto = new LoySurveyDetailReqDto();
            itemAttrReqDto.setEmpId(reqDto.getEmpId());
            itemAttrReqDto.setRidSurveyItem(reqDto.getRidSurveyItem());

            this.loySurveyMapper.deleteSurveyItemAttrAll(itemAttrReqDto);
            this.addDefaultSurveyItemAttr(reqDto);
        }

        if ("Y".equals(reqDto.getNaFlag())) {
            int existsNaAttr = this.loySurveyMapper.selectExistsNaItemAttr(reqDto);

            if (existsNaAttr == 0) {
                LoySurveyDetailReqDto existAttrDto = new LoySurveyDetailReqDto();
                existAttrDto.setRidSurveyItem(reqDto.getRidSurveyItem());
                existAttrDto.setEmpId(reqDto.getEmpId());
                existAttrDto.setItemAttrNo("99");
                existAttrDto.setItemAttrValue("해당 없음");

                this.loySurveyMapper.insertSurveyItemAttrDetail(existAttrDto);
            }
        }

        if (reqDto.getRidImage() == null) {
            this.removeSurveyImage(reqDto.getRidSurveyItem());

            if (reqDto.getImageData() != null) {
                this.addSurveyItemImage(reqDto);
            }
        }

        return new StatusResDto(true, reqDto.getRidSurveyItem());
    }

    /*
     * 1. 메소드명: removeSurveyItemDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @Transactional
    public StatusResDto removeSurveyItemDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 삭제할 수 없습니다.");
        }

        this.loySurveyMapper.deleteSurveyItemAttrAll(reqDto);

        this.removeSurveyImage(reqDto.getRidSurveyItem());

        this.loySurveyMapper.deleteSurveyItemDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: getSurveyItemAttrList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public GridPagingResDto<LoySurveyItemAttrListResDto> getSurveyItemAttrList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        return new GridPagingResHelper<LoySurveyItemAttrListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyItemAttrList(reqDto),
                AnnotationType.CommCode);
    }

    /*
     * 1. 메소드명: getSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public LoySurveyItemAttrListResDto getSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        return this.loySurveyMapper.selectSurveyItemAttrDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto addSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 신규 작성 할 수 없습니다.");
        }

        LoySurveyItemListResDto itemResDto = this.loySurveyMapper.selectSurveyItemDetail(reqDto);
        String fieldTypeCode = itemResDto.getFieldTypeCode();
        if ("INFO".equals(fieldTypeCode) || "TEXT".equals(fieldTypeCode) || "DROP_SCORE".equals(fieldTypeCode)) {
            return new StatusResDto(false, "필드타입이 \"텍스트\", \"드롭다운(점수)\" 일 경우에는 항목을 추가할 수 없습니다.");
        }

        if ("Y".equals(reqDto.getGiveOfferFlag()) && "Y".equals(itemResDto.getGiveOfferFlag())) {
            return new StatusResDto(false, "오퍼 제공 체크 항목은 문항 정보, 항목 아이템 중 한 곳에서만 설정 가능합니다.");
        }

        this.loySurveyMapper.insertSurveyItemAttrDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: modifySurveyItemAttrDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto modifySurveyItemAttrDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 수정할 수 없습니다.");
        }

        LoySurveyItemAttrListResDto itemAttrResDto = this.loySurveyMapper.selectSurveyItemAttrDetail(reqDto);
        if (itemAttrResDto == null) {
            return new StatusResDto(false, "존재하지 않는 항목 아이템 입니다.");
        }

        Integer checkGiveOfferFlag = this.loySurveyMapper.selectExistsGiveOfferFlagItem(reqDto);
        if ("Y".equals(reqDto.getGiveOfferFlag()) && checkGiveOfferFlag > 0) {
            return new StatusResDto(false, "오퍼 제공 체크 항목은 문항 정보, 항목 아이템 중 한 곳에서만 설정 가능합니다.");
        }

        this.loySurveyMapper.updateSurveyItemAttrDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: removeSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto removeSurveyItemAttrDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 삭제할 수 없습니다.");
        }

        this.loySurveyMapper.deleteSurveyItemAttrDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: getSurveyMemberList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public GridPagingResDto<LoySurveyMemberListResDto> getSurveyMemberList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        return new GridPagingResHelper<LoySurveyMemberListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyMemberList(reqDto),
                AnnotationType.PersonalData);
    }

    /*
     * 1. 메소드명: clearSurveyMemberMaskingDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public LoySurveyMemberListResDto clearSurveyMemberMaskingDetail(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        this.loggingHelper.insertCustReleaLog(reqDto, "loy_Survey"); // 이력 저장

        return new AnnotationHelper<>(
                AnnotationType.PersonalData,
                this.loySurveyMapper.clearSurveyMemberMaskingDetail(reqDto)
        ).getItem();
    }

    /*
     * 1. 메소드명: getSurveyOfferList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public GridPagingResDto<LoySurveyOfferListResDto> getSurveyOfferList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        return new GridPagingResHelper<LoySurveyOfferListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyOfferList(reqDto),
                AnnotationType.ALL);
    }

    /*
     * 1. 메소드명: getSurveyOfferDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public LoySurveyOfferListResDto getSurveyOfferDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        return loySurveyMapper.selectSurveyOfferDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyOfferDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto addSurveyOfferDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 신규 작성 할 수 없습니다.");
        }

        this.loySurveyMapper.insertSurveyOfferDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: modifySurveyOfferDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto modifySurveyOfferDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 수정할 수 없습니다.");
        }

        LoySurveyOfferListResDto offerResDto = this.loySurveyMapper.selectSurveyOfferDetail(reqDto);
        if (offerResDto == null) {
            return new StatusResDto(false, "존재하지 않는 오퍼 정보 입니다.");
        }

        this.loySurveyMapper.updateSurveyOfferDetail(reqDto);

        return new StatusResDto(true, "");
    }

    /*
     * 1. 메소드명: removeSurveyOfferDetail
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @Transactional
    public StatusResDto removeSurveyOfferDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        Pair<Boolean, String> checkPair = this.checkSurveyStatus(reqDto.getRidSurvey());
        if (!checkPair.getLeft()) {
            return new StatusResDto(false, checkPair.getRight() != null ? checkPair.getRight() : "작성 중이 아닐 때는 삭제할 수 없습니다.");
        }

        this.loySurveyMapper.deleteSurveyOfferDetail(reqDto);

        return new StatusResDto(true, "");
    }

    public LoySurveyResultSummaryResDto getSurveyResultSummary(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        return this.loySurveyMapper.selectSurveyResultSummary(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyResultList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    public GridPagingResDto<LoySurveyResultListResDto> getSurveyResultList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyResultListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyResultList(reqDto),
                AnnotationType.CommCode);
    }

    /*
     * 1. 메소드명: selectSurveyResultDtlList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: sj.jung
     * 4. 작성일자: 2022. 3. 14.
     */
    public GridPagingResDto<LoySurveyResultListResDto> selectSurveyResultDtlList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyResultListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyResultDtlList(reqDto),
                AnnotationType.CommCode);
    }

    //설문결과 요약 엑셀 다운로드
    public ExcelDownloadDto downloadSurveyResultSummary(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        try {
            ExcelWriter writer = new ExcelWriter("설문_결과_요약");
            ExcelSheetWriter sheetWriter = writer.createSheet("설문_결과_요약");

            // 결과 요약 설정
            sheetWriter.addTitle("결과 요약");
            sheetWriter.setupTargetClass(LoySurveyResultListResDto.class);

            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            DecimalFormat rateFormat = new DecimalFormat("###.##%");

            LoySurveyDetailReqDto detailReqDto = new LoySurveyDetailReqDto();
            detailReqDto.setRid(reqDto.getRid());

            LoySurveyResultSummaryResDto summaryResDto = this.loySurveyMapper.selectSurveyResultSummary(detailReqDto);
            List<ExcelCustomDataVo> customDataList = Arrays.asList(
                    ExcelCustomDataVo.builder()
                            .header("총 대상자")
                            .value(decimalFormat.format(summaryResDto.getTotalCount()))
                            .build(),
                    ExcelCustomDataVo.builder()
                            .header("참여자")
                            .value(decimalFormat.format(summaryResDto.getEnterCount()))
                            .build(),
                    ExcelCustomDataVo.builder()
                            .header("참여율")
                            .value(rateFormat.format(summaryResDto.getEnterRate()))
                            .build()
            );
            sheetWriter.addSheetVerticalCustomDataList(customDataList);

            sheetWriter.addEmptyRow();

            // 항목별 요약 설정
            sheetWriter.addTitle("항목별 요약");
            this.excelService.executeExcelDataDownload(sheetWriter, (offset, chunkSize) -> {
                reqDto.setSkipCount(offset);
                reqDto.setPageSize(chunkSize);
                reqDto.init(CommonUtil.getInstance().getDBType());

                List<LoySurveyResultListResDto> selectedList = this.loySurveyMapper.selectSurveyResultList(reqDto);
                return ListResHelper.convertAnnotationData(selectedList, AnnotationType.CommCode);
            });

            ExcelDownloadDto dto = new ExcelDownloadDto(true, "");
            dto.setupFileDetail(writer.save());
            return dto;
        } catch (Exception e) {
            throw new DataFailException(e, "엑셀 다운로드 처리 중 오류가 발생하였습니다.");
        }
    }

    //설문 결과 상세 엑셀 다운로드
    public GridPagingResDto<LoySurvRsltExcelDnResDto> downloadSurveyResultDetail(LoySurveyListReqDto reqDto) {
        //log.debug("{}", reqDto);
        return new GridPagingResHelper<LoySurvRsltExcelDnResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loySurveyMapper.selectSurveyResultDetailList(reqDto), AnnotationType.CommCode);
    }

    //설문 결과 상세 엑셀 다운로드
//    public ExcelDownloadDto downloadSurveyResultDetail(LoySurveyListReqDto reqDto) {
//        log.debug("{}", reqDto);
//
//        String offerType = this.loySurveyMapper.selectSurveyOfferType(reqDto);
//        reqDto.setOfferType(offerType);
//
//        try {
//            ExcelWriter writer = new ExcelWriter("설문_결과_상세");
//            ExcelSheetWriter sheetWriter = writer.createSheet("설문_결과_상세");
//            sheetWriter.setupTargetClass(LoySurveyResultDetailListResDto.class);
//
//            List<LoySurveyResultDetailHeaderVo> headerList = this.loySurveyMapper.selectSurveyResultDetailHeaderList(reqDto);
//            reqDto.setHeaderList(headerList);
//            sheetWriter.addHeaderNameList(
//                    headerList.stream()
//                            .map(vo -> new ExcelFieldVo(vo.getHeaderKey(), vo.getHeaderTitle()))
//                            .collect(Collectors.toList())
//            );
//
//            this.excelService.executeExcelDataDownload(sheetWriter, (offset, chunkSize) -> {
//                reqDto.setSkipCount(offset);
//                reqDto.setPageSize(chunkSize);
//                reqDto.init(CommonUtil.getInstance().getDBType());
//
//                return ListResHelper.convertAnnotationData(this.loySurveyMapper.selectSurveyResultDetailList(reqDto), AnnotationType.CommCode);
//            });
//
//            ExcelDownloadDto dto = new ExcelDownloadDto(true, "");
//            dto.setupFileDetail(writer.save());
//            return dto;
//        } catch (Exception e) {
//            throw new DataFailException(e, "엑셀 다운로드 처리 중 오류가 발생하였습니다.");
//        }
//    }

    @Transactional
    public LoySurveyResDto copySurveyDetail(LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        //LoySurveyDetailResDto res = loySurveyMapper.selectSurveyDetail(reqDto);
        LoySurveyDetailResDto detailResDto = this.loySurveyMapper.selectSurveyDetailForImages(reqDto);
        if (detailResDto == null) {
            return new LoySurveyResDto(false, "존재 하지 않는 설문 입니다.", null);
        }

        // 1. 설문 마스터 복사
        this.loySurveyMapper.insertSurveyDetailCopy(reqDto);

        // 2. 설문 페이지 복사
        List<LoySurveyCopyVo> sectionCopyRidList = this.loySurveyMapper.selectSurveySectionCopyRidList(reqDto);
        if (sectionCopyRidList == null || sectionCopyRidList.isEmpty()) {
            return new LoySurveyResDto(true, "", reqDto.getRidSurveyCopy());
        }

        reqDto.setRidSurveySectionCopyList(sectionCopyRidList);
        this.loySurveyMapper.insertSurveySectionCopy(reqDto);

        // 3. 설문 문항 복사
        List<LoySurveyCopyVo> itemCopyRidList = this.loySurveyMapper.selectSurveyItemCopyRidList(reqDto);
        if (itemCopyRidList == null || itemCopyRidList.isEmpty()) {
            return new LoySurveyResDto(true, "", reqDto.getRidSurveyCopy());
        }

        reqDto.setRidSurveyItemCopyList(itemCopyRidList);
        this.loySurveyMapper.insertSurveyItemCopy(reqDto);

        // 4. 설문 보기 복사
        this.loySurveyMapper.insertSurveyItemAttrCopy(reqDto);

        return new LoySurveyResDto(true, "", reqDto.getRidSurveyCopy());
    }

    /*
     * 1. 메소드명: checkSurveyStatus
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 29.
     */
    private Pair<Boolean, String> checkSurveyStatus(String ridSurvey) {
        LoySurveyDetailReqDto reqDto = new LoySurveyDetailReqDto();
        reqDto.setRidSurvey(ridSurvey);

        //LoySurveyDetailResDto res = loySurveyMapper.selectSurveyDetail(reqDto);
        LoySurveyDetailResDto resDto = this.loySurveyMapper.selectSurveyDetailForImages(reqDto);
        if (resDto == null) {
            return Pair.of(false, "존재 하지 않는 설문 입니다.");
        }

        return Pair.of("W".equals(resDto.getStatusCode()), "");
    }

    private void addDefaultSurveyItemAttr(LoySurveyDetailReqDto reqDto) {
        String fieldTypeCode = reqDto.getFieldTypeCode();
        List<LoySurveyDetailReqDto> surveyItemAttrList = new ArrayList<>();

        if ("DROP_NORMAL".equals(fieldTypeCode) || "DROP_SCORE".equals(fieldTypeCode)) {
            int no = 1;

            if ("DROP_SCORE".equals(fieldTypeCode)) {
                int startNum = reqDto.getStartNum();
                int endNum = reqDto.getEndNum();

                for (int i = startNum; i <= endNum; i++) {
                    String value = String.valueOf(i);

                    LoySurveyDetailReqDto dto = new LoySurveyDetailReqDto();
                    dto.setRidSurveyItem(reqDto.getRidSurveyItem());
                    dto.setEmpId(reqDto.getEmpId());
                    dto.setItemAttrNo(String.valueOf(no++));
                    dto.setItemAttrValue(value);

                    surveyItemAttrList.add(dto);
                }
            }

            if ("Y".equals(reqDto.getNaFlag())) {
                LoySurveyDetailReqDto dto = new LoySurveyDetailReqDto();
                dto.setRidSurveyItem(reqDto.getRidSurveyItem());
                dto.setEmpId(reqDto.getEmpId());
                dto.setItemAttrNo("99");
                dto.setItemAttrValue("해당 없음");

                surveyItemAttrList.add(dto);
            }
        }

        if (!surveyItemAttrList.isEmpty()) {
            this.loySurveyMapper.insertSurveyItemAttrAll(surveyItemAttrList);
        }
    }
    /*
     * 1. 메소드명: removeSurveyImage
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 1. 28.
     * 5. 설명: 설문 상세의 이미지가 한개일 경우 사용
     */
    private void removeSurveyImage(String ridSurvey) {

        MultiUploadReqDto uploadReqDto = new MultiUploadReqDto();
        uploadReqDto.setParentId(ridSurvey);
        uploadReqDto.setCategory(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY);
        uploadReqDto.setSchemas("com");

        String imgFileName = commonMapper.selectImagePathParent(uploadReqDto);

        FTPUtil.deleteFile(imgFileName);
        this.commonMapper.deleteParentImages(uploadReqDto);
    }

    /*
     * 1. 메소드명: removeSurveyImage
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 1. 28.
     * 5. 설명: 설문 상세의 이미지가 두개일 경우 사용
     */
    private void removeSurveyImage(String ridSurvey, String type) {

        MultiUploadReqDto uploadReqDto = new MultiUploadReqDto();
        uploadReqDto.setParentId(ridSurvey);
        uploadReqDto.setType(type);
        uploadReqDto.setCategory(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY);
        uploadReqDto.setSchemas("com");

        String imgFileName = commonMapper.selectImagePathParent(uploadReqDto);
        /* C:/icignal/UploadFile 경로의 해당 이미지 삭제
        if(ObjectUtil.isNotEmpty(imgFileName)){
            String dir = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadFullPath");
            File file = new File(dir + imgFileName);

            if(file.exists()){
                file.delete();
            }
        } */
         
        FTPUtil.deleteFile(imgFileName);
        this.commonMapper.deleteParentImages(uploadReqDto);
    }

    private void removeSurveyItemImage(String ridSurveyItem, String empId) {

        MultiUploadReqDto uploadReqDto = new MultiUploadReqDto();
        uploadReqDto.setParentId(ridSurveyItem);
        uploadReqDto.setEmpId(empId);
        uploadReqDto.setCategory(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY);
        uploadReqDto.setSchemas("com");

        this.commonMapper.deleteParentImages(uploadReqDto);
    }

    /*
     * 1. 메소드명: addSurveyItemImage
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 1. 28.
     * 5. 설명: 설문 상세의 이미지가 한개일 경우 사용
     */
    private void addSurveyItemImage(LoySurveyDetailReqDto reqDto) {
        try {
            MultiUploadReqDto uploadReqDto = reqDto.getImageData();

            String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
            String fileName = FilenameUtils.removeExtension(uploadReqDto.getFileName());
            String extensions = uploadReqDto.getFileName().substring(uploadReqDto.getFileName().indexOf("."));
            File currentFile = Paths.get(servletContext.getRealPath(""), uploadReqDto.getFilePath()).toFile();

            UploadImageReqDto imageReqDto = new UploadImageReqDto();
            imageReqDto.setId(CommonUtil.newRid());
            imageReqDto.setImageFolder(Paths.get(SURVEY_UPLOAD_PATH, currentDate).toString());
            imageReqDto.setImageFileName(fileName);
            imageReqDto.setImageFileType(extensions);
            imageReqDto.setSeq(1);
            imageReqDto.setParentId(reqDto.getRidSurveyItem());
            imageReqDto.setEmpId(reqDto.getEmpId());
            imageReqDto.setSchemas("com");
            imageReqDto.setImageFlag(1);
            imageReqDto.setImageLang(reqDto.getLang());
            imageReqDto.setLang(reqDto.getLang());
            imageReqDto.setOriImageFileName(FilenameUtils.removeExtension(uploadReqDto.getFileName()));
            imageReqDto.setSize(currentFile.length());
            imageReqDto.setImageType(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY);
            imageReqDto.setMultiTableName("image");

            this.commonMapper.multiUploadImage(imageReqDto);

            FTPUtil.saveFile(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY.name(), currentDate, currentFile.getPath());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    /*
     * 1. 메소드명: addSurveyItemImage
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 1. 28.
     * 5. 설명: 설문 상세의 이미지가 두개일 경우 사용
     */
    private void addSurveyItemImage(LoySurveyDetailReqDto reqDto, MultiUploadReqDto imageData, String type) {
        try {
            /* C:/icignal/UploadFile 경로에 Temp 폴더의 파일 복사 로직
            MultiUploadReqDto uploadReqDto = imageData;

            String basePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadFullPath");
            String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

            Path directoryPath = Paths.get(basePath, SURVEY_UPLOAD_PATH, currentDate);
            if (!directoryPath.toFile().exists()) {
                directoryPath.toFile().mkdirs();
            }

            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            String extensions = FilenameUtils.getExtension(uploadReqDto.getFileName());
            Path targetPath = Paths.get(basePath, SURVEY_UPLOAD_PATH, currentDate, String.format("%s.%s", uuid, extensions));

            File currentFile = Paths.get(servletContext.getRealPath(""), uploadReqDto.getFilePath()).toFile();
            FileUtils.copyFile(currentFile, targetPath.toFile()); */

            MultiUploadReqDto uploadReqDto = imageData;

            String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
            String fileName = FilenameUtils.removeExtension(uploadReqDto.getFileName());
            String extensions = uploadReqDto.getFileName().substring(uploadReqDto.getFileName().indexOf("."));
            File currentFile = Paths.get(servletContext.getRealPath(""), uploadReqDto.getFilePath()).toFile();

            UploadImageReqDto imageReqDto = new UploadImageReqDto();
            imageReqDto.setId(CommonUtil.newRid());
            imageReqDto.setType(type);
            imageReqDto.setImageFolder(Paths.get(SURVEY_UPLOAD_PATH, currentDate).toString());
            //imageReqDto.setImageFileName(uuid);
            imageReqDto.setImageFileName(fileName);
            imageReqDto.setImageFileType(extensions);
            imageReqDto.setSeq(1);
            imageReqDto.setParentId(reqDto.getRidSurveyItem());
            imageReqDto.setEmpId(reqDto.getEmpId());
            imageReqDto.setSchemas("com");
            imageReqDto.setImageFlag(1);
            imageReqDto.setImageLang(reqDto.getLang());
            imageReqDto.setLang(reqDto.getLang());
            imageReqDto.setOriImageFileName(FilenameUtils.removeExtension(uploadReqDto.getFileName()));
            imageReqDto.setSize(currentFile.length());
            imageReqDto.setImageType(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY);
            imageReqDto.setMultiTableName("image");

            this.commonMapper.multiUploadImage(imageReqDto);

            //FTPUtil.saveFile("SURVEY", currentDate, targetPath.toString());
            FTPUtil.saveFile(CommonUtil.IMAGE_UPLOAD_TYPE.SURVEY.name(), currentDate, currentFile.getPath());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    /*
     * 1. 메소드명: getContentSurveyList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: gy.lee
     */
    public GridPagingResDto<LoySurveyListResDto> getContentSurveyList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                loySurveyMapper.selectContentSurveyList(reqDto),
                AnnotationType.CommCode);
    }

	public GridPagingResDto<LoySurveyAnalysisResDto> getSurveyAnalysis(LoySurveyListReqDto reqDto) {
		log.debug("{}", reqDto);
		
        return new GridPagingResHelper<LoySurveyAnalysisResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                loySurveyMapper.selectSurveyAnalysis(reqDto),
                AnnotationType.CommCode);
	}

    /*
     * 1. 메소드명: getTextItemList
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 3. 2.
     * 5. 설명: 설문 TEXT 항목 제어를 위한 LIST 조회
     *    (설문에서 Radio, CheckBox항목중에 기타(보기외 다른 항목)가 있을시 그 항목을 선태하면 Textarea setDisabled 처리 하게끔 사용하기 위한 용도)
     */
    public GridPagingResDto<LoySurveyTextItemListResDto> getTextItemList(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        // 설문 구간 RID
        //reqDto.setRidSurveySection(loySurveyMapper.selectSurveySectionRidForAttr(reqDto));
        // 이미 제어 항목인 ITEM RID
        //reqDto.setRidSurveyItem(loySurveyMapper.selectSurveyItemRidControlled(reqDto));

        return new GridPagingResHelper<LoySurveyTextItemListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                loySurveyMapper.selectTextItemList(reqDto),
                AnnotationType.ALL);
    }

    /*
     * 1. 메소드명: initSurveyItemControlled
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 3. 14.
     * 5. 설명: 제어중인 설문 TEXT 항목 초기화
     *    (설문에서 Radio, CheckBox항목중에 기타(보기외 다른 항목)가 있을시 그 항목을 선태하면 Textarea setDisabled 처리 하게끔 사용하기 위한 용도)
     */
    public StatusResDto initSurveyItemControlled(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        if(ObjectUtil.isNotEmpty(reqDto.getRidSurveyItemAttr())) {
            loySurveyMapper.initSurveyItemControlled(reqDto);
            rtnValue.setSuccess(true);
        }

        return rtnValue;
    }


    /*
     * 1. 메소드명: getSurveyItemListPop
     * 2. 클래스명: LoySurveyService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 4. 5.
     * 5. 설명: 설문 항목 LIST 조회 팝업
     */
    public GridPagingResDto<LoySurveyItemListResDto> getSurveyItemListPop(LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        return new GridPagingResHelper<LoySurveyItemListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                loySurveyMapper.selectSurveyItemListPop(reqDto),
                AnnotationType.ALL);
    }
}