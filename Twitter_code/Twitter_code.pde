import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;
import com.temboo.Library.Twitter.Tweets.*;
TembooSession session = new TembooSession(XXXX, XXXX, XXXX);

JSONArray tweets;
String finAnswer;
String finQuestion;
String finCredits;
String mode = "recent";
int lenA;
int lenQ;
int hasRun = 0;

void whyDid() {
 // Create the Choreo object using your Temboo session
  Tweets tweetsChoreo = new Tweets(session);
  tweetsChoreo.setResultType(mode);

  // Set inputs
  String myQuery  = "\"why did\"";
  tweetsChoreo.setQuery(myQuery);
  tweetsChoreo.setAccessToken(XXXX);
  tweetsChoreo.setConsumerKey(XXXX);
  tweetsChoreo.setConsumerSecret(XXXX);
  tweetsChoreo.setAccessTokenSecret(XXXX);

  // Run the Choreo and store the results
  TweetsResultSet tweetsResults = tweetsChoreo.run();
  
  String[] result = {tweetsResults.getResponse()};
  String name =  "wdt.json";
  saveStrings(name,result);
}

void because() {
  // Create the Choreo object using your Temboo session
  Tweets tweetsChoreo = new Tweets(session);
  tweetsChoreo.setResultType(mode);
  // Set inputs
  String myQuery  = "because";
  tweetsChoreo.setQuery(myQuery);
  tweetsChoreo.setAccessToken(XXXX);
  tweetsChoreo.setConsumerKey(XXXX);
  tweetsChoreo.setConsumerSecret(XXXX);
  tweetsChoreo.setAccessTokenSecret(XXXX);

  // Run the Choreo and store the results
  TweetsResultSet tweetsResults = tweetsChoreo.run();
  
  String[] result = {tweetsResults.getResponse()};
  String name = "bc.json";
  saveStrings(name,result);
 }
 
void makeSureQuestionHasQuestionMark() {
 int index = finQuestion.length()-1;
 if ( finQuestion.substring(index).equals("?") == false) {
   finQuestion = finQuestion + "?";
 }
  
}

void tweetIt() {
  makeSureQuestionHasQuestionMark();
  StatusesUpdate statusesUpdateChoreo = new StatusesUpdate(session);
  String currentTweet = finQuestion + "\n" + "\n" + finAnswer + "\n" + "\n" + finCredits;
    
  if (currentTweet.length() <= 140) {
    statusesUpdateChoreo.setStatusUpdate(currentTweet); 
    statusesUpdateChoreo.setAccessToken(XXXX);
    statusesUpdateChoreo.setConsumerKey(XXXX);
    statusesUpdateChoreo.setConsumerSecret(XXXX);
    statusesUpdateChoreo.setAccessTokenSecret(XXXX);
    StatusesUpdateResultSet statusesUpdateResults = statusesUpdateChoreo.run();
  }
  else
   { 
     
     println(currentTweet);
     println(currentTweet.length());
     println(finCredits.length());
     if (shortenTweets()==true) {
       tweetIt();    
     }
     else if(currentTweet.length() - finCredits.length() < 140) {
       currentTweet = finQuestion + "\n\n" + finAnswer;
       //tweetIt();
     }
 }
 
 
 
 
 
 
 
}

void shortenQuestion() {
  String[] stops = {"and", ",", ".", "\"",";"};
  int index = 0;
  for (String i : stops) {
    index = max(index, finQuestion.indexOf(i));
  }
  if (index > 0) {
    finQuestion = finQuestion.substring(0,index);}
}

void shortenAnswer() {
  String[] stops = {"and", ",", ".", "\"",";"};
  int index = 0;
  for (String i : stops) {
    index = max(index, finAnswer.indexOf(i));
  }
  if (index > 0) {
    finAnswer = finAnswer.substring(0,index); }
}

boolean shortenTweets() {
  lenQ = finQuestion.length();
  lenA = finAnswer.length();
  
  shortenAnswer();
  if (lenQ > finQuestion.length()) {
    println("true");
    return true;
  }
  shortenAnswer();
  if (lenQ > finQuestion.length()) {
    println("true");
    return true;
    
  }
  println("false");
  return false;
}




void setup() {
  
  whyDid();
  because();
  String aJsonFilename = "wdt.json";
  JSONObject json = loadJSONObject(aJsonFilename);
  
  String bJsonFilename = "bc.json";
  JSONObject bjson = loadJSONObject(bJsonFilename);
  
  tweets = new JSONArray();
  if (json == null || bjson ==null) 
  {
    println("JSONObject could not be loaded!");
  }
  else 
  {
    JSONArray statuses = json.getJSONArray("statuses");
    JSONArray statusesb = bjson.getJSONArray("statuses");
    for (int i=0; i<statuses.size(); i++) {
        JSONObject aTweet = statuses.getJSONObject(i);
        String aText = aTweet.getString("text");
        String aTime = aTweet.getString("created_at");
        JSONObject aUser = aTweet.getJSONObject("user");
        String aScreenName = aUser.getString("screen_name");
        String aName = aUser.getString("name");
        
        JSONObject bTweet = statusesb.getJSONObject(i);
        String bText = bTweet.getString("text");
        String bTime = bTweet.getString("created_at");
        JSONObject bUser = bTweet.getJSONObject("user");
        String bScreenName = bUser.getString("screen_name");
        String bName = bUser.getString("name");

        finAnswer= "B" + getAnswer(bText).substring(1);
        finQuestion = "W" + getQuestion(aText).substring(1);
        finCredits = aScreenName + "&" + bScreenName;
        Cleanup();
        tweetIt();
    }
  }
}


void Cleanup() {
  finAnswer = clearDoubles(endsInAt(clearAmp(finAnswer)));
  finQuestion = clearDoubles(endsInAt(clearAmp(finQuestion)) + "?");  
  finCredits = clearDoubles(clearQ(finCredits));
  
}
  
String getQuestion(String text)
{
  int index = (text.toLowerCase()).indexOf("why did");
  if (index >= 0 ) {
    String cleared = text.substring(index);
  if((cleared.toLowerCase()).indexOf("http") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("http")));}
  if((cleared.toLowerCase()).indexOf("?") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("?")));}
  if((cleared.toLowerCase()).indexOf("\n") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("\n")));}
  return cleared; }
  return "WHY";
}



String getAnswer(String text)
{
  int index = (text.toLowerCase()).indexOf("because");
  String cleared = text.substring(index);
  if((cleared.toLowerCase()).indexOf("http") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("http")));}
  if((cleared.toLowerCase()).indexOf("...") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("...")));}
  if((cleared.toLowerCase()).indexOf("\n") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("\n")));}
  if((cleared.toLowerCase()).indexOf("!") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("!")));}
    
  return cleared; 
}
  
  
  
  
  
  
  
  
  
  
//clears the text of random messes,   i should turn this into one function that loops through psoobilities  
  
  
  
String clearAmp(String input) {
  int index = input.indexOf("&amp");
  while (index != -1) {
   input = input.substring(0, index) + "&" +input.substring(index+5,input.length());
   index = input.indexOf("&amp");
  }
  index = input.indexOf("&gt");
  while (index != -1) {
   input = input.substring(0, index) + input.substring(index+4,input.length());
   index = input.indexOf("&gt");
  }
  return input;
}




String endsInAt(String input) {
  int index = input.indexOf("@");
  if (index>-1 && (input.substring(index,input.length())).indexOf(" ") >-1) {
    input = input.substring(0,index);
  }
  return input;
}



String clearSpace(String input){
  int index = input.indexOf("  ");
  while (index != -1) {
   input = input.substring(0, index) + input.substring(index+2,input.length());
   index = input.indexOf("  ");
  }
  return input;
}

String clearQ(String input){
  int index = input.indexOf("?");
  while (index != -1) {
   input = input.substring(0, index) + input.substring(index+2,input.length());
   index = input.indexOf("?");
  }
  return input;
}



String clearDoubles(String input){
  int index = input.indexOf("__");
  while (index != -1) {
   input = input.substring(0, index) + input.substring(index+2,input.length());
   index = input.indexOf("__");
  }
  
  index = input.indexOf("  ");
  while (index != -1) {
   input = input.substring(0, index) + " " + input.substring(index+3,input.length());
   index = input.indexOf("  ");
  }
  
  return input;
}