import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

JSONArray tweets;
int number = 201;

void setup() {
  String aJsonFilename = "wdt" + number + ".json";
  JSONObject json = loadJSONObject(aJsonFilename);
  
  String bJsonFilename = "bc" + number + ".json";
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
        String aColor = aUser.getString("profile_background_color");
        println(i + "\t" + aText);
        JSONObject tweet = new JSONObject();
        tweet.setString("text", aText +" ");
        tweet.setString("name", aName);
        tweet.setString("color", aColor);
        tweet.setString("screenName",aScreenName);
        tweet.setString("date", aTime);
        //tweets.setJSONObject(i, tweet);                
       
        
        JSONObject bTweet = statusesb.getJSONObject(i);
        String bText = bTweet.getString("text");
        String bTime = bTweet.getString("created_at");
        JSONObject bUser = bTweet.getJSONObject("user");
        String bScreenName = bUser.getString("screen_name");
        String bName = bUser.getString("name");
        String bColor = bUser.getString("profile_background_color");
        println(i + "\t" + bText);
        tweet.setString("textB", bText +" ");
        tweet.setString("nameB", bName);
        tweet.setString("colorB", bColor);
        tweet.setString("screenNameB",bScreenName);
        tweet.setString("dateB", bTime);
        tweet.setString("credits", "By " + aName + " and " + bName + ".");
        tweets.setJSONObject(i, tweet);
        tweet.setString("question", getQuestion(aText)+"?");
        tweet.setString("answer",getAnswer(bText));
        tweet.setString("by",aName + " & " + bName );


      saveJSONArray(tweets,  number + ".json");
    }
      
  }}
  
  
String getQuestion(String text)
{
  int index = (text.toLowerCase()).indexOf("why did");
  String cleared = text.substring(index);
  if((cleared.toLowerCase()).indexOf("http") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("http")));}
  if((cleared.toLowerCase()).indexOf("?") > 0){
    cleared = cleared.substring(0, ((cleared.toLowerCase()).indexOf("?")));}
    
  return cleared; 
}

String getAnswer(String text)
{
  String lowercasedText = text.toLowerCase();
  int indexOfBecause = lowercasedText.indexOf("because");
  String textStartingFromBecause = text.substring(indexOfBecause);
  String textStartingFromBecauseLowercased = textStartingFromBecause.toLowerCase();
  if (textStartingFromBecauseLowercased.indexOf("http") > 0){
    return text.substring(indexOfBecause, (lowercasedText.indexOf("http")));
  }
  return text.substring(indexOfBecause); 
}
  