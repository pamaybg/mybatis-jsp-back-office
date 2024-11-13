package com.icignal.kepler.analysis.common.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRAnalysisCommonRequestDTO
 * 2. 파일명	: KPRAnalysisCommonRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisCommonReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String logicalCompId;
	private String atribGroupColumnId;
	private String analysisId;
	private String analysisId_New;
	private String analysisTypeCode;
	private String analysisMasterFlag;
	private String chartTypeCode;
	private Integer columnGroupFlag;
	private String columnId;
	private String columnUseTypeCode;
	private String groupFuncTypeCode;
	private Integer seq;
	private String promptValue;
	private String promptTypeCode;
	private String fieldGroupColumnId;
	private List<KprAnalysisCommonReqDto> atribGroupColumnList;

	private Boolean pagingFlag;

	private String dashboardId;
	private String dashboardId_New;
	private Integer dashboardSeq;
	private String dashboardEmbedType;
	
	
	//aws db접속정보
		private String dbInformId; // 아이디
		private String createByName; // 생성자명
		private String createDate; // 생성일시
		private String serviceNm; // 서비스명
		private String conDbType; // DB유형
		private String conDbTypeName; // DB유형 Mart Name
		private String conIp; // 접속IP
		private String conPort; // 접속PORT
		private String conId; // 접속ID
		private String conUrl; // 접속URL
		private String conPw; // 접속pw
		private String dbDesc; // 설명
		private String conDbClass; // 설명
		private String secretNm;	//비밀명
		

	public String getDbInformId() {
			return dbInformId;
		}

		public void setDbInformId(String dbInformId) {
			this.dbInformId = dbInformId;
		}

		public String getCreateByName() {
			return createByName;
		}

		public void setCreateByName(String createByName) {
			this.createByName = createByName;
		}

		public String getCreateDate() {
			return createDate;
		}

		public void setCreateDate(String createDate) {
			this.createDate = createDate;
		}

		public String getServiceNm() {
			return serviceNm;
		}

		public void setServiceNm(String serviceNm) {
			this.serviceNm = serviceNm;
		}

		public String getConDbType() {
			return conDbType;
		}

		public void setConDbType(String conDbType) {
			this.conDbType = conDbType;
		}

		public String getConDbTypeName() {
			return conDbTypeName;
		}

		public void setConDbTypeName(String conDbTypeName) {
			this.conDbTypeName = conDbTypeName;
		}

		public String getConIp() {
			return conIp;
		}

		public void setConIp(String conIp) {
			this.conIp = conIp;
		}

		public String getConPort() {
			return conPort;
		}

		public void setConPort(String conPort) {
			this.conPort = conPort;
		}

		public String getConId() {
			return conId;
		}

		public void setConId(String conId) {
			this.conId = conId;
		}

		public String getConUrl() {
			return conUrl;
		}

		public void setConUrl(String conUrl) {
			this.conUrl = conUrl;
		}

		public String getConPw() {
			return conPw;
		}

		public void setConPw(String conPw) {
			this.conPw = conPw;
		}

		public String getDbDesc() {
			return dbDesc;
		}

		public void setDbDesc(String dbDesc) {
			this.dbDesc = dbDesc;
		}

		public String getConDbClass() {
			return conDbClass;
		}

		public void setConDbClass(String conDbClass) {
			this.conDbClass = conDbClass;
		}

		public String getSecretNm() {
			return secretNm;
		}

		public void setSecretNm(String secretNm) {
			this.secretNm = secretNm;
		}

	public String getEmpId() {
		return this.empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getLogicalCompId() {
		return this.logicalCompId;
	}

	public void setLogicalCompId(String logicalCompId) {
		this.logicalCompId = logicalCompId;
	}

	public String getAtribGroupColumnId() {
		return this.atribGroupColumnId;
	}

	public void setAtribGroupColumnId(String atribGroupColumnId) {
		this.atribGroupColumnId = atribGroupColumnId;
	}

	public String getAnalysisId() {
		return this.analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisId_New() {
		return this.analysisId_New;
	}

	public void setAnalysisId_New(String analysisId_New) {
		this.analysisId_New = analysisId_New;
	}

	public String getAnalysisTypeCode() {
		return this.analysisTypeCode;
	}

	public void setAnalysisTypeCode(String analysisTypeCode) {
		this.analysisTypeCode = analysisTypeCode;
	}

	public String getAnalysisMasterFlag() {
		return this.analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}

	public String getChartTypeCode() {
		return this.chartTypeCode;
	}

	public void setChartTypeCode(String chartTypeCode) {
		this.chartTypeCode = chartTypeCode;
	}

	public Integer getColumnGroupFlag() {
		return this.columnGroupFlag;
	}

	public void setColumnGroupFlag(Integer columnGroupFlag) {
		this.columnGroupFlag = columnGroupFlag;
	}

	public String getColumnId() {
		return this.columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getColumnUseTypeCode() {
		return this.columnUseTypeCode;
	}

	public void setColumnUseTypeCode(String columnUseTypeCode) {
		this.columnUseTypeCode = columnUseTypeCode;
	}

	public String getGroupFuncTypeCode() {
		return this.groupFuncTypeCode;
	}

	public void setGroupFuncTypeCode(String groupFuncTypeCode) {
		this.groupFuncTypeCode = groupFuncTypeCode;
	}

	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getPromptValue() {
		return this.promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getPromptTypeCode() {
		return this.promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getFieldGroupColumnId() {
		return this.fieldGroupColumnId;
	}

	public void setFieldGroupColumnId(String fieldGroupColumnId) {
		this.fieldGroupColumnId = fieldGroupColumnId;
	}

	public List<KprAnalysisCommonReqDto> getAtribGroupColumnList() {
		return atribGroupColumnList;
	}

	public void setAtribGroupColumnList(List<KprAnalysisCommonReqDto> atribGroupColumnList) {
		this.atribGroupColumnList = atribGroupColumnList;
	}

	public Boolean getPagingFlag() {
		return pagingFlag;
	}

	public void setPagingFlag(Boolean pagingFlag) {
		this.pagingFlag = pagingFlag;
	}

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}

	public String getDashboardId_New() {
		return dashboardId_New;
	}

	public void setDashboardId_New(String dashboardId_New) {
		this.dashboardId_New = dashboardId_New;
	}

	public Integer getDashboardSeq() {
		return dashboardSeq;
	}

	public void setDashboardSeq(Integer dashboardSeq) {
		this.dashboardSeq = dashboardSeq;
	}

	public String getDashboardEmbedType() {
		return dashboardEmbedType;
	}

	public void setDashboardEmbedType(String dashboardEmbedType) {
		this.dashboardEmbedType = dashboardEmbedType;
	}
}