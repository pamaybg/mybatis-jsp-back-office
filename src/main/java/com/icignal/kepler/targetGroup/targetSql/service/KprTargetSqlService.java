package com.icignal.kepler.targetGroup.targetSql.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.PersonalDataUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.service.KprTargetGroupService;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlDetailReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlEditReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlTargetListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlValidationReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlDetailResDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlListResDto;
import com.icignal.kepler.targetGroup.targetSql.mapper.KprTargetSqlMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;

/**
 * 타겟SQL Service
 *
 * @name : infavor.kepler.targetGroup.service.impl.KprTargetSqlService
 * @date : 2018. 4. 23.
 * @author : jh.kim
 * @description :
 */
@Service
public class KprTargetSqlService {

    @Autowired
    private KprTargetSqlMapper kprTargetSqlMapper;
    
    @Autowired 
    private CommonService commonService;
    
    @Autowired
    private KprTargetGroupService kprTargetGroupService;
    
    @Autowired
    private StandardPBEStringEncryptor encrypor;

    @Autowired
    private MKTCallQueryDao mktCallQueryDao;
    
    @Autowired
    private SystemCommCodeService systemCommCodeService;

    /**
     * 대상자 쿼리 그룹정보 상세 조회
     *
     * @programId :
     * @name : getTargetSqlDetail
     * @date : 2018. 4. 11.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public KprTargetSqlDetailResDto getTargetSqlDetail(KprTargetSqlDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        KprTargetSqlDetailResDto rtnValue = kprTargetSqlMapper.selectTargetSqlDetail(param);

        // 대상자 건수 조회
        if (ObjectUtil.isNotEmpty(rtnValue.getFilterSqlCount())) {
            String selectContent = rtnValue.getFilterSqlCount();

            KprTargetSqlDBInfoReqDto tgsfdr = new KprTargetSqlDBInfoReqDto();
            tgsfdr.setTargetGroupId(param.getTargetGroupId());
            tgsfdr.setLang(param.getLang());

            try {
            	MKTDBInfoDTO dbInfoReq = new MKTDBInfoDTO();
                dbInfoReq.setSystemColumn(param.getSystemColumn());
                dbInfoReq.setDbId(rtnValue.getDbInformId());

        	 	if("Y".equals(param.getCafe24Yn())) {
        	 		dbInfoReq.setDbId("BCC089F0A3C87A25E0530100007F4B8C");
        	     }
            	
                // 로지컬 컴포넌트 db 정보 조회
            	MKTDBInfoDTO dbInfo = this.getDBInform(dbInfoReq);
            	
           
                if (ObjectUtil.isNotEmpty(dbInfo)) {

                    // 쿼리 실행
                    String rtnQuery = (String) mktCallQueryDao.callSelectObject("getSegmentAllCount", selectContent, new ArrayList<String>(), dbInfo, java.lang.String.class);
                    rtnValue.setTargetCount(rtnQuery);
                    
                    //건수 저장
                    param.setCnt(Integer.parseInt(rtnQuery));
                    kprTargetSqlMapper.updateTagetGroupCount(param);
                }
                else {
                    rtnValue.setTargetCount("0");
                }
            }
            catch (IllegalArgumentException e) {
                LogUtil.error(e);
                rtnValue.setTargetCount(IFVMErrorHelper.MSG_T0001);
            }
        }

        return rtnValue;
    }

    /**
     * DB접속정보 조회
     *
     * @programId :
     * @name : getDBInform
     * @date : 2018. 4. 13.
     * @author : jh.kim
     * @table :
     * @param param
     * @return
     * @description :
     */
    public MKTDBInfoDTO getDBInform(MKTDBInfoDTO param) {
        LogUtil.param(this.getClass(), param);
        
        MKTDBInfoDTO dbInfo =  kprTargetSqlMapper.selectDBInform(param);
        
        if(ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
        	try {
				Map<String, Object> dbInfoJSON =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(dbInfo.getSecretNm());		
        		
				dbInfo.setUrl(dbInfoJSON.get("url").toString());
				dbInfo.setUserName(dbInfoJSON.get("username").toString());
				dbInfo.setPassword(dbInfoJSON.get("password").toString());
				dbInfo.setConIp(dbInfoJSON.get("ip").toString());
				dbInfo.setConPort(dbInfoJSON.get("port").toString());
				
        	}catch(IllegalArgumentException e){
        		LogUtil.error(e.getMessage());
        	}
        } else {
        	dbInfo.setPassword(encrypor.decrypt(dbInfo.getPassword()));
        }
        
        return dbInfo;
    }

    /**
     * SQL쿼리 검증
     *
     * @programId :
     * @name : targetSqlValidation
     * @date : 2018. 4. 13.
     * @author : jh.kim
     * @table :
     * @description :
     */
    
    @SuppressWarnings("unchecked")
    public StatusResDto targetSqlValidation(KprTargetSqlValidationReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        if (ObjectUtil.isNotEmpty(param.getDbId())) {

        	MKTDBInfoDTO dbInfoReq = new MKTDBInfoDTO();
            dbInfoReq.setSystemColumn(param.getSystemColumn());
            dbInfoReq.setDbId(param.getDbId());

            // 접속 db 정보 설정
            MKTDBInfoDTO dbInfo = this.getDBInform(dbInfoReq);

            if (ObjectUtil.isNotEmpty(dbInfo)) {

                String query = param.getFilterSql();
                
                query = "SELECT * FROM (" + query + ") T WHERE 1=0";
            }
            // 데이터베이스 정보없음.
            else {
                rtnValue.setMessage("NOT_DB_INFO");
            }
        }
        //DB ID를 받아오지 않음.
        else {
            rtnValue.setMessage("NOT_DB_ID");
        }

        return rtnValue;
    }

    /**
     * 타겟 그룹 SQL 등록 및 수정
     *
     * @programId :
     * @name : editTargetSql
     * @date : 2018. 4. 18.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public StatusResDto saveTargetSql(KprTargetSqlEditReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();

        // 레코드 개수 조회 쿼리
        StringBuffer lgcSqlBuffer = new StringBuffer();
        lgcSqlBuffer.append("select count(1) as cnt from ( ")
        			.append(param.getFilterSql())
        			.append(" ) t where 1 = 1 ");
        param.setFilterSqlCount(lgcSqlBuffer.toString());

        // 등록
        if (ObjectUtil.isEmpty(param.getId())) {
        	String id = commonService.getRowID();
        	param.setId(id);
        	
            kprTargetSqlMapper.insertAnlTargetGroup(param);
            rtnValue.setMessage(id);
        }
        // 수정
        else {
            kprTargetSqlMapper.updateAnlTargetGroup(param);
            rtnValue.setMessage(param.getId());
        }
              
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * 타겟 대상자 MBR_NO 목록 조회
     *
     * @programId :
     * @name : selectTargetMemberNumListSql
     * @date : 2018. 4. 25.
     * @author : jh.kim
     * @table :
     * @param tgtlr
     * @return
     * @description :
     */
    @SuppressWarnings("unchecked")
    public List<String> selectTargetMemberNumListSql(KprTargetSqlTargetListReqDto param, String type) {
        List<String> rtnList = null;

        if (ObjectUtil.isNotEmpty(param.getDbInformId())) {
        	
            MKTDBInfoDTO dbInfoReq = new MKTDBInfoDTO();
            dbInfoReq.setSystemColumn(param.getSystemColumn());
            dbInfoReq.setDbId(param.getDbInformId());
            
            // 접속 db 정보 설정
            MKTDBInfoDTO dbInfo = this.getDBInform(dbInfoReq);

            if (ObjectUtil.isNotEmpty(dbInfo)) {
                //dbInfo.setPassword(encrypor.decrypt(dbInfo.getPassword()));

                String sqlQuery =  param.getFilterSql();
                
                //조회 유형이 전체가 아닐 경우만 페이징 조회
                if (!"ALL".equals(type)) {
                
	                //페이징 설정
	        		if (DB_TYPE.MYSQL.toString().equals(dbInfo.getConDbType())) {
	        			sqlQuery += " limit " + param.getSkipCount() + ", " + param.getPageSize();
	        		} 
	        		else if (DB_TYPE.POSTGRESQL.toString().equals(dbInfo.getConDbType())) {
	        			sqlQuery += " offset " + param.getSkipCount() + " limit " + param.getPageSize();
	        		}
                    else if (DB_TYPE.MSSQL.toString().equals(dbInfo.getConDbType())) {
                        sqlQuery = "select t.segkey from (\n" +
                                "select t.*\n" +
                                ", ROW_NUMBER() OVER (ORDER BY segkey DESC) as RowNumber\n" +
                                "from (" + sqlQuery
                                + ") t\n" +
                                ") t\n" +
                                "WHERE RowNumber > "+param.getSkipCount()+" and RowNumber <= "+param.getPageSize()*param.getPage();
                    }
	        		else{
	        			sqlQuery += " offset " + param.getSkipCount() + " rows fetch next " + param.getPageSize() + " rows only";
	        		}
                }

                try {
                    // 쿼리 실행
                    rtnList = mktCallQueryDao.callSelectForList("selectTargetMemberNumListSql", sqlQuery, new ArrayList<>(), dbInfo, java.lang.String.class);
                }
                // 쿼리 실행중 오류 발생
                catch (IllegalArgumentException e) {
                    LogUtil.error(e.getMessage(),e);
                }
            }
        }
        return rtnList;
    }

    /**
     * 타겟SQL 대상자 목록 조회
     *
     * @programId :
     * @name : getTargetSqlTargetList
     * @date : 2018. 4. 23.
     * @author : jh.kim
     * @table :
     * @description :
     */
    @SuppressWarnings("unchecked")
    public GridPagingResDto getTargetSqlTargetList(KprTargetSqlTargetListReqDto tgtlr) {
        LogUtil.param(this.getClass(), tgtlr);

        ((GridPagingReqDto) tgtlr).init(CommonUtil.getInstance().getDBType());

        GridPagingResDto rtnValue = new GridPagingResDto();
        String lgcCompId = "";
        
        //타겟SQL정보 조회
        KprTargetSqlDetailReqDto param = new KprTargetSqlDetailReqDto();
        param.setSystemColumn(tgtlr.getSystemColumn());
        param.setTargetGroupId(tgtlr.getTargetGroupId());

        KprTargetSqlDetailResDto dtl = this.getTargetSqlDetail(param);
        tgtlr.setDbInformId(dtl.getDbInformId());
        tgtlr.setFilterSql(dtl.getFilterSql());
        tgtlr.init(DB_TYPE.valueOf(dtl.getConDbType()));
        tgtlr.setStrEndPaging("");

        List<String> targetMemberList = this.selectTargetMemberNumListSql(tgtlr, "PAGE");

        if (ObjectUtil.isNotEmpty(targetMemberList) && targetMemberList.size() > 0) {

            // 공통코드 테이블에서 회원정보 공통LC RID 조회
        	MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode("TGT_MBR_BASIC_LC");
            GridPagingResDto commCodeGrid = systemCommCodeService.getCommCodeList(commCodeReq);
            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                	MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                	if("Y".equals(dtl.getExtrYn())) {
                		//외부(카페 24) LC
                		lgcCompId = mccgrd.getAttrib03();
                	}else {
                		//대상자 조회,컬럼 LC
                		lgcCompId = mccgrd.getAttrib02();
                    }
                }
            }

            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(tgtlr.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);
            
            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = kprTargetGroupService.getTargetGroupLcDBInfo(tgdir);
            MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
            
        	reqDbInfoDto.setConIp(lcDBInfo.getConIp());
            reqDbInfoDto.setConPort(lcDBInfo.getConPort());
            reqDbInfoDto.setUserName(lcDBInfo.getConId());
            reqDbInfoDto.setPassword(lcDBInfo.getConPassword());
            reqDbInfoDto.setUrl(lcDBInfo.getConUrl());
            reqDbInfoDto.setDriverClassName(lcDBInfo.getConDbClass());
            reqDbInfoDto.setConDbType(lcDBInfo.getConDbType());
            
            // 회원정보 조회하여 대상자 수 조회
            KprTargetSqlValidationReqDto ktsvr = new KprTargetSqlValidationReqDto();
            ktsvr.setSystemColumn(tgtlr.getSystemColumn());
            ktsvr.setFilterSql(tgtlr.getFilterSql());
            ktsvr.setDbId(tgtlr.getDbInformId());

            StatusResDto cntrst = this.getTargetSqlCount(ktsvr);
            rtnValue.setRecords(Integer.parseInt(cntrst.getMessage()));

            //기본 쿼리 생성
            StringBuilder query = new StringBuilder();
            query.append(lcDBInfo.getLgcSql());
            query.insert(6, " distinct ");
            query.append(" where " + lcDBInfo.getSegKeyCol() + " in (");

            for (int idx = 0; idx < targetMemberList.size(); idx++) {
                String targetMember = targetMemberList.get(idx);
                if (idx != 0) query.append(",");
                query.append("'").append(targetMember).append("'");
            }
            query.append(")");

            String queryStr = query.toString();

            List<LinkedHashMap<String, String>> list = mktCallQueryDao.callSelectForListMap("getTargetSqlTargetList", queryStr, new ArrayList<>(), reqDbInfoDto);
         //   List<LinkedHashMap<String, String>> rsTable = new ArrayList<>();

            /*for (int idx = 0; idx < targetMemberList.size(); idx++) {
                boolean addFlag = false;
                String targetMember = targetMemberList.get(idx).get(key);

                for (int i = 0; i < list.size(); i++) {
                    LinkedHashMap<String, String> map = list.get(i);
                    if (targetMember.equals(map.get(lcDBInfo.getSegKeyColAlias()))) {
                        rsTable.add((LinkedHashMap<String, String>) map);
                        addFlag = true;
                        break;
                    }
                }
                if (addFlag == false) {
                    LinkedHashMap<String, String> map = new LinkedHashMap<>();
                    map.put(lcDBInfo.getSegKeyColAlias(), targetMember);
                    rsTable.add(map);
                }
            }*/
            
            rtnValue = ObjectUtil.ConvertListToGrid(tgtlr, list, rtnValue.getRecords(), "");
        }
        
        return rtnValue;
    }

    @SuppressWarnings("unchecked")
    public GridPagingResDto getAllTargetSqlTargetList(KprTargetSqlTargetListReqDto tgtlr) {
        LogUtil.param(this.getClass(), tgtlr);

        GridPagingResDto rtnList = new GridPagingResDto();
        List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
        
        String lgcCompId = "";

        //타겟SQL정보 조회
        KprTargetSqlDetailReqDto param = new KprTargetSqlDetailReqDto();
        param.setSystemColumn(tgtlr.getSystemColumn());
        param.setTargetGroupId(tgtlr.getTargetGroupId());

        KprTargetSqlDetailResDto dtl = this.getTargetSqlDetail(param);
        tgtlr.setDbInformId(dtl.getDbInformId());
        tgtlr.setFilterSql(dtl.getFilterSql());
        tgtlr.init(DB_TYPE.valueOf(dtl.getConDbType()));
        tgtlr.setStrEndPaging("");
            
        //대상자 회원 조회
        List<String> targetMemberList = this.selectTargetMemberNumListSql(tgtlr, "ALL");
        
        if (ObjectUtil.isNotEmpty(targetMemberList) && targetMemberList.size() > 0) {

            // 공통코드 테이블에서 회원정보 공통LC RID 조회
            MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode("TGT_MBR_BASIC_LC");
            GridPagingResDto commCodeGrid = systemCommCodeService.getCommCodeList(commCodeReq);
            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                	MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                    lgcCompId = mccgrd.getAttrib02();
                }
            }

            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(tgtlr.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);
            
            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = kprTargetGroupService.getTargetGroupLcDBInfo(tgdir);

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
            
            //기본 쿼리 생성
            StringBuilder query = new StringBuilder();
            query.append(lcDBInfo.getLgcSql());
            query.insert(6, " distinct ");
            query.append(" where " + lcDBInfo.getSegKeyCol());
            
            int idx = 1;
            int size = targetMemberList.size();
            String inStr = "";
            
            //대상자 목록
            for (String memId : targetMemberList) {
            	
				//in 절 값 생성
				if (idx % 900 == 0 || idx == size) {
					inStr += "'" + memId + "'";
				} else {
					inStr += "'" + memId + "',";
				}
            	
            	//900단위로 나누어 실행 또는 마지막
				if (idx % 900 == 0 || idx == size) {
					//sql 생성
					String sql = query.toString() + " in (" + inStr + ")";
					
					//타겟그룹 대상자 목록 조회
	                list.addAll(mktCallQueryDao.callSelectForListMap("getAllTargetSqlTargetList", sql, new ArrayList<String>(), reqDbInfoDto));
	                
	                //초기화
	                inStr = "";
				}
				
				idx++;
            }
            
            rtnList = ObjectUtil.ConvertListToGrid(tgtlr, list, list.size(), "");
        }
        
        return rtnList;
    }

    /**
     * 대상자 수 조회
     *
     * @programId :
     * @name : getTargetSqlCount
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description :
     */
    @SuppressWarnings("unchecked")
    
    public StatusResDto getTargetSqlCount(KprTargetSqlValidationReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        if (ObjectUtil.isNotEmpty(param.getDbId())) {

            MKTDBInfoDTO dbInfoReq = new MKTDBInfoDTO();
            dbInfoReq.setSystemColumn(param.getSystemColumn());
            dbInfoReq.setDbId(param.getDbId());

            
            if("Y".equals(param.getCafe24Yn())) {
                dbInfoReq.setDbId("BCC089F0A3C87A25E0530100007F4B8C");
            }
            
            // 접속 db 정보 설정
            MKTDBInfoDTO dbInfo = this.getDBInform(dbInfoReq);

            if (ObjectUtil.isNotEmpty(dbInfo)) {
                dbInfo.setPassword(dbInfo.getPassword());

                StringBuffer lgcSqlBuffer = new StringBuffer();
                lgcSqlBuffer.append("select count(1) as CNT from ( ")
                			.append(param.getFilterSql())
                			.append(" ) t where 1 = 1 ");

                try {
                    // 쿼리 실행
                    Map<String, String> rtnQuery = mktCallQueryDao.callSelectForMap("getSegmentAllCount", lgcSqlBuffer.toString(), new ArrayList<String>(), dbInfo);
                    String cnt = String.valueOf(rtnQuery.get("CNT"));
                    rtnValue.setMessage(cnt);
                }
                // 쿼리 실행중 오류 발생
                catch (IllegalArgumentException e) {
                	LogUtil.error(e.toString());
                    rtnValue.setMessage("SQL_ERROR");
                }
            }
            // 데이터베이스 정보없음.
            else {
                rtnValue.setMessage("NOT_DB_INFO");
            }
        }
        //DB ID를 받아오지 않음.
        else {
            rtnValue.setMessage("NOT_DB_ID");
        }

        return rtnValue;
    }

    /**
     * 타겟SQL 목록 조회
     *
     * @programId :
     * @name : getTargetSqlList
     * @date : 2018. 4. 25.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public GridPagingResDto<KprTargetSqlListResDto> getTargetSqlList(KprTargetSqlListReqDto param) {
        LogUtil.param(this.getClass(), param);

		return new GridPagingResHelper<KprTargetSqlListResDto>().newGridPagingResDto( 
				param.init(CommonUtil.getInstance().getDBType()),
				kprTargetSqlMapper.selectTargetSqlList(param), AnnotationType.CommCode);  
    }
    
    
    /**
     * @programId :
     * @name : saveCf24TargetGroup
     * @date : 2020. 11. 23.
     * @author : yj.choi
     * @table : 
     * @return :
     * @throws ParseException 
     * @description : 카페24 타겟그룹 저장
     */
    
    public StatusResDto saveCf24TargetGroup(KprTargetSqlEditReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);

    	StatusResDto rtnValue = new StatusResDto(false, "");


    	StringBuffer sql = new StringBuffer();
    	sql.append(" select rid as segkey from loy.loy_lnl_cf24_mbr where flag = 1 ");


    	String strCondWhere = reqDto.getStrCondWhere();
    	
    	
    	sql.append(" and ");
    	sql.append(strCondWhere);
    		
    	reqDto.setCafe24Yn("Y");
    	reqDto.setFilterSql(sql.toString());
    	reqDto.setExtrYn("Y");
    	reqDto.setType("SQL");
    	reqDto.setDbInformId("BCC089F0A3C87A25E0530100007F4B8C");

    	rtnValue = saveTargetSql(reqDto);

    	return rtnValue;
    }

    /**
     * @programId :
     * @name : getTargetCafe24List
     * @date : 2020. 12. 15.
     * @author : yj.choi
     * @table : 
     * @return :
     * @throws ParseException 
     * @description : 카페24 타겟그룹 조회
     */
    
public GridPagingResDto getTargetCafe24List(KprTargetSqlTargetListReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		GridPagingResDto rtnList = new GridPagingResDto();
		
        KprTargetSqlDetailReqDto param = new KprTargetSqlDetailReqDto();
        param.setSystemColumn(reqDto.getSystemColumn());
        param.setTargetGroupId(reqDto.getTargetGroupId());

        param.setCafe24Yn("Y");
        
        KprTargetSqlDetailResDto dtl = this.getTargetSqlDetail(param);
        reqDto.setDbInformId(dtl.getDbInformId());
        reqDto.setFilterSql(dtl.getFilterSql());
        reqDto.init(DB_TYPE.valueOf(dtl.getConDbType()));
        reqDto.setStrEndPaging("");
        
        
        KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
        tgdir.setSystemColumn(reqDto.getSystemColumn());
        String lgcId = kprTargetSqlMapper.selectCafe24LgcId();
        
        tgdir.setLgcCompId(lgcId);
        
        //LC DB 정보 조회
        KprTargetGroupDBInfoResDto lcDBInfo = kprTargetGroupService.getTargetGroupLcDBInfo(tgdir);
        MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
        
    	reqDbInfoDto.setConIp(lcDBInfo.getConIp());
        reqDbInfoDto.setConPort(lcDBInfo.getConPort());
        reqDbInfoDto.setUserName(lcDBInfo.getConId());
        reqDbInfoDto.setPassword(lcDBInfo.getConPassword());
        reqDbInfoDto.setUrl(lcDBInfo.getConUrl());
        reqDbInfoDto.setDriverClassName(lcDBInfo.getConDbClass());
        reqDbInfoDto.setConDbType(lcDBInfo.getConDbType());
        
        reqDto.setDbInformId("BCC089F0A3C87A25E0530100007F4B8C");
        
        List<String> targetMemberList = this.selectTargetMemberNumListSql(reqDto, "PAGE");
        
        int idx = 1;
        int size = targetMemberList.size();
        String inStr = "";
        StringBuilder query = new StringBuilder();
        String dataKey = BeansUtil.getDbEncryptDataKey();
        query.append("select rid as \"rid\", cc.mark_name as \"mallNm\", mbr_nm as \"name\", cell_ph as \"cellPh\", email as \"email\", sms_yn as \"smsYn\", email_yn as \"emailYn\" ");
        query.append(" , to_char(to_date(reg_dt,'YYYYMMDD'), 'YYYY-MM-DD') as \"regDate\"" );
        query.append(" , user_id as \"userId\"");
        query.append(" from loy.loy_lnl_cf24_mbr ll "); 
        query.append(" left outer join com.comm_code cc on ll.mall = cc.code_name and group_code = 'CF24_MBR_MALL'");
        query.append(" where rid ");
        
        List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
        List<LinkedHashMap<String, String>> list2 = new ArrayList<LinkedHashMap<String, String>>();
        
        //대상자 목록
        for (String memId : targetMemberList) {
        	
			//in 절 값 생성
			if (idx % 900 == 0 || idx == size) {
				inStr += "'" + memId + "'";
			} else {
				inStr += "'" + memId + "',";
			}
        	
        	//900단위로 나누어 실행 또는 마지막
			if (idx % 900 == 0 || idx == size) {
				//sql 생성
				String sql = query.toString() + " in (" + inStr + ")";
				
				//타겟그룹 대상자 목록 조회
                list.addAll(mktCallQueryDao.callSelectForListMap("getTargetCafe24List", sql, new ArrayList<String>(), reqDbInfoDto));
                
                //초기화
                inStr = "";
			}
			
			idx++;
        }
        for(LinkedHashMap<String, String> a : list) {

        	String decName = SecurityUtil.decodeDbAES256(dataKey, a.get("name"));
        	String decPh = SecurityUtil.decodeDbAES256(dataKey, a.get("cellPh"));
        	String decEmail = SecurityUtil.decodeDbAES256(dataKey, a.get("email"));

        	if(ObjectUtil.isNotEmpty(reqDto.getExcelFlag()) && reqDto.getExcelFlag()) {

        		a.put("name", decName);
        		a.put("cellPh", decPh);
        		a.put("email", decEmail);
        		a.put("userId", SecurityUtil.decodeDbAES256(dataKey, a.get("userId")));
        	}else {
        		a.put("name", PersonalDataUtil.maskedCustNm(decName));
        		a.put("cellPh", PersonalDataUtil.maskedTelephone(decPh));
        		a.put("email", PersonalDataUtil.maskedEmail(decEmail));
        		a.put("userId", SecurityUtil.decodeDbAES256(dataKey, a.get("userId")));

        	}

        	list2.add(a);

        }

        
        rtnList = ObjectUtil.ConvertListToGrid(reqDto, list2, Integer.parseInt(reqDto.getTargetSqlCount()), "");
        
        
        return rtnList;
	}
	/**
	 * select cafe24 Flag
	 *
	 * @programId :
	 * @name : getTargetCafe24YnFlag
	 * @date : 2021. 4. 14.
	 * @author : lee.gy
	 * @table :
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @description :
	 */
	public KprTargetSqlDetailResDto getTargetCafe24YnFlag(KprTargetSqlDetailReqDto param) {
	    LogUtil.param(this.getClass(), param);
	
	    KprTargetSqlDetailResDto rtnValue = new KprTargetSqlDetailResDto();
	    		
	    rtnValue = kprTargetSqlMapper.getTargetCafe24YnFlag(param);
	
	    return rtnValue;
	}
}
