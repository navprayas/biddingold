package com.navprayas.bidding.common.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteMethod;

/**
 * This class is responsible to maintain the client script sessions and push
 * updates to the respective clients.
 * 
 * 
 */
public class SessionManager {

	/* This is the container which holds all the script sessions */
	private static Set<ScriptSession> scriptSessions = new HashSet<ScriptSession>();

	public static Map<String, ScriptSession> scriptSessionsMap = new HashMap<String, ScriptSession>();
	/**
	 * This method will get called by the client to register a script session
	 * with the application
	 * 
	 * @param param -
	 *            client parameter to set to the scriptSession object.
	 */
	@RemoteMethod
	public void addScriptSession(String param) {
		/* Creating the script session for the requested client. */
		ScriptSession scriptSession = WebContextFactory.get()
				.getScriptSession();
		
		/* Setting the attribute to the client */
		scriptSession.setAttribute("client", param);
		/*
		 * Adding the script session to the script session container. The
		 * synchronized block to ensure safe write to object.
		 */
		synchronized (scriptSessions) {
			scriptSessions.add(scriptSession);
			scriptSessionsMap.put(param, scriptSession);
		}
	}
	/**
	 * This method is used to remove the script session from the script session
	 * container
	 */
	@RemoteMethod
	public void removeScriptSession(String param) {
		/* Getting the script session for the client. */
		ScriptSession scriptSession = WebContextFactory.get()
				.getScriptSession();
		/* Invalidate the particular script session. */
		scriptSession.invalidate();
		/*
		 * Remove the script session from the container. the synchronized block
		 * is to ensure safe removal.
		 */
		synchronized (scriptSessions) {
			scriptSessions.remove(scriptSession);
			scriptSessionsMap.remove(param);
		}
	}
}
