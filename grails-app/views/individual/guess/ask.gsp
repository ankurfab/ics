<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Simple GSP page</title></head>
  <body>
 
  <g:javascript library="prototype"/>
  <g:javascript>
    document.observe("dom:loaded", function() {
      $("field").focus();  
    });
  </g:javascript>
 
  <h1>Guess</h1>
  <p>Guesses left: <strong>${guessLeft}</strong>.</p>
 
  <p>
    <g:form action="guess">
      <g:textField id="field" name="number" value="0" />
      <g:submitButton name="evaluate" value="Try this number!" />
    </g:form>
  </p>
 
  </body>
</html>