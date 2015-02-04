<cfparam name="ideeventinfo" >
<cfset xmldoc=xmlParse (ideeventinfo)>
<!--- Step 1 Get Callback URL from ideeventinfo --->
<cfset urlvar= xmldoc.event.ide.callbackurl.xmlText>

<!--- Step 2
      Create XML to send comman to IDE - gettable in this case
 --->
<cfsavecontent variable="cmnd" >
<cfoutput>
	<response>
		<ide>
			<commands>
				<command type="gettable"> 
					 <params>						   
						  <param key="datasource" value="cfARTgallery" /> 
						  <param key="table" value="ART" /> 
						  <!--- specify server in case server name is known.
						  	By default Server on which extension is running is used --->
						  <!--- <param key="server" value="localhost" /> --->
					 </params> 
				</command>
			 </commands>	
		</ide>
	</response>
</cfoutput>
</cfsavecontent>

<!--- Step 3 Execute Callback command and get response --->
<cfhttp method="post" url="#urlvar#" result="cmndrslt" >
    <cfhttpparam type="body" value="#cmnd#" >
</cfhttp>

<!--- dump response from command --->
<cfoutput>This demo assumes there is cfartgallery datasource present on he server</cfoutput><br/>
<cfset commandResponseXML = xmlParse(cmndrslt.fileContent) >
<cfdump var="#commandResponseXML#">
