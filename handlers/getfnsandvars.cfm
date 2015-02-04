<cfparam name="ideeventinfo" >
<cfset xmldoc=xmlParse (ideeventinfo)>
<!--- Step 1 Get Callback URL from ideeventinfo --->
<cfset urlvar= xmldoc.event.ide.callbackurl.xmlText>

<!--- Step 2
      Create XML to send comman to IDE - getfunctionsandvariables in this case
 --->
<cfsavecontent variable="cmnd" >
<cfoutput>
	<response>
		<ide>			
			<commands>
				<command type="getfunctionsandvariables" > 
					 <params> 
						  <param key="filePath" value="#xmldoc.event.ide.editor.file.xmlattributes.location#"/> 
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
<cfset commandResponseXML = xmlParse(cmndrslt.fileContent) >
<cfdump var="#commandResponseXML#">
