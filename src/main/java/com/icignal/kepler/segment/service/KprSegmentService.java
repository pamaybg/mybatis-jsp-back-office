package com.icignal.kepler.segment.service;


import java.util.*;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.ANL_SEG_FILTER_TYPE;
import com.icignal.common.util.CommonUtil.ANL_SEG_FILTER_TYPE_CD;
import com.icignal.common.util.CommonUtil.ANL_SEG_TYPE;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.CommonUtil.MKT_SERC_OPRT_TYPE;
import com.icignal.common.util.CommonUtil.MKT_WHERE_SIGN;
import com.icignal.common.util.CommonUtil.TASK_DATA_STATUS;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.segment.dto.request.KprAttributeGroupColumnInfoReqDto;
import com.icignal.kepler.segment.dto.request.KprCopySegmentReqDto;
import com.icignal.kepler.segment.dto.request.KprLogicalComponentColumnListReqDto;
import com.icignal.kepler.segment.dto.request.KprLogicalComponentDBInfoReqDto;
import com.icignal.kepler.segment.dto.request.KprLogicalComponentListReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentCountReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentDetailReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentFilterReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentLcTblRelListReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentListReqDto;
import com.icignal.kepler.segment.dto.request.KprSetSegmentFilterRelReqDto;
import com.icignal.kepler.segment.dto.request.KprSetSegmentFilterReqDto;
import com.icignal.kepler.segment.dto.request.KprSetSegmentReqDto;
import com.icignal.kepler.segment.dto.response.KprAttributeGroupColumnInfoResDto;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentColumnListResDto;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentDBInfoResDto;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentListResDto;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentSegKeyAndSqlResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentCountResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentDetailResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentFilterListResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentFilterResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentLcTblRelListResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentListResDto;
import com.icignal.kepler.segment.dto.response.kprSegmentFilterLinkResDto;
import com.icignal.kepler.segment.mapper.KprSegmentMapper;


/**
 * @author : 류동균
 * @name : infavor.kepler.segment.service.impl
 * @date : 2016. 6. 9.
 * @description : 세그먼트 Service
 */
@Service
public class KprSegmentService {

    @Autowired
    private MKTCallQueryDao mktCallQueryDao;

    @Autowired
    StandardPBEStringEncryptor encryptor;

    @Autowired
    public KprSegmentMapper kprSegmentMapper;

    /**
     * @return :
     * @programId : ANL_SEG_001
     * @name : getSegmentList
     * @date : 2016. 7. 1.
     * @author : 류동균
     * @table : anl.anl_seg_mst, anl.anl_lgc_comp_mst, com.employee
     * @description : 세그먼트 목록 조회
     */
    public GridPagingResDto<KprSegmentListResDto> getSegmentList(KprSegmentListReqDto slr) {
        LogUtil.param(KprSegmentService.class, slr);
        slr.setSVCAlias("s");
        return new GridPagingResHelper<KprSegmentListResDto>().newGridPagingResDto(
                slr.init(CommonUtil.getInstance().getDBType()),
                kprSegmentMapper.selectSegmentList(slr));
    }

    /**
     * @return :
     * @programId : ANL_SEG_P01
     * @name : getLogicalComponentList
     * @date : 2016. 7. 1.
     * @author : 류동균
     * @table : anl.anl_lgc_comp_mst, com.employee
     * @description : 로지컬 컴포넌트 목록
     */
    public GridPagingResDto<KprLogicalComponentListResDto> getLogicalComponentList(KprLogicalComponentListReqDto lclr) {
        LogUtil.param(KprSegmentService.class, lclr);
        lclr.setSVCAlias("l");
        return new GridPagingResHelper<KprLogicalComponentListResDto>().newGridPagingResDto(
                lclr.init(CommonUtil.getInstance().getDBType()),
                kprSegmentMapper.selectLogicalComponentList(lclr));
    }

    /**
     * @return :
     * @programId : ANL_SEG_P01
     * @name : addSegment
     * @date : 2016. 7. 7.
     * @author : 류동균
     * @table : anl.anl_seg_mst
     * @description : 세그먼트 등록
     */
    public StatusResDto addSegment(KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentService.class, ssr);

        StatusResDto rtnValue = new StatusResDto();

        //세그먼트 등록
        if (ObjectUtil.isNotEmpty(ssr.getSegmentTypeCode()) && "CUST_SEG_LIST".equals(ssr.getSegmentTypeCode())) {
            ssr.setSegmentTypeCode("CUST_SEG_LIST");
        } else {
            ssr.setSegmentTypeCode(ANL_SEG_TYPE.SEG.name());
        }
        //rtnValue = kprSegmentMapper.addSegment(ssr);

        String rid = CommonUtil.newRid();
        ssr.setSegmentId(rid);
        kprSegmentMapper.insertSegment(ssr);

        rtnValue.setSuccess(true);
        rtnValue.setMessage(rid);

        String segmentId = rtnValue.getMessage();

        //전체 건수 필터 생성
        if (rtnValue.getSuccess()) {
            KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
            //ssfr.setAppServiceId(ssr.getAppServiceId());
            // ssfr.setCountry(ssr.getCountry());
            ssfr.setLang(ssr.getLang());
            // ssfr.setAccountId(ssr.getAccountId());
            ssfr.setCreateBy(ssr.getCreateBy());
            ssfr.setModifyBy(ssr.getModifyBy());
            ssfr.setFilterTypeCode(ANL_SEG_FILTER_TYPE.ALL.name());
            ssfr.setOffSetX("400");
            ssfr.setOffSetY("50");
            ssfr.setSegmentId(segmentId);
            ssfr.setLogicalCompId(ssr.getLogicalCompId());
            ssfr.setSegFilterId(CommonUtil.newRid());

            if (ObjectUtil.isNotEmpty(ssr.getSegmentTypeCode()) && "CUST_SEG_LIST".equals(ssr.getSegmentTypeCode())) {
                ssr.setSegmentTypeCode("CUST_SEG_LIST");
            } else {
                ssr.setSegmentTypeCode(ANL_SEG_TYPE.SEG.name());
            }

            //필터 등록
            // rtnValue = kprSegmentMapper.addSegmentFilter(ssfr);
            kprSegmentMapper.insertSegmentFilter(ssfr);
            rtnValue.setSuccess(true);
            rtnValue.setMessage(ssfr.getSegFilterId());


            //필터 SQL 생성 및 COUNT
            rtnValue = editSegmentFilterSqlAndCount(ssfr, null);

            if (rtnValue.getSuccess()) {
                rtnValue.setMessage(segmentId);
            } else {
                ssr.setSegmentId(segmentId);
                //세그먼트 삭제
                kprSegmentMapper.deleteSegmentBySegmentId(ssr);

                //세그먼트 필터 삭제
                kprSegmentMapper.deleteSegmentFilterBySegmentId(ssfr);

                rtnValue.setMessage(IFVMErrorHelper.MSG_S0003);
            }
        } else {
            rtnValue.setMessage(IFVMErrorHelper.MSG_S0003);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_P03
     * @name : getAttributeGroupColumnValueList
     * @date : 2016. 7. 11.
     * @author : 류동균
     * @table :
     * @description : 어트리뷰트 속성 그룹 값 목록 조회
     */
    public GridPagingResDto<Object> getAttributeGroupColumnValueList(KprAttributeGroupColumnInfoReqDto agcir) {
        LogUtil.param(KprSegmentService.class, agcir);

        //return kprSegmentMapper.getAttributeGroupColumnValueList(agcir);
        KprAttributeGroupColumnInfoResDto colInfo = new KprAttributeGroupColumnInfoResDto();

//        agcir.setMainShop("'S2078'");

        //어트리뷰트 그룹 컬럼 정보 조회
        colInfo = kprSegmentMapper.selectAtribGroupColumnInfo(agcir);
        GridPagingResDto<Object> rtnValue = new GridPagingResDto<Object>();

        String sqlQuery = "";

        if (colInfo != null && ObjectUtil.isNotEmpty(colInfo.getSelValueSql())) {
            //쿼리 생성
            sqlQuery = colInfo.getSelValueSql();
        } else {
            //쿼리 생성
            sqlQuery = colInfo.getValueSql();
        }

        KprLogicalComponentDBInfoReqDto lcdbir = new KprLogicalComponentDBInfoReqDto();
        lcdbir.setLang(agcir.getLang());
        lcdbir.setLogicalCompId(colInfo.getLogicalCompId());

        //접속 db 정보 설정
        MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
        dbInfo = getLogicalComponentDBInfo(lcdbir);

        //쿼리 실행
        rtnValue = mktCallQueryDao.callSelectForGridList("getAttributeGroupColumnValueList", sqlQuery, new ArrayList<String>(), dbInfo, agcir);


        return rtnValue;

    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : getSegmentFilterKeyColumn
     * @date : 2016. 7. 11.
     * @author : 류동균
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @description : 세그먼트 전체 건수
     */
    public String getSegmentAllCount(KprSegmentCountReqDto scr) {
        LogUtil.param(KprSegmentService.class, scr);

        String rtnValue = null;
        // rtnValue = kprSegmentMapper.getSegmentAllCount(scr);

        KprSegmentCountResDto rtnSqlQuery = new KprSegmentCountResDto();

        //세그먼트 전체 건수 Sql 조회
        rtnSqlQuery = kprSegmentMapper.selectSegmentAllCountSql(scr);

        if (ObjectUtil.isNotEmpty(rtnSqlQuery)) {
            String selectContent = rtnSqlQuery.getFilterSqlCount();
            KprLogicalComponentDBInfoReqDto lcdbir = new KprLogicalComponentDBInfoReqDto();
            lcdbir.setLogicalCompId(scr.getLogicalCompId());
            lcdbir.setLang(scr.getLang());

            //로지컬 컴포넌트 db 정보 조회
            MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
            dbInfo = getLogicalComponentDBInfo(lcdbir);

            if (ObjectUtil.isNotEmpty(dbInfo)) {
                //쿼리 실행
                rtnValue = (String) mktCallQueryDao.callSelectObject("getSegmentAllCount", selectContent, new ArrayList<String>(), dbInfo, java.lang.String.class);
            }
        }

        return rtnValue;

    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : getSegmentDetail
     * @date : 2016. 7. 12.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 상세 조회
     */
    public KprSegmentDetailResDto getSegmentDetail(KprSegmentDetailReqDto sdr) {
        LogUtil.param(KprSegmentService.class, sdr);

        KprSegmentDetailResDto rtnValue = new KprSegmentDetailResDto();

        //세그먼트 상세 조회
        //  rtnValue = kprSegmentMapper.getSegmentDetail(sdr);

        rtnValue = kprSegmentMapper.selectSegmentDetail(sdr);

        //세그먼트 필터 목록 조회
        rtnValue.setFilterList(getSegmentFilterList(sdr));

        //세그먼트 필터값 설정


        //세그먼트 필터 관계 목록 조회
        rtnValue.setFilterRelList(kprSegmentMapper.selectSegmentFilterRelList(sdr));

        return rtnValue;
    }

    //세그먼트 필터 조회
    public List<KprSegmentFilterListResDto> getSegmentFilterList(KprSegmentDetailReqDto sdr) {

        List<KprSegmentFilterListResDto> rtnValue = new ArrayList<KprSegmentFilterListResDto>();
        //rtnValue = kprSegmentMapper.getSegmentFilterList(sdr);
        sdr.setSVCAlias("f");

        rtnValue = kprSegmentMapper.selectSegmentFilterList(sdr);


        for (KprSegmentFilterListResDto filter : rtnValue) {
            //필터값 설정
            String operatCode = filter.getOperatCode();
            String filterValue = filter.getFilterValue();

            LogUtil.debug("===== filterValue: " + filterValue);

            //IN or NOT IN 일 경우
            if (MKT_SERC_OPRT_TYPE.IN.getType().equals(operatCode) || MKT_SERC_OPRT_TYPE.NOT_IN.getType().equals(operatCode)) {

                //앞뒤 "( ", " )" 제거
                filterValue = filterValue.substring(2, filterValue.length() - 2);

                List<String> filterValueList = new ArrayList<String>();

                String[] strList = filterValue.split(MKT_WHERE_SIGN.COMMA.getValue());
                for (String str : strList) {
                    String value = StringUtil.getStrWhereValueDecoded(str, operatCode);
                    filterValueList.add(value);
                }

                filter.setFilterValueList(filterValueList);
                //ms-sql 한글이 있을 경우 N타입으로 제거
                if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
                    if (StringUtil.isHangul(filterValue))
                        filter.setFilterValue(filterValue.replaceAll("N'", "'"));
                }
            }

            //BETWEEN 일 경우
            else if (MKT_SERC_OPRT_TYPE.BETWEEN.getType().equals(operatCode)) {
                String[] strList = filterValue.split(MKT_WHERE_SIGN.AND.getValue());

                if (strList.length == 2) {
                    String value = StringUtil.getStrWhereValueDecoded(strList[0], operatCode);
                    String and = StringUtil.getStrWhereValueDecoded(strList[1], operatCode);

                    filter.setFilterValue(value);
                    filter.setAndValue(and);
                }
            }

            //그외
            else {
                String value = StringUtil.getStrWhereValueDecoded(filterValue, operatCode);
                filter.setFilterValue(value);
            }
        }

        return rtnValue;
    }

    /**
     * @return : anl.anl_seg_filter
     * @programId : ANL_SEG_P03
     * @name : saveSegmentFilter
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 필터 저장
     */
    public StatusResDto saveSegmentFilter(KprSetSegmentFilterReqDto ssfr) {
        LogUtil.param(KprSegmentService.class, ssfr);

        StatusResDto rtnValue = new StatusResDto();
        //this.startTransaction();

        //필터 값 설정
        String operatCode = ssfr.getOperatCode();
        String filterValue = "";
        List<String> originFilterValueList = ssfr.getFilterValueList();

        try {

            //IN or NOT IN 일 경우
            if (MKT_SERC_OPRT_TYPE.IN.getType().equals(operatCode) || MKT_SERC_OPRT_TYPE.NOT_IN.getType().equals(operatCode)) {
                //값 확인
                if (ObjectUtil.isNotEmpty(originFilterValueList)) {
                    // 구분자로 필터 값 분리해서 새로 리스트 생성
                    Set<String> splitedValSet = new LinkedHashSet<>();
                    for(String splitVal : originFilterValueList) {
                        splitedValSet.addAll(Arrays.asList(splitVal.split(";,")));
                    }
                    ssfr.setFilterValueList(new ArrayList<>(splitedValSet));

                    for (String val : ssfr.getFilterValueList()) {
                        String value = StringUtil.getStrWhereValueEncoded(val, operatCode);

                        if (ObjectUtil.isEmpty(filterValue)) {
                            filterValue += value;
                        } else {
                            //***** " ," 조회시 띄어쓰기 + 콤마로 배열 구분
                            filterValue += MKT_WHERE_SIGN.COMMA.getValue() + value;
                        }
                    }

                    filterValue = MKT_WHERE_SIGN.LEFT_PARENTHESIS.getValue() + filterValue + MKT_WHERE_SIGN.RIGHT_PARENTHESIS.getValue();
                }
            }

            //BETWEEN 일 경우
            else if (MKT_SERC_OPRT_TYPE.BETWEEN.getType().equals(operatCode)) {
                String value = StringUtil.getStrWhereValueEncoded(ssfr.getFilterValue(), operatCode);
                String andvalue = StringUtil.getStrWhereValueEncoded(ssfr.getAndValue(), operatCode);

                filterValue = value + MKT_WHERE_SIGN.AND.getValue() + andvalue;
            }

            //그외
            else {
                String value = StringUtil.getStrWhereValueEncoded(ssfr.getFilterValue(), operatCode);
                filterValue = value;
            }

            ssfr.setFilterValue(filterValue);
            ssfr.setFilterValueList(originFilterValueList);

            //등록
            if (TASK_DATA_STATUS.I.name().equals(ssfr.getDataStatus())) {
                // rtnValue = kprSegmentMapper.addSegmentFilter(ssfr);

                kprSegmentMapper.insertSegmentFilter(ssfr);
                rtnValue.setSuccess(true);
                rtnValue.setMessage(ssfr.getSegFilterId());

            }
            //수정
            else if (TASK_DATA_STATUS.U.name().equals(ssfr.getDataStatus())) {
                // rtnValue = kprSegmentMapper.editSegmentFilter(ssfr);
                kprSegmentMapper.updateSegmentFilter(ssfr);
                rtnValue.setSuccess(true);

            }
            //삭제
            else if (TASK_DATA_STATUS.D.name().equals(ssfr.getDataStatus())) {
                //필터 삭제
                kprSegmentMapper.deleteSegmentFilter(ssfr);
                rtnValue.setSuccess(true);

                KprSetSegmentFilterRelReqDto ssfrr = new KprSetSegmentFilterRelReqDto();
                ssfrr.setModifyBy(ssfr.getModifyBy());
                ssfrr.setChildFilterId(ssfr.getSegFilterId());

                //필터 관계 삭제
                //  rtnValue = kprSegmentMapper.removeSegmentFilterRelByChildFilterId(ssfrr);
                kprSegmentMapper.deleteSegmentFilterRelByChildFilterId(ssfrr);
                rtnValue.setSuccess(true);

            }

            //세그먼트 필터 좌표 저장
            if (ObjectUtil.isNotEmpty(ssfr.getFilterList())) {
                for (KprSetSegmentFilterReqDto filter : ssfr.getFilterList()) {
                    filter.setModifyBy(ssfr.getModifyBy());
                    //kprSegmentMapper.editSegmentFilterOffSet(filter);
                    kprSegmentMapper.updateSegmentFilterOffSet(filter);

                }
            }

            //등록/수정 일 경우 세그먼트 필터 관계 저장, 세그먼트 필터 sql/count 수정
            if (rtnValue.getSuccess() &&
                    TASK_DATA_STATUS.I.name().equals(ssfr.getDataStatus()) ||
                    TASK_DATA_STATUS.U.name().equals(ssfr.getDataStatus())) {

                //세그먼트 필터 관계 저장
                if (ObjectUtil.isNotEmpty(ssfr.getFilterRelList())) {
                    for (KprSetSegmentFilterRelReqDto ssfrr : ssfr.getFilterRelList()) {
                        //   ssfrr.setAppServiceId(ssfr.getAppServiceId());
                        //   ssfrr.setCountry(ssfr.getCountry());
                        ssfrr.setLang(ssfr.getLang());
                        //  ssfrr.setAccountId(ssfr.getAccountId());
                        ssfrr.setCreateBy(ssfr.getCreateBy());
                        ssfrr.setModifyBy(ssfr.getModifyBy());

                        saveSegmentFilterRel(ssfrr);
                    }
                }

                rtnValue = editSegmentFilterSqlAndCount(ssfr, null);

                if (rtnValue.getSuccess()) {
                    KprSegmentFilterReqDto sfr = new KprSegmentFilterReqDto();
                    sfr.setLang(ssfr.getLang());
                    sfr.setSegFilterId(ssfr.getSegFilterId());

                    KprSegmentFilterResDto filter = getSegmentFilter(sfr);
                    ObjectMapper mapper = new ObjectMapper();

                    String jsonString = "";

                    try {
                        jsonString = mapper.writeValueAsString(filter);
                    } catch (JsonProcessingException e) {
                        LogUtil.error(e);
                    }

                    rtnValue.setMessage(jsonString);
                }

            }
        } catch (Exception e){
            rtnValue.setSuccess(false);
            rtnValue.setMessage("MSG_S0007");
        }

        //this.endTransaction();

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : getSegmentFilter
     * @date : 2017. 2. 24.
     * @author : dg.ryu
     * @table :
     * @description : 세그먼트 필터 조회
     */
    public KprSegmentFilterResDto getSegmentFilter(KprSegmentFilterReqDto sfr) {
        KprSegmentFilterResDto filter = kprSegmentMapper.selectSegmentFilter(sfr);

        if (ObjectUtil.isNotEmpty(filter)) {
            //필터값 설정
            String operatCode = filter.getOperatCode();
            String filterValue = filter.getFilterValue();

            //IN or NOT IN 일 경우
            if (MKT_SERC_OPRT_TYPE.IN.getType().equals(operatCode) || MKT_SERC_OPRT_TYPE.NOT_IN.getType().equals(operatCode)) {

                //앞뒤 "( ", " )" 제거
                filterValue = filterValue.substring(2, filterValue.length() - 2);

                List<String> filterValueList = new ArrayList<String>();

                String[] strList = filterValue.split(MKT_WHERE_SIGN.COMMA.getValue());
                for (String str : strList) {
                    String value = StringUtil.getStrWhereValueDecoded(str, operatCode);
                    filterValueList.add(value);
                }

                filter.setFilterValueList(filterValueList);
                //ms-sql 한글이 있을 경우 N타입으로 제거
                if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
                    if (StringUtil.isHangul(filterValue))
                        filter.setFilterValue(filterValue.replaceAll("N'", "'"));
                }
            }

            //BETWEEN 일 경우
            else if (MKT_SERC_OPRT_TYPE.BETWEEN.getType().equals(operatCode)) {
                String[] strList = filterValue.split(MKT_WHERE_SIGN.AND.getValue());

                if (strList.length == 2) {
                    String value = StringUtil.getStrWhereValueDecoded(strList[0], operatCode);
                    String and = StringUtil.getStrWhereValueDecoded(strList[1], operatCode);

                    filter.setFilterValue(value);
                    filter.setAndValue(and);
                }
            }

            //그외
            else {
                String value = StringUtil.getStrWhereValueDecoded(filterValue, operatCode);
                filter.setFilterValue(value);
            }
        }

        return filter;
    }

    /**
     * @return : anl.anl_seg_filter_rel
     * @programId : ANL_SEG_002
     * @name : saveSegmentFilterRel
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 필터 관계 저장
     */
    public StatusResDto saveSegmentFilterRel(KprSetSegmentFilterRelReqDto ssfrr) {
        LogUtil.param(KprSegmentService.class, ssfrr);

        StatusResDto rtnValue = new StatusResDto();

        //등록
        if (TASK_DATA_STATUS.I.name().equals(ssfrr.getDataStatus())) {
            //rtnValue = kprSegmentMapper.addSegmentFilterRel(ssfrr);
            kprSegmentMapper.insertSegmentFilterRel(ssfrr);
            String id = ssfrr.getSegFilterRelId();
            rtnValue.setSuccess(true);
            rtnValue.setMessage(id);
        }
        //수정
        else if (TASK_DATA_STATUS.U.name().equals(ssfrr.getDataStatus())) {
            //	rtnValue = kprSegmentMapper.editSegmentFilterRel(ssfrr);
            kprSegmentMapper.updateSegmentFilterRel(ssfrr);
            rtnValue.setSuccess(true);
        }
        //삭제
        else if (TASK_DATA_STATUS.D.name().equals(ssfrr.getDataStatus())) {
            //rtnValue = kprSegmentMapper.removeSegmentFilterRel(ssfrr);
            kprSegmentMapper.deleteSegmentFilterRel(ssfrr);
            rtnValue.setSuccess(true);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : saveAsDifferentSegment
     * @date : 2021. 08. 13.~
     * @author : 이경영
     * @table :
     * @description : 세그먼트 다른이름으로 저장
     */
    public StatusResDto saveAsDifferentSegment(KprSetSegmentReqDto reqDto) {
        LogUtil.param(KprSegmentService.class, reqDto);

        StatusResDto rtnValue = new StatusResDto();

        //대상 필터 아이디 조회( 조회할 필터가 있는지에 대한 체크로직)
        KprSegmentFilterReqDto sfr = new KprSegmentFilterReqDto();
        sfr.setSegFilterId(reqDto.getFilterList().get(0).getSegFilterId());

        if (ObjectUtil.isNotEmpty(sfr)) {

            //세그먼트 복제 등록
            KprSetSegmentReqDto ssr = new KprSetSegmentReqDto();
            ssr.setOriSegmentId(reqDto.getOriSegmentId());
            ssr.setSegmentId(CommonUtil.newRid());
            ssr.setSegmentName(reqDto.getSegmentName());
            ssr.setSegmentDesc(reqDto.getSegmentDesc());
            ssr.setModifyBy(reqDto.getModifyBy());
            ssr.setCreateBy(reqDto.getCreateBy());

            if (kprSegmentMapper.insertCopyDifferentSegment(ssr) > 0) {

                //filter list 만드는 로직
                HashMap<String, ArrayList<kprSegmentFilterLinkResDto>> filterListMap = new HashMap<>();
                for (KprSetSegmentFilterReqDto filterData : reqDto.getFilterList()) {

                    ArrayList<kprSegmentFilterLinkResDto> filterInputDataList = new ArrayList<kprSegmentFilterLinkResDto>();
                    kprSegmentFilterLinkResDto filterInputData = new kprSegmentFilterLinkResDto();

                    filterInputData.setOriSegFilterId(filterData.getSegFilterId());
                    filterInputData.setSegFilterId(CommonUtil.newRid());
                    filterInputData.setCreateBy(reqDto.getCreateBy());
                    filterInputData.setModifyBy(reqDto.getModifyBy());
                    filterInputData.setSegmentId(ssr.getSegmentId());

                    filterInputDataList.add(filterInputData);

                    filterListMap.put(filterInputData.getOriSegFilterId(), filterInputDataList);
                }
                //filter list 만드는 로직
                for (KprSetSegmentFilterReqDto filterData : reqDto.getFilterList()) {
                    if (StringUtil.isNotEmpty(filterData.getCombFilterAId()) && StringUtil.isNotEmpty(filterData.getCombFilterBId())) {
                        ArrayList<kprSegmentFilterLinkResDto> filterInputDataList = new ArrayList<kprSegmentFilterLinkResDto>();


                        ArrayList<kprSegmentFilterLinkResDto> filterFindDataList = filterListMap.get(filterData.getSegFilterId());
                        kprSegmentFilterLinkResDto filterInputData = new kprSegmentFilterLinkResDto();

                        filterInputData.setOriSegFilterId(filterFindDataList.get(0).getOriSegFilterId());
                        filterInputData.setSegFilterId(filterFindDataList.get(0).getSegFilterId());
                        filterInputData.setOriCombFilterAId(filterData.getCombFilterAId());
                        filterInputData.setOriCombFilterBId(filterData.getCombFilterBId());

                        ArrayList<kprSegmentFilterLinkResDto> filterFindADataList = filterListMap.get(filterData.getCombFilterAId());
                        filterInputData.setCombFilterAId(filterFindADataList.get(0).getSegFilterId());
                        ArrayList<kprSegmentFilterLinkResDto> filterFindBDataList = filterListMap.get(filterData.getCombFilterBId());
                        filterInputData.setCombFilterBId(filterFindBDataList.get(0).getSegFilterId());

                        filterInputData.setSegmentId(ssr.getSegmentId());
                        filterInputData.setCreateBy(reqDto.getCreateBy());
                        filterInputData.setModifyBy(reqDto.getModifyBy());

                        filterInputDataList.add(filterInputData);

                        filterListMap.replace(filterData.getSegFilterId(), filterInputDataList);
                    }
                }
                HashMap<String, ArrayList<kprSegmentFilterLinkResDto>> filterRelListMap = new HashMap<>();

                //filter rel list 만드는 로직
                List<kprSegmentFilterLinkResDto> filterRelInputData = kprSegmentMapper.segmentDifferentFilterRelTarget(ssr.getOriSegmentId());

                if (StringUtil.isNotEmpty(filterRelInputData)) {
                    for (kprSegmentFilterLinkResDto RelData : filterRelInputData) {

                        ArrayList<kprSegmentFilterLinkResDto> filterRelInputDataList = new ArrayList<kprSegmentFilterLinkResDto>();
                        kprSegmentFilterLinkResDto RelInputData = new kprSegmentFilterLinkResDto();

                        RelInputData.setOriSegFilterRelId(RelData.getOriSegFilterRelId());
                        RelInputData.setSegFilterRelId(CommonUtil.newRid());
                        RelInputData.setSegmentId(ssr.getSegmentId());
                        RelInputData.setCreateBy(reqDto.getCreateBy());
                        RelInputData.setModifyBy(reqDto.getModifyBy());
                        RelInputData.setOriSegFilterId(RelData.getOriSegFilterId());
                        RelInputData.setOriChildFilterId(RelData.getOriChildFilterId());

                        ArrayList<kprSegmentFilterLinkResDto> filterFindSegFilterDataList = filterListMap.get(RelData.getOriSegFilterId());
                        RelInputData.setSegFilterId(filterFindSegFilterDataList.get(0).getSegFilterId());
                        ArrayList<kprSegmentFilterLinkResDto> filterFindChildDataList = filterListMap.get(RelData.getOriChildFilterId());
                        RelInputData.setChildFilterId(filterFindChildDataList.get(0).getSegFilterId());


                        filterRelInputDataList.add(RelInputData);

                        filterRelListMap.put(RelData.getOriSegFilterRelId(), filterRelInputDataList);
                    }
                }
                //filter 저장
                for (String key : filterListMap.keySet()) {
                    for (kprSegmentFilterLinkResDto data : filterListMap.get(key)) {
                        KprSetSegmentFilterReqDto insertData = new KprSetSegmentFilterReqDto();
                        insertData.setSegFilterId(data.getSegFilterId());
                        insertData.setCreateBy(data.getCreateBy());
                        insertData.setModifyBy(data.getModifyBy());
                        insertData.setSegmentId(data.getSegmentId());
                        insertData.setOriSegFilterId(data.getOriSegFilterId());
                        insertData.setCombFilterAId(data.getCombFilterAId());
                        insertData.setCombFilterBId(data.getCombFilterBId());
                        if (kprSegmentMapper.insertCopyDifferentFilter(insertData) > 0) {
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage(insertData.getSegmentId());
                        } else {
                            rtnValue.setSuccess(false);
                            rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);
                        }
                    }
                }
                //filter rel 저장
                for (String key : filterRelListMap.keySet()) {
                    for (kprSegmentFilterLinkResDto data : filterRelListMap.get(key)) {
                        KprSetSegmentFilterRelReqDto insertData = new KprSetSegmentFilterRelReqDto();
                        insertData.setSegFilterRelId(data.getSegFilterRelId());
                        insertData.setSegFilterId(data.getSegFilterId());
                        insertData.setOriSegFilterRelId(data.getOriSegFilterRelId());
                        insertData.setChildFilterId(data.getChildFilterId());
                        insertData.setCreateBy(data.getCreateBy());
                        insertData.setModifyBy(data.getModifyBy());
                        insertData.setSegmentId(data.getSegmentId());
                        if (kprSegmentMapper.insertCopyDifferentFilterRel(insertData) > 0) {
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage(insertData.getSegmentId());
                        } else {
                            rtnValue.setSuccess(false);
                            rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);
                        }
                    }
                }


            } else {
                rtnValue.setSuccess(false);
                rtnValue.setMessage(IFVMErrorHelper.MSG_3025);
            }
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);

        }
        return rtnValue;
    }

    /**
     * @return : anl.anl_seg_filter
     * @programId : ANL_SEG_002
     * @name : saveSegment
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 저장
     */
    public StatusResDto saveSegment(KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentService.class, ssr);

        StatusResDto rtnValue = new StatusResDto();

        //세그먼트 저장
        rtnValue = editSegment(ssr);

        //세그먼트 필터 좌표 저장
        if (ObjectUtil.isNotEmpty(ssr.getFilterList())) {
            for (KprSetSegmentFilterReqDto ssfr : ssr.getFilterList()) {
                ssfr.setModifyBy(ssr.getModifyBy());
                kprSegmentMapper.updateSegmentFilterOffSet(ssfr);
                rtnValue.setSuccess(true);
            }
        }

        return rtnValue;
    }

    /**
     * @return : anl.anl_seg_filter
     * @programId : ANL_SEG_002
     * @name : editSegment
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 수정
     */
    public StatusResDto editSegment(KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentService.class, ssr);

        StatusResDto rtnValue = new StatusResDto();

        //세그먼트 저장
        kprSegmentMapper.updateSegment(ssr);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : anl.anl_seg_filter
     * @programId : ANL_SEG_002
     * @name : editSegmentLogicalComponentId
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table :
     * @description : 세그먼트 로지컬 컴포넌트 id 수정
     */
    public StatusResDto editSegmentLogicalComponentId(KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentService.class, ssr);

        StatusResDto rtnValue = new StatusResDto();

        KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
        ssfr.setModifyBy(ssr.getModifyBy());
        ssfr.setSegmentId(ssr.getSegmentId());
        //ssfr.setAccountId(ssr.getAccountId());

        //필터 모두 삭제
        //rtnValue = kprSegmentMapper.removeSegmentFilterBySegmentId(ssfr);
        kprSegmentMapper.deleteSegmentFilterBySegmentId(ssfr);
        rtnValue.setSuccess(true);

        KprSetSegmentFilterRelReqDto ssfrr = new KprSetSegmentFilterRelReqDto();
        ssfrr.setModifyBy(ssr.getModifyBy());
        ssfrr.setSegmentId(ssr.getSegmentId());
        //ssfrr.setAccountId(ssr.getAccountId());

        //필터 관계 모두 삭제
        //rtnValue = kprSegmentMapper.removeSegmentFilterRelBySegmentId(ssfrr);

        kprSegmentMapper.deleteSegmentFilterRelBySegmentId(ssfrr);
        rtnValue.setSuccess(true);
        //로지컬 컴포넌트 아이디 수정
        //	rtnValue = kprSegmentMapper.editSegmentLogicalComponentId(ssr);

        kprSegmentMapper.updateSegmentLogicalComponentId(ssr);
        //전체 건수 필터 생성
        if (rtnValue.getSuccess()) {
            //ssfr.setAppServiceId(ssr.getAppServiceId());
            //ssfr.setCountry(ssr.getCountry());
            ssfr.setLang(ssr.getLang());
            //ssfr.setAccountId(ssr.getAccountId());
            ssfr.setCreateBy(ssr.getCreateBy());
            ssfr.setModifyBy(ssr.getModifyBy());
            ssfr.setFilterTypeCode(ANL_SEG_FILTER_TYPE.ALL.name());
            ssfr.setOffSetX("400");
            ssfr.setOffSetY("50");
            ssfr.setSegmentId(ssr.getSegmentId());
            ssfr.setLogicalCompId(ssr.getLogicalCompId());
            ssfr.setSegFilterId(CommonUtil.newRid());

            //필터 등록
            //rtnValue = kprSegmentMapper.addSegmentFilter(ssfr);

            kprSegmentMapper.insertSegmentFilter(ssfr);
            rtnValue.setSuccess(true);
            //필터 SQL 생성 및 COUNT
            rtnValue = editSegmentFilterSqlAndCount(ssfr, null);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_P03
     * @name : getLogicalComponentColumnList
     * @date : 2016. 7. 26.
     * @author : 류동균
     * @table : anl.anl_atrib_group_column
     * @description : 로지컬컴포넌트 컬럼 목록
     */

    public List<KprLogicalComponentColumnListResDto> getLogicalComponentColumnList(KprLogicalComponentColumnListReqDto lcclr) {
        LogUtil.param(KprSegmentService.class, lcclr);

        List<KprLogicalComponentColumnListResDto> rtnValue = new ArrayList<KprLogicalComponentColumnListResDto>();
        rtnValue = kprSegmentMapper.selectLogicalComponentColumnList(lcclr);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : resetAllSegmentFilterCount
     * @date : 2016. 7. 26.
     * @author : 류동균
     * @table : anl.anl_seg_filter
     * @description : 전체 세그먼트 필터 건수 재설정
     */

    public StatusResDto resetAllSegmentFilterCount(KprSegmentFilterReqDto sfr) {
        LogUtil.param(KprSegmentService.class, sfr);

        StatusResDto rtnValue = new StatusResDto();
        //rtnValue = kprSegmentMapper.resetAllSegmentFilterCount(sfr);

        KprSegmentFilterResDto allCoutFilter = new KprSegmentFilterResDto();

        //전체건수 필터 조회
        allCoutFilter = kprSegmentMapper.selectAllCountSegmentFilter(sfr);
        sfr.setSegFilterId(allCoutFilter.getSegFilterId());

        KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
        //  ssfr.setAppServiceId(sfr.getAppServiceId());
        // ssfr.setCountry(sfr.getCountry());
        ssfr.setLang(sfr.getLang());
        ssfr.setModifyBy(sfr.getModifyBy());
        //ssfr.setAccountId(sfr.getAccountId());
        ssfr.setSegmentId(sfr.getSegmentId());
        ssfr.setLogicalCompId(sfr.getLogicalCompId());

        ssfr.setFilterTypeCode(allCoutFilter.getFilterTypeCode());
        ssfr.setSegFilterId(allCoutFilter.getSegFilterId());

        //세그먼트 필터 sql/count 수정
        rtnValue = editSegmentFilterSqlAndCount(ssfr, null);

        //하위 필터 조회
        List<KprSegmentFilterResDto> childFilterList = new ArrayList<KprSegmentFilterResDto>();
        childFilterList = kprSegmentMapper.selectChildSegmentFilterList(sfr);

        //전체 건수의 바로 아래 하위 필터 firstFlag 1 설정
        for (int i = 0; i < childFilterList.size(); i++) {
            childFilterList.get(i).setFirstFlag("1");
        }

        //DB 정보 조회
        KprLogicalComponentDBInfoReqDto lcdbir = new KprLogicalComponentDBInfoReqDto();
        lcdbir.setLogicalCompId(ssfr.getLogicalCompId());
        lcdbir.setLang(ssfr.getLang());
        MKTDBInfoDTO dbInfo = getLogicalComponentDBInfo(lcdbir);

        //하위 필터 sql/count 수정
        for (int i = 0; i < childFilterList.size(); i++) {
            KprSegmentFilterResDto filter = childFilterList.get(i);
            ssfr.setFilterTypeCode(filter.getFilterTypeCode());
            ssfr.setSegFilterId(filter.getSegFilterId());
            ssfr.setFirstFlag(filter.getFirstFlag());
            sfr.setSegFilterId(filter.getSegFilterId());

            //세그먼트 필터 sql/count 수정
            rtnValue = editSegmentFilterSqlAndCount(ssfr, dbInfo);

            //하위 필터의 하위 필터 조회
            List<KprSegmentFilterResDto> childFilterList2 = new ArrayList<KprSegmentFilterResDto>();
            childFilterList2 = kprSegmentMapper.selectChildSegmentFilterList(sfr);

            if (ObjectUtil.isNotEmpty(childFilterList2)) {
                childFilterList.addAll(childFilterList2);
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : resetSegmentFilterCount
     * @date : 2018. 12. 07.
     * @author : 류동균
     * @table : anl.anl_seg_filter
     * @description : 세그먼트 필터 건수 재설정
     */
    @SuppressWarnings("unchecked")
    public StatusResDto resetSegmentFilterCount(KprSegmentFilterReqDto sfr) {
        LogUtil.param(KprSegmentService.class, sfr);

        StatusResDto rtnValue = new StatusResDto();
        //	rtnValue = kprSegmentMapper.resetSegmentFilterCount(sfr);
        KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
        //ssfr.setAppServiceId(sfr.getAppServiceId());
        //   ssfr.setCountry(sfr.getCountry());
        ssfr.setLang(sfr.getLang());
        ssfr.setModifyBy(sfr.getModifyBy());
        // ssfr.setAccountId(sfr.getAccountId());
        ssfr.setSegmentId(sfr.getSegmentId());
        ssfr.setLogicalCompId(sfr.getLogicalCompId());
        ssfr.setSegFilterId(sfr.getSegFilterId());

        //세그먼트 필터 sql/count 수정
        rtnValue = editSegmentFilterSqlAndCount(ssfr, null);

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : copySegmentBySegmentFilterId
     * @date : 2016. 8. 12.
     * @author : 류동균
     * @table : anl.anl_seg_mst, anl.anl_seg_filter, anl.anl_seg_filter_rel
     * @description : 세그먼트 복제 By segFilterId
     */

    public StatusResDto copySegmentBySegmentFilterId(KprCopySegmentReqDto csr) {
        LogUtil.param(KprSegmentService.class, csr);

        StatusResDto rtnValue = new StatusResDto();

        List<KprSegmentFilterResDto> rtnFilterList = new ArrayList<KprSegmentFilterResDto>();

        KprSegmentFilterReqDto sfr = new KprSegmentFilterReqDto();
        sfr.setSegFilterId(csr.getSegFilterId());

        //대상 필터 아이디 조회
        KprSegmentFilterResDto tgtFilter = new KprSegmentFilterResDto();
        tgtFilter = kprSegmentMapper.selectSegmentFilter(sfr);

        if (ObjectUtil.isNotEmpty(tgtFilter)) {
            rtnFilterList.add(tgtFilter);

            List<String> segFilterIdList = new ArrayList<String>();
            segFilterIdList.add(csr.getSegFilterId());

            for (int i = 0; i < segFilterIdList.size(); i++) {
                sfr.setSegFilterId(segFilterIdList.get(i));
                List<KprSegmentFilterResDto> parFilterList = new ArrayList<KprSegmentFilterResDto>();

                //상위 필터 아이디 목록 조회
                parFilterList = kprSegmentMapper.selectParentSegmentFilterIdList(sfr);

                for (KprSegmentFilterResDto filter : parFilterList) {
                    segFilterIdList.add(filter.getSegFilterId());

                    rtnFilterList.add(filter);
                }
            }

            //세그먼트 복제 등록
            KprSetSegmentReqDto ssr = new KprSetSegmentReqDto();
            ssr.setCreateBy(csr.getCreateBy());
            ssr.setModifyBy(csr.getModifyBy());
            //ssr.setAccountId(csr.getAccountId());
            ssr.setOriSegmentId(rtnFilterList.get(0).getSegmentId());

            //고객 세그먼트 추가로 인한 수정 20.07.15 sh.park
            if ("TGT_GROUP".equals(csr.getSegmentType())) {
                ssr.setSegmentTypeCode(ANL_SEG_TYPE.TGT_GROUP.name());
            } else if ("CUST_SEG_RULE".equals(csr.getSegmentType())) {
                ssr.setSegmentTypeCode(ANL_SEG_TYPE.CUST_SEG_RULE.name());
            } else {
                ssr.setSegmentTypeCode(ANL_SEG_TYPE.SEG.name());
            }
            //rtnValue = kprSegmentMapper.addCopySegment(ssr);
            ssr.setSegmentId(CommonUtil.newRid());
            if (kprSegmentMapper.insertCopySegment(ssr) > 0) {
                rtnValue.setSuccess(true);
                rtnValue.setMessage(ssr.getSegmentId());
            }

            if (rtnValue.getSuccess()) {
                String segmentId = rtnValue.getMessage();

                HashMap<String, String> idMap = new HashMap<String, String>();
                List<String> endFilterList = new ArrayList<String>();
                List<String> endFilterRelList = new ArrayList<String>();

                KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
                ssfr.setCreateBy(csr.getCreateBy());
                ssfr.setModifyBy(csr.getModifyBy());
                //ssfr.setAccountId(csr.getAccountId());
                ssfr.setSegmentId(segmentId);

                KprSetSegmentFilterRelReqDto ssfrr = new KprSetSegmentFilterRelReqDto();
                ssfrr.setCreateBy(csr.getCreateBy());
                ssfrr.setModifyBy(csr.getModifyBy());
                //ssfrr.setAccountId(csr.getAccountId());
                ssfrr.setSegmentId(segmentId);

                /**
                 * 세그먼트를 복제 하기 위해 ID를 생성해주어야 한다.
                 */
                for (KprSegmentFilterResDto filter : rtnFilterList) {
                    //필터 ID 생성
                    if (ObjectUtil.isNotEmpty(filter.getSegFilterId()) && ObjectUtil.isEmpty(idMap.get(filter.getSegFilterId()))) {
                        idMap.put(filter.getSegFilterId(), CommonUtil.newRid());
                    }

                    //필터 관계 ID 생성
                    if (ObjectUtil.isNotEmpty(filter.getSegFilterRelId()) && ObjectUtil.isEmpty(idMap.get(filter.getSegFilterRelId()))) {
                        idMap.put(filter.getSegFilterRelId(), CommonUtil.newRid());
                    }

                    //하위 필터 ID 생성
                    if (ObjectUtil.isNotEmpty(filter.getChildFilterId()) && ObjectUtil.isEmpty(idMap.get(filter.getChildFilterId()))) {
                        idMap.put(filter.getChildFilterId(), CommonUtil.newRid());
                    }

                    //조합필터A ID 생성
                    if (ObjectUtil.isNotEmpty(filter.getCombFilterAId()) && ObjectUtil.isEmpty(idMap.get(filter.getCombFilterAId()))) {
                        idMap.put(filter.getCombFilterAId(), CommonUtil.newRid());
                    }

                    //조합필터B ID 생성
                    if (ObjectUtil.isNotEmpty(filter.getCombFilterBId()) && ObjectUtil.isEmpty(idMap.get(filter.getCombFilterBId()))) {
                        idMap.put(filter.getCombFilterBId(), CommonUtil.newRid());
                    }
                }

                for (KprSegmentFilterResDto filter : rtnFilterList) {
                    //필터 중복 등록 확인
                    if (!endFilterList.contains(filter.getSegFilterId())) {
                        ssfr.setOriSegFilterId(filter.getSegFilterId());
                        ssfr.setSegFilterId(idMap.get(filter.getSegFilterId()));
                        ssfr.setCombFilterAId(idMap.get(filter.getCombFilterAId()));
                        ssfr.setCombFilterBId(idMap.get(filter.getCombFilterBId()));

                        //필터 복제 등록
                        //	rtnValue = kprSegmentMapper.addCopySegmentFilter(ssfr);
                        if (kprSegmentMapper.insertCopySegmentFilter(ssfr) > 0) {
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage(ssfr.getSegFilterId());
                        }
                        endFilterList.add(filter.getSegFilterId());
                    }

                    //필터 관계 중복 등록 확인
                    if (ObjectUtil.isNotEmpty(filter.getSegFilterRelId()) && !endFilterRelList.contains(filter.getSegFilterRelId()) && rtnValue.getSuccess()) {
                        ssfrr.setOriSegFilterRelId(filter.getSegFilterRelId());
                        ssfrr.setSegFilterRelId(idMap.get(filter.getSegFilterRelId()));
                        ssfrr.setSegFilterId(idMap.get(filter.getSegFilterId()));
                        ssfrr.setChildFilterId(idMap.get(filter.getChildFilterId()));

                        //필터 관계 복제 등록
                        //rtnValue = kprSegmentMapper.addCopySegmentFilterRel(ssfrr);
                        String id = ssfrr.getSegFilterRelId();
                        if (kprSegmentMapper.insertCopySegmentFilterRel(ssfrr) > 0) {
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage(id);
                        }
                        endFilterRelList.add(filter.getSegFilterRelId());
                    }

                    if (!rtnValue.getSuccess()) {
                        break;
                    }
                }

                //정상 종류 후 복제된 대상 필터 아이디 반환
                if (rtnValue.getSuccess()) {
                    String segFilterId = rtnFilterList.get(0).getSegFilterId();
                    segFilterId = idMap.get(segFilterId);

                    rtnValue.setMessage(segFilterId);
                } else {
                    //세그먼트 삭제
                    kprSegmentMapper.deleteSegmentBySegmentId(ssr);

                    //세그먼트 필터 삭제
                    kprSegmentMapper.deleteSegmentFilterBySegmentId(ssfr);

                    //세그먼트 필터 관계 삭제
                    kprSegmentMapper.deleteSegmentFilterRelBySegmentId(ssfrr);

                    rtnValue.setSuccess(false);
                    rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);
                }
            } else {
                rtnValue.setSuccess(false);
                rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);
            }

        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage(IFVMErrorHelper.MSG_S0005);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : removeSegment
     * @date : 2016. 9. 13.
     * @author : 류동균
     * @table : anl.anl_seg_mst, anl.anl_seg_filter, anl.anl_seg_filter_rel
     * @description : 세그먼트 삭제
     */

    public StatusResDto removeSegment(KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentService.class, ssr);

        StatusResDto rtnValue = new StatusResDto();

        //세그먼트 삭제
        //rtnValue = kprSegmentMapper.removeSegmentBySegmentId(ssr);
        kprSegmentMapper.deleteSegmentBySegmentId(ssr);

        //고객 세그먼트 삭제시 고객세그먼트 룰 삭제
        if (ObjectUtil.isNotEmpty(ssr.getSegmentTypeCode()) && "CUST_SEG_LIST".equals(ssr.getSegmentTypeCode())) {
            kprSegmentMapper.deleteSegmentChildNodes(ssr);
        }

        KprSetSegmentFilterReqDto ssfr = new KprSetSegmentFilterReqDto();
        ssfr.setModifyBy(ssr.getModifyBy());
        ssfr.setSegmentId(ssr.getSegmentId());
        //ssfr.setAccountId(ssr.getAccountId());

        //세그먼트 필터 삭제
        //rtnValue = kprSegmentMapper.removeSegmentFilterBySegmentId(ssfr);
        kprSegmentMapper.deleteSegmentFilterBySegmentId(ssfr);

        KprSetSegmentFilterRelReqDto ssfrr = new KprSetSegmentFilterRelReqDto();
        ssfrr.setModifyBy(ssr.getModifyBy());
        ssfrr.setSegmentId(ssr.getSegmentId());
        //ssfrr.setAccountId(ssr.getAccountId());

        //세그먼트 필터 관계 삭제
        //	rtnValue = kprSegmentMapper.removeSegmentFilterRelBySegmentId(ssfrr);
        kprSegmentMapper.deleteSegmentFilterRelBySegmentId(ssfrr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }


    /**
     * @return :
     * @programId : ANL_SEG_002
     * @name : editSegmentFilterSqlAndCount
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table : anl.anl_seg_filter
     * @description : 세그먼트 필터 sql/count 수정
     */
    public StatusResDto editSegmentFilterSqlAndCount(KprSetSegmentFilterReqDto ssfr, MKTDBInfoDTO dbInfo) {
        KprSetSegmentFilterReqDto ssfrdata = ssfr;
        MKTDBInfoDTO dbInfodata = dbInfo;
        LogUtil.param(this.getClass(), ssfrdata);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String rtnQuery = "";
        String sqlQuery = "";

        KprSegmentCountReqDto scr = new KprSegmentCountReqDto();
        //scr.setAccountId(ssfr.getAccountId());
        // scr.setAppServiceId(ssfr.getAppServiceId());
        // scr.setCountry(ssfr.getCountry());
        scr.setLang(ssfrdata.getLang());
        scr.setSegmentId(ssfrdata.getSegmentId());
        scr.setSegFilterId(ssfrdata.getSegFilterId());
        scr.setLogicalCompId(ssfrdata.getLogicalCompId());
        scr.setFirstFlag(ssfrdata.getFirstFlag());

        String firstFlag = "1";
        if (ObjectUtil.isNotEmpty(ssfrdata.getFirstFlag())) {
            firstFlag = "1";
        } else {
            firstFlag = "0";
        }
        scr.setFirstFlag(firstFlag);

        //	KprSegmentCountResDto rtnSqlQuery = new KprSegmentCountResDto();

        String filterSql = "";
        String filterSqlCount = "";

        //세그먼트 필터 유형 확인
        if (ANL_SEG_FILTER_TYPE.ALL.name().equals(ssfrdata.getFilterTypeCode())) {
            scr.setFirstFlag("1");
        }

        //sql 조회 프로시저 호출 request dto에 값을 받음
		/*this.update("KPRSegmentSql.callProcGetSegmentCountSql", scr, true);

        filterSql = scr.getFilterSql();
        filterSqlCount = scr.getFilterSqlCount();*/

        KprSegmentFilterReqDto req = new KprSegmentFilterReqDto();
        req.setSystemColumn(ssfrdata.getSystemColumn());
        req.setSegmentId(ssfrdata.getSegmentId());
        req.setSegFilterId(ssfrdata.getSegFilterId());
        KprSegmentFilterResDto res = genSegmentFilterSql(req);

        filterSql = res.getFilterSql();
        filterSqlCount = res.getFilterSqlCount();

        //sql 확인
        if (ObjectUtil.isNotEmpty(filterSql) && ObjectUtil.isNotEmpty(filterSqlCount)) {

            try {
                //로지컬 컴포넌트 db 정보 조회
                if (ObjectUtil.isEmpty(dbInfodata)) {
                    KprLogicalComponentDBInfoReqDto lcdbir = new KprLogicalComponentDBInfoReqDto();
                    lcdbir.setLogicalCompId(ssfrdata.getLogicalCompId());
                    lcdbir.setLang(ssfrdata.getLang());
                    dbInfodata = getLogicalComponentDBInfo(lcdbir);
                }

                if (ObjectUtil.isNotEmpty(dbInfodata)) {
                    sqlQuery = filterSqlCount;

                    //쿼리 실행
                    rtnQuery = (String) mktCallQueryDao.callSelectObject("getSegmentFilterCount", sqlQuery, new ArrayList<String>(), dbInfodata, java.lang.String.class);

                }

                ssfrdata.setFilterSqlCount(filterSqlCount);
                ssfrdata.setFilterSql(filterSql);
                ssfrdata.setCount(rtnQuery);

                //세그먼트 필터 sql/count 수정
                kprSegmentMapper.updateSegmentFilterSqlAndCount(ssfrdata);
                rtnValue.setSuccess(true);
                rtnValue.setMessage(rtnQuery);

                if (ObjectUtil.isNotEmpty(rtnQuery)) {
                    rtnValue.setSuccess(true);
                    rtnValue.setMessage(rtnQuery);
                }
            } catch(Exception e){
                rtnValue.setSuccess(false);
                rtnValue.setMessage("MSG_S0007");
            }

        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage(IFVMErrorHelper.MSG_S0006);
        }

        return rtnValue;
    }

    public String genSegmentLcBaseSql(KprSegmentFilterReqDto sfr) {
        KprSegmentLcTblRelListReqDto reqDto = new KprSegmentLcTblRelListReqDto();
        reqDto.setSegmentId(sfr.getSegmentId());

        List<KprSegmentLcTblRelListResDto> lcTblRelList = kprSegmentMapper.selectSegmentLcTableRelListBySegId(reqDto);

        for (int i = 0; i < lcTblRelList.size(); i++) {
            KprSegmentLcTblRelListResDto lcTblRel = lcTblRelList.get(i);

            if (ObjectUtil.isNotEmpty(lcTblRel) && ObjectUtil.isNotEmpty(lcTblRel.getLeftLgcCompTblRelId())) {
                reqDto.setLeftLgcCompTblRelId(lcTblRel.getLeftLgcCompTblRelId());
                List<KprSegmentLcTblRelListResDto> lcTblRelChildList = kprSegmentMapper.selectSegmentLcTableRelListByTblRelId(reqDto);

                lcTblRelList.addAll(lcTblRelChildList);
            }
        }

        Set<KprSegmentLcTblRelListResDto> set = new HashSet<KprSegmentLcTblRelListResDto>(lcTblRelList);
        List<KprSegmentLcTblRelListResDto> rtnList = new ArrayList<KprSegmentLcTblRelListResDto>(set);

        Collections.sort(rtnList);

        int idx = 0;
        String beforeLeftSchmaTblNm = "";
        String beforeLeftTblAlias = "";
        String beforeRightSchmaTblNm = "";
        String beforeRightTblAlias = "";
        StringBuffer sql = new StringBuffer();
        for (KprSegmentLcTblRelListResDto rel : rtnList) {
            String joinTypeCd = rel.getJoinTypeCd();
            String joinTypeNm = rel.getJoinTypeNm();
            String joinOprtCd = rel.getJoinOprtCd();
            String joinOprtNm = rel.getJoinOprtNm();
            String leftSchmaTblNm = rel.getLeftSchmaTblNm();
            String leftTblAlias = rel.getLeftTblAlias();
            String leftTblAliasColNm = rel.getLeftTblAliasColNm();
            String rightTblAlias = rel.getRightTblAlias();
            String rightSchmaTblNm = rel.getRightSchmaTblNm();
            String rightTblAliasColNm = rel.getRightTblAliasColNm();

            if (idx == 0) {
                if (ObjectUtil.isNotEmpty(leftSchmaTblNm) && ObjectUtil.isNotEmpty(leftTblAlias)) {
                    sql.append(String.format(" from %s %s", leftSchmaTblNm, leftTblAlias));
                    sql.append(String.format("\n %s join %s %s on %s %s %s", joinTypeNm, rightSchmaTblNm, rightTblAlias, leftTblAliasColNm, joinOprtNm, rightTblAliasColNm));
                } else {
                    sql.append(String.format(" from %s %s", rightSchmaTblNm, rightTblAlias));
                }
            } else {
                if (beforeRightSchmaTblNm.equals(rightSchmaTblNm) && beforeRightTblAlias.equals(rightTblAlias)) {
                    sql.append(String.format(" and %s %s %s", leftTblAliasColNm, joinOprtNm, rightTblAliasColNm));
                } else {
                    sql.append(String.format("\n %s join %s %s on %s %s %s", joinTypeNm, rightSchmaTblNm, rightTblAlias, leftTblAliasColNm, joinOprtNm, rightTblAliasColNm));
                }
            }

            beforeRightSchmaTblNm = rightSchmaTblNm;
            beforeRightTblAlias = rightTblAlias;
            idx++;
        }

        return sql.toString();
    }

    /**
     * @return :
     * @programId :
     * @name : genSegmentFilterSql
     * @date : 2019. 2. 15.
     * @author : dg.ryu
     * @table :
     * @description : 세그먼트 필터 SQL 생성
     */
    @SuppressWarnings("unchecked")
    public KprSegmentFilterResDto genSegmentFilterSql(KprSegmentFilterReqDto sfr) {
        LogUtil.param(this.getClass(), sfr);

        KprSegmentFilterResDto rtnValue = new KprSegmentFilterResDto();


        //로지컬컴포넌트 key and Sql 조회
        KprLogicalComponentSegKeyAndSqlResDto lgcRes = new KprLogicalComponentSegKeyAndSqlResDto();
        lgcRes = kprSegmentMapper.selectLogicalComponentSegKeyAndSql(sfr);

        String lgcSql = lgcRes.getLgcSql();
        String baseSelect = "select " + lgcRes.getKeyColumn() + " as segkey";
        int idx = lgcSql.indexOf("from") > 0 ? lgcSql.indexOf("from") : lgcSql.indexOf("FROM");
        String baseForm = lgcSql.substring(idx);

        /*String genBaseForm = genSegmentLcBaseSql(sfr);

        if (ObjectUtil.isNotEmpty(genBaseForm)) {
            baseForm = genBaseForm;
        }*/

        String baseSql = baseSelect + " " + baseForm;
        String groupByStr = " group by " + lgcRes.getKeyColumn();

        //하위 필터 조회
        List<KprSegmentFilterResDto> filterList = new ArrayList<KprSegmentFilterResDto>();

        //전체건수 필터 조회
        KprSegmentFilterResDto allCoutFilter = kprSegmentMapper.selectAllCountSegmentFilter(sfr);
        filterList.add(allCoutFilter);

        for (int i = 0; i < filterList.size(); i++) {
            KprSegmentFilterResDto filter = filterList.get(i);

            //필터 설정
            setFilter(filter, filterList);

            String x1 = "";
            String x2 = "";

            //조합필터 일 경우 조합필터 값 존재여부확인(x1, x2)
            if (ANL_SEG_FILTER_TYPE_CD.UNION.toString().equals(filter.getFilterTypeCode())
                    || ANL_SEG_FILTER_TYPE_CD.INTERSECTION.toString().equals(filter.getFilterTypeCode())
                    || ANL_SEG_FILTER_TYPE_CD.A_DIFF_SET.toString().equals(filter.getFilterTypeCode())
                    || ANL_SEG_FILTER_TYPE_CD.B_DIFF_SET.toString().equals(filter.getFilterTypeCode())
            ) {


                x1 = getFilterSql(filter.getCombFilterAId(), filterList);
                x2 = getFilterSql(filter.getCombFilterBId(), filterList);

                if (ObjectUtil.isEmpty(x1) || ObjectUtil.isEmpty(x2)) {
                    //값이 없을경우 필터목록 마지막으로 이동
                    filterList.add(filter);
                    filterList.remove(i);
                    i = i - 1;

                    continue;
                }
            }


            String whereStr = ObjectUtil.isNotEmpty(filter.getWhereStr()) ? filter.getWhereStr() : "";
            String havingStr = ObjectUtil.isNotEmpty(filter.getHavingStr()) ? filter.getHavingStr() : "";
            String filterSql = "";
            String filterSqlCount = "";

            /**
             * 전체
             */
            if (ANL_SEG_FILTER_TYPE_CD.ALL.toString().equals(filter.getFilterTypeCode())) {
                filterSql = baseSql + whereStr + groupByStr + havingStr;
                filterSqlCount = "select count(distinct segkey) from (" + filterSql + ") t";
            }
            /**
             * 기본필터
             */
            else if (ANL_SEG_FILTER_TYPE_CD.DEFAULT.toString().equals(filter.getFilterTypeCode())) {

                // LIKE 유형
                if ("LIKE_L".equals(filter.getOperatCode()) || "LIKE_R".equals(filter.getOperatCode())) {
                    filter.setOperatCode("LIKE");
                }

                if ("CUSTDTDEF".equals(filter.getOperatCode())) {
                    //사용자 날짜 정의
                    if(ObjectUtil.isEmpty(filter.getCustDtDef())){
                        whereStr += " and " + filter.getTblAliasColNm() + " " + "is null";
                    } else {
                        whereStr += " and " + filter.getTblAliasColNm() + " " + filter.getCustDtDef();
                    }
                } else if ("IS NULL".equals(filter.getOperatCode()) || "IS NOT NULL".equals(filter.getOperatCode())) {
                    whereStr += " and " + filter.getTblAliasColNm() + " " + filter.getOperatCode();
                } else {
                    // 기준 컬럼이 DATE 형 일 경우
                    if ("ORACLE".equals(filter.getConDbType()) && "DATE".equals(filter.getDataTypeCd())) {
                        String conVal = filter.getFilterValue();

                        if ("IN".equals(filter.getOperatCode()) || "NOT IN".equals(filter.getOperatCode())) {
                            conVal = conVal.replace("(", "");
                            conVal = conVal.replace(")", "");
                            conVal = conVal.replace("'", "");

                            String s[] = conVal.split(",");

                            String r = "";
                            boolean f = false;
                            for (String t : s) {
                                if (t.indexOf('.') > 0) {
                                    t = t.substring(0, t.indexOf('.'));
                                }

                                if (f) {
                                    r += ",";
                                }

                                r += "TO_DATE('" + t + "', 'yyyy-mm-dd hh24:mi:ss')";

                                f = true;
                            }

                            conVal = "(" + r + ")";
                        } else {
                            // 밀리세컨드 제거
                            if (conVal.indexOf('.') > 0) {
                                conVal = conVal.substring(0, conVal.indexOf('.')) + "'";
                            }

                            conVal = "TO_DATE(" + conVal + ", 'yyyy-mm-dd hh24:mi:ss')";
                        }

                        whereStr += " and " + filter.getTblAliasColNm() + " " + filter.getOperatCode() + " " + conVal;
                    } else {
                        whereStr += " and " + filter.getTblAliasColNm() + " " + filter.getOperatCode() + " " + filter.getFilterValue();
                    }
                }

                if (ObjectUtil.isNotEmpty(filter.getParSegFilterSql())) {
                    String s1 = filter.getParSegFilterSql();
                    String s2 = baseSql + whereStr + groupByStr + havingStr;

                    filterSql = "select distinct x1.segkey from (" + s1 + ")  x1 join (" + s2 + ")  x2 on x1.segkey = x2.segkey";
                    filterSqlCount = "select count(distinct x1.segkey) from (" + s1 + ")  x1 join (" + s2 + ")  x2 on x1.segkey = x2.segkey";
                } else {
                    filterSql = baseSql + whereStr + groupByStr + havingStr;
                    filterSqlCount = "select count(distinct segkey) from (" + filterSql + ") t";
                }
            }
            /**
             * 그룹함수
             */
            else if (ANL_SEG_FILTER_TYPE_CD.GROUP_FUNC.toString().equals(filter.getFilterTypeCode())) {
                if ("".equals(havingStr)) {
                    havingStr += " having " + filter.getGroupFuncTypeCode() + "(" + filter.getGroupFuncDtl() + ") " + filter.getOperatCode() + " " + filter.getFilterValue();
                } else {
                    havingStr += " and " + filter.getGroupFuncTypeCode() + "(" + filter.getGroupFuncDtl() + ") " + filter.getOperatCode() + " " + filter.getFilterValue();
                }

                if (ObjectUtil.isNotEmpty(filter.getParSegFilterSql())) {
                    String s1 = filter.getParSegFilterSql();
                    String s2 = baseSql + whereStr + groupByStr + havingStr;

                    filterSql = "select distinct x1.segkey from (" + s1 + ")  x1 join (" + s2 + ")  x2 on x1.segkey = x2.segkey";
                    filterSqlCount = "select count(distinct x1.segkey) from (" + s1 + ")  x1 join (" + s2 + ")  x2 on x1.segkey = x2.segkey";
                } else {
                    filterSql = baseSql + whereStr + groupByStr + havingStr;
                    filterSqlCount = "select count(distinct segkey) from (" + filterSql + ") t";
                }
            }
            /**
             * 합집합
             */
            else if (ANL_SEG_FILTER_TYPE_CD.UNION.toString().equals(filter.getFilterTypeCode())) {
                filterSql = "select distinct segkey from (" + x1 + " union all " + x2 + ") t";
                filterSqlCount = "select count(distinct segkey) from (" + x1 + " union all " + x2 + ") t";
            }
            /**
             * 교집합
             */
            else if (ANL_SEG_FILTER_TYPE_CD.INTERSECTION.toString().equals(filter.getFilterTypeCode())) {
                filterSql = "select distinct x1.segkey from (" + x1 + ")  x1 join (" + x2 + ")  x2 on x1.segkey = x2.segkey";
                filterSqlCount = "select count(distinct x1.segkey) from (" + x1 + ")  x1 join (" + x2 + ")  x2 ON x1.segkey = x2.segkey";
            }
            /**
             * A차집합
             */
            else if (ANL_SEG_FILTER_TYPE_CD.A_DIFF_SET.toString().equals(filter.getFilterTypeCode())) {
                filterSql = "select distinct x1.segkey from (" + x1 + ")  x1 left join (" + x2 + ")  x2 on x1.segkey = x2.segkey where x2.segkey is null";
                filterSqlCount = "select count(distinct x1.segkey) from (" + x1 + ")  x1 left join (" + x2 + ")  x2 on x1.segkey = x2.segkey where x2.segkey is null";
            }

            /**
             * B차집합
             */
            else if (ANL_SEG_FILTER_TYPE_CD.B_DIFF_SET.toString().equals(filter.getFilterTypeCode())) {
                filterSql = "select distinct x2.segkey from (" + x1 + ")  x1 right outer join (" + x2 + ")  x2 on x1.segkey = x2.segkey where x1.segkey is null";
                filterSqlCount = "select count(distinct x2.segkey) from (" + x1 + ")  x1 right outer join (" + x2 + ")  x2 on x1.segkey = x2.segkey where x1.segkey is null";
            }

            filter.setWhereStr(whereStr);
            filter.setHavingStr(havingStr);
            filter.setFilterSql(filterSql);
            filter.setFilterSqlCount(filterSqlCount);

            //현재 필터와 구하려는 필터 아이디가 같다면 중지
            if (sfr.getSegFilterId().equals(filter.getSegFilterId())) {

                rtnValue.setFilterSql(filter.getFilterSql());
                rtnValue.setFilterSqlCount(filter.getFilterSqlCount());

                break;
            }
            //하위 필터 조회
            else {
                KprSegmentFilterReqDto req = new KprSegmentFilterReqDto();
                req.setSystemColumn(sfr.getSystemColumn());
                req.setSegmentId(sfr.getSegmentId());
                req.setSegFilterId(filter.getSegFilterId());

                //하위 필터의 하위 필터 조회
                List<KprSegmentFilterResDto> childFilterList = new ArrayList<KprSegmentFilterResDto>();
                childFilterList = kprSegmentMapper.selectChildSegmentFilterList(req);

                if (ObjectUtil.isNotEmpty(childFilterList)) {
                    filterList.addAll(childFilterList);
                }
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : getLogicalComponentDBInfo
     * @date : 2016. 7. 12.
     * @author : 류동균
     * @table : anl.anl_db_infom
     * @description : 로지컬 컴포넌트 db 정보 조회
     */
    public MKTDBInfoDTO getLogicalComponentDBInfo(KprLogicalComponentDBInfoReqDto lcdbir) {
        LogUtil.param(this.getClass(), lcdbir);
        KprLogicalComponentDBInfoResDto lgcDbInfo = new KprLogicalComponentDBInfoResDto();

        //로지컬 컴포넌트 db 정보 조회
        lgcDbInfo = kprSegmentMapper.selectLogicalComponentDBInfo(lcdbir);
        //JSONObject dbInfoJSON = new JSONObject();
        MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
        if (ObjectUtil.isNotEmpty(lgcDbInfo.getSecretNm())) {
            try {

                //	BeansUtil.getAWSCredentials()
                Map<String, Object> map = new SecretsManager(BeansUtil.getAWSCredentials(),
                        BeansUtil.getAwsRegion()
                ).getSecretMap(lgcDbInfo.getSecretNm());

                //	dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
                lgcDbInfo.setConUrl(map.get("url").toString());
                lgcDbInfo.setConId(map.get("username").toString());
                lgcDbInfo.setConPassword(map.get("password").toString());
                lgcDbInfo.setConIp(map.get("ip").toString());
                lgcDbInfo.setConPort(map.get("port").toString());

            } catch (ArithmeticException e) {
                LogUtil.error(e.getMessage());
            }
        } else {
            lgcDbInfo.setConPassword(encryptor.decrypt(lgcDbInfo.getConPassword()));
        }
        dbInfo.setDriverClassName(lgcDbInfo.getConDbClass());
        dbInfo.setConIp(lgcDbInfo.getConIp());
        dbInfo.setConPort(lgcDbInfo.getConPort());
        dbInfo.setUserName(lgcDbInfo.getConId());
        dbInfo.setPassword(lgcDbInfo.getConPassword());
        dbInfo.setUrl(lgcDbInfo.getConUrl());
        dbInfo.setConDbType(lgcDbInfo.getConDbType());


        return dbInfo;
    }

    /**
     * @return :
     * @programId :
     * @name : setFilter
     * @date : 2019. 2. 15.
     * @author : dg.ryu
     * @table :
     * @description : 필터 설정
     */
    public void setFilter(KprSegmentFilterResDto f, List<KprSegmentFilterResDto> l) {

        if (ANL_SEG_FILTER_TYPE_CD.ALL.toString().equals(f.getFilterTypeCode())) {
            f.setWhereStr(" where 1=1");
            f.setHavingStr("");
        } else if (ObjectUtil.isNotEmpty(f.getParSegFilterId())) {
            for (KprSegmentFilterResDto p : l) {
                if (f.getParSegFilterId().equals(p.getSegFilterId())) {
                    f.setWhereStr(p.getWhereStr());
                    f.setHavingStr(p.getHavingStr());

                    if (ANL_SEG_FILTER_TYPE_CD.UNION.toString().equals(p.getFilterTypeCode())
                            || ANL_SEG_FILTER_TYPE_CD.INTERSECTION.toString().equals(p.getFilterTypeCode())
                            || ANL_SEG_FILTER_TYPE_CD.A_DIFF_SET.toString().equals(p.getFilterTypeCode())
                            || ANL_SEG_FILTER_TYPE_CD.B_DIFF_SET.toString().equals(p.getFilterTypeCode())
                    ) {
                        f.setParSegFilterSql(p.getFilterSql());
                    } else if (ObjectUtil.isNotEmpty(p.getParSegFilterSql())) {
                        f.setParSegFilterSql(p.getFilterSql());
                    }

                    break;
                }
            }
        } else {
            f.setWhereStr(" where 1=1");
            f.setHavingStr("");
        }
    }

    /**
     * @return :
     * @programId :
     * @name : getFilterSql
     * @date : 2019. 2. 15.
     * @author : dg.ryu
     * @table :
     * @description : 필터 SQL 추출
     */
    public String getFilterSql(String f, List<KprSegmentFilterResDto> l) {
        String rtnValue = null;
        for (KprSegmentFilterResDto p : l) {
            if (f.equals(p.getSegFilterId())) {
                rtnValue = ObjectUtil.isNotEmpty(p.getFilterSql()) ? p.getFilterSql() : "";
                break;
            }
        }
        return rtnValue;
    }
}