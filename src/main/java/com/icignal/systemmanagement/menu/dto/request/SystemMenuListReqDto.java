package com.icignal.systemmanagement.menu.dto.request;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemAuthMenuNameLangResDto;

public class SystemMenuListReqDto extends GridPagingReqDto{

	private boolean admFlag;
	private String empId;
	private List<SystemAuthMenuNameLangResDto> menuNames;
	
	private String id;
	private String memId;
	private String menuId;
	private String menuName;
	private String appServiceType;
	private String menuLevel;	
	private String parentMenuId;
	private Integer sortSeq;
	private String fileName;
	private List<SystemMenuListReqDto> array;
	private List<MultiUploadReqDto> images;


	private String testFile;
	
	private String imageId;
	private String imageFolder;
	private String imageFileName;
	private String imageFileType;
	
	private String progId;
	private String testFileName;
	
	private String filePath;
	private String oriName;
	private String url;
    private String extension;
    
	private boolean update;
	
	private String progNum;
	private String progName;
	private String progTypeCd;
	private String progPath;
    private String applyType;
	
	private String authGroupId;
	
	private String progTypeCheck;
	
	private String iconImg;
	
	private int privacyFlg; //개인정보 메뉴 여부

	private String mobileFlg; //모바일 여부

	public List<MultiUploadReqDto> getImages() {
		return images;
	}

	public void setImages(List<MultiUploadReqDto> images) {
		this.images = images;
	}
	
	

	public String getOriName() {
		return oriName;
	}

	public void setOriName(String oriName) {
		this.oriName = oriName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getAuthGroupId() {
		return authGroupId;
	}

	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

	public String getProgNum() {
		return progNum;
	}

	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}

	public String getProgName() {
		return progName;
	}

	public void setProgName(String progName) {
		this.progName = progName;
	}

	public String getProgTypeCd() {
		return progTypeCd;
	}

	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}

	public String getProgPath() {
		return progPath;
	}

	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public boolean isUpdate() {
		return update;
	}

	public void setUpdate(boolean update) {
		this.update = update;
	}

	public String getTestFileName() {
		return testFileName;
	}

	public void setTestFileName(String testFileName) {
		this.testFileName = testFileName;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	

	public String getProgId() {
		return progId;
	}

	public void setProgId(String progId) {
		this.progId = progId;
	}

	public String getImageFolder() {
		return imageFolder;
	}

	public void setImageFolder(String imageFolder) {
		this.imageFolder = imageFolder;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageFileType() {
		return imageFileType;
	}

	public void setImageFileType(String imageFileType) {
		this.imageFileType = imageFileType;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getTestFile() {
		return testFile;
	}

	public void setTestFile(String testFile) {
		this.testFile = testFile;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<SystemMenuListReqDto> getArray() {
		return array;
	}

	public void setArray(List<SystemMenuListReqDto> array) {
		this.array = array;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	public Integer getSortSeq() {
		return sortSeq;
	}

	public void setSortSeq(Integer sortSeq) {
		this.sortSeq = sortSeq;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}


	public String getAppServiceType() {
		return appServiceType;
	}

	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}

	public boolean getAdmFlag() {
		return admFlag;
	}

	public void setAdmFlag(boolean admFlag) {
		this.admFlag = admFlag;
	}

	public List<SystemAuthMenuNameLangResDto> getMenuNames() {
		return menuNames;
	}

	public void setMenuNames(List<SystemAuthMenuNameLangResDto> menuNames) {
		List<SystemAuthMenuNameLangResDto> listDto; 
		listDto = menuNames;
		
		if(listDto  == null){
			listDto  = new ArrayList<SystemAuthMenuNameLangResDto>();
		}
		
		this.menuNames = listDto;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getProgTypeCheck() {
		return progTypeCheck;
	}

	public void setProgTypeCheck(String progTypeCheck) {
		this.progTypeCheck = progTypeCheck;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getPrivacyFlg() {
		return privacyFlg;
	}

	public void setPrivacyFlg(int privacyFlg) {
		this.privacyFlg = privacyFlg;
	}

	public String getIconImg() {
		return iconImg;
	}

	public void setIconImg(String iconImg) {
		this.iconImg = iconImg;
	}

	public String getMobileFlg() {return mobileFlg;}

	public void setMobileFlg(String mobileFlg) {this.mobileFlg = mobileFlg;}

}
