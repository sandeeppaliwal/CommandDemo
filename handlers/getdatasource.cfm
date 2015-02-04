<cfparam name="ideeventinfo" >
<cfset xmldoc=xmlParse (ideeventinfo)>
<!--- Step 1 Get Callback URL from ideeventinfo --->
<cfset callbackurl= xmldoc.event.ide.callbackurl.xmlText>

<!--- Step 2
      Create XML to send comman to IDE - getdatasources in this case
 --->
<cfsavecontent variable="commandxml" >
<cfoutput>
	<response>
		<ide>
			<commands>
				<!--- Provide server name to get datasources of specific server
                      By Default datasources of server on which extension is running are returned --->
                      
				<command type="getdatasources" >
								
					  <!--- pass server name to get datasources of specific server --->
					  <!---<params> 
					   		<param key="server" value="localhost" /> 
					  </params>---> 
				 </command>	
			 </commands>	
		</ide>
	</response>
</cfoutput>
</cfsavecontent>

<!--- Execute Callback command and get response --->
<cfhttp method="post" url="#callbackurl#" result="cmndrslt" >
	<cfhttpparam type="body" value="#commandxml#" >
</cfhttp>

<!--- dump response from command --->
<cfset commandResponseXML = xmlParse(cmndrslt.fileContent) >
<cfdump var="#commandResponseXML#">