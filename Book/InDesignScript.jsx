#includepath "~/Documents/;%USERPROFILE%Documents";
#include "basiljs/bundle/basil.js";

var jsonString = b.loadString("all-2.json");
var jsonData;

//--------------------------------------------------------
function setup() {
    
  b.clear (b.doc()); // Clear the document at the very start. 
  var pageNum = 0;    
  var pgW = 6*72;        
  var pgH= 9*72;

  var doc=b.doc();
  with(b.doc().documentPreferences) {
    pageWidth = pgW + "pt";
    pageHeight = pgH + "pt";
    b.width = pgW;
    b.height = pgH;
  }
    

  // Make a title page. 
  b.fill(0,0,0);
  b.textSize(24);
  b.textFont("Helvetica","Light"); 
  b.textAlign(Justification.RIGHT_ALIGN ); 
  b.text("Attempts at Jokes", 72,72,360,36);
  b.textSize(12);
  b.text("Takos & Twitter", 72,108,360,36);
  
  // Parse the JSON file into the jsonData array
  jsonData = b.JSON.decode( jsonString );
  b.println("Number of elements in JSON: " + jsonData.length);

  // Initialize some variables for element placement positions.
  // Remember that the units are "points", 72 points = 1 inch.
  var titleX = 36; 
  var titleY = 76;
  var titleW = 72*5;
 
  var titleH = 24;

  // These are the header fields from the tweet CSV:
  // tweet_id,in_reply_to_status_id,in_reply_to_user_id,timestamp,source,text,
  // retweeted_status_id,retweeted_status_user_id,,retweeted_status_timestamp,
  // expanded_urls

  var textW=pgW*0.75;
  var textOffs=(pgW-textW)/2;
  var textOffsY=72;
  var x=textOffs;
  var y=pgH*0.25;
    
  var textSize1=8;
  var textSize2=30;
  var tweetDist=textSize2*2;
    
  var whiteSpaceStr=" ";

  var elements=[];
    
  var doNewPage=false;
  var w = 0;
  // Loop over every element of the book content array
  for (var i = 0; i <jsonData.length; i+=3){ // 10; i+=3){     //jsonData.length; i+=3) {
      
    // Create the next page. 
    b.addPage();
    b.noStroke();  // no border around image, please.
    b.fill(0,0,0);

    var textY = titleY;
    var fontA = "Itallic";
    var fontB = "Regular";
    var size1 = 14;
    var size2 = 8;
    var font = "Helvetica";
    pageNum = pageNum +1;
      
      
    
      
      
    b.textSize(size1);
      
    b.textAlign(Justification.CENTER_ALIGN);
    b.textFont(font,fontB); 
    b.text("-", 216-20, 228, 40, 40);
    b.text("-", 216-20, 420, 40, 40);
   // b.textSize(size2);
   // b.text(pageNum, 216-20, 612, 40, 40); 
    b.textSize(size1);
      
      
    w = 0;
    if (jsonData[i].question.length > 57){
        w = 15;
    }
    if (jsonData[i].question.length > 114){
        w = 30;
    }  
    b.color(0,0,0);    
    b.textFont(font,fontB); 
    b.textAlign(Justification.LEFT_ALIGN );
    b.text(jsonData[i].question, titleX,textY,titleW,titleH*3); textY+=titleH;//+15; 
      
    b.color(80,80,80);    
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i].name,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5;
    
      
          
    w =0; 
      
    if (jsonData[i].answer.length > 57){
        w = 15;
    }
    if (jsonData[i].answer.length > 114){
        w = 30;
    }  
        
    b.color(0,0,0);      
    b.textSize(size1);
    b.textFont(font,fontB); 
    b.textAlign(Justification.RIGHT_ALIGN );
    b.text(jsonData[i].answer, titleX,textY,titleW,titleH*3); textY+=titleH;//+15;
    b.color(80,80,80);
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i].nameB,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5; 
   
      
    w = 0;
    if (jsonData[i+1].question.length > 57){
        w = 15;
    }
    if (jsonData[i+1].question.length > 114){
        w = 30;
    }    
    b.color(0,0,0);
    textY = (pgH-2*titleY)*(1/3)+titleY*1.5;
    b.textSize(size1);
    b.textFont(font,fontB); 
    b.textAlign(Justification.LEFT_ALIGN );
    b.text(jsonData[i+1].question, titleX,textY,titleW,titleH*3); textY+=titleH;//+15; 
    b.color(80,80,80);      
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i+1].name,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5;//2;
    
      
    w =0; 
      
    if (jsonData[i+1].answer.length > 57){
        w = 15;
    }
    if (jsonData[i+1].answer.length > 114){
        w = 30;
    }  
      
    b.color(0,0,0);      
    b.textSize(size1);
    b.textFont(font,fontB);
    b.textAlign(Justification.RIGHT_ALIGN );
    b.text(jsonData[i+1].answer, titleX,textY,titleW,titleH*3); textY+=titleH;//+15;
    b.color(80,80,80);
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i+1].nameB,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5;//2; 
    w = 0;
    if (jsonData[i+2].question.length > 57){
        w = 15;
    }
    if (jsonData[i+2].question.length > 114){
        w = 30;
    }
    b.color(0,0,0);      
    textY = (pgH-2*titleY)*(2/3)+titleY*2;
    b.textSize(size1);
    b.textFont(font,fontB); 
    b.textAlign(Justification.LEFT_ALIGN );
    b.text(jsonData[i+2].question, titleX,textY,titleW,titleH*3); textY+=titleH;//+15; 
    b.color(80,80,80);      
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i+2].name,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5;//2;
    
    w =0; 
      
    if (jsonData[i+2].answer.length > 57){
        w = 15;
    }
    if (jsonData[i+2].answer.length > 114){
        w = 30;
    }
    b.color(0,0,0);      
    b.textSize(size1);
    b.textFont(font,fontB); 
    b.textAlign(Justification.RIGHT_ALIGN );      
    b.text(jsonData[i+2].answer, titleX,textY,titleW,titleH*3); textY+=titleH;//+15;
    b.color(80,80,80);
    b.textSize(size2);
    b.textFont(font,fontA); 
    b.text(jsonData[i+2].nameB,       titleX,textY+w,titleW,titleH); textY+=titleH*1.5;//2; 
 

  };
}

// This makes it all happen:
b.go(); 