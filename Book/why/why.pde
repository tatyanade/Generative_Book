import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

// Create a session using your Temboo account application details
TembooSession session = new TembooSession(XXXX);
int x = 209;
void setup() {
  // Run the Tweets Choreo function
  runTweetsChoreo();
}

void runTweetsChoreo() {
  // Create the Choreo object using your Temboo session
  Tweets tweetsChoreo = new Tweets(session);
  tweetsChoreo.setResultType("recent");

  // Set inputs
  String myQuery  = "\"why did\"";
  tweetsChoreo.setQuery(myQuery);
  tweetsChoreo.setAccessToken(XXXX);
  tweetsChoreo.setConsumerKey(XXXX);
  tweetsChoreo.setConsumerSecret(XXXX);
  tweetsChoreo.setAccessTokenSecret(XXXX);

  // Run the Choreo and store the results
  TweetsResultSet tweetsResults = tweetsChoreo.run();
  
  // Print results
  println(tweetsResults.getLimit());
  println(tweetsResults.getRemaining());
  println(tweetsResults.getReset());
  //println(tweetsResults.getResponse());

  String[] result = {tweetsResults.getResponse()};
  //println(result);
  String name =  "..\\data\\wdt" + x + ".json";
  saveStrings(name,result);
}