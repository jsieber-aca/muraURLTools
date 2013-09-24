<!---
    URL Tools - A Plugin for Mura CMS
    Copyright (C) 2011 Greg Moser - www.gregmoser.com
    Copyright (C) 2013 Seb Duggan - sebduggan.com
    
    License:
    Apache License
    Version 2.0, January 2004
    http://www.apache.org/licenses/
--->
<cfsilent>
	<cfif not structKeyExists(request,"pluginConfig")>
		<cfset pluginID=listLast(listGetat(getDirectoryFromPath(getCurrentTemplatePath()),listLen(getDirectoryFromPath(getCurrentTemplatePath()),application.configBean.getFileDelim())-1,application.configBean.getFileDelim()),"_")>
		<cfset request.pluginConfig=application.pluginManager.getConfig(pluginID)>
		<cfset hasPluginConfig=false>
	<cfelse>
		<cfset hasPluginConfig=true>
	</cfif>
	
	<cfif not hasPluginConfig and not isUserInRole('S2')>
		<cfif not structKeyExists(session,"siteID") or not application.permUtility.getModulePerm(request.pluginConfig.getValue('moduleID'),session.siteid)>
			<cfif isDefined('variables.framework')>
				<cfif not variables.framework.reloadapplicationoneveryrequest>
					<cflocation url="#application.configBean.getContext()#/admin/" addtoken="false">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfsilent>

