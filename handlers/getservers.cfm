<cfparam name="ideeventinfo" >
<cfset xmldoc=xmlParse (ideeventinfo)>
<!--- Step 1 Get Callback URL from ideeventinfo --->
<cfset callbackurl= xmldoc.event.ide.callbackurl.xmlText>

<!--- Step 2
      Create XML to send comman to IDE - getservers in this case
 --->
<cfsavecontent variable="commandxml" >
<cfoutput>
	<response>
		<ide>
			<commands>
				<command type="getservers">
	 			</command>
			</commands>		
		</ide>
	</response>
</cfoutput>
</cfsavecontent>
<!--- Step 3 Execute Callback command and get response --->
<cfhttp method="post" url="#callbackurl#" result="cmndrslt" >
	<cfhttpparam type="body" value="#commandxml#" >
</cfhttp>

<!--- dump response from command --->
<cfset commandResponseXML = xmlParse(cmndrslt.fileContent) >
<cfoutput>Dump of response from get Servers Command</cfoutput><br/>
<cfdump var="#commandResponseXML#">