package com.icignal.kepler.targetGroup.targetSimple.service;

import java.util.*;

import com.icignal.common.util.*;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.*;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetSimple.type.BrandTypeCode;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.api.plus.Person;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;
import com.icignal.kepler.common.mapper.KprCommonMapper;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetGroup.mapper.KprTargetGroupMapper;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprDbInfoDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewSaveDataReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewSaveReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListTagetGroupReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListUpdateTagetGroupReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleGroupNameResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTagetGroupResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTargetGroupValueResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprLogicalComponentInfoResDto;
import com.icignal.kepler.targetGroup.targetSimple.mapper.KprTargetSimpleMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.StringUtils;

@Service("KprTargetSimpleService")
public class KprTargetSimpleService {
    @Autowired
    private CommonService commonService;
    @Autowired
    private KprTargetSimpleMapper KprTargetSimpleMapper;
    @Autowired
    private KprCommonMapper kprCommonMapper;
    @Autowired
    StandardPBEStringEncryptor encrypor;
    @Autowired
    private SystemCommCodeService systemCommcodeService;
    @Autowired
    private MKTCallQueryDao mktCallQueryDao;
    @Autowired
    private KprTargetGroupMapper kprTragetGroupMapper;

    //데이터베이스 유형
    private enum DATABASE_TYPE {MYSQL, ORACLE,MSSQL}

    ;

    //연산자
    private enum SERC_OPRT_CODE {BETWEEN, IN, LIKE, CUSTDTDEF, FROMTO}

    ;

    private static final String CARRIAGE_RETURN_STR = "\n ";
    private static final String AND_STR = " AND ";
    private static final String WHERE_STR = " WHERE ";
    private static final String EQUAL_STR = " = ";
    private static final String TGT_GROUP_SIMPLE_LC_TYPE = "TGT_GROUP_SIMPLE_LC_TYPE";
    private static final String MKT_DT_DEFAULT = "MKT_DT_DEFAULT";
    private static final String SELECT_STR = "SELECT ";
    private static final String COUNT_STR = "COUNT(*)";

    // 그룹 컬럼 이름 조회
    public List<KprGetTargetSimpleListResDto> aleadySelectGroupColName(KprGetTargetSimpleListReqDto param) {

        LogUtil.param(this.getClass(), param);

        return KprTargetSimpleMapper.aleadySelectGroupColName(param);
    }

    // 그룹 이름 조회
    public List<KprGetTargetSimpleGroupNameResDto> aleadySelectGroupName(KprGetTargetSimpleListReqDto param) {

        LogUtil.param(this.getClass(), param);

        return KprTargetSimpleMapper.aleadySelectGroupName(param);
    }

    // 신규 그룹 컬럼 이름 조회
    public List<KprGetTargetSimpleListResDto> selectGroupColNameCondition(KprGetTargetSimpleListNewReqDto param) {

        LogUtil.param(this.getClass(), param);
        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();
        KprGetTargetSimpleListNewReqDto retValue = new KprGetTargetSimpleListNewReqDto();
        retValue.setDbInfo(serverType);

        return KprTargetSimpleMapper.selectGroupColNameCondition(retValue);
    }

    // 신규 그룹 이름 조회
    public List<KprGetTargetSimpleGroupNameResDto> selectGroupTopNameCondition(KprGetTargetSimpleListNewReqDto param) {

        LogUtil.param(this.getClass(), param);
        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();
        KprGetTargetSimpleListNewReqDto retValue = new KprGetTargetSimpleListNewReqDto();
        retValue.setDbInfo(serverType);

        return KprTargetSimpleMapper.selectGroupTopNameCondition(retValue);
    }

    // 신규 심플 타겟팅 조건 삽입
    public StatusResDto insertGroupNameTargetingGroupCondition(KprGetTargetSimpleListNewSaveReqDto param) {

        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String tgtGroupId = commonService.getRowID();

        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        String[] query = null;
        KprLogicalComponentInfoResDto lgcCompInfo = KprTargetSimpleMapper.selectLogicalComponentInfo(serverType);
        query = getLgcTargetQuery(param.getDataList(), lgcCompInfo);
        List<String> queryData = getTargetGroupCount(query);//대상수[0],대상수_쿼리[1],대상자_쿼리[2],대상자[나머지]


        // 타겟그룹 조건 등록
        for (KprGetTargetSimpleListNewSaveDataReqDto data : param.getDataList()) {

            data.setTargetGroupId(tgtGroupId);
            data.setDbInfo(serverType);
            data.setSystemColumn(param.getSystemColumn());
            KprTargetSimpleMapper.insertGroupNameTargetingGroupCondition(data);
        }
        // 타겟그룹 등록
        param.setTargetGroupId(tgtGroupId);
        param.setDbInfo(serverType);
        param.setCnt(queryData.get(0));
        param.setFilterSqlCount(queryData.get(1));
        param.setFilterSql(queryData.get(2));
        KprTargetSimpleMapper.insertGroupNameTargetingGroupEnRoll(param);

        rtnValue.setSuccess(true);
        rtnValue.setMessage(tgtGroupId);

        return rtnValue;
    }

    // 타겟 그룹 조회
    public KprGetTargetSimpleListTagetGroupResDto selectTargetGroup(KprGetTargetSimpleListTagetGroupReqDto param) {

        LogUtil.param(this.getClass(), param);

        return KprTargetSimpleMapper.selectTargetGroup(param);
    }

    // 타겟 그룹 헤당 심플타겟팅 값 조회
    public List<KprGetTargetSimpleListTargetGroupValueResDto> aleadySelectGroupValue(KprGetTargetSimpleListTagetGroupReqDto param) {

        LogUtil.param(this.getClass(), param);

        return KprTargetSimpleMapper.aleadySelectGroupValue(param);
    }

    // 타겟 그룹 수정
    public StatusResDto tarGetGroupValueUpdate(KprGetTargetSimpleListUpdateTagetGroupReqDto param) {

        LogUtil.param(this.getClass(), param);

        StatusResDto reValue = new StatusResDto();
        reValue.setSuccess(false);

        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        String[] query = null;
        KprLogicalComponentInfoResDto lgcCompInfo = KprTargetSimpleMapper.selectLogicalComponentInfo(serverType);
        try {
            query = getLgcTargetQuery(param.getDataList(), lgcCompInfo);
            List<String> queryData = getTargetGroupCount(query);//대상수[0],대상수_쿼리[1],대상자_쿼리[2],대상자[나머지]
//            TARGET_EXE_YN = 'Y'
            param.setCnt(queryData.get(0));
            param.setFilterSqlCount(queryData.get(1));
            param.setFilterSql(queryData.get(2));
            KprTargetSimpleMapper.tarGetGroupValueUpdate(param);
            for (KprGetTargetSimpleListNewSaveDataReqDto data : param.getDataList()) {
                data.setSystemColumn(param.getSystemColumn());
                KprTargetSimpleMapper.tarGetGroupTargetingValueUpdate(data);
            }
            reValue.setSuccess(true);
            reValue.setMessage(param.getTargetGroupId());
        } catch (Exception e) {
            reValue.setSuccess(false);

        }
        return reValue;
    }

    // 대상수를 넘겨줌.
    public KprGetTargetSimpleListNewSaveReqDto insertTargetingCountBtn(KprGetTargetSimpleListNewSaveReqDto param) {

        LogUtil.param(this.getClass(), param);

        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        String[] query = null;
        KprLogicalComponentInfoResDto lgcCompInfo = KprTargetSimpleMapper.selectLogicalComponentInfo(serverType);
        query = getLgcTargetQuery(param.getDataList(), lgcCompInfo);
        List<String> queryData = new ArrayList<>();
        KprGetTargetSimpleListNewSaveReqDto retValue = new KprGetTargetSimpleListNewSaveReqDto();
        try {
            queryData = getTargetGroupCount(query);//대상수[0],대상수_쿼리[1],대상자_쿼리[2],대상자[나머지]
            param.setCnt(queryData.get(0));
            retValue = param;
        } catch (Exception e) {
        }

        return retValue;
    }

    //심플디테일 그리드 쿼리 실행
    public GridPagingResDto selectSimpleTargetingGridList(KprTargetGroupTargetListReqDto tgtlr) {

        LogUtil.param(this.getClass(), tgtlr);

        ((GridPagingReqDto) tgtlr).init(CommonUtil.getInstance().getDBType());

        GridPagingResDto rtnValue = new GridPagingResDto<>();
        String lgcCompId = "";
        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");

        List<String> targetMemberList = selectTargetMemberNumListSql(tgtlr, "PAGE");

        if (ObjectUtil.isNotEmpty(targetMemberList) && targetMemberList.size() > 0) {
            // 공통코드 테이블에서 회원정보 공통LC RID 조회
            MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode(TGT_GROUP_SIMPLE_LC_TYPE);
            GridPagingResDto commCodeGrid = systemCommcodeService.getCommCodeList(commCodeReq);
            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                    MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                    if (mccgrd.getMarkName().equals(serverType)) {
                        lgcCompId = mccgrd.getAttrib02();
                        break;
                    }
                }
            }

            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(tgtlr.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);

            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = getTargetGroupLcDBInfo(tgdir);

            //db 정보 Setting
            MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
            reqDbInfoDto.setDriverClassName(lcDBInfo.getConDbClass());
            reqDbInfoDto.setConIp(lcDBInfo.getConIp());
            reqDbInfoDto.setConPort(lcDBInfo.getConPort());
            reqDbInfoDto.setUserName(lcDBInfo.getConId());
            reqDbInfoDto.setPassword(lcDBInfo.getConPassword());
            reqDbInfoDto.setUrl(lcDBInfo.getConUrl());
            reqDbInfoDto.setConDbType(lcDBInfo.getConDbType());

            // 회원정보 조회하여 대상자 수 조회
            KprTargetGroupReqDto tgrReq = new KprTargetGroupReqDto();
            tgrReq.setSystemColumn(tgtlr.getSystemColumn());
            tgrReq.setTargetGroupId(tgtlr.getTargetGroupId());

            KprTargetGroupResDto targetGroupInfo = getTargetGroup(tgrReq);
            rtnValue.setRecords(Integer.parseInt(targetGroupInfo.getTargetCount()));

//            KprGetTargetSimpleListTagetGroupReqDto aldSeldGroupReqDto = new KprGetTargetSimpleListTagetGroupReqDto();
//            aldSeldGroupReqDto.setTargetGroupId(tgtlr.getTargetGroupId());
//            List<KprGetTargetSimpleListTargetGroupValueResDto> aldSelGroup = KprTargetSimpleMapper.aleadySelectGroupValue(aldSeldGroupReqDto);
//            Collection<KprGetTargetSimpleListTargetGroupValueResDto> aldSelArray = CollectionUtils.select(aldSelGroup, object -> StringUtils.equalsIgnoreCase(((KprGetTargetSimpleListTargetGroupValueResDto) object).getSumYn(), "Y"));

//            Boolean aldSelFlag = aldSelArray.size() > 0 ? true : false;

//            List<String> aldColDataList = new ArrayList<>();
//            for(KprGetTargetSimpleListTargetGroupValueResDto aldColData : aldSelArray) {
//                aldColDataList.add(aldColData.getId());
//            }

//            KprTargetGroupColumnListReqDto sumQueryCallReqDto = new KprTargetGroupColumnListReqDto();
//            sumQueryCallReqDto.setTargetGroupId(tgtlr.getTargetGroupId());
//            List<KprTargetGroupColumnListResDto> sumQueryCallReq = kprTragetGroupMapper.selectTargetGroupColumnList(sumQueryCallReqDto);

//            String lgcFromSql = "";

//            if (lcDBInfo.getLgcSql().indexOf("from") > 0) {
//                lgcFromSql = lcDBInfo.getLgcSql().substring(lcDBInfo.getLgcSql().indexOf("from"));
//            } else {
//                lgcFromSql = lcDBInfo.getLgcSql().substring(lcDBInfo.getLgcSql().indexOf("FROM"));
//            }


            //기본 쿼리 생성
            StringBuilder query = new StringBuilder();
//            if(aldSelFlag){
//                int colIdx = 1;
//                query.append("select ");
//                for(KprTargetGroupColumnListResDto colData : sumQueryCallReq) {
//                        if(colIdx != 1){
//                            query.append(",");
//                        }
//                        if(aldColDataList.contains(colData.getTgtGroupCondId())) {
//                            query.append("sum( t."+colData.getColumnName()+")\n");
//                        } else {
//                            query.append("max( t."+colData.getColumnName()+")\n");
//                        }
//                    colIdx++;
//                }
//                query.append("from (\n")
//                     .append(lcDBInfo.getLgcSql()+"\n");
//            } else {
                query.append(lcDBInfo.getLgcSql()+"\n")
                        .insert(6," distinct ");
//            }
            query.append(" where " + lcDBInfo.getSegKeyCol());

            int idx = 1;
            int size = targetMemberList.size();
            String inStr = "";
            List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();

            for (String memId : targetMemberList) {

                //in 절 값 생성
                if (idx % 1000 == 0 || idx == size) {
                    inStr += "'" + memId + "'";
                } else {
                    inStr += "'" + memId + "',";
                }

                //1000단위로 나누어 실행 또는 마지막
                if (idx % 1000 == 0 || idx == size) {

//                    if(aldSelFlag) {
//                        query.append(" in (" + inStr + ")\n")
//                             .append(") t");
//                    } else {
                        query.append(" in (" + inStr + ")\n");
//                    }

                    String sql = query.toString();

                    //타겟그룹 대상자 목록 조회
                    list.addAll(mktCallQueryDao.callSelectForListMap("getSimpleTargetList", sql, new ArrayList<String>(), reqDbInfoDto));

                    //초기화
                    inStr = "";
                }

                idx++;
            }

            //결과 list
            //     List<LinkedHashMap<String, String>> rsTable = new ArrayList<>();

            rtnValue = ObjectUtil.ConvertListToGrid(tgtlr, list, rtnValue.getRecords(), targetGroupInfo.getConDbType());
        }

        return rtnValue;
    }

    //워크플로우 조건추출 목록 조회
    public GridPagingResDto<KprTargetGroupListResDto> selectSimpleList(KprTargetGroupListReqDto tglr) {
        LogUtil.param(this.getClass(), tglr);
        tglr.setSVCAlias("tg");

        return new GridPagingResHelper<KprTargetGroupListResDto>().newGridPagingResDto(
                tglr.init(CommonUtil.getInstance().getDBType()),
                KprTargetSimpleMapper.selectSimpleList(tglr));
    }

    /**
     * 타겟 대상자 MBR_NO 목록 조회
     *
     * @param tgtlr
     * @return
     * @programId :
     * @name : selectTargetMemberNumListSql
     * @date : 2018. 2. 23.
     * @author : jh.kim
     * @table :
     * @description :
     * @modify : 2020-07-21 LEE GYEONG YOUNG
     */
    @SuppressWarnings("unchecked")
    public List<String> selectTargetMemberNumListSql(KprTargetGroupTargetListReqDto tgtlr, String type) {
        LogUtil.param(this.getClass(), tgtlr);

        List<String> rtnValue = new ArrayList<>();
        StringBuilder sqlQuery = new StringBuilder();

        // 대상 목록 SQL 조회
        sqlQuery = new StringBuilder(kprTragetGroupMapper.selectTargetMemberNumListSql(tgtlr));

        tgtlr.setSVCAlias("");

        // 접속 db 정보 설정
        MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();


        //타겟그룹 조회
        KprTargetGroupDBInfoReqDto tgsfdr = new KprTargetGroupDBInfoReqDto();
        tgsfdr.setLang(tgtlr.getLang());
        tgsfdr.setTargetGroupId(tgtlr.getTargetGroupId());
        dbInfo = getTargetGroupDBInfo(tgsfdr);

        // 쿼리 실행
        if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery.toString())) {
            //조회 유형이 전체가 아닐 경우만 페이징 조회
            if (!"ALL".equals(type)) {
                //페이징 설정
                if (DB_TYPE.MYSQL.toString().equals(dbInfo.getConDbType()) || DB_TYPE.MEMSQL.toString().equals(dbInfo.getConDbType())) {
                    sqlQuery.append( "limit " + tgtlr.getSkipCount() + ", " + tgtlr.getPageSize());
                } else if (DB_TYPE.POSTGRESQL.toString().equals(dbInfo.getConDbType())) {
                    sqlQuery.append( " offset " + tgtlr.getSkipCount() + " limit " + tgtlr.getPageSize());
                } else if (DB_TYPE.MSSQL.toString().equals(dbInfo.getConDbType())) {
                    StringBuilder rtnQuery = new StringBuilder();

                    rtnQuery.append("select t.segkey\n")
                            .append("  from (\n")
                            .append("select t.* ")
                            .append("       , ceiling(count(1) over() / " + tgtlr.getPageSize() + ")+1 as \"totalPage\"\n")
                            .append("       , ceiling(count(1) over()) as \"totalCount\"\n")
                            .append("       , ROW_NUMBER() OVER (ORDER BY segkey DESC) as \"RowNumber\"\n")
                            .append("  from ( ")
                            .append("    " + sqlQuery)
                            .append(") t")
                            .append("        ) t \n")
                            .append(" WHERE RowNumber > " + tgtlr.getSkipCount() + " and RowNumber <= " + tgtlr.getPageSize() * tgtlr.getPage() + "\n");

                    sqlQuery = rtnQuery;
                } else {
                    sqlQuery.append(" offset " + tgtlr.getSkipCount() + " rows fetch next " + tgtlr.getPageSize() * tgtlr.getRows() + " rows only");
                }
            }

            rtnValue = mktCallQueryDao.callSelectForList("selexctTargetMemberNumListSql", sqlQuery.toString(), new ArrayList<>(), dbInfo, java.lang.String.class);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : getTargetGroupLcDBInfo
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_db_inform
     * @description : 타겟그룹 LC DB 정보 조회
     * @modify : 2020-07-21 LEE GYEONG YOUNG
     */

    public KprTargetGroupDBInfoResDto getTargetGroupLcDBInfo(KprTargetGroupDBInfoReqDto tgdir) {
        LogUtil.param(this.getClass(), tgdir);

        KprTargetGroupDBInfoResDto dbInfo = kprTragetGroupMapper.selectTargetGroupLcDBInfo(tgdir);

        if (ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
            try {
                Map<String, Object> dbInfoJSON = new SecretsManager(BeansUtil.getAWSCredentials(),
                        BeansUtil.getAwsRegion()
                ).getSecretMap(dbInfo.getSecretNm());

                dbInfo.setConUrl(dbInfoJSON.get("url").toString());
                dbInfo.setConId(dbInfoJSON.get("username").toString());
                dbInfo.setConPassword(dbInfoJSON.get("password").toString());
                dbInfo.setConIp(dbInfoJSON.get("ip").toString());
                dbInfo.setConPort(dbInfoJSON.get("port").toString());

            } catch (IllegalArgumentException e) {
                LogUtil.error(e.getMessage());
            }
        } else {
            dbInfo.setConPassword(encrypor.decrypt(dbInfo.getConPassword()));
        }

        return dbInfo;
    }

    /**
     * @return :
     * @programId : ANL_TGT_002
     * @name : selectTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @description : 타겟그룹 상세 조회
     * @modify : 2020-07-21 LEE GYEONG YOUNG
     */

    public KprTargetGroupResDto getTargetGroup(KprTargetGroupReqDto tgr) {
        LogUtil.param(this.getClass(), tgr);

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
        // rtnValue = kprTragetGroupMapper.getTargetGroup(tgr);

        // 타겟그룹 상세 조회
        rtnValue = KprTargetSimpleMapper.selectTargetGridGroup(tgr);

        // 대상수
        if (ObjectUtil.isNotEmpty(rtnValue.getFilterSqlCount())) {
            String selectContent = rtnValue.getFilterSqlCount();

            KprTargetGroupDBInfoReqDto tgsfdr = new KprTargetGroupDBInfoReqDto();
            tgsfdr.setTargetGroupId(tgr.getTargetGroupId());
            tgsfdr.setLang(tgr.getLang());

            try {
                // 로지컬 컴포넌트 db 정보 조회
                MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
                dbInfo = getTargetGroupDBInfo(tgsfdr);

                if (ObjectUtil.isNotEmpty(dbInfo)) {
                    String rtnQuery = "";
                    // 쿼리 실행
                    rtnQuery = (String) mktCallQueryDao.callSelectObject("getSegmentAllCount", selectContent, new ArrayList<String>(), dbInfo, java.lang.String.class);
                    rtnValue.setTargetCount(rtnQuery);

                    //건수 저장
                    tgr.setCnt(Integer.parseInt(rtnQuery));
                    kprTragetGroupMapper.updateTagetGroupCount(tgr);
                }
            } catch (IllegalArgumentException e) {
                LogUtil.error(e);
                rtnValue.setTargetCount(IFVMErrorHelper.MSG_T0001);
            }
        }
        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : getTargetGroupDBInfo
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_db_inform
     * @description : 타겟그룹 DB 정보 조회
     * @modify : 2020-07-21 LEE GYEONG YOUNG
     */
    public MKTDBInfoDTO getTargetGroupDBInfo(KprTargetGroupDBInfoReqDto tgdir) {
        LogUtil.param(this.getClass(), tgdir);
        KprTargetGroupDBInfoResDto tgDbInfo = new KprTargetGroupDBInfoResDto();

        //로지컬 컴포넌트 db 정보 조회
        tgDbInfo = kprTragetGroupMapper.selectTargetGroupDBInfo(tgdir);

        //접속 db 정보 설정
        MKTDBInfoDTO rtnValue = new MKTDBInfoDTO();
        rtnValue.setDriverClassName(tgDbInfo.getConDbClass());
        rtnValue.setConDbType(tgDbInfo.getConDbType());

        if (ObjectUtil.isNotEmpty(tgDbInfo.getSecretNm())) {
            try {
                Map<String, Object> dbInfoJSON = new SecretsManager(BeansUtil.getAWSCredentials(),
                        BeansUtil.getAwsRegion()
                ).getSecretMap(tgDbInfo.getSecretNm());

                rtnValue.setUrl(dbInfoJSON.get("url").toString());
                rtnValue.setUserName(dbInfoJSON.get("username").toString());
                rtnValue.setPassword(dbInfoJSON.get("password").toString());
                rtnValue.setConIp(dbInfoJSON.get("ip").toString());
                rtnValue.setConPort(dbInfoJSON.get("port").toString());

            } catch (IllegalArgumentException e) {
                LogUtil.error(e.getMessage());
            }
        } else {
            rtnValue.setConIp(tgDbInfo.getConIp());
            rtnValue.setConPort(tgDbInfo.getConPort());
            rtnValue.setUserName(tgDbInfo.getConId());
            rtnValue.setPassword(encrypor.decrypt(tgDbInfo.getConPassword()));
            rtnValue.setUrl(tgDbInfo.getConUrl());
        }

        return rtnValue;
    }

    //대상수,대상자를 구해서 리스트로 넘겨줌.
    public List<String> getTargetGroupCount(String[] query) {

        List<String> target = new ArrayList();
        Integer targetCount = 0;


        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        KprLogicalComponentInfoResDto tgtGroupInfo = new KprLogicalComponentInfoResDto();
        tgtGroupInfo = KprTargetSimpleMapper.selectLogicalComponentInfo(serverType);

        MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
        dbInfo.setDriverClassName(tgtGroupInfo.getConDbClass());
        dbInfo.setConDbType(tgtGroupInfo.getConDbType());

        if (ObjectUtil.isNotEmpty(tgtGroupInfo.getAwsSecretNm())) {
            try {
                Map<String, Object> map = new SecretsManager(BeansUtil.getAWSCredentials(),
                        BeansUtil.getAwsRegion()).getSecretMap(tgtGroupInfo.getAwsSecretNm());
                dbInfo.setUrl(map.get("url").toString());
                dbInfo.setUserName(map.get("username").toString());
                dbInfo.setPassword(map.get("password").toString());
                dbInfo.setConIp(map.get("ip").toString());
                dbInfo.setConPort(map.get("port").toString());
                dbInfo.setDriverClassName(map.get("driverClassName").toString());
            } catch (IllegalArgumentException e) {
                LogUtil.error(e.getMessage());
            }
        } else {
            dbInfo.setConIp(tgtGroupInfo.getConIp());
            dbInfo.setConPort(tgtGroupInfo.getConPort());
            dbInfo.setUserName(tgtGroupInfo.getConId());
            dbInfo.setPassword(encrypor.decrypt(tgtGroupInfo.getConPassword()));
            dbInfo.setUrl(tgtGroupInfo.getConUrl());
        }

        targetCount = (Integer) mktCallQueryDao.callSelectObject("getTargetGroupCount", query[0], new ArrayList<>(), dbInfo, Integer.class);

        List<String> rtnValue = new ArrayList();
        rtnValue.add(targetCount.toString());//대상수 Index : 0번
        rtnValue.add(query[0]);//쿼리1 -> 대상수 Index : 1번
        rtnValue.add(query[1]);//쿼리2 -> 대상자 Index : 2번


        return rtnValue;
    }

    //쿼리를 만듬.
    public String[] getLgcTargetQuery(List<KprGetTargetSimpleListNewSaveDataReqDto> dataList, KprLogicalComponentInfoResDto lgcCompInfo) {

        StringBuilder strWhere = new StringBuilder();
        strWhere.append(CARRIAGE_RETURN_STR).append(WHERE_STR);
        StringBuilder strHaving = new StringBuilder();
        //rid 설정
        strWhere.append("1=1");
        String mainShopCode = dataList.get(0).getMainShopCd();
        String mainShopColumn = BrandTypeCode.fromCode(mainShopCode.substring(0, 1)).getMainShopColumn();

        for (KprGetTargetSimpleListNewSaveDataReqDto cond : dataList) {
            String operationTypeCode = cond.getCompOper();
            String filterValue = cond.getCompVal();
            String andValue = "";
            String lcLogicOper = " " + AND_STR + " "; //and
            String sumYn = cond.getSumYn();

            if(ObjectUtil.isNotEmpty(filterValue)) {

                // 유효성 검사 체크용 쿼리 생성
                // 연산자 타입이 사용자 날짜 함수가 아니라면, 일반적인 처리
                if (!SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
                    filterValue = filterValue.replaceAll("'", "");
                    filterValue = filterValue.replaceAll("\\%", "");
//					filterValue = filterValue.replaceAll("\\(", "");
//					filterValue = filterValue.replaceAll("\\)", "");

                    if (!SERC_OPRT_CODE.BETWEEN.name().equals(operationTypeCode) && cond.getDataTypeCd().equals("DATE") && ObjectUtil.isNotEmpty(filterValue)) {
                        filterValue = filterValue.replace(".0", "");
                        filterValue = filterValue.replace("-", "");
                        filterValue = filterValue.replace(":", "");
                        filterValue = "TO_DATE(" + "'" + filterValue + "'" + ",'" + "yyyymmdd hh24miss" + "'" + ")";
                    }


                    if (SERC_OPRT_CODE.BETWEEN.name().equals(operationTypeCode)) {

                        if (ObjectUtil.isNotEmpty(filterValue)) {
                            String ValueDivi[] = filterValue.split(AND_STR);

                            //문자열 분리
                            for (int i = 0; i < ValueDivi.length; i++) {
                                filterValue = ValueDivi[0];
                                andValue = ValueDivi[1];
                            }
                            andValue = andValue.replaceAll("'", "");
                            andValue = andValue.replaceAll("\\%", "");
//								andValue = andValue.replaceAll("\\(", "");
//								andValue = andValue.replaceAll("\\)", "");
//								
                            if (cond.getDataTypeCd().equals("DATE")) {
                                filterValue = filterValue.replace(".0", "");
                                andValue = andValue.replace(".0", "");
                                filterValue = filterValue.replace("-", "");
                                andValue = andValue.replace("-", "");
                                filterValue = filterValue.replace(":", "");
                                andValue = andValue.replace(":", "");
                                if (DB_TYPE.ORACLE.toString().equals(lgcCompInfo.getConDbType())) {
                                    filterValue =
                                            "TO_DATE(" + "'" + filterValue + "'" + ",'" + "yyyymmdd hh24miss" + "'" + ")" +
                                                    lcLogicOper +
                                                    "TO_DATE(" + "'" + andValue + "'" + ",'" + "yyyymmdd hh24miss" + "'" + ")";
                                } else if (DB_TYPE.MSSQL.toString().equals(lgcCompInfo.getConDbType())) {
                                    filterValue =
                                            "CONVERT(Datetime, " + "'" + filterValue + "'" + ")" +
                                                    lcLogicOper +
                                                    "CONVERT(Datetime, " + "'" + andValue + "'" + ")";
                                }
                            } else {

                                filterValue = "'" + filterValue + "'" + lcLogicOper + "'" + andValue + "'";
                            }
                        }
                    } else if (SERC_OPRT_CODE.IN.name().equals(operationTypeCode) || "NOT IN".equals(operationTypeCode)) {
                        String[] valueList = filterValue.split(",");
                        filterValue = "";

                        for (Integer idx = 0; idx < valueList.length; idx++) {
                            String value = valueList[idx].trim();
                            value = value.trim();

                            if (!cond.getDataTypeCd().equals("DATE")) {
                                filterValue = filterValue + "'" + value + "'";
                            } else {
                                filterValue = filterValue + value;
                            }

                            Integer index = idx + 1;
                            if (index != valueList.length) {
                                filterValue = filterValue + ", ";
                            }
                        }

                        filterValue = " (" + filterValue + ") ";
                    } else if (SERC_OPRT_CODE.LIKE.name().equals(operationTypeCode)) {
                        filterValue = "'%" + filterValue + "%'";
                    } else if ("IS NULL".equals(operationTypeCode)) {
                        filterValue = "";
                    } else if ("IS NOT NULL".equals(operationTypeCode)) {
                        filterValue = "";
                    } else if (SERC_OPRT_CODE.FROMTO.name().equals(operationTypeCode)) {
                        operationTypeCode = "BETWEEN";

                        if (ObjectUtil.isNotEmpty(filterValue)) {
                            String ValueDivi[] = filterValue.split(AND_STR);

                            //문자열 분리
                            for (int i = 0; i < ValueDivi.length; i++) {
                                filterValue = ValueDivi[0];
                                andValue = ValueDivi[1];
                            }
                            andValue = andValue.replaceAll("'", "");
                            andValue = andValue.replaceAll("\\%", "");
//								andValue = andValue.replaceAll("\\(", "");
//								andValue = andValue.replaceAll("\\)", "");
//
                            filterValue = filterValue.replace(".0", "");
                            andValue = andValue.replace(".0", "");
                            filterValue = filterValue.replace("-", "");
                            andValue = andValue.replace("-", "");
                            filterValue = filterValue.replace(":", "");
                            andValue = andValue.replace(":", "");

                            if (DB_TYPE.ORACLE.toString().equals(lgcCompInfo.getConDbType())) {
                                filterValue =
                                        "TO_DATE(" + "'" + filterValue + "'" + ",'" + "yyyymmdd hh24miss" + "'" + ")" +
                                                lcLogicOper +
                                                "TO_DATE(" + "'" + andValue + "'" + ",'" + "yyyymmdd hh24miss" + "'" + ")";
                            } else if (DB_TYPE.MSSQL.toString().equals(lgcCompInfo.getConDbType())) {
                                filterValue =
                                        "CONVERT(Datetime, " + "'" + filterValue + "'" + " + ' 00:00:00.000' )" +
                                                lcLogicOper +
                                                "CONVERT(Datetime, " + "'" + andValue + "'" + "+ ' 23:59:59.997' )";
                            }
                        }
                    } else {
                        if (!cond.getDataTypeCd().equals("DATE")) {
                            filterValue = "'" + filterValue + "'";
                        }
                    }

                } else {
                    //operationTypeCode = EQUAL_STR;

                    String codeValue = filterValue;
                    if (codeValue != null && !codeValue.equals("''") && !codeValue.equals("")) {
                        KprCommonCodeReqDto codeReqDto = new KprCommonCodeReqDto();
                        codeReqDto.setGroupCode(MKT_DT_DEFAULT);
                        codeReqDto.setCodeName(codeValue);
                        KprCommonCodeResDto codeResDto = kprCommonMapper.getCommCodeDetail(codeReqDto);

                        String databaseType = lgcCompInfo.getConDbType();

                        if (DATABASE_TYPE.MYSQL.name().equals(databaseType)) {
                            filterValue = codeResDto.getAttrib01();
                        } else if(DATABASE_TYPE.ORACLE.name().equals(databaseType)) {
                            filterValue = codeResDto.getAttrib02();
                        } else if(DATABASE_TYPE.MSSQL.name().equals(databaseType)) {
                            filterValue = codeResDto.getAttrib04();
                        }
                    }
                }


                if (DB_TYPE.MSSQL.toString().equals(lgcCompInfo.getConDbType())) {
                    if (sumYn.equals("Y")) {
                        //havig 사용시
                        if ("=".equals(operationTypeCode) ||
                                "!=".equals(operationTypeCode) ||
                                ">".equals(operationTypeCode) ||
                                "<".equals(operationTypeCode) ||
                                ">=".equals(operationTypeCode) ||
                                "<=".equals(operationTypeCode)) {

                            strHaving.append(CARRIAGE_RETURN_STR);

                            if (StringUtil.isEmpty(strHaving.toString())) {
                                strHaving.append(" HAVING ");
                            } else {
                                strHaving.append(lcLogicOper);
                            }

                            strHaving.append("sum( cast( " + cond.getTblAliasColNm() + " as numeric))")
                                    .append(" " + operationTypeCode + " ")
                                    .append(" cast(" + filterValue + " as numeric)");

                            continue;
                        }
                    }
                }

                // 그룹 함수 미사용 시
                // AND 조건 설정
                if (filterValue != null && !filterValue.equals("''") && !filterValue.equals("")) {
                    strWhere.append(CARRIAGE_RETURN_STR)
                            .append(lcLogicOper);
                    if (!SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
                        strWhere.append(cond.getTblAliasColNm())
                        .append(" " + operationTypeCode + " ");
                    } else {
                        strWhere.append("convert(datetime,"+cond.getTblAliasColNm()+")");
                    }
                    strWhere.append(" " + filterValue);
                } else if ("IS NULL".equals(operationTypeCode) || "IS NOT NULL".equals(operationTypeCode)) {
                    strWhere.append(CARRIAGE_RETURN_STR)
                            .append(lcLogicOper)
                            .append(cond.getTblAliasColNm())
                            .append(" " + operationTypeCode + " ")
                            .append(filterValue);
                }
            }
        }

        //        list vo에서 컬렉션을 이용해 값 찾는법
//        Collection<KprGetTargetSimpleListNewSaveDataReqDto> havingArray = CollectionUtils.select(dataList, object -> StringUtils.equalsIgnoreCase(((KprGetTargetSimpleListNewSaveDataReqDto) object).getSumYn(), "Y"));

        StringBuilder rtnValue1 = new StringBuilder(); // 최종 로지컬 컴포넌트 Sql 포함 쿼리 생성 count
        StringBuilder rtnValue2 = new StringBuilder(); // 최종 로지컬 컴포넌트 Sql 포함 쿼리 생성 segkey

        String lgcSql = "";

        if (lgcCompInfo.getLgcSql().indexOf("from") > 0) {
            lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("from"));
        } else {
            lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("FROM"));
        }

        if (StringUtil.isNotEmpty(strHaving.toString())) {
            rtnValue1.append("select count(*) from (\n")
                    .append(SELECT_STR) // select
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append("count(distinct "+lgcCompInfo.getTblAliasColNm()+ ") as cnt") //count
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append(lgcSql)
                    .append(strWhere.toString())
                    .append(" and " + mainShopColumn + " = '" + mainShopCode + "' ")
                    .append(" and (IsAcceptToReciveSMS = 'Y') ")
                    .append(CARRIAGE_RETURN_STR)
                    .append(" GROUP BY ")
                    .append(lgcCompInfo.getTblAliasColNm())
                    .append(strHaving)
                    .append(CARRIAGE_RETURN_STR)
                    .append(")t");

            rtnValue2.append(SELECT_STR) // select
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append(lgcCompInfo.getTblAliasColNm() + " AS segkey")
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append(lgcSql)
                    .append(strWhere.toString())
                    .append(" and " + mainShopColumn + " = '" + mainShopCode + "' ")
                    .append(" and (IsAcceptToReciveSMS = 'Y') ")
                    .append(CARRIAGE_RETURN_STR)
                    .append(" GROUP BY ")
                    .append(lgcCompInfo.getTblAliasColNm())
                    .append(strHaving);
        } else {
            rtnValue1.append(SELECT_STR) // select
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append("count(distinct "+lgcCompInfo.getTblAliasColNm()+ ") as cnt") //count
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append(lgcSql)
                    .append(strWhere.toString())
                    .append(" and " + mainShopColumn + " = '" + mainShopCode + "' ")
                    .append(" and (IsAcceptToReciveSMS = 'Y') ");
            rtnValue2.append(SELECT_STR) // select
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append("distinct "+lgcCompInfo.getTblAliasColNm() + " AS segkey")
                    .append(CARRIAGE_RETURN_STR) // \n
                    .append(lgcSql)
                    .append(strWhere.toString())
                    .append(" and " + mainShopColumn + " = '" + mainShopCode + "' ")
                    .append(" and (IsAcceptToReciveSMS = 'Y') ");
        }
        String[] rtnValue = new String[]{rtnValue1.toString(), rtnValue2.toString()};

        return rtnValue;
    }

    /**
     * @author : 이경영
     * @description : 타겟그룹 컬럼 목록 모두 조회
     */

    public List<KprTargetGroupColumnListResDto> getSimpleTargetGroupColumnAllList(KprTargetGroupColumnListReqDto tgclr) {
        LogUtil.param(this.getClass(), tgclr);
        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        tgclr.setServerType(serverType);

        return KprTargetSimpleMapper.selectSimpleTargetGroupColumnAllList(tgclr);
    }

    /**
     * @author : 이경영
     * @description : 특정 타겟그룹 컬럼 조회
     */

    public List<KprTargetGroupColumnListResDto> getSimpleTargetGroupColumnList(KprTargetGroupColumnListReqDto tgclr) {
        LogUtil.param(this.getClass(), tgclr);
        String serverType = BeansUtil.getApplicationProperty("icignal.server-type");
        serverType = serverType.toUpperCase();

        tgclr.setServerType(serverType);

        return KprTargetSimpleMapper.selectSimpleTargetGroupColumnList(tgclr);
    }
    
}