<cfparam name="ideeventinfo" >
<cfset xmldoc=xmlParse (ideeventinfo)>

<!--- Step 1
      Get callback URL from ideeventinfo xml
 --->
<cfset urlvar= xmldoc.event.ide.callbackurl.xmlText>


<!--- Step 2
      Create XML to send comman to IDE - openfile in this case
 --->
<cfsavecontent variable="cmnd" >
<cfoutput>
	<response>
		<ide>
			<commands>
				<command type="searchfile" > 
					  <params> 
						   <param key="fileName" value="test_file_for_search.cfm"/> 
						   <param key="from" value="#expandPath ("..")#"/> 
						   <param key="searchDirection" value="down"/> 
						   <param key="matchfolder" value="true"/> 
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
<cfoutput>
	Executed searchfile command for file "test_file_for_search.cfm" within folder (#expandPath ("..")#) and got following result	
</cfoutput>
<cfdump var="#commandResponseXML#">