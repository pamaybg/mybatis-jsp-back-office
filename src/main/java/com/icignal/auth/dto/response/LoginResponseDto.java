package com.icignal.auth.dto.response;


import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.icignal.common.base.dto.response.MultiImageResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

/**
 * @file : LoginResponseDTO.java
 * @date : 2014. 12. 02.
 * @author : 김정석
 */
public class LoginResponseDto extends StatusResDto implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 838555605217245647L;
	private String id;
	private String accName;
	private String name;              
	private String email;             
	private Boolean emailPublic;       
	private int postCount;         
	private int replyCount;        
	private int sympathyCount;     
	private String imageUrl;          
	private int alarmCount;        
	private Boolean syncFacebook;   
	private Boolean syncTwitter;     
	private String twitterToken;
	private String twitterTokenSecret;
	private String facebookToken;
	private String gender;            
	private String age;               
	private String mailAcceRegion;    
	private int alarmFavoriteSite; 
	private int alarmMySite;       
	private int alarmJoinSite;     
	private int alarmPostReply;
	private String permission;
	private String twitterId;
	private MultiImageResDto imageMUrl;
	private int unReadMsgCount;
	private String facebookId;
	private String introduction;
	private int msgGroupCnt;
	private int unreadAlarmCnt;
	private int inviteAlarmCnt;
	private Boolean isLogin;
	private String empStatus;

	private String partyType;

	@JsonIgnore
	private String sessionId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getEmailPublic() {
		return emailPublic;
	}
	public void setEmailPublic(Boolean emailPublic) {
		this.emailPublic = emailPublic;
	}
	public int getPostCount() {
		return postCount;
	}
	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getSympathyCount() {
		return sympathyCount;
	}
	public void setSympathyCount(int sympathyCount) {
		this.sympathyCount = sympathyCount;
	} 
	public String getImageUrl() {
		if(this.imageUrl != null && this.imageUrl.length() > 0 && !this.imageUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.imageMUrl = new MultiImageResDto();
			ImageUtil.setMultiImages(this.imageUrl, this.imageMUrl);
			this.imageUrl = CommonUtil.getInstance().getImageServerUrl() + "/" + this.imageUrl;
		}

		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public int getAlarmCount() {
		return alarmCount;
	}
	public void setAlarmCount(int alarmCount) {
		this.alarmCount = alarmCount;
	}
	public Boolean getSyncFacebook() {
		return syncFacebook;
	}
	public void setSyncFacebook(Boolean syncFacebook) {
		this.syncFacebook = syncFacebook;
	}
	public Boolean getSyncTwitter() {
		return syncTwitter;
	}
	public void setSyncTwitter(Boolean syncTwitter) {
		this.syncTwitter = syncTwitter;
	}
	public String getTwitterToken() {
		return twitterToken;
	}
	public void setTwitterToken(String twitterToken) {
		this.twitterToken = twitterToken;
	}
	public String getTwitterTokenSecret() {
		return twitterTokenSecret;
	}
	public void setTwitterTokenSecret(String twitterTokenSecret) {
		this.twitterTokenSecret = twitterTokenSecret;
	}
	public String getFacebookToken() {
		return facebookToken;
	}
	public void setFacebookToken(String facebookToken) {
		this.facebookToken = facebookToken;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getMailAcceRegion() {
		return mailAcceRegion;
	}
	public void setMailAcceRegion(String mailAcceRegion) {
		this.mailAcceRegion = mailAcceRegion;
	}
	public int getAlarmFavoriteSite() {
		return alarmFavoriteSite;
	}
	public void setAlarmFavoriteSite(int alarmFavoriteSite) {
		this.alarmFavoriteSite = alarmFavoriteSite;
	}
	public int getAlarmMySite() {
		return alarmMySite;
	}
	public void setAlarmMySite(int alarmMySite) {
		this.alarmMySite = alarmMySite;
	}
	public int getAlarmJoinSite() {
		return alarmJoinSite;
	}
	public void setAlarmJoinSite(int alarmJoinSite) {
		this.alarmJoinSite = alarmJoinSite;
	}
	public int getAlarmPostReply() {
		return alarmPostReply;
	}
	public void setAlarmPostReply(int alarmPostReply) {
		this.alarmPostReply = alarmPostReply;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public String getTwitterId() {
		return twitterId;
	}
	public void setTwitterId(String twitterId) {
		this.twitterId = twitterId;
	}
	public MultiImageResDto getImageMUrl() {
		return imageMUrl;
	}
	public void setImageMUrl(MultiImageResDto imageMUrl) {
		this.imageMUrl = imageMUrl;
	}
	public int getUnReadMsgCount() {
		return unReadMsgCount;
	}
	public void setUnReadMsgCount(int unReadMsgCount) {
		this.unReadMsgCount = unReadMsgCount;
	}
	public String getFacebookId() {
		return facebookId;
	}
	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public int getMsgGroupCnt() {
		return msgGroupCnt;
	}
	public void setMsgGroupCnt(int msgGroupCnt) {
		this.msgGroupCnt = msgGroupCnt;
	}
	public int getUnreadAlarmCnt() {
		return unreadAlarmCnt;
	}
	public void setUnreadAlarmCnt(int unreadAlarmCnt) {
		this.unreadAlarmCnt = unreadAlarmCnt;
	}
	public int getInviteAlarmCnt() {
		return inviteAlarmCnt;
	}
	public void setInviteAlarmCnt(int inviteAlarmCnt) {
		this.inviteAlarmCnt = inviteAlarmCnt;
	}
	public Boolean getIsLogin() {
		return isLogin;
	}
	public void setIsLogin(Boolean isLogin) {
		this.isLogin = isLogin;
	}
	public String getAccName() {
		return accName;
	}
	public void setAccName(String accName) {
		this.accName = accName;
	}
	public String getPartyType() {
		return partyType;
	}
	public void setPartyType(String partyType) {
		this.partyType = partyType;
	}
	public String getEmpStatus() {
		return empStatus;
	}
	public void setEmpStatus(String empStatus) {
		this.empStatus = empStatus;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}  
}


