package com.icignal.common.session;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpSession;

import com.icignal.common.util.LogUtil;

/*-
 * ==================================================
 *  Class Name  : BMWSessionPool.java
 *  Create Date : 2018. 1. 31.
 *  Create User : 이기오
 * ==================================================
 *  History
 * --------------------------------------------------
 *  Modify Date  | Modify User  | Description
 * -------------- -------------- --------------------
 *  2018. 1. 31.   이기오         최초작성
 * ==================================================
 * */
public final class MKTSessionPool {
	private static final MKTSessionPool instance = new MKTSessionPool();;
	private static HashMap<String, HttpSession> sessionPool;
	private static HashMap<String, HttpSession> userIds;
	
	
	public static  MKTSessionPool getInstance() {
		return instance;
	}

	private MKTSessionPool() {
		this.init();
	}

	private void init() {
		if (this.sessionPool == null) {
			this.sessionPool = new HashMap<String, HttpSession>();
			this.userIds = new HashMap<String, HttpSession>();
			LogUtil.info("==============================");
			LogUtil.info("session pool is null");
			LogUtil.info("==============================");
		}

	}

	public void addSession(HttpSession session) {
		if (!this.sessionPool.containsKey(session.getId())) {
			Iterator<Entry<String, HttpSession>> iter = this.sessionPool.entrySet().iterator();

			while (iter.hasNext()) {
				Entry<String, HttpSession> userKey = iter.next();
				HttpSession sessions = userKey.getValue();
				if (!session.getId().equals(sessions.getId()) && this.getUserId(sessions).equals(this.getUserId(session))) {
					this.addRelateSession(session, sessions);
				}
			}

			this.sessionPool.put(session.getId(), session);
			String userKey = this.getUserId(session);
			this.userIds.put(userKey, session);
			LogUtil.info("==============================");
			LogUtil.info("session add : " + session.getId());
			List<HttpSession> sessions = this.getRelateSessions(session);
			Iterator<HttpSession> i = sessions.iterator();

			while (i.hasNext()) {
				HttpSession s = i.next();
				LogUtil.info("relate session : " + s.getId());
			}

			LogUtil.info("==============================");
		}

	}

	public void updateSession(HttpSession session) {
		if (this.sessionPool.containsKey(session.getId())) {
			this.sessionPool.remove(session.getId());
			this.sessionPool.put(session.getId(), session);
			String userId = this.getUserId(session);
			this.userIds.remove(userId + session.getId());
			this.userIds.put(userId + session.getId(), session);
			LogUtil.info("==============================");
			LogUtil.info("session update : " + session.getId());
			LogUtil.info("==============================");
		}

	}

	public void removeSession(HttpSession session) {
		if (this.sessionPool.containsKey(session.getId())) {
			this.sessionPool.remove(session.getId());
			this.userIds.remove(this.getUserId(session));
			LogUtil.info("==============================");
			LogUtil.info("session remove : " + session.getId());
			LogUtil.info("==============================");
			
			session.invalidate();
		}

	}

	public HttpSession getSession(String id, boolean isSessionId) {
		HttpSession rtnValue = null;
		if (isSessionId) {
			if (this.sessionPool.containsKey(id)) {
				LogUtil.info("==============================");
				LogUtil.info("session get : " + id);
				LogUtil.info("==============================");
				rtnValue = this.sessionPool.get(id);
			}
		} else if (this.userIds.containsKey(id)) {
			LogUtil.info("==============================");
			LogUtil.info("session get : " + id);
			LogUtil.info("==============================");
			rtnValue = this.userIds.get(id);
		}

		return rtnValue;
	}

	public List<HttpSession> getSessions(List<String> memIds) {
		ArrayList<HttpSession> rtnValue = new ArrayList<HttpSession>();
		Iterator<String> i = memIds.iterator();

		while (true) {
			while (i.hasNext()) {
				String memId = i.next();
				Iterator<Entry<String, HttpSession>> iter = this.userIds.entrySet().iterator();

				while (iter.hasNext()) {
					Entry<String, HttpSession> entry = iter.next();
					String userKey = entry.getKey();
					if (userKey.contains(memId)) {
						rtnValue.add(entry.getValue());
						break;
					}
				}
			}

			return rtnValue;
		}
	}

	public void printSessionPool() {
		LogUtil.info("===== pool scan start =====");
		Iterator<Entry<String, HttpSession>> iter = this.sessionPool.entrySet().iterator();

		while (iter.hasNext()) {
			Entry<String, HttpSession> entry = iter.next();
			HttpSession session = entry.getValue();
			Iterator<HttpSession> i = this.getRelateSessions(session).iterator();

			while (i.hasNext()) {
				HttpSession s = i.next();
				LogUtil.info("session : " + session.getId() + " relate session : " + s.getId());
			}
		}

		LogUtil.info("===== pool scan end =====");
	}

	public HashMap<String, HttpSession> getSessionPool() {
		return this.sessionPool;
	}

	public Set<String> getSessionIds() {
		return this.sessionPool.keySet();
	}

	public Set<Entry<String, HttpSession>> getSessionEntrys() {
		return this.sessionPool.entrySet();
	}

	public void resetSessionPool() {
		this.sessionPool.clear();
	}

	private String getUserId(HttpSession session) {
		String rtnValue = "";
		String result = (String) session.getAttribute("SESSION_USER_KEY");
		if (result != null) {
			rtnValue = result;
		}

		return rtnValue;
	}

	private void addRelateSession(HttpSession session, HttpSession addSession) {
		List<HttpSession> sessionGroup = this.getRelateSessions(session);
		sessionGroup.add(addSession);
		session.setAttribute("RELATE_SESSION_GROUP", sessionGroup);
	}

	@SuppressWarnings("unchecked")
	private List<HttpSession> getRelateSessions(HttpSession session) {
		Object sessionGroup = null;

		sessionGroup = (List<HttpSession>) session.getAttribute("RELATE_SESSION_GROUP");


		if (sessionGroup == null) {
			sessionGroup = new ArrayList<HttpSession>();
		}

		return (List<HttpSession>) sessionGroup;
	}
}